using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Common;
using NewsWebsite.Data.Models.AmlakInfo;
using NewsWebsite.Entities.identity;
using NewsWebsite.ViewModels.Api.Contract.AmlakLog;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakLog {
    [Table("tblBudgetLogs")]
    public class BudgetLog:BaseModel {
        public int TargetId{ get; set; }
        public TargetTypesBudgetLog TargetType{ get; set; }
        public DateTime? Date{ get; set; }
        public int? AdminId{ get; set; }
        public string Description{ get; set; }
        public string Coding{ get; set; }
        public string Url{ get; set; }
        public string Ip{ get; set; }
        public string Device{ get; set; }

        public User Admin{ get; set; }
        
        [NotMapped]
        public string? DateFa{get{ return Helpers.MiladiToHejri(Date); }}
        
        [NotMapped]
        public string? TargetTypeText{get{ return Helpers.UC(TargetType.ToString(),"budgetLogTargetType"); }}

    }


    public enum TargetTypesBudgetLog {
        Coding=1,
        AreaShare=2,
        Project=3,
        VasetAcc=4,
        User=5,
    }
}

//-------------------------------------------------------------------------------------------------
//-------------------------------------------    scopes    ----------------------------------------
//-------------------------------------------------------------------------------------------------


public static class LogExtensions {

    public static IQueryable<BudgetLog> TargetId(this IQueryable<BudgetLog> query, int? value){
        if (BaseModel.CheckParameter(value,0)){
            return query.Where(e => e.TargetId == value);
        }
        return query;
    }
    public static IQueryable<BudgetLog> TargetType(this IQueryable<BudgetLog> query, int? value){
        if (BaseModel.CheckParameter(value,0)){
            return query.Where(e => e.TargetType == (TargetTypesBudgetLog)Enum.ToObject(typeof(TargetTypesBudgetLog), value));
            ;
        }
        return query;
    }
    public static IQueryable<BudgetLog> AdminId(this IQueryable<BudgetLog> query, int? value){
        if (BaseModel.CheckParameter(value,0)){
            return query.Where(e => e.AdminId == value);
        }
        return query;
    }
    public static IQueryable<BudgetLog> Description(this IQueryable<BudgetLog> query, string? value){
        if (BaseModel.CheckParameter(value,0)){
            return query.Where(e => EF.Functions.Like(e.Description ,$"%{value}%"));
        }
        return query;
    }
    public static IQueryable<BudgetLog> Url(this IQueryable<BudgetLog> query, string? value){
        if (BaseModel.CheckParameter(value,0)){
            return query.Where(e => EF.Functions.Like(e.Url ,$"%{value}%"));
        }
        return query;
    }
    public static IQueryable<BudgetLog> Coding(this IQueryable<BudgetLog> query, string? value){
        if (BaseModel.CheckParameter(value,0)){
            // return query.Where(e => e.Coding==value);
            return query.Where(e => EF.Functions.Like(e.Coding ,$"%{value}%"));
        }
        return query;
    }
}