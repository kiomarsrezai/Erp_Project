﻿using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.FileProviders;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Contract;
using NewsWebsite.ViewModels.Api.Public;
using Newtonsoft.Json;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq.Dynamic.Core;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Data;
using NewsWebsite.Data.Models;
using NewsWebsite.Data.Models.AmlakInfo;
using NewsWebsite.Data.Repositories;
using NewsWebsite.ViewModels;
using NewsWebsite.ViewModels.Api.Contract.AmlakInfo;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using System.Linq;
using NewsWebsite.ViewModels.Api.Contract.AmlakLog;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;

namespace NewsWebsite.Areas.Api.Controllers.v1.amlak
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class AmlakInfoApiController : EnhancedController
    {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        protected readonly ProgramBuddbContext _db;

        public AmlakInfoApiController(IUnitOfWork uw, IConfiguration config, IWebHostEnvironment webHostEnvironment,ProgramBuddbContext db)
        {
            _config = config;
            _uw = uw;
            _webHostEnvironment = webHostEnvironment;
            _db=db;

        }

        
        [HttpGet]
        [Route("UpdateDataFromSdi_ahvaz_kiosk14000719_8798")]
        public async Task<ApiResult<ResponseLayerDto>> UpdateDataFromSdi_ahvaz_kiosk()
        {
            var options = new RestClientOptions("https://sdi.ahvaz.ir")
            {
                MaxTimeout = -1,
            };
            var client = new RestClient(options);
            var request = new RestRequest("/geoapi/user/login/", Method.Post);
            request.AddHeader("content-type", "application/json");
            request.AddHeader("Accept", "application/json, text/plain, */*");
            request.AddHeader("Cookie", "cookiesession1=678ADA629490114186F01A0EF409171D; csrftoken=dKwYwwwT5wcj60bhh4ojKy1R4JQrdxD7; sessionid=bsj9qwbunhlpl7bymk7o9uy3x6cr9ubg");
            var body = @"{" + "\n" +
            @" ""username"": ""ERP_Fava""," + "\n" +
            @" ""password"":" + "\n" +
            @"""123456""," + "\n" +
            @" ""appId"": ""mobilegis""" + "\n" +
            @"}";
            request.AddStringBody(body, DataFormat.Json);
            RestResponse responselogin = await client.ExecuteAsync(request);
            var resplogin = JsonConvert.DeserializeObject<ResponseLoginSdiDto>(responselogin.Content.ToString());

            //var options2 = new RestClientOptions("https://sdi.ahvaz.ir")
            //{
            //    MaxTimeout = -1,
            //};
            //var client2 = new RestClient(options2);
            //var request2 = new RestRequest("/geoserver/ows?service=wfs&version=1.0.0&request=GetFeature&typeName=ahvaz_kiosk14000719_8798&srsname=EPSG:4326&outputFormat=application/json&maxFeatures=10000&startIndex=0&authkey="+ resplogin.api_key.ToString(), Method.Get);
            //request.AddHeader("content-type", "application/json");
            //request.AddHeader("Accept", "application/json, text/plain, */*");
            //request.AddHeader("Cookie", "cookiesession1=678ADA629490114186F01A0EF409171D; csrftoken=dKwYwwwT5wcj60bhh4ojKy1R4JQrdxD7; sessionid=bsj9qwbunhlpl7bymk7o9uy3x6cr9ubg");
            //RestResponse response2 = await client2.ExecuteAsync(request2);
            ////UTF8Encoding uTF8Encoding = new UTF8Encoding();
            ////uTF8Encoding.GetBytes(response2.Content.ToString());
            //byte[] messageBytes = Encoding.UTF8.GetBytes(response2.Content);
            //string newmessage = Encoding.UTF8.GetString(messageBytes, 0, messageBytes.Length);
            var options2 = new RestClientOptions("https://sdi.ahvaz.ir")
            {
                MaxTimeout = -1,
            };
            var client2 = new RestClient(options2);
            var request2 = new RestRequest("/geoserver/ows?service=wfs&version=1.0.0&request=GetFeature&typeName=ahvaz_kiosk14000719_8798&srsname=EPSG:4326&outputFormat=application/json&maxFeatures=10000&startIndex=0&authkey=e434be85d126299659334f104feffb18f51328a6", Method.Post);
            request2.AddHeader("content-type", "application/json");
            request2.AddHeader("Accept", "application/json, text/plain, */*");
            request2.AddHeader("Cookie", "cookiesession1=678ADA629490114186F01A0EF409171D; csrftoken=dKwYwwwT5wcj60bhh4ojKy1R4JQrdxD7; sessionid=bsj9qwbunhlpl7bymk7o9uy3x6cr9ubg");
            RestResponse response2 = await client2.ExecuteAsync(request2);
            byte[] messageBytes = Encoding.UTF8.GetBytes(response2.Content);
            string newmessage = Encoding.UTF8.GetString(messageBytes, 0, messageBytes.Length);

            var respLayer = JsonConvert.DeserializeObject<SdiDto>(newmessage.ToString());

            for (int i = 0; i < respLayer.TotalFeatures; i++){
                var feature = respLayer.Features[i];

                var oldItem = await _db.AmlakInfos.FirstOrDefaultAsync(a => a.SdiId == feature.Id);

                if (oldItem == null){
                    var item = new AmlakInfo(){
                        SdiId = feature.Id,
                        AreaId = feature.Properties.Mantaqe != null ? feature.Properties.Mantaqe.ToInt() : 52,
                        Coordinates = feature.Geometry == null ? "[]" : JsonConvert.SerializeObject(feature.Geometry.Coordinates[0]),
                        Masahat = 0,
                        AmlakInfoKindId= 3,
                        EstateInfoName = feature.Properties.Name,
                        EstateInfoAddress = feature.Properties.Address,
                        CreatedAt = Helpers.GetServerDateTimeType(),
                        UpdatedAt = Helpers.GetServerDateTimeType(),
                    };
                    _db.Add(item);
                    await _db.SaveChangesAsync();
                    
                    await SaveLogAsync(_db, item.Id, TargetTypes.AmlakInfo, "ملک عمومی ثبت شد");

                }
                else{
                    oldItem.AreaId = feature.Properties.Mantaqe != null ? feature.Properties.Mantaqe.ToInt() : 52;
                    oldItem.Coordinates = feature.Geometry == null ? "[]" : JsonConvert.SerializeObject(feature.Geometry.Coordinates[0]);
                    await _db.SaveChangesAsync();
                }
            }
            
            // for (int i = 0; i <= respLayer.totalFeatures; i++)
            // {
            //     using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            //     {
            //         using (SqlCommand sqlCommand = new SqlCommand("SP012_AmlakInfo_Insert", sqlconnect))
            //         {
            //             sqlconnect.Open();
            //             sqlCommand.Parameters.AddWithValue("AmlakInfoId", respLayer.features[i].id);
            //             sqlCommand.Parameters.AddWithValue("AreaId", respLayer.features[i].properties.mantaqe);
            //             sqlCommand.Parameters.AddWithValue("AmlakInfoKindId", 3);
            //             sqlCommand.Parameters.AddWithValue("EstateInfoName", respLayer.features[i].properties.name);
            //             sqlCommand.Parameters.AddWithValue("EstateInfoAddress", respLayer.features[i].properties.adress);
            //             sqlCommand.Parameters.AddWithValue("AmlakInfolong", respLayer.features[i].geometry.coordinates[0][0].ToString());
            //             sqlCommand.Parameters.AddWithValue("AmlakInfolate", respLayer.features[i].geometry.coordinates[0][1].ToString());
            //             sqlCommand.CommandType = CommandType.StoredProcedure;
            //             SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
            //
            //         }
            //     }
            // }

            return Ok(respLayer);
        }
    

        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------

        [Route("List")]
        [HttpGet]
        public async Task<ApiResult<object>> AmlakInfoList(AmlakInfoReadInputVm param){
            await CheckUserAuth(_db);

            var builder = _db.AmlakInfos
                .Search(param.Search)
                .AreaId(param.AreaId)
                .OwnerId(param.OwnerId)
                .AmlakInfoKindId(param.AmlakInfoKindId)
                .MainPlateNumber(param.MainPlateNumber).SubPlateNumber(param.SubPlateNumber)
                .Where(a => a.Rentable == param.Rentable);
            
            if (!string.IsNullOrEmpty(param.SupplierName)){
                builder = builder
                    .Join(_db.AmlakInfoContracts,
                        a => a.Id,
                        c => c.AmlakInfoId,
                        (a, c) => new { AmlakInfo = a, Contract = c })
                    .Join(_db.AmlakInfoContractSuppliers,
                        ac => ac.Contract.Id,
                        cs => cs.ContractId,
                        (ac, cs) => new { ac.AmlakInfo, ContractSupplier = cs })
                    .Join(_db.Suppliers,
                        acs => acs.ContractSupplier.SupplierId,
                        s => s.Id,
                        (acs, s) => new { acs.AmlakInfo, Supplier = s })
                    .Where(acs => acs.Supplier.FirstName.Contains(param.SupplierName) || acs.Supplier.LastName.Contains(param.SupplierName) || (acs.Supplier.FirstName+" "+acs.Supplier.LastName).Contains(param.SupplierName))
                    .Select(acs => acs.AmlakInfo);
            }
 
            
            
            switch (param.ContractStatus){
                case 0: // all
                    break;
                case 1: // withContract
                    builder = builder.Where(ai => ai.Contracts.Any());
                    break;
                case 2: // withoutContract
                    builder = builder.Where(ai => !ai.Contracts.Any());
                    break;
                case 3: // withActiveContract
                    builder = builder.Where(ai => ai.Contracts.Any(c => c.DateEnd == null || c.DateEnd > DateTime.Now));
                    break;
                case 4: // withoutActiveContract
                    builder = builder.Where(ai => !ai.Contracts.Any(c => c.DateEnd == null || c.DateEnd > DateTime.Now));
                    break;
                case 5: // 2 month to finish
                    builder = builder.Where(ai => ai.Contracts.Any(c => c.DateEnd != null && c.DateEnd > DateTime.Now && c.DateEnd < DateTime.Now.AddMonths(2)));
                    break;
            }
            switch (param.ZemanatStatus){
                case 0: // all
                    break;
                case 1: // ValidZemanatDate
                    builder = builder.Where(ai => ai.Contracts.Any(c => c.ZemanatEndDate == null || c.ZemanatEndDate > DateTime.Now));
                    break;
                case 2: // ExpiredZemanatDate
                    builder = builder.Where(ai => !ai.Contracts.Any(c => c.ZemanatEndDate == null || c.ZemanatEndDate > DateTime.Now));
                    break;
                
                case 3: // 2 month to finish
                    builder = builder.Where(ai => ai.Contracts.Any(c => c.ZemanatEndDate == null && c.ZemanatEndDate > DateTime.Now && c.ZemanatEndDate < DateTime.Now.AddMonths(2)));
                    break;
                
            }
            var pageCount = (int)Math.Ceiling((await builder.CountAsync())/Convert.ToDouble(param.PageRows));

            if (param.Export == 1 || param.ExportKMZ ==1){
                param.Page = 1;
                param.PageRows = 100000;
            }
            
            if (param.ForMap == 0){
                builder = builder
                    .Include(a => a.Area)
                    .Include(a => a.Owner)
                    .Include(a => a.AmlakInfoKind)
                    .OrderBy(param.Sort,param.SortType)
                    .Page2(param.Page, param.PageRows);
            }
            else{
                builder = builder
                    .Include(a => a.AmlakInfoKind);
            }

           
            var items = await builder.ToListAsync();
            
            foreach (var item in items){
                if (item.Area!=null && item.Area.Id == 9){
                    item.Area.AreaName = "شهرداری مرکز";
                }
                if (item.Owner!=null && item.Owner.Id == 9){
                    item.Owner.AreaName = "شهرداری مرکز";
                }
            }
            if (param.Export == 1){
                var fileUrl = ExportExcelAmlak(items);
                return Ok(new {fileUrl});
            }
            if (param.ExportKMZ == 1){
                var fileUrl = ExportKmz(items);
                return Ok(new {fileUrl});
            }
            
            var finalItems = MyMapper.MapTo<AmlakInfo, AmlakInfoListVm>(items);

            return Ok(new {items=finalItems,pageCount});
        }

        
        
        private static object ExportExcelAmlak(List<AmlakInfo> items){
            var finalItems = new List<List<object>>();

            foreach (var item in items){
                var row = new List<object>();
                row.Add(item.Id);
                row.Add(item.Owner.AreaName);
                row.Add(item.Area.AreaName);
                row.Add(item.IsSubmited);
                row.Add(item.Masahat);
                row.Add(item.AmlakInfoKind.AmlakInfoKindName);
                row.Add(item.EstateInfoName);
                row.Add(item.EstateInfoAddress);
                row.Add(item.CurrentStatusText);
                row.Add(item.StructureText);
                row.Add(item.OwnerTypeText);
                row.Add(item.Coordinates);
                row.Add(item.CodeUsing);
                row.Add(item.TypeUsing);
                row.Add(item.Code);
                
                finalItems.Add(row);
            }

            return Helpers.ExportExcelFile(finalItems, "amlak_info");
        }

        
        private static object ExportKmz(List<AmlakInfo> items){
            var list = new List<Helpers.KMZVM>();
            foreach (var item in items){
                list.Add(new Helpers.KMZVM{Name = "id:" + item.Id, Coordinates = item.Coordinates });
            }
            
            return Helpers.ExportKmzFile(list,"amlak_info"); 
        }
        
        [Route("Map")]
        [HttpGet]
        public async Task<ApiResult<object>> AmlakInfoListMap(AmlakInfoListMapInputVm param){
            await CheckUserAuth(_db);

            var builder = _db.AmlakInfos
                .Search(param.Search)
                .AreaId(param.AreaId)
                .OwnerId(param.OwnerId)
                .AmlakInfoKindId(param.AmlakInfoKindId)
                .MainPlateNumber(param.MainPlateNumber).SubPlateNumber(param.SubPlateNumber)
                .Where(a => a.Rentable == param.Rentable);
            
            if (!string.IsNullOrEmpty(param.SupplierName)){
                builder = builder
                    .Join(_db.AmlakInfoContracts,
                        a => a.Id,
                        c => c.AmlakInfoId,
                        (a, c) => new { AmlakInfo = a, Contract = c })
                    .Join(_db.AmlakInfoContractSuppliers,
                        ac => ac.Contract.Id,
                        cs => cs.ContractId,
                        (ac, cs) => new { ac.AmlakInfo, ContractSupplier = cs })
                    .Join(_db.Suppliers,
                        acs => acs.ContractSupplier.SupplierId,
                        s => s.Id,
                        (acs, s) => new { acs.AmlakInfo, Supplier = s })
                    .Where(acs => acs.Supplier.FirstName.Contains(param.SupplierName) || acs.Supplier.LastName.Contains(param.SupplierName) || (acs.Supplier.FirstName+" "+acs.Supplier.LastName).Contains(param.SupplierName))
                    .Select(acs => acs.AmlakInfo);
            }
            builder = builder.Include(a => a.AmlakInfoKind);

            
            var withoutActiveContractsZValid= await builder
                .Where(ai => !ai.Contracts.Any(c => c.DateEnd == null || c.DateEnd > DateTime.Now))//withoutActiveContract
                .Where(ai => ai.Contracts.Any(c => c.ZemanatEndDate == null || c.ZemanatEndDate > DateTime.Now)) // ValidZemanatDate
                .ToListAsync();
            
            var withoutActiveContractsZExpired= await builder
                .Where(ai => !ai.Contracts.Any(c => c.DateEnd == null || c.DateEnd > DateTime.Now)) // withoutActiveContract
                .Where(ai => !ai.Contracts.Any(c => c.ZemanatEndDate == null || c.ZemanatEndDate > DateTime.Now))//ExpiredZemanatDate
                .ToListAsync();
            
            
            var activeContracts2MonthZValid= await builder
                .Where(ai => ai.Contracts.Any(c => c.DateEnd != null && c.DateEnd > DateTime.Now && c.DateEnd < DateTime.Now.AddMonths(2)))
                .Where(ai => ai.Contracts.Any(c => c.ZemanatEndDate == null || c.ZemanatEndDate > DateTime.Now)) // ValidZemanatDate
                .ToListAsync();
            var activeContracts2MonthZExpired= await builder
                .Where(ai => ai.Contracts.Any(c => c.DateEnd != null && c.DateEnd > DateTime.Now && c.DateEnd < DateTime.Now.AddMonths(2)))
                .Where(ai => !ai.Contracts.Any(c => c.ZemanatEndDate == null || c.ZemanatEndDate > DateTime.Now))//ExpiredZemanatDate
                .ToListAsync();
            
            
            var activeContractsMore2MonthZValid= await builder
                .Where(ai => ai.Contracts.Any(c => c.DateEnd != null && c.DateEnd > DateTime.Now.AddMonths(2)))
                .Where(ai => ai.Contracts.Any(c => c.ZemanatEndDate == null || c.ZemanatEndDate > DateTime.Now)) // ValidZemanatDate
                .ToListAsync(); 
            var activeContractsMore2MonthZExpired= await builder
                .Where(ai => ai.Contracts.Any(c => c.DateEnd != null && c.DateEnd > DateTime.Now.AddMonths(2)))
                .Where(ai => !ai.Contracts.Any(c => c.ZemanatEndDate == null || c.ZemanatEndDate > DateTime.Now))//ExpiredZemanatDate
                .ToListAsync();

            
            if(param.ContractStatus==1) // قرارداد فعال بیش از 2 ماه
                return Ok(new{
                    activeContractsMore2MonthZValid= MyMapper.MapTo<AmlakInfo, AmlakInfoListVm>(activeContractsMore2MonthZValid),
                    activeContractsMore2MonthZExpired= MyMapper.MapTo<AmlakInfo, AmlakInfoListVm>(activeContractsMore2MonthZExpired)
                });
            
            if(param.ContractStatus==2) // قرارداد فعال کمتر از 2 ماه
                return Ok(new{
                    activeContracts2MonthZValid= MyMapper.MapTo<AmlakInfo, AmlakInfoListVm>(activeContracts2MonthZValid),
                    activeContracts2MonthZExpired= MyMapper.MapTo<AmlakInfo, AmlakInfoListVm>(activeContracts2MonthZExpired),
                });
             if(param.ContractStatus==3) // بدون قرارداد
                return Ok(new{
                    withoutActiveContractsZValid= MyMapper.MapTo<AmlakInfo, AmlakInfoListVm>(withoutActiveContractsZValid),
                    withoutActiveContractsZExpired= MyMapper.MapTo<AmlakInfo, AmlakInfoListVm>(withoutActiveContractsZExpired),
                });
            
            return Ok(new{
                withoutActiveContractsZValid= MyMapper.MapTo<AmlakInfo, AmlakInfoListVm>(withoutActiveContractsZValid),
                withoutActiveContractsZExpired= MyMapper.MapTo<AmlakInfo, AmlakInfoListVm>(withoutActiveContractsZExpired),
                activeContracts2MonthZValid= MyMapper.MapTo<AmlakInfo, AmlakInfoListVm>(activeContracts2MonthZValid),
                activeContracts2MonthZExpired= MyMapper.MapTo<AmlakInfo, AmlakInfoListVm>(activeContracts2MonthZExpired),
                activeContractsMore2MonthZValid= MyMapper.MapTo<AmlakInfo, AmlakInfoListVm>(activeContractsMore2MonthZValid),
                activeContractsMore2MonthZExpired= MyMapper.MapTo<AmlakInfo, AmlakInfoListVm>(activeContractsMore2MonthZExpired)
            }); 
        }

        
        
        [Route("Read")]
        [HttpGet]
        public async Task<ApiResult<AmlakInfoReadVm>> AmlakInfoRead(PublicParamIdViewModel param){
            await CheckUserAuth(_db);

            var item = await _db.AmlakInfos
                .Include(a=>a.Area)
                .Include(a => a.Owner)
                .Include(a=>a.AmlakInfoKind)
                .Id(param.Id).FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("پیدا نشد");

            
            if (item.Area!=null && item.Area.Id == 9){
                item.Area.AreaName = "شهرداری مرکز";
            }
            if (item.Owner!=null && item.Owner.Id == 9){
                item.Owner.AreaName = "شهرداری مرکز";
            }
            
            var finalItem = MyMapper.MapTo<AmlakInfo, AmlakInfoReadVm>(item);
            var activeCount = await _db.AmlakInfoContracts.AmlakInfoId(item.Id).Where(c => c.DateEnd > DateTime.Now).CountAsync();
            finalItem.IsContracted = activeCount > 0;
        
            return Ok(finalItem);
        }
        //
        //
        [Route("Update")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakInfoUpdate([FromBody] AmlakInfoUpdateVm param){
            await CheckUserAuth(_db);

            var item = await _db.AmlakInfos.Id(param.Id).FirstOrDefaultAsync();
            if(item==null)
                return BadRequest("آیتم پیدا نشد");
        
            item.OwnerId = param.OwnerId;
            item.AreaId = param.AreaId;
            // item.IsSubmited = param.IsSubmited;
            item.Masahat = param.Masahat;
            item.AmlakInfoKindId = param.AmlakInfoKindId;
            item.EstateInfoName = param.EstateInfoName;
            item.EstateInfoAddress = param.EstateInfoAddress;
            item.CurrentStatus = param.CurrentStatus;
            item.Structure = param.Structure;
            item.OwnerType = param.OwnerType;
            item.Code = param.Code;
            item.MainPlateNumber = param.MainPlateNumber;
            item.SubPlateNumber = param.SubPlateNumber;
            item.UpdatedAt = Helpers.GetServerDateTimeType();
            await _db.SaveChangesAsync();
            
            await SaveLogAsync(_db, item.Id, TargetTypes.AmlakInfo, "ملک عمومی ویرایش شد");
   
            return Ok(item.Id.ToString());
        }
        //
        
        [Route("AmlakInfo/Delete")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakInfoDelete([FromBody] PublicParamIdViewModel param)
        {
            await CheckUserAuth(_db);

            var item = await _db.AmlakInfos.Id(param.Id).FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("پیدا نشد");
            
            // todo: check has contract or not
            
            
            var images = await _db.AmlakAttachs.Where(e=>e.TargetType=="AmlakInfos").Where(a=>a.TargetId==param.Id).ToListAsync();
            // todo: remove files from server
            _db.RemoveRange(images);
            _db.Remove(item);
            _db.SaveChanges();
            
            await SaveLogAsync(_db, item.Id, TargetTypes.AmlakInfo, "ملک عمومی حذف شد");

            return Ok("حذف شد");
        }

        
        
        
        [Route("Kind")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakInfoKindVm>>> AmlakInfoKind(int rentable=1)
        {
            await CheckUserAuth(_db);

            var items = await _db.AmlakInfoKinds.Rentable(rentable).ToListAsync();
            var finalItems = MyMapper.MapTo<AmlakInfoKind, AmlakInfoKindVm>(items);

            return Ok(finalItems);
        }

    }
}
