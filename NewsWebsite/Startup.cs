﻿using System;
using System.Globalization;
using System.IO;
using AutoMapper;
using Coravel;
using Newtonsoft.Json;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Localization;
using Microsoft.AspNetCore.StaticFiles;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.FileProviders;
using Microsoft.Extensions.Hosting;
using NewsWebsite.Data;
using NewsWebsite.IocConfig;
using NewsWebsite.IocConfig.Api.Middlewares;
using NewsWebsite.IocConfig.Api.Swagger;
using NewsWebsite.Services;
using NewsWebsite.Services.Contracts;
using NewsWebsite.ViewModels.DynamicAccess;
using NewsWebsite.ViewModels.Settings;
using Newtonsoft;

namespace NewsWebsite
{
    public class Startup
    {
        public IConfiguration Configuration { get; }
        public IServiceProvider Services { get; }
        private readonly SiteSettings SiteSettings;
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
            SiteSettings = configuration.GetSection(nameof(SiteSettings)).Get<SiteSettings>();
        }
        public void ConfigureServices(IServiceCollection services)
        {
            services.Configure<SiteSettings>(Configuration.GetSection(nameof(SiteSettings)));
            //services.AddDbContext<ProgramBuddbContext>(options => options.UseSqlServer(Configuration.GetConnectionString("SqlServer")));
            services.AddDbContext<ProgramBuddbContext>(options => options.UseSqlServer(Configuration.GetConnectionString("SqlErp")));
            services.AddCustomServices();
            services.AddTransient<ISecurityTrimmingService, SecurityTrimmingService>();
            services.AddTransient<IMvcActionsDiscoveryService, MvcActionsDiscoveryService>();
            //services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>();
            services.AddCustomIdentityServices();
            services.AddAutoMapper();
            services.AddScheduler();
            services.AddApiVersioning();
            services.AddSwagger();
            services.AddCors(options => options.AddPolicy("CorsPolicy",
                builder =>
                {
                    builder
                    .AllowAnyOrigin()
                    .AllowAnyMethod()
                    .AllowAnyHeader();
                }));

            services.AddCustomAuthentication(SiteSettings);
            services.ConfigureWritable<SiteSettings>(Configuration.GetSection("SiteSettings"));
            services.AddAuthorization(options =>
            {
                options.AddPolicy(ConstantPolicies.DynamicPermission, policy => policy.Requirements.Add(new DynamicPermissionRequirement()));
            });

            services.ConfigureApplicationCookie(options =>
            {
                options.LoginPath = "/Home/Index";
                options.AccessDeniedPath = "/Admin/Manage/AccessDenied";
            });

            // services.AddControllers().AddJsonOptions(options =>
            // {
            //     options.JsonSerializerOptions.Converters.Add(new DateTimeConverter());
            // });
            services.AddMvc();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            app.UseCors(options => options.WithOrigins("*").AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod());

            var defaultCulture = new CultureInfo("en-US"); // Change to the desired culture
            var supportedCultures = new[] { defaultCulture };

            app.UseRequestLocalization(new RequestLocalizationOptions
            {
                DefaultRequestCulture = new RequestCulture(defaultCulture),
                SupportedCultures = supportedCultures,
                SupportedUICultures = supportedCultures
            });
            
            var cachePeriod = env.IsDevelopment() ? "600" : "605800";
            app.UseWhen(context => context.Request.Path.StartsWithSegments("/api"), appBuilder =>
            {
                // appBuilder.UseRequestLogging();
                appBuilder.UseCustomExceptionHandler();
            });

            app.UseWhen(context => !context.Request.Path.StartsWithSegments("/api"), appBuilder =>
            {
                DefaultFilesOptions options = new DefaultFilesOptions();
                options.DefaultFileNames.Clear();
                options.DefaultFileNames.Add("index.html");

                app.UseDefaultFiles(options);

                if (env.IsDevelopment())
                    appBuilder.UseDeveloperExceptionPage();
                else
                    appBuilder.UseExceptionHandler("/Home/Error");
            });

           

            app.UseStaticFiles(new StaticFileOptions
            {
                FileProvider = new PhysicalFileProvider(Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "CacheFiles")),
                OnPrepareResponse = ctx =>
                {
                    ctx.Context.Response.Headers.Append("Cache-Control", $"public,max-age={cachePeriod}");
                },
                RequestPath = "/CacheFiles",
            });


            app.UseStaticFiles();
            
            // add DWG file as static file
            var provider2 = new FileExtensionContentTypeProvider();
            provider2.Mappings[".dwg"] = "application/acad";
            provider2.Mappings[".kmz"] = "application/vnd.google-earth.kmz";
            app.UseStaticFiles(new StaticFileOptions
            {
                ContentTypeProvider = provider2
            });

            app.UseCustomIdentityServices();

            var provider = app.ApplicationServices;

            provider.UseScheduler(scheduler =>
            {
                //scheduler.Schedule<SendWeeklyNewsletter>().EveryMinute();
                scheduler.Schedule<SendWeeklyNewsletter>().Cron("29 20 * * 5"); //UTC Time
                //scheduler.Schedule<SendWeeklyNewsletter>().Cron("14 15 * * 0"); //UTC Time
            });

            app.Use(async (context, next) =>
            {
                await next();
                if (context.Response.StatusCode == 404)
                {
                    context.Request.Path = "/home/error404";
                    await next();
                }
            });

            app.UseSwaggerAndUI();
            app.UseRouting();
            app.UseAuthorization();
            app.UseEndpoints(routes =>
            {
                routes.MapControllerRoute(
                  name: "areas",
                  pattern: "{area:exists}/{controller=Home}/{action=Index}/{id?}"
                );
                routes.MapControllerRoute(

                 name: "default",
                 pattern: "{controller=Home}/{action=Index}/{id?}"
               );
            });
        }
    }
}
