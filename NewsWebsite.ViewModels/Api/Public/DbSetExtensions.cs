using System;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Linq.Expressions;
using System.Net;
using System.Threading.Tasks;
using NewsWebsite.Common;
using System.Linq;

namespace NewsWebsite.ViewModels.Api.Public {
    public static class DbSetExtensions {
        //----------------------------------------------------------------------------------------------------------------
        //-----------------------------------------------  Order by   ----------------------------------------------------
        //----------------------------------------------------------------------------------------------------------------

        public static IQueryable<T> OrderBy<T>(this IQueryable<T> source, string orderBy, string sort = "ASC"){
            if (sort.ToLower() == "asc"){
                return source.GetOrderByQuery(CapitalizeFirstLetter(orderBy), "OrderBy");
            }
            else{
                return source.GetOrderByQuery(CapitalizeFirstLetter(orderBy), "OrderByDescending");
            }
        }

        private static IQueryable<T> GetOrderByQuery<T>(this IQueryable<T> source, string orderBy, string methodName){
            var sourceType = typeof(T);
            var property = sourceType.GetProperty(orderBy);
            var parameterExpression = Expression.Parameter(sourceType, "x");
            var getPropertyExpression = Expression.MakeMemberAccess(parameterExpression, property);
            var orderByExpression = Expression.Lambda(getPropertyExpression, parameterExpression);
            var resultExpression = Expression.Call(typeof(Queryable), methodName,
                new[]{ sourceType, property.PropertyType }, source.Expression,
                orderByExpression);

            return source.Provider.CreateQuery<T>(resultExpression);
        }

        public static string CapitalizeFirstLetter(string input){
            if (string.IsNullOrEmpty(input)){
                return input;
            }

            char[] charArray = input.ToCharArray();
            charArray[0] = char.ToUpper(charArray[0]);
            return new string(charArray);
        }

        //----------------------------------------------------------------------------------------------------------------
        //-----------------------------------------------  first and find   ----------------------------------------------
        //----------------------------------------------------------------------------------------------------------------

        
        public static TEntity FindOrError<TEntity>(this IQueryable<TEntity> query, string id, string message = "آیتمی با این شناسه یافت نشد!") where TEntity : BaseModel{
            return FindOrError(query, id.ParseInt(), message);
        }

        public static TEntity FindOrError<TEntity>(this IQueryable<TEntity> query, int id, string message = "آیتمی با این شناسه یافت نشد!") where TEntity : BaseModel{
            var entity = query.FirstOrDefault(e => e.Id == id);
            // if (entity == null)
                // throw new ErrMessageException(message, HttpStatusCode.NotFound);

            return entity;
        }

        public static TEntity FirstOrError<TEntity>(this IQueryable<TEntity> query, string message = "Item not found") where TEntity : BaseModel{
            var entity = query.FirstOrDefault();
            // if (entity == null)
                // throw new ErrMessageException(message, HttpStatusCode.NotFound);

            return entity;
        }
        //----------------------------------------------------------------------------------------------------------------
        //-----------------------------------------------  pagination ----------------------------------------------------
        //----------------------------------------------------------------------------------------------------------------


        public static IQueryable<TEntity> Page<TEntity>(this IQueryable<TEntity> query, int? loadedCount, int perPage = 20) where TEntity : BaseModel{
            return query.Skip(loadedCount ?? 0).Take(perPage);
        }

        public static IQueryable<TEntity> Page<TEntity>(this IQueryable<TEntity> query, string? loadedCount, string perPage = "20") where TEntity : BaseModel{
            return query.Skip(Convert.ToInt32(loadedCount)).Take(Convert.ToInt32(perPage));
        }

        public static IQueryable<TEntity> Page2<TEntity>(this IQueryable<TEntity> query, int? page, int perPage = 20) where TEntity : BaseModel{
            if (page == null || page == 0)
                page = 1;

            var offset = (page - 1) * perPage;
            return query.Skip(offset ?? 0).Take(perPage);
        }

        public static IQueryable<TEntity> Page2<TEntity>(this IQueryable<TEntity> query, string? page, string? perPage = "20") where TEntity : BaseModel{
            var perPage2 = Convert.ToInt32(perPage);
            if (perPage == null)
                perPage2 = 20;
            return Page2(query, Convert.ToInt32(page), perPage2);
        }
    }
}