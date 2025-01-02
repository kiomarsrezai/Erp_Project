using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using NewsWebsite.Common;
using NewsWebsite.Data;
using NewsWebsite.Data.Models.LogRequest;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace NewsWebsite.IocConfig.Api.Middlewares {
    public static class RequestLoggingMiddlewareExtentions {
        public static IApplicationBuilder UseRequestLogging(this IApplicationBuilder builder){
            return builder.UseMiddleware<RequestLoggingMiddleware>();
        }
    }

    public class RequestLoggingMiddleware {
        private readonly RequestDelegate _next;
        private readonly IServiceScopeFactory _scopeFactory;

        public RequestLoggingMiddleware(RequestDelegate next, IServiceScopeFactory scopeFactory){
            _next = next;
            _scopeFactory = scopeFactory;
        }
        public async Task Invoke(HttpContext context)
        {
            var logRequest = new LogRequest{
                Url = context.Request.Path,
                Duration = 0, // Will be updated after the request completes
                Headers = SerializeHeaders(context.Request.Headers),
                Payloads =GetPayload(context),
                RequestType = context.Request.Method,
                Ip = context.Connection.RemoteIpAddress?.ToString(),
                CreatedAt = DateTime.UtcNow
            };
            
            // // Step 2: Start timer to capture request duration
            var stopwatch = Stopwatch.StartNew();



                var response = context.Response;
                var originBody = response.Body;
                using var newBody = new MemoryStream();
                response.Body = newBody;
                var responseBody = "";
            try{

                await _next(context);

                // Step 3: Capture response details after request is completed
                logRequest.Duration = (int)stopwatch.ElapsedMilliseconds; // Store duration in milliseconds
                logRequest.ResponseStatusCode = context.Response.StatusCode;

                newBody.Seek(0, SeekOrigin.Begin);
                responseBody = await new StreamReader(newBody).ReadToEndAsync();
                logRequest.Response = responseBody.Length>500?responseBody.Substring(0,500):responseBody;


                using (var scope = _scopeFactory.CreateScope()){
                    var dbContext = scope.ServiceProvider.GetRequiredService<ProgramBuddbContext>();

                    if (context.Response.StatusCode == 500){
                        // Extract the exception message
                        var jsonObject = JObject.Parse(responseBody);
                        var message = jsonObject["Message"].First.ToString();
                        var innerJsonObject = JObject.Parse(message);
                        var exceptionMessage = innerJsonObject["Exception"].ToString();

                        var stackTrace = innerJsonObject["StackTrace"].ToString();
                        var firstAddress = stackTrace.Split(new[] { "\\r\\n" }, StringSplitOptions.None).FirstOrDefault();

                        var logException = new LogRequestException{
                            LogRequestId = logRequest.Id,
                            Location = firstAddress, 
                            Exception = exceptionMessage,
                            Code = "500", // todo: 
                        };
                        dbContext.LogRequestExceptions.Add(logException);
                    }

                    // Step 4: Save LogRequest to the database
                    dbContext.LogRequests.Add(logRequest);
                    await dbContext.SaveChangesAsync();
                }

            }
            catch (Exception ex){
                logRequest.Duration = (int)stopwatch.ElapsedMilliseconds; // Store duration in milliseconds
                logRequest.ResponseStatusCode = 500; // Internal Server Error
                logRequest.Response = $"Exception: {ex.Message}";


                using (var scope = _scopeFactory.CreateScope()){
                    var dbContext = scope.ServiceProvider.GetRequiredService<ProgramBuddbContext>();

                    var logException = new LogRequestException{
                        LogRequestId = logRequest.Id,
                        Location = "",//ex.StackTrace, // You can improve this by identifying the exact location
                        Exception = "",//ex.Message,
                        Code = "500"//ex.StackTrace
                    };

                    // Step 4: Save LogRequest to the database
                    dbContext.LogRequests.Add(logRequest);
                    dbContext.LogRequestExceptions.Add(logException);
                    await dbContext.SaveChangesAsync();
                }
                

                throw;
            }



            // await ModifyResponseAsync22(response,newBody);
            var stream = response.Body;

            string modifiedResponse = responseBody;
            // string modifiedResponse = "Hello from Stackoverflow";
            stream.SetLength(0);
            using var writer = new StreamWriter(stream, leaveOpen: true);
            await writer.WriteAsync(modifiedResponse);
            await writer.FlushAsync();
            response.ContentLength = stream.Length;
            
            
            newBody.Seek(0, SeekOrigin.Begin);
            await newBody.CopyToAsync(originBody);
            response.Body = originBody;
        }

        private static string GetPayload(HttpContext context){
            var jsonString = Helpers.ReqAll(context);
            // return jsonString;
            var jsonObject = JObject.Parse(jsonString);

// Function to transform key-value array to object
            JObject TransformKeyValueArray(object keyValueArray){
                if (keyValueArray is JObject)
                    return (JObject)keyValueArray;
                else{
                    var keyValueArray1 = (JArray)keyValueArray; // todo:
                    
                    var transformedObject = new JObject();
                    foreach (var item in keyValueArray1){
                        var key = item["Key"].ToString();
                        var value = item["Value"].First.ToString();
                        transformedObject[key] = value;
                    }
    
                    return transformedObject;
                }
            }            
            JObject TransformKeyValueObject(JObject keyValueArray){
                return keyValueArray;
            }
            
// Transform each main key if it exists
            var finalJsonObject = new JObject();

            if (jsonObject["query"] != null)
                finalJsonObject["query"] = TransformKeyValueArray(jsonObject["query"]);

            if (jsonObject["form"] != null)
                finalJsonObject["form"] = TransformKeyValueArray(jsonObject["form"]);
            
            if (jsonObject["body"] != null)
                finalJsonObject["body"] = TransformKeyValueArray(jsonObject["body"]);
            
            string transformedJsonString = finalJsonObject.ToString(Formatting.None);

            return transformedJsonString;
        }

        // Helper method to serialize headers to string (for logging purposes)
        private string SerializeHeaders(IHeaderDictionary headers)
        {
            // List of headers to ignore
            var ignoredHeaders = new HashSet<string>(StringComparer.OrdinalIgnoreCase)
            {
                "Connection",
                "Content-Length",
                "Content-Type",
                "Accept-Encoding",
                "Accept-Language",
                "Referer",
                "User-Agent",
                "Origin",
                "ngrok-skip-browser-warning",
                "sec-ch-ua-platform",
                "sec-ch-ua",
                "sec-ch-ua-mobile",
                "Sec-Fetch-Site",
                "Sec-Fetch-Mode",
                "Sec-Fetch-Dest"
            };

            // Filter headers and serialize to JSON
            var filteredHeaders = headers
                .Where(h => !ignoredHeaders.Contains(h.Key))
                .ToDictionary(h => h.Key, h => string.Join(", ", h.Value));

            return JsonConvert.SerializeObject(filteredHeaders);
        }


        // Helper method to capture the request payload (body) if needed
        private async Task<string> CaptureRequestPayload(HttpContext context){
            if (context.Request.ContentLength > 0 && context.Request.Body.CanSeek){
                context.Request.Body.Seek(0, SeekOrigin.Begin);
                using (var reader = new StreamReader(context.Request.Body)){
                    return await reader.ReadToEndAsync();
                }
            }

            return string.Empty;
        }


        private async Task ModifyResponseAsync(HttpResponse response){
            var stream = response.Body;

            //uncomment to re-read the response stream
            //stream.Seek(0, SeekOrigin.Begin);
            using var reader = new StreamReader(stream, leaveOpen: true);
            string originalResponse = await reader.ReadToEndAsync();

            //add modification logic

            string modifiedResponse = "Hello from Stackoverflow";
            stream.SetLength(0);
            using var writer = new StreamWriter(stream, leaveOpen: true);
            await writer.WriteAsync(modifiedResponse);
            await writer.FlushAsync();
            response.ContentLength = stream.Length;
        }
    }
}