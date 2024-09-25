using Microsoft.AspNetCore.Hosting;
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
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;

namespace NewsWebsite.Areas.Api.Controllers.v1.amlak
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class ContractAmlakInfoApiController : EnhancedController
    {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        protected readonly ProgramBuddbContext _db;

        public ContractAmlakInfoApiController(IUnitOfWork uw, IConfiguration config, IWebHostEnvironment webHostEnvironment,ProgramBuddbContext db)
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
            var respLayer = JsonConvert.DeserializeObject<ResponseLayerDto>(newmessage.ToString());

            for (int i = 0; i <= respLayer.totalFeatures; i++)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP012_AmlakInfo_Insert", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("AmlakInfoId", respLayer.features[i].id);
                        sqlCommand.Parameters.AddWithValue("AreaId", respLayer.features[i].properties.mantaqe);
                        sqlCommand.Parameters.AddWithValue("AmlakInfoKindId", 3);
                        sqlCommand.Parameters.AddWithValue("EstateInfoName", respLayer.features[i].properties.name);
                        sqlCommand.Parameters.AddWithValue("EstateInfoAddress", respLayer.features[i].properties.adress);
                        sqlCommand.Parameters.AddWithValue("AmlakInfolong", respLayer.features[i].geometry.coordinates[0][0].ToString());
                        sqlCommand.Parameters.AddWithValue("AmlakInfolate", respLayer.features[i].geometry.coordinates[0][1].ToString());
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();

                    }
                }
            }

            return Ok(respLayer);
        }
    
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------

        [Route("Contract/List")]
        [HttpGet]
        public async Task<ApiResult<object>> ContractList(int amlakInfoId,int ownerId,int page=1,int pageRows=10){
            await CheckUserAuth(_db);

            var builder = _db.AmlakInfoContracts
                .AmlakInfoId(amlakInfoId)
                .OwnerId(ownerId);

            
            var items = await builder
                .Include(a=>a.Owner)
                .Page2(page,pageRows)
                .ToListAsync();
            var finalItems = MyMapper.MapTo<AmlakInfoContract, AmlakInfoContractListVm>(items);

            foreach (var finalItem in finalItems)
                finalItem.DateShamsi = finalItem.Date.ConvertMiladiToShamsi( "yyyy/MM/dd");;
            
            var pageCount = (int)Math.Ceiling((await builder.CountAsync())/Convert.ToDouble(pageRows));
            
            return Ok(new{items=finalItems,pageCount});
        }

       

        [Route("Contract/Read")]
        [HttpGet]
        public async Task<ApiResult<AmlakInfoContractReadVm>> ContractRead(int ContractId){
            await CheckUserAuth(_db);
            
            var item = await _db.AmlakInfoContracts
                .Id(ContractId)
                .Include(a=>a.AmlakInfo)
                .Include(a=>a.Prices)
                .Include(a=>a.Owner)
                .Include(a=>a.Suppliers)
                .ThenInclude(s=>s.Supplier)
                .FirstAsync();
            
            
            var finalItem = MyMapper.MapTo<AmlakInfoContract, AmlakInfoContractReadVm>(item);

            finalItem.DateShamsi = finalItem.Date.ConvertMiladiToShamsi( "yyyy/MM/dd");;
            finalItem.DateFromShamsi = finalItem.DateFrom.ConvertMiladiToShamsi( "yyyy/MM/dd");;
            finalItem.DateEndShamsi = finalItem.DateEnd.ConvertMiladiToShamsi( "yyyy/MM/dd");;

            return Ok(finalItem);
        }

        [Route("Contract/Insert")]
        [HttpPost]
        public async Task<ApiResult<string>> ContractInsert([FromBody] AmlakInfoContractInsertVm param){
            await CheckUserAuth(_db);

            var amlakInfo =await  _db.AmlakInfos.Id( param.AmlakInfoId).FirstOrDefaultAsync();
            if (amlakInfo == null)
                return BadRequest("ملک یافت نشد");
            
            // insert contract 

            var contract = new AmlakInfoContract();
            contract.AmlakInfoId=param.AmlakInfoId;
            contract.OwnerId=param.OwnerId;
            contract.DoingMethodId=param.DoingMethodId;
            contract.Number=param.Number;
            contract.Date=param.Date;
            contract.Description=param.Description;
            contract.DateFrom=Helpers.HejriToMiladiDateTime(param.DateFrom);
            contract.DateEnd=Helpers.HejriToMiladiDateTime(param.DateEnd);
            contract.ZemanatPrice=param.ZemanatPrice;
            contract.Type=param.Type;
            contract.ModatValue=param.ModatValue;
            contract.Nemayande=param.Nemayande;
            contract.Modir=param.Modir;
            contract.Sarparast=param.Sarparast;
            contract.TenderNumber=param.TenderNumber;
            contract.TenderDate=param.TenderDate;
            contract.CreatedAt = Helpers.GetServerDateTimeType();
            contract.UpdatedAt = Helpers.GetServerDateTimeType();
            
            _db.Add(contract);
            await _db.SaveChangesAsync();


            // update amlak info 
            if (amlakInfo.Masahat == null || amlakInfo.Masahat == 0){
                amlakInfo.Masahat = param.Masahat;
                amlakInfo.UpdatedAt = Helpers.GetServerDateTimeType();
            }

            if (string.IsNullOrEmpty(amlakInfo.Structure)){
                amlakInfo.Structure = param.Structure;
                amlakInfo.UpdatedAt = Helpers.GetServerDateTimeType();
            }

            if (string.IsNullOrEmpty(amlakInfo.Owner)){
                amlakInfo.Owner = param.Owner;
                amlakInfo.UpdatedAt = Helpers.GetServerDateTimeType();
            }

            if (string.IsNullOrEmpty(amlakInfo.TypeUsing)){
                amlakInfo.TypeUsing = param.TypeUsing;
                amlakInfo.UpdatedAt = Helpers.GetServerDateTimeType();
            }
            

            

            foreach (var price in param.Prices){

                var amlakInfoPrice = new AmlakInfoContractPrice();
                amlakInfoPrice.ContractId = contract.Id;
                amlakInfoPrice.Year = price.Year;
                amlakInfoPrice.Deposit= price.Deposit;
                amlakInfoPrice.Rent= price.Rent;

                _db.Add(amlakInfoPrice);
            }
            
            foreach (var supplierId in param.SupplierIds){

                var amlakInfoSupplier = new AmlakInfoContractSupplier();
                amlakInfoSupplier.ContractId = contract.Id;
                amlakInfoSupplier.SupplierId = supplierId;

                _db.Add(amlakInfoSupplier);
            }
            
            await _db.SaveChangesAsync();

            return Ok(contract.Id.ToString());
        }

        
        
        [Route("Contract/Update")]
        [HttpPost]
        public async Task<ApiResult<string>> ContractUpdate([FromBody] AmlakInfoContractUpdateVm param){
            await CheckUserAuth(_db);
            
            var contract =await  _db.AmlakInfoContracts.Id( param.Id).FirstOrDefaultAsync();
            if (contract == null)
                return BadRequest("قرارداد یافت نشد");

            var amlakInfo =await  _db.AmlakInfos.Id( contract.AmlakInfoId).FirstOrDefaultAsync();
            if (amlakInfo == null)
                return BadRequest("ملک یافت نشد");
            
            
            // update contract 
            contract.OwnerId=param.OwnerId;
            contract.DoingMethodId=param.DoingMethodId;
            contract.Number=param.Number;
            contract.Date=param.Date;
            contract.Description=param.Description;
            contract.DateFrom=Helpers.HejriToMiladiDateTime(param.DateFrom);
            contract.DateEnd=Helpers.HejriToMiladiDateTime(param.DateEnd);
            contract.ZemanatPrice=param.ZemanatPrice;
            contract.Type=param.Type;
            contract.ModatValue=param.ModatValue;
            contract.Nemayande=param.Nemayande;
            contract.Modir=param.Modir;
            contract.Sarparast=param.Sarparast;
            contract.TenderNumber=param.TenderNumber;
            contract.TenderDate=param.TenderDate;
            contract.UpdatedAt = Helpers.GetServerDateTimeType();

            
            
            // update amlak info 
            if (amlakInfo.Masahat == null || amlakInfo.Masahat == 0)
                amlakInfo.Masahat = param.Masahat;
            if (string.IsNullOrEmpty(amlakInfo.Structure))
                amlakInfo.Structure=param.Structure;
            if (string.IsNullOrEmpty(amlakInfo.Owner))
                amlakInfo.Owner=param.Owner;
            if (string.IsNullOrEmpty(amlakInfo.TypeUsing))
                amlakInfo.TypeUsing=param.TypeUsing;


            var prices = await _db.AmlakInfoContractPrices.Where(a => a.ContractId == param.Id).ToListAsync();
            _db.RemoveRange(prices);
            
            var suppliers = await _db.AmlakInfoContractSuppliers.Where(a => a.ContractId == param.Id).ToListAsync();
            _db.RemoveRange(suppliers);
            
            await _db.SaveChangesAsync();


            foreach (var price in param.Prices){

                var amlakInfoPrice = new AmlakInfoContractPrice();
                amlakInfoPrice.ContractId = contract.Id;
                amlakInfoPrice.Year = price.Year;
                amlakInfoPrice.Deposit= price.Deposit;
                amlakInfoPrice.Rent= price.Rent;

                _db.Add(amlakInfoPrice);
            }
            
            foreach (var supplierId in param.SupplierIds){

                var amlakInfoSupplier = new AmlakInfoContractSupplier();
                amlakInfoSupplier.ContractId = contract.Id;
                amlakInfoSupplier.SupplierId = supplierId;

                _db.Add(amlakInfoSupplier);
            }
            
            await _db.SaveChangesAsync();

            return Ok(contract.Id.ToString());
        }

        [Route("Contract/Delete")]
        [HttpPost]
        public async Task<ApiResult<string>> ContractDelete([FromBody] PublicParamIdViewModel param){
            await CheckUserAuth(_db);

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP012_ContractAmlak_Delete", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", param.Id);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                 
                }
            }
          return Ok("با موفقیت انجام شد");
        }
        
        [Route("Contract/Upload")]
        [HttpPost]
        public async Task<ApiResult<string>> ContractUploadFile(AmlakInfoContractFileUploadVm fileUpload){
            await CheckUserAuth(_db);

            if (fileUpload.ContractId == null)
                return BadRequest(new{ message = "شناسه قرارداد نامعتبر می باشد" });
        
            string fileName = await UploadHelper.UploadFile(fileUpload.FormFile, "Contracts/" + fileUpload.ContractId);
            if (fileName != ""){
                var item = new AmlakInfoContractFile();
                item.ContractId = fileUpload.ContractId ?? 0;
                item.FileName = fileName;
                item.FileTitle = fileUpload.FileTitle;
                _db.Add(item);
                await _db.SaveChangesAsync();
            }else{
                return BadRequest(new{ message = "فایل نامعتبر می باشد" });
            }
        
            return Ok("موفق");
        }

        [Route("Contract/Files")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakInfoContractFilesListVm>>> ContractAttachFiles(int contractId){
            await CheckUserAuth(_db);

            if (contractId == 0) BadRequest();
        
            var items = await _db.AmlakInfoContractFiles.Where(a => a.ContractId == contractId).ToListAsync();
            var finalItems = MyMapper.MapTo<AmlakInfoContractFile, AmlakInfoContractFilesListVm>(items);
            
            foreach (var item in finalItems){
                item.FileName = "/Upload/Contracts/" +item.ContractId+"/"+ item.FileName;
            }

        
            return Ok(finalItems);
        }

        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        
        
        [Route("Supplier/List")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakInfoSupplierUpdateVm>>> SuppliersList(string txtSerach){
            await CheckUserAuth(_db);

            List<AmlakInfoSupplierUpdateVm> ContractView = new List<AmlakInfoSupplierUpdateVm>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP011_SuppliersAmlak_List", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("txtSerach", txtSerach);
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            AmlakInfoSupplierUpdateVm data = new AmlakInfoSupplierUpdateVm();
                            data.Id = int.Parse(dataReader["Id"].ToString());
                            data.FirstName = dataReader["FirstName"].ToString();
                            data.LastName = dataReader["LastName"].ToString();
                            data.Mobile = dataReader["Mobile"].ToString();
                            data.CodePost = dataReader["CodePost"].ToString();
                            data.Address = dataReader["Address"].ToString();
                            data.NationalCode = dataReader["NationalCode"].ToString();
                            ContractView.Add(data);
                        }
                    }
                    sqlconnect.Close();
                }
            }
            return Ok(ContractView);
        }

        [Route("Supplier/Read")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakInfoSupplierUpdateVm>>> SuppliersRead(PublicParamIdViewModel param){
            await CheckUserAuth(_db);

            List<AmlakInfoSupplierUpdateVm> ContractView = new List<AmlakInfoSupplierUpdateVm>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP011_SuppliersAmlak_Read", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("Id", param.Id);
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            AmlakInfoSupplierUpdateVm data = new AmlakInfoSupplierUpdateVm();
                            data.Id = int.Parse(dataReader["Id"].ToString());
                            data.FirstName = dataReader["FirstName"].ToString();
                            data.LastName = dataReader["LastName"].ToString();
                            data.Mobile = dataReader["Mobile"].ToString();
                            data.CodePost = dataReader["CodePost"].ToString();
                            data.Address = dataReader["Address"].ToString();
                            data.NationalCode = dataReader["NationalCode"].ToString();
                            ContractView.Add(data);
                        }
                    }
                    sqlconnect.Close();
                }
            }
            return Ok(ContractView);
        }

        [Route("Supplier/Insert")]
        [HttpPost]
        public async Task<ApiResult<AmlakInfoSupplierUpdateVm>> SupplierInsert([FromBody] AmlakInfoSupplierInsertVm param){
            await CheckUserAuth(_db);

            AmlakInfoSupplierUpdateVm supp = new AmlakInfoSupplierUpdateVm();
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP012_SuppliersAmlak_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("FirstName", param.FirstName);
                    sqlCommand.Parameters.AddWithValue("LastName", param.LastName);
                    sqlCommand.Parameters.AddWithValue("Mobile", param.Mobile);
                    sqlCommand.Parameters.AddWithValue("CodePost", param.CodePost);
                    sqlCommand.Parameters.AddWithValue("Address", param.Address);
                    sqlCommand.Parameters.AddWithValue("NationalCode", param.NationalCode);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (await dataReader.ReadAsync())
                    {
                        supp.Id = int.Parse(dataReader["id"].ToString());
                        supp.FirstName = dataReader["FirstName"].ToString();
                        supp.LastName = dataReader["LastName"].ToString();
                        supp.Mobile = dataReader["Mobile"].ToString();
                        supp.CodePost = dataReader["CodePost"].ToString();
                        supp.Address = dataReader["Address"].ToString();
                        supp.NationalCode = dataReader["NationalCode"].ToString();
                    }
                }
            }
            return Ok(supp);
        }

        [Route("Supplier/Update")]
        [HttpPost]
        public async Task<ApiResult<string>> SupplierUpdate([FromBody] AmlakInfoSupplierUpdateVm param){
            await CheckUserAuth(_db);

            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP011_SuppliersAmlak_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", param.Id);
                    sqlCommand.Parameters.AddWithValue("FirstName", param.FirstName);
                    sqlCommand.Parameters.AddWithValue("LastName", param.LastName);
                    sqlCommand.Parameters.AddWithValue("Mobile", param.Mobile);
                    sqlCommand.Parameters.AddWithValue("CodePost", param.CodePost);
                    sqlCommand.Parameters.AddWithValue("Address", param.Address);
                    sqlCommand.Parameters.AddWithValue("NationalCode", param.NationalCode);

                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        if (dataReader["Message_DB"].ToString() != null) readercount = dataReader["Message_DB"].ToString();
                    }
                }
            }
            if (string.IsNullOrEmpty(readercount)) return Ok("با موفقیت انجام شد");
            else
                return BadRequest(readercount);
        }

        [Route("Supplier/Delete")]
        [HttpPost]
        public async Task<ApiResult<string>> SupplierDelete([FromBody] PublicParamIdViewModel param){
            await CheckUserAuth(_db);

            //string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP011_SuppliersAmlak_Delete", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", param.Id);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();

                }
            }
            return Ok("با موفقیت انجام شد");
        }

        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------

        [Route("AmlakInfo/List")]
        [HttpGet]
        public async Task<ApiResult<object>> AmlakInfoList(AmlakInfoReadInputVm param){
            await CheckUserAuth(_db);

            var builder = _db.AmlakInfos
                .Search(param.Search)
                .AreaId(param.AreaId)
                .AmlakInfoKindId(param.AmlakInfoKindId)
                .Where(a => a.Rentable == param.Rentable);
            
            var pageCount = (int)Math.Ceiling((await builder.CountAsync())/Convert.ToDouble(param.PageRows));
            
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
                
            }

            if (param.Export == 1){
                param.Page = 1;
                param.PageRows = 100000;
            }
            
            if (param.ForMap == 0){
                builder = builder
                    .Include(a => a.Area)
                    .Include(a => a.AmlakInfoKind)
                    .Page2(param.Page, param.PageRows);
            }

           
            var items = await builder.ToListAsync();
            
            if (param.Export == 1){
                var fileUrl = ExportExcelAmlak(items);
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
                row.Add(item.Area.AreaName);
                row.Add(item.IsSubmited);
                row.Add(item.Masahat);
                row.Add(item.AmlakInfoKind.AmlakInfoKindName);
                row.Add(item.EstateInfoName);
                row.Add(item.EstateInfoAddress);
                row.Add(item.CurrentStatus);
                row.Add(item.Structure);
                row.Add(item.Owner);
                row.Add(item.AmlakInfolate);
                row.Add(item.AmlakInfolong);
                row.Add(item.CodeUsing);
                row.Add(item.TypeUsing);
                
                finalItems.Add(row);
            }

            return Helpers.ExportExcelFile(finalItems, "amlak_info");
        }

        
        
        
        
        [Route("AmlakInfo/Read")]
        [HttpGet]
        public async Task<ApiResult<AmlakInfoReadVm>> AmlakInfoRead(PublicParamIdViewModel param){
            await CheckUserAuth(_db);

            var item = await _db.AmlakInfos.Include(a=>a.Area).Include(a=>a.AmlakInfoKind).Id(param.Id).FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("پیدا نشد");
            
            var finalItem = MyMapper.MapTo<AmlakInfo, AmlakInfoReadVm>(item);
        
            return Ok(finalItem);
        }
        //
        //
        [Route("AmlakInfo/Update")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakInfoUpdate([FromBody] AmlakInfoUpdateVm param){
            await CheckUserAuth(_db);

            var item = await _db.AmlakInfos.Id(param.Id).FirstOrDefaultAsync();
            if(item==null)
                return BadRequest("آیتم پیدا نشد");
        
            item.AreaId = param.AreaId;
            // item.IsSubmited = param.IsSubmited;
            item.Masahat = param.Masahat;
            item.AmlakInfoKindId = param.AmlakInfoKindId;
            item.EstateInfoName = param.EstateInfoName;
            item.EstateInfoAddress = param.EstateInfoAddress;
            item.CurrentStatus = param.CurrentStatus;
            item.Structure = param.Structure;
            item.Owner = param.Owner;
            item.UpdatedAt = Helpers.GetServerDateTimeType();
            await _db.SaveChangesAsync();
        
            return Ok(item.Id.ToString());
        }
        //
        //
        [Route("AmlakInfo/Upload")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakInfoUploadFile(AmlakInfoFileUploadVm fileUpload){
            await CheckUserAuth(_db);
            if (fileUpload.AmlakInfoId == null)
                return BadRequest(new{ message = "شناسه ملک نامعتبر می باشد" });
        
        
            string fileName = await UploadHelper.UploadFile(fileUpload.FormFile, "AmlakInfos/" + fileUpload.AmlakInfoId);
            if (fileName != ""){
                var item = new AmlakInfoFile();
                item.AmlakInfoId = fileUpload.AmlakInfoId ?? 0;
                item.FileName = fileName;
                item.FileTitle = fileUpload.FileTitle;
                item.Type = fileUpload.Type;
                // return Helpers.dd(fileUpload.FileTitle);
                _db.Add(item);
                await _db.SaveChangesAsync();
            }
            else{
                return BadRequest(new{ message = "فایل نامعتبر می باشد" });
            }
        
            return Ok("موفق");
        }
        //
        [Route("AmlakInfo/Files")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakInfoFilesListVm>>> AmlakInfoAttachFiles(int AmlakInfoId){
            await CheckUserAuth(_db);
            if (AmlakInfoId == 0) BadRequest();
        
            var items = await _db.AmlakInfoFiles.Where(a => a.AmlakInfoId == AmlakInfoId).ToListAsync();
            var finalItems = MyMapper.MapTo<AmlakInfoFile, AmlakInfoFilesListVm>(items);
            
            foreach (var item in finalItems){
                item.FileName = "/Upload/AmlakInfos/" +item.AmlakInfoId+"/"+ item.FileName;
            }

        
            return Ok(finalItems);
        }

        
        [Route("AmlakInfo/Delete")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakInfoDelete([FromBody] PublicParamIdViewModel param)
        {
            await CheckUserAuth(_db);

            var item = await _db.AmlakInfos.Id(param.Id).FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("پیدا نشد");
            
            // todo: check has contract or not
            
            var images = await _db.AmlakInfoFiles.Where(a=>a.AmlakInfoId==param.Id).ToListAsync();
            // todo: remove files from server
            _db.RemoveRange(images);
            _db.Remove(item);
            _db.SaveChanges();
            
            return Ok("حذف شد");
        }

        
        
        
        [Route("AmlakInfo/Kind")]
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
