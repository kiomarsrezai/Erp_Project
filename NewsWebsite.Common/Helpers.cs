﻿using System;
using System.Collections;
using System.Collections.Generic;
using System.Dynamic;
using System.Globalization;
using System.IO;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Security.Cryptography;
using System.Text;
using Microsoft.AspNetCore.Routing;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using JsonSerializer = System.Text.Json.JsonSerializer;
using SharpKml.Dom;
using SharpKml.Engine;
using System.IO;
using System.IO.Compression;
using System.Net;
using System.Text.Json;
using SharpKml.Base;
using TimeSpan = System.TimeSpan;


namespace NewsWebsite.Common {
    

public static class Helpers {

    public static string ReqAll(this HttpContext context){
        object objs = new{};

        if (context.Request.HasFormContentType){
            objs = CombineObjects(objs, new{form=context.Request.Form});
        }
        
        objs = CombineObjects(objs, new{query=context.Request.Query});
        
        try{
            string body;
            JsonDocument jsonDoc = null;
            context.Request.EnableBuffering();
    
            if (context.Request.Body.CanSeek){
                context.Request.Body.Position = 0;
            }
    
            using (var reader = new StreamReader(context.Request.Body, leaveOpen: true)){
                body = reader.ReadToEndAsync().Result;
            }

            var obj2 = JsonConvert.DeserializeObject<ExpandoObject>(body);
            
            objs = CombineObjects(objs, new{body= obj2 });
            
            // Reset the position to allow subsequent reads
            context.Request.Body.Position = 0;
        }
        catch (Exception ){
            // ignored
        }

        
        return JsonConvert.SerializeObject(objs, Formatting.Indented);
        // return objs;
    }
    
    
    public static object CombineObjects(object? obj1, object? obj2){
        if (obj1 == null && obj2 == null){
            return new{ };
        }

        var combined = new ExpandoObject() as IDictionary<string, object>;

        if (obj1 != null){
            var properties1 = obj1.GetType().GetProperties();
            foreach (var prop in properties1){
                combined[prop.Name] = prop.GetValue(obj1);
            }
        }

        if (obj2 != null){
            var properties2 = obj2.GetType().GetProperties();
            foreach (var prop in properties2){
                combined[prop.Name] = prop.GetValue(obj2);
            }
        }

        return combined;
    }
    
    
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
        else if (obj is string[]){
            if (asJson)
                msg = $"{{\"string[]\": [{string.Join(", ", ((string[])obj).Select(s => $"\"{s}\""))}]}}";
            else
                msg = $"(string[]) [{string.Join(", ", obj)}]";
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




    public static string MiladiToHejri(DateTime? miladiDate){
        if (miladiDate == null)
            return "0000/00/00 00:00:00";
        return MiladiToHejri(miladiDate.ToString());
    }

    public static string MiladiToHejri(string miladiDate ){
        if (miladiDate!=null && DateTime.TryParse(miladiDate, out DateTime miladiDateTime) && miladiDateTime.Year>1){
            PersianCalendar pc = new PersianCalendar();

            int year = pc.GetYear(miladiDateTime);
            int month = pc.GetMonth(miladiDateTime);
            int day = pc.GetDayOfMonth(miladiDateTime);
            string persianDate = $"{year:D4}/{month:D2}/{day:D2}";

            if (miladiDateTime.TimeOfDay != TimeSpan.Zero){
                string time = miladiDateTime.ToString("HH:mm:ss");
                persianDate += $" {time}";
            }

            return persianDate;
        }

        return "0000/00/00 00:00:00";
    }
    
    
    public static string HejriToMiladi(string hejriDate ){
        string[] formats = { "yyyy/MM/dd HH:mm:ss", "yyyy/MM/dd","yyyy/MM/dd hh:mm:ss tt" };

        if (hejriDate!=null && DateTime.TryParseExact(hejriDate, formats, CultureInfo.InvariantCulture, DateTimeStyles.None, out DateTime hejriDateTime))
        {
        // Helpers.dd(hejriDate);
            PersianCalendar pc = new PersianCalendar();
            int year = int.Parse(hejriDateTime.ToString("yyyy", CultureInfo.InvariantCulture));
            int month = int.Parse(hejriDateTime.ToString("MM", CultureInfo.InvariantCulture));
            int day = int.Parse(hejriDateTime.ToString("dd", CultureInfo.InvariantCulture));

            if (formats[0].Length <= hejriDate.Length)
            {
                int hour = hejriDateTime.Hour;
                int minute = hejriDateTime.Minute;
                int second = hejriDateTime.Second;

                DateTime miladiDateTime2 = pc.ToDateTime(year, month, day, hour, minute, second, 0);

                return miladiDateTime2.ToString("yyyy-MM-dd HH:mm:ss");
            }
            else
            {
                DateTime miladiDateTime2 = pc.ToDateTime(year, month, day, 0, 0, 0, 0);

                return miladiDateTime2.ToString("yyyy-MM-dd");
            }
        }

        return "0000-00-00 00:00:00";


    }
    
    public static DateTime HejriToMiladiDateTime(string hejriDate){
        string dateString = HejriToMiladi(hejriDate);
        DateTime dateTime;

        return DateTime.Parse(dateString);
    }
        
    
    
    
    public static DateTime GetTimeZonedDatetime(){
        // TimeZoneInfo tehranTimeZone = TimeZoneInfo.FindSystemTimeZoneById("Asia/Tehran");
        // DateTime serverTime = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, tehranTimeZone);
        DateTime serverTime = DateTime.Now;
        return serverTime;
    }

    public static string GetServerDateTime(){
        return GetTimeZonedDatetime().ToString("yyyy-MM-dd HH:mm:ss");
    }
    public static DateTime GetServerDateTimeType(){
        return GetTimeZonedDatetime();
    }

    public static string GetServerDate(){
        return GetTimeZonedDatetime().ToString("yyyy-MM-dd");
    }

    public static string GetServerTime(){
        return GetTimeZonedDatetime().ToString("HH:mm:ss");
    }

    
    
    
      
    public static string ExportExcelFile(List<List<object>> items,string excelFileName,string filename=null){
        // Path to the template file
        string templatePath = Path.Combine(Directory.GetCurrentDirectory(), $"wwwroot/excel_templates/{excelFileName}.xlsx");

        // Open the template
        using (FileStream file = new FileStream(templatePath, FileMode.Open, FileAccess.Read)){
            IWorkbook workbook = new XSSFWorkbook(file);
            ISheet sheet = workbook.GetSheetAt(0); // Assuming data should go into the first sheet

            // Start populating from row 1 (assuming row 0 contains headers)
            int rowIndex = 1;

            foreach (var item in items){
                IRow row = sheet.GetRow(rowIndex) ?? sheet.CreateRow(rowIndex);
                for (int i = 0; i < item.Count; i++){
                    row.CreateCell(i).SetCellValue(item[i]+""); 

                }
                rowIndex++;
            }

            if (filename == null)
                filename = Path.GetFileNameWithoutExtension(excelFileName);
            else
                filename = Path.GetFileNameWithoutExtension(filename);
            
            // Save the file to a temporary location
            string tmpPath = "/tmp/" + $"{filename}_{DateTimeOffset.Now.ToUnixTimeMilliseconds()}.xlsx";
            string tempFilePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot"+tmpPath);

            using (FileStream outputFile = new FileStream(tempFilePath, FileMode.Create, FileAccess.Write)){
                workbook.Write(outputFile); // Write to the file
            }
            workbook.Close();
            
            return tmpPath; // Return the path to the saved file
        }
    }


    public static string UC(this int? value, string key){
        return UC(value.ToString(), key);
    }

    public static string UC(this string? stringValue, string key){
        var jsonPath = "utils.json"; // Adjust the path as needed
        var jsonData = File.ReadAllText(jsonPath);
        var jsonObject = JObject.Parse(jsonData);

        foreach (var property in jsonObject.Properties()){
            string key1 = property.Name;
            JToken value = property.Value;

            if (key1 == key){
                foreach (var nestedProperty in value.Children<JProperty>()){
                    if (nestedProperty.Name == stringValue){
                        return nestedProperty.Value.ToString();
                    }
                }
            }
        }

        return stringValue;
    }
    public static object UCReverse(this string? stringValue, string key,object defaultVal=null){
        var jsonPath = "utils.json"; // Adjust the path as needed
        var jsonData = File.ReadAllText(jsonPath);
        var jsonObject = JObject.Parse(jsonData);

        foreach (var property in jsonObject.Properties()){
            string key1 = property.Name;
            JToken value = property.Value;

            if (key1 == key){
                foreach (var nestedProperty in value.Children<JProperty>()){
                    if (nestedProperty.Value.ToString() == stringValue){
                        return nestedProperty.Name;
                    }
                }
            }
        }

        if (defaultVal != null)
            return defaultVal;
        
        return stringValue;
    }
    
    
    public static string GenerateToken(int length = 50)
    {
        char[] chars =
            "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890".ToCharArray();

        byte[] data = new byte[4 * length];
        using (var crypto = RandomNumberGenerator.Create())
        {
            crypto.GetBytes(data);
        }

        var result = new StringBuilder(length);
        for (int i = 0; i < length; i++)
        {
            var rnd = BitConverter.ToUInt32(data, i * 4);
            var idx = rnd % chars.Length;

            result.Append(chars[idx]);
        }

        return result.ToString();
    }


    public class KMZVM {
        public string Name;
        public string Coordinates;
    }

    public static string ExportKmzFile(List<KMZVM> items, string preName = ""){
// Create a KML document
        var kml = new Kml();
        var document = new Document();
        kml.Feature = document;
        //----------------------------------------------


        // var privs = _db.AmlakPrivateNews.ToList();
        foreach (var item in items){
            var outerBoundary = new LinearRing();
            var coordinateCollection = new CoordinateCollection();
            var coordinates = JsonConvert.DeserializeObject<List<List<double>>>(item.Coordinates.ToString());
            // var str = "";
            if (coordinates.Count == 1){
                var placemark = new Placemark{
                    Name = item.Name,
                    Geometry = new Point{ Coordinate = new Vector(coordinates[0][0], coordinates[0][1]) }
                };
                document.AddFeature(placemark);
            }
            else{
                foreach (var coordinate in coordinates){
                    // str+=coordinate[1] +","+ coordinate[0]+"   /    ";
                    coordinateCollection.Add(new Vector(coordinate[1], coordinate[0]));
                }

                outerBoundary.Coordinates = coordinateCollection;

                var polygon1 = new Polygon{
                    OuterBoundary = new OuterBoundary{ LinearRing = outerBoundary }
                };
                var placemark = new Placemark{
                    Name = item.Name,
                    Geometry = polygon1
                };
                document.AddFeature(placemark);
            }
        }


        //----------------------------------------------

// Save the KML to a KMZ file
        using var memoryStream = new MemoryStream();
        KmlFile kmlFile = KmlFile.Create(kml, false);
        kmlFile.Save(memoryStream);

        string tmpPath = "/tmp/" + $"{preName}_{DateTimeOffset.Now.ToUnixTimeMilliseconds()}.kmz";
        string fullPath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot"+tmpPath);

        using var fileStream = new FileStream(fullPath, FileMode.Create);
        using var archive = new ZipArchive(fileStream, ZipArchiveMode.Create, true);

        var entry = archive.CreateEntry("doc.kml");
        using var entryStream = entry.Open();
        memoryStream.Seek(0, SeekOrigin.Begin);
        memoryStream.CopyTo(entryStream);

        return tmpPath;
    }
     
    
    
    
    public static String GetUserIp(HttpContext context)
    {
        
        string[] keys = { "HTTP_CLIENT_IP", "HTTP_X_FORWARDED_FOR", "HTTP_X_FORWARDED", "HTTP_X_CLUSTER_CLIENT_IP", "HTTP_FORWARDED_FOR", "HTTP_FORWARDED", "REMOTE_ADDR" };
    
        foreach (var key in keys)
        {
            if (context.Request.Headers.ContainsKey(key)){
                foreach (var ip in context.Request.Headers[key].ToString().Split(','))
                {
                    var trimmedIp = ip.Trim();
                    if (IPAddress.TryParse(trimmedIp, out IPAddress parsedIp) &&
                        (!IPAddress.IsLoopback(parsedIp) ))//|| !IPAddress.IsIPv6LinkLocal(parsedIp)
                    {
                        return trimmedIp;
                    }
                }
            }
        }

        return context.Connection.RemoteIpAddress?.ToString();
    }

    public static string GetUserDeviceInfo(HttpContext context)
    {
        if (context.Request.Headers.TryGetValue("User-Agent", out var userAgent))
        {
            return userAgent.ToString();
        }

        return "Unknown Device";
    }

}
}
