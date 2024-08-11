using System;
using System.Globalization;
using System.Linq;
using Microsoft.IdentityModel.Tokens;
using NewsWebsite.Common;
using Newtonsoft.Json;

namespace NewsWebsite.ViewModels.Api.Public {
    public class BaseModel {
        public int Id{ get; set; }

        public static bool CheckParameter(object? parameter, object? defaultValue = null){
            if (parameter is null || parameter is string str && string.IsNullOrWhiteSpace(str) || parameter.Equals(defaultValue)){
                return false;
            }

            return true;
        }

        public static string? correctImage(string? image, string path, bool noDefault = false){
            if (noDefault && image == null){
                return image;
            }

            if (image == null || !image.Any())
                image = "default.png";

            if (image != null && image.StartsWith("http")){
                return image;
            }

            return path + image;
        }
    }

    public static class BaseExtensions {
        public static IQueryable<TEntity> Id<TEntity>(this IQueryable<TEntity> query, int? value) where TEntity : BaseModel{
            if (BaseModel.CheckParameter(value)){
                return query.Where(e => e.Id == value);
            }

            return query;
        }


        public static IQueryable<TEntity> Id<TEntity>(this IQueryable<TEntity> query, string? value) where TEntity : BaseModel{
            if (BaseModel.CheckParameter(value)){
                var value2 = Convert.ToInt32(value);
                return query.Where(e => e.Id == value2);
            }

            return query;
        }
    }
}