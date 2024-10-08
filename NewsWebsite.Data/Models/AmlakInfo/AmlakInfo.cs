﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Common;
using NewsWebsite.ViewModels.Api.Contract.AmlakInfo;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.Data.Models.AmlakInfo {
    [Table("tblAmlakInfo")]
    public class AmlakInfo:BaseModel {
        public int Id{ get; set; }
        public int AreaId{ get; set; }
        public bool? IsSubmited{ get; set; }
        public double? Masahat{ get; set; }
        public int AmlakInfoKindId{ get; set; }
        public string EstateInfoName{ get; set; }
        public string EstateInfoAddress{ get; set; }
        public string CurrentStatus{ get; set; } // AmlakInfoStatuses
        public string Structure{ get; set; } // AmlakInfoStructures
        public string Owner{ get; set; } // AmlakInfoOwners
        public string AmlakInfolate{ get; set; }
        public string AmlakInfolong{ get; set; }
        public string CodeUsing{ get; set; }
        public bool? IsContracted{ get; set; }
        public string TypeUsing{ get; set; }
        public int Rentable{ get; set; } 
        public DateTime? CreatedAt{ get; set; }
        public DateTime? UpdatedAt{ get; set; }

        public virtual  AmlakInfoKind AmlakInfoKind{ get; set; }
        public virtual  TblAreas Area{ get; set; }
        
        public ICollection<AmlakInfoContract> Contracts{ get; set; }
        
        
        [NotMapped]
        public string? CreatedAtFa{get{ return Helpers.MiladiToHejri(CreatedAt); }}

        [NotMapped]
        public string? UpdatedAtFa{get{ return Helpers.MiladiToHejri(UpdatedAt); }}
    }    

    

    public static class AmlakInfoExtensions {

        public static IQueryable<AmlakInfo> Rentable(this IQueryable<AmlakInfo> query, int? value){
            if (BaseModel.CheckParameter(value,null)){
                return query.Where(e => e.Rentable == value);
            }
            return query;
        }
        public static IQueryable<AmlakInfo> AreaId(this IQueryable<AmlakInfo> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.AreaId == value);
            }
            return query;
        }
        public static IQueryable<AmlakInfo> AmlakInfoKindId(this IQueryable<AmlakInfo> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.AmlakInfoKindId == value);
            }
            return query;
        }
        public static IQueryable<AmlakInfo> Search(this IQueryable<AmlakInfo> query, string? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(a=> EF.Functions.Like(a.EstateInfoName, $"%{value}%") || 
                                       EF.Functions.Like(a.EstateInfoAddress, $"%{value}%"));
            }
            return query;
        }
    }
}