using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.SwaggerGen;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;


namespace NewsWebsite.IocConfig.Api.Swagger
{
    public static class SwaggerConfigurationExtentions
    {
        public static void AddSwagger(this IServiceCollection services)
        {
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc(
                    "v1",
                    new OpenApiInfo()
                    {
                        Title = "Library Api",
                        Version = "v1",
                        Description = "Through this Api you can access BudgetInfo",
                        Contact = new OpenApiContact
                        {
                            Email = "kiomarsrezai@gmail.com",
                            Name = "Kiomars Rezaei",
                            Url=  new Uri("http://www.Ict.Ahvaz.Ir"),
                        },
                        License = new OpenApiLicense
                        {
                            Name = "License",
                            Url = new Uri("http://www.Ict.Ahvaz.ir"),
                        },
                    });
                c.SwaggerDoc(
                   "v2",
                   new OpenApiInfo()
                   {
                       Title = "Library Api",
                       Version = "v2",
                       Description = "Through this Api you can access BudgetInfo",
                       Contact = new OpenApiContact
                       {
                           Email = "kiomarsrezai@gmail.com",
                           Name = "Kiomars Rezaei",
                           Url = new Uri("http://www.Ict.Ahvaz.ir"),
                       },
                       License = new OpenApiLicense
                       {
                           Name = "License",
                           Url = new Uri("http://www.Ict.Ahvaz.ir"),
                       },
                   });


                c.DescribeAllParametersInCamelCase();

                c.OperationFilter<RemoveVersionParameters>();
                c.DocumentFilter<SetVersionInPaths>();

                c.DocInclusionPredicate((docName, apiDesc) =>
                {
                    if (!apiDesc.TryGetMethodInfo(out MethodInfo methodInfo)) return false;

                    var versions = methodInfo.DeclaringType
                        .GetCustomAttributes<ApiVersionAttribute>(true)
                        .SelectMany(attr => attr.Versions);

                    return versions.Any(v => $"v{v.ToString()}" == docName);
                });

                c.OperationFilter<UnauthorizedResponsesOperationFilter>(true, "Bearer");
                c.AddSecurityDefinition ("Bearer", new OpenApiSecurityScheme
                {
                    Description = "JWT Authorization header using the Bearer scheme. Example: \"Bearer {token}\" \n   Bearer eyJhbGciOiJBMTI4S1ciLCJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwidHlwIjoiSldUIn0.zFxsRfN-nlj-024J3znVTWXHZmlE93B7aPJtYk2s_6ZauOT70PAVzQ.ovPqgq2hKX-vkZcGkSo9OQ.XX-qZAwdHfPww_HVJ0_fNSi4Ncg-3ZWRoPS8HL34eCCbXhjnYagNaDylM7dKv4CjHOJugQJLNExDc-HusB5RM9ymAknp2QSrCHUGZvgFz2MALscrUUCLS320dCJX3RaOOzTq3Iv0Nvkrj4GCMQ_U496w_Oz5aQf81hAZBIQ76qDb1NT7BZr0-TwSsFIRvhqSEzjDdgLrfKAR0n97PG2fNP0QsXYjUZNlHaNHG8elQwePIsV23xR4d4v5G4q6ANVKX3qpXigjdmBDL71yKafVwXb_fSdJxH0WiERsf3OZ6SPc2UyFBX41et7JL4K2ugQU1plSOB1aD26SDd1czpzgHe3jOJnYubpjfOPHQR9cA9ytC9aNluN1I8eotyIdUMT38g0MIz9ZD86bH9VTmjmiBxMtUDXwR_NKwRC9cVHp8TRZ4vzPPyeBAu022XtiPi-bXmGKg-1LM773_36SwXPl3Z7f6ZOzEe8x68jOnpbmUr8HRLms1tCXQF-7pnoPQQ45WavfK0I9FR_O4yuqlv5CtjNuCn5KZd--R2JW5Jk4uqmnd8S3wK3lxi_RPtqpzZMTpy1wKq5zR6FOvjZVnwl2cyc82dmZQ9Pef1ogX0XMWpEkPdM9No1Kmpv3gFX0RDnX6r2AzGhv-3h7Ry4g_LQNDg.ilK04Chyfuk7r56jcG90ZQ",
                    Name = "Authorization",
                    In = ParameterLocation.Header,
                });

                //c.AddSecurityRequirement(new Dictionary<string, IEnumerable<string>>
                //{
                //    {"Bearer", new string[] { }}
                //});

                // Add security definition for Bearer token
                c.AddSecurityRequirement(new OpenApiSecurityRequirement(){
                    {
                        new OpenApiSecurityScheme
                        {
                            Reference = new OpenApiReference
                            {
                                Type = ReferenceType.SecurityScheme,
                                Id = "Bearer"
                            },
                            Scheme = "oauth2",
                            Name = "Bearer",
                            In = ParameterLocation.Header
                        },
                        new List<string>()
                    }
                });

                //var xmlFile = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
                //var xmlPath = Path.Combine(AppContext.BaseDirectory, xmlFile);
                //c.IncludeXmlComments(xmlPath);
            });
        }

        public static void UseSwaggerAndUI(this IApplicationBuilder app)
        {
            app.UseSwagger();
            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint("/swagger/v1/swagger.json", "My Api v1");
                c.SwaggerEndpoint("/swagger/v2/swagger.json", "My Api v2");
            });

        }
    }
}
