using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using System.Reflection;
using System.Runtime.CompilerServices;
using Microsoft.AspNetCore.Routing;
using Newtonsoft.Json;
using JsonSerializer = System.Text.Json.JsonSerializer;

namespace NewsWebsite.Common {
    

public static class Helpers {


    public static string? dd(object? obj, bool asJson = true, bool retun = false){
        string msg;


        if (obj == null){
            if (asJson)
                msg = "@null";
            else
                msg = "{\"value\": null}";
        }
        else if (obj is string){
            if (asJson)
                msg = $"{{\"string\": \"{obj}\"}}";
            else
                msg = $"(string) \"{obj}\"";
        }
        else if (obj is int){
            if (asJson)
                msg = $"{{\"int\": {obj}}}";
            else
                msg = $"(int) {obj}";
        }
        else if (obj.GetType().IsAnonymousType()){
            msg = SerializeAnonymousType(obj, asJson);
        }
        else if (obj is JsonResult jsonResult){
            msg = SerializeJsonResult(jsonResult);
        }
        else{
            msg = $"({obj.GetType().Name}) {obj}";
        }

        if (retun){
            return msg;
        }

        throw new DDException(msg);
    }

    private static string SerializeJsonResult(JsonResult jsonResult){
        var result = new{
            StatusCode = jsonResult.StatusCode,
            Value = dd(jsonResult.Value, true, true)
        };
        return JsonSerializer.Serialize(result);
    }


    private static string SerializeAnonymousType(object obj, bool asJson){
        var properties = obj.GetType().GetProperties();
        var propertyValues = new Dictionary<string, string>();

        foreach (var property in properties){
            var propertyName = property.Name;
            var propertyValue = property.GetValue(obj);
            var serializedValue = dd(propertyValue, asJson, true);
            propertyValues[propertyName] = serializedValue;
        }

        return JsonSerializer.Serialize(propertyValues);
    }

    public static bool IsAnonymousType(this Type type){
        return Attribute.IsDefined(type, typeof(CompilerGeneratedAttribute), false)
               && type.IsGenericType && type.Name.Contains("AnonymousType")
               && (type.Name.StartsWith("<>", StringComparison.OrdinalIgnoreCase) || type.Name.StartsWith("VB$", StringComparison.OrdinalIgnoreCase))
               && (type.Attributes & TypeAttributes.NotPublic) == TypeAttributes.NotPublic;
    }


    public static void ddParams(HttpContext HttpContext, RouteData RouteData){
        // Retrieve query string parameters
        var result = new Dictionary<string, object>();

        try{
            // Retrieve query string parameters
            result["QueryString"] = HttpContext.Request.Query;
        }
        catch (Exception ex){
            result["QueryStringError"] = ex.Message;
        }

        try{
            // Retrieve form data (if it's a POST request with a form)
            result["FormData"] = HttpContext.Request.Form;
        }
        catch (Exception ex){
            result["FormDataError"] = ex.Message;
        }

        try{
            // Retrieve route data (if you have any)
            result["RouteData"] = RouteData.Values;
        }
        catch (Exception ex){
            result["RouteDataError"] = ex.Message;
        }

        dd(result);
    }
}

}
