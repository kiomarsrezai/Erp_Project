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
using NewsWebsite.Data;
using NewsWebsite.Data.Models;
using NewsWebsite.Data.Repositories;

namespace NewsWebsite.Areas.Api.Controllers.v1
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class ContractAmlakApiController : ControllerBase
    {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        protected readonly ProgramBuddbContext _db;

        public ContractAmlakApiController(IUnitOfWork uw, IConfiguration config, IWebHostEnvironment webHostEnvironment,ProgramBuddbContext db)
        {
            _config = config;
            _uw = uw;
            _webHostEnvironment = webHostEnvironment;
            _db=db;

        }

        
        [Route("AmlakInfoFileList")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakInfoFileList>>> AmlakInfoFileList(PublicParamIdViewModel model)
        {

            List<AmlakInfoFileList> ContractView = new List<AmlakInfoFileList>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP0_FileDetail_Read", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("Id", model.Id);
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            AmlakInfoFileList data = new AmlakInfoFileList();
                            data.Id = int.Parse(dataReader["Id"].ToString());
                            data.FileName = dataReader["FileName"].ToString();
                            ContractView.Add(data);
                        }
                    }
                    sqlconnect.Close();
                }
            }
            return Ok(ContractView);
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
    
        [HttpGet]
        [Route("UpdateDataFromSdi_ahvaz_amlak_tatbiqii_9244")]
        public async Task<ApiResult<string>> UpdateDataFromSdi_ahvaz_amlak_tatbiqi()
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
            var request2 = new RestRequest("/geoserver/ows?service=wfs&version=1.0.0&request=GetFeature&typeName=amlak_tatbiqii_9244&srsname=EPSG:4326&outputFormat=application/json&maxFeatures=10000&startIndex=0&authkey=e434be85d126299659334f104feffb18f51328a6", Method.Post);
            request2.AddHeader("content-type", "application/json");
            request2.AddHeader("Accept", "application/json, text/plain, */*");
            request2.AddHeader("Cookie", "cookiesession1=678ADA629490114186F01A0EF409171D; csrftoken=dKwYwwwT5wcj60bhh4ojKy1R4JQrdxD7; sessionid=bsj9qwbunhlpl7bymk7o9uy3x6cr9ubg");
            RestResponse response2 = await client2.ExecuteAsync(request2);
            byte[] messageBytes = Encoding.UTF8.GetBytes(response2.Content);
            string newmessage = Encoding.UTF8.GetString(messageBytes, 0, messageBytes.Length);
            //var respLayer = JsonConvert.DeserializeObject<ResponseLayerDto>(newmessage.ToString());

            //for (int i = 0; i <= respLayer.totalFeatures; i++)
            //{
            //    using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            //    {
            //        using (SqlCommand sqlCommand = new SqlCommand("SP012_AmlakInfo_Insert", sqlconnect))
            //        {
            //            sqlconnect.Open();
            //            sqlCommand.Parameters.AddWithValue("AmlakInfoId", respLayer.features[i].id);
            //            sqlCommand.Parameters.AddWithValue("AreaId", respLayer.features[i].properties.mantaqe);
            //            sqlCommand.Parameters.AddWithValue("AmlakInfoKindId", 4);
            //            sqlCommand.Parameters.AddWithValue("EstateInfoName", respLayer.features[i].properties.name);
            //            sqlCommand.Parameters.AddWithValue("EstateInfoAddress", respLayer.features[i].properties.adress);
            //            sqlCommand.Parameters.AddWithValue("AmlakInfolong", respLayer.features[i].geometry.coordinates[0][0].ToString());
            //            sqlCommand.Parameters.AddWithValue("AmlakInfolate", respLayer.features[i].geometry.coordinates[0][1].ToString());
            //            sqlCommand.CommandType = CommandType.StoredProcedure;
            //            SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();

            //        }
            //    }
            //}

            return Ok(response2);
        }

        [Route("AmlakInfoContractList")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakInfoContractListViewModel>>> AmlakInfoContractList(int AmlakInfoId)
        {
            List<AmlakInfoContractListViewModel> ContractView = new List<AmlakInfoContractListViewModel>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP012_AmlakInfoContractList", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("AmlakInfoId", AmlakInfoId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            AmlakInfoContractListViewModel data = new AmlakInfoContractListViewModel();
                            data.id = int.Parse(dataReader["id"].ToString());
                            data.AreaId = StringExtensions.ToNullableInt(dataReader["AreaId"].ToString());
                            data.AmlakId = StringExtensions.ToNullableInt(dataReader["AmlakId"].ToString());
                            data.Number = dataReader["Number"].ToString();
                            data.AreaName = dataReader["AreaName"].ToString();
                            data.Masahat = StringExtensions.ToNullablefloat(dataReader["Masahat"].ToString());
                            data.EstateInfoName = dataReader["EstateInfoName"].ToString();
                            data.EstateInfoAddress = dataReader["EstateInfoAddress"].ToString();
                            data.Sarparast = dataReader["Sarparast"].ToString();
                            data.Modir = dataReader["Modir"].ToString();
                            data.Nemayande = dataReader["Nemayande"].ToString();
                            data.TenderNumber = dataReader["TenderNumber"].ToString();
                            data.TenderDate = dataReader["TenderDate"].ToString();
                            data.TypeUsing = dataReader["TypeUsing"].ToString();
                            data.ContractType = dataReader["ContractType"].ToString();
                            data.Date = dataReader["Date"].ToString();
                            data.DateShamsi = dataReader["Date"].ToString();
                            data.Description = dataReader["Description"].ToString();
                            data.AmlakInfoId = dataReader["AmlakInfoId"].ToString();
                            data.DoingMethodId = dataReader["DoingMethodId"].ToString();
                            data.SupplierFullName = dataReader["SupplierFullName"].ToString();
                            data.DateFrom = dataReader["DateFrom"].ToString();
                            data.DateFromShamsi = dataReader["DateFrom"].ToString();
                            data.DateEnd = dataReader["DateEnd"].ToString();
                            data.DateEndShamsi = dataReader["DateEnd"].ToString();
                            data.Amount = Int64.Parse(dataReader["Amount"].ToString());
                            data.Surplus = Int64.Parse(dataReader["Surplus"].ToString());
                            data.Final = bool.Parse(dataReader["Final"].ToString());
                            data.IsSubmited = bool.Parse(dataReader["IsSubmited"].ToString());

                            ContractView.Add(data);
                        }
                    }
                    sqlconnect.Close();
                }
            }
            return Ok(ContractView);
        }

        [Route("ContractAmlakInfoListByAreaId")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakInfoContractListViewModel>>> ContractAmlakInfoListByAreaId(int AreaId)
        {
            List<AmlakInfoContractListViewModel> ContractView = new List<AmlakInfoContractListViewModel>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP012_ContractAmlak_Search", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("areaId", AreaId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            AmlakInfoContractListViewModel data = new AmlakInfoContractListViewModel();
                            data.id = int.Parse(dataReader["id"].ToString());
                            data.AreaId = StringExtensions.ToNullableInt(dataReader["AreaId"].ToString());
                            data.AmlakId = StringExtensions.ToNullableInt(dataReader["AmlakId"].ToString());
                            data.Number = dataReader["Number"].ToString();
                            data.AreaName = dataReader["AreaName"].ToString();
                            data.Masahat = StringExtensions.ToNullablefloat(dataReader["Masahat"].ToString());
                            data.EstateInfoName = dataReader["EstateInfoName"].ToString();
                            data.EstateInfoAddress = dataReader["EstateInfoAddress"].ToString();
                            data.Sarparast = dataReader["Sarparast"].ToString();
                            data.Modir = dataReader["Modir"].ToString();
                            data.Nemayande = dataReader["Nemayande"].ToString();
                            data.TenderNumber = dataReader["TenderNumber"].ToString();
                            data.TenderDate = dataReader["TenderDate"].ToString();
                            data.TypeUsing = dataReader["TypeUsing"].ToString();
                            data.ContractType = dataReader["ContractType"].ToString();
                            data.Date = dataReader["Date"].ToString();
                            data.DateShamsi = dataReader["Date"].ToString();
                            data.Description = dataReader["Description"].ToString();
                            data.AmlakInfoId = dataReader["AmlakInfoId"].ToString();
                            data.DoingMethodId = dataReader["DoingMethodId"].ToString();
                            data.SupplierFullName = dataReader["SupplierFullName"].ToString();
                            data.DateFrom = dataReader["DateFrom"].ToString();
                            data.DateFromShamsi = dataReader["DateFrom"].ToString();
                            data.DateEnd = dataReader["DateEnd"].ToString();
                            data.DateEndShamsi = dataReader["DateEnd"].ToString();
                            data.Amount = Int64.Parse(dataReader["Amount"].ToString());
                            data.Surplus = Int64.Parse(dataReader["Surplus"].ToString());
                            data.Final = bool.Parse(dataReader["Final"].ToString());
                            data.IsSubmited = bool.Parse(dataReader["IsSubmited"].ToString());

                            ContractView.Add(data);
                        }
                    }
                    sqlconnect.Close();
                }
            }
            return Ok(ContractView);
        }

        [Route("Test11")]
        [HttpGet]
        public async Task<ApiResult<TblBudgets>> Test11(int ContractId){

            TblBudgets b = _db.TblBudgets.FirstOrDefault();
            
            return Ok( b);

        }

        [Route("AmlakInfoContractRead")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakInfoContractViewModel>>> AmlakInfoContractRead(int ContractId)
        {
            List<AmlakInfoContractViewModel> ContractSearchView = new List<AmlakInfoContractViewModel>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP012_AmlakInfoContract_Read", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("ContractId", ContractId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            AmlakInfoContractViewModel data = new AmlakInfoContractViewModel();
                            data.id = int.Parse(dataReader["id"].ToString());
                            data.Number = dataReader["Number"].ToString();
                            data.AreaId = int.Parse(dataReader["AreaId"].ToString());
                            data.Masahat = StringExtensions.ToNullablefloat(dataReader["Masahat"].ToString());
                            data.EstateInfoName = dataReader["EstateInfoName"].ToString();
                            data.EstateInfoAddress = dataReader["EstateInfoAddress"].ToString();
                            data.Sarparast = dataReader["Sarparast"].ToString();
                            data.Modir = dataReader["Modir"].ToString();
                            data.Nemayande = dataReader["Nemayande"].ToString();
                            data.ModatValue = dataReader["ModatValue"].ToString();
                            data.TenderNumber = dataReader["TenderNumber"].ToString();
                            data.TenderDate = dataReader["TenderDate"].ToString();
                            data.TypeUsing = dataReader["TypeUsing"].ToString();
                            data.ContractType = dataReader["ContractType"].ToString();
                            data.Date = dataReader["Date"].ToString();
                            data.DateShamsi = dataReader["Date"].ToString();
                            data.Description = dataReader["Description"].ToString();
                            data.AmlakInfoId = dataReader["AmlakInfoId"].ToString();
                            data.AmlakId = StringExtensions.ToNullableInt(dataReader["AmlakId"].ToString());
                            data.DoingMethodId = StringExtensions.ToNullableInt(dataReader["DoingMethodId"].ToString());
                            data.SuppliersId = StringExtensions.ToNullableInt(dataReader["SuppliersId"].ToString());
                            data.DateFrom = dataReader["DateFrom"].ToString();
                            data.DateFromShamsi = dataReader["DateFrom"].ToString();
                            data.DateEnd = dataReader["DateEnd"].ToString();
                            data.DateEndShamsi = dataReader["DateEnd"].ToString();
                            data.Amount = Int64.Parse(dataReader["Amount"].ToString());
                            data.AmountMonth = Int64.Parse(dataReader["AmountMonth"].ToString());
                            data.Zemanat_Price = Int64.Parse(dataReader["Zemanat_Price"].ToString());
                            data.Surplus = Int64.Parse(dataReader["Surplus"].ToString());
                            data.Final = bool.Parse(dataReader["Final"].ToString());
                            data.IsSubmited = bool.Parse(dataReader["IsSubmited"].ToString());

                            ContractSearchView.Add(data);
                        }
                    }
                    sqlconnect.Close();
                }
            }
            return Ok(ContractSearchView);
        }

        [Route("ContractAmlakInfoInsert")]
        [HttpPost]
        public async Task<ApiResult<AmlakInfoContractListViewModel>> Ac_ContractInsert([FromBody] ContractAmlakInsertParamViewModel param)
        {
            AmlakInfoContractListViewModel data = new AmlakInfoContractListViewModel();
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP012_ContractAmlak_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("AreaId", param.AreaId);
                    sqlCommand.Parameters.AddWithValue("Number", param.Number);
                    sqlCommand.Parameters.AddWithValue("Date", param.Date);
                    sqlCommand.Parameters.AddWithValue("Description", param.Description);
                    sqlCommand.Parameters.AddWithValue("SuppliersId", param.SuppliersId);
                    sqlCommand.Parameters.AddWithValue("DoingMethodId", 6);
                    sqlCommand.Parameters.AddWithValue("AmlakId", param.AmlakId);
                    sqlCommand.Parameters.AddWithValue("TenderNumber", param.TenderNumber);
                    sqlCommand.Parameters.AddWithValue("TenderDate", param.TenderDate);
                    sqlCommand.Parameters.AddWithValue("Sarparast", param.Sarparast);
                    sqlCommand.Parameters.AddWithValue("Nemayande", param.Nemayande);
                    sqlCommand.Parameters.AddWithValue("Modir", param.Modir);
                    sqlCommand.Parameters.AddWithValue("Masahat", param.Masahat);
                    sqlCommand.Parameters.AddWithValue("TypeUsing", param.TypeUsing);
                    sqlCommand.Parameters.AddWithValue("CurrentStatus", param.CurrentStatus);
                    sqlCommand.Parameters.AddWithValue("Structure", param.Structure);
                    sqlCommand.Parameters.AddWithValue("Owner", param.Owner);
                    sqlCommand.Parameters.AddWithValue("DateFrom", param.DateFrom);
                    sqlCommand.Parameters.AddWithValue("DateEnd", param.DateEnd);
                    sqlCommand.Parameters.AddWithValue("Amount", param.Amount);
                    sqlCommand.Parameters.AddWithValue("AmountMonth", param.AmountMonth);
                    sqlCommand.Parameters.AddWithValue("Zemanat_Price", param.Zemanat_Price);
                    sqlCommand.Parameters.AddWithValue("ModatValue", param.ModatValue);

                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        data.id = int.Parse(dataReader["id"].ToString());
                        data.Number = dataReader["Number"].ToString();
                        data.AreaId = int.Parse(dataReader["AreaId"].ToString());
                        data.AreaName = dataReader["AreaName"].ToString();
                        data.Masahat = StringExtensions.ToNullablefloat(dataReader["Masahat"].ToString());
                        data.EstateInfoName = dataReader["EstateInfoName"].ToString();
                        data.EstateInfoAddress = dataReader["EstateInfoAddress"].ToString();
                        data.Sarparast = dataReader["Sarparast"].ToString();
                        data.Modir = dataReader["Modir"].ToString();
                        data.ModatValue = dataReader["ModatValue"].ToString();
                        data.Nemayande = dataReader["Nemayande"].ToString();
                        data.TenderNumber = dataReader["TenderNumber"].ToString();
                        data.TenderDate = dataReader["TenderDate"].ToString();
                        data.TypeUsing = dataReader["TypeUsing"].ToString();
                        data.ContractType = dataReader["ContractType"].ToString();
                        data.Date = dataReader["Date"].ToString();
                        data.DateShamsi = dataReader["Date"].ToString();
                        data.Description = dataReader["Description"].ToString();
                        data.AmlakInfoId = dataReader["AmlakInfoId"].ToString();
                        data.AmlakId = StringExtensions.ToNullableInt(dataReader["AmlakId"].ToString());
                        data.DoingMethodId = dataReader["DoingMethodId"].ToString();
                        data.SupplierFullName = dataReader["SupplierFullName"].ToString();
                        data.DateFrom = dataReader["DateFrom"].ToString();
                        data.DateFromShamsi = dataReader["DateFrom"].ToString();
                        data.DateEnd = dataReader["DateEnd"].ToString();
                        data.DateEndShamsi = dataReader["DateEnd"].ToString();
                        data.Amount = Int64.Parse(dataReader["Amount"].ToString());
                        data.Surplus = Int64.Parse(dataReader["Surplus"].ToString());
                        data.Final = bool.Parse(dataReader["Final"].ToString());
                        data.IsSubmited = bool.Parse(dataReader["IsSubmited"].ToString());

                    }
                }
            }

            return Ok(data);
        }

        [Route("ContractAmlakInfoUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_ContractUpdate([FromBody] ContractAmlakUpdateParamViewModel param)
        {
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP012_ContractAmlak_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", param.Id);
                    sqlCommand.Parameters.AddWithValue("AreaId", param.AreaId);
                    sqlCommand.Parameters.AddWithValue("Number", param.Number);
                    sqlCommand.Parameters.AddWithValue("Date", param.Date);
                    sqlCommand.Parameters.AddWithValue("Description", param.Description);
                    sqlCommand.Parameters.AddWithValue("SuppliersId", param.SuppliersId);
                    sqlCommand.Parameters.AddWithValue("DoingMethodId", 6);
                    sqlCommand.Parameters.AddWithValue("AmlakId", param.AmlakId);
                    sqlCommand.Parameters.AddWithValue("TenderNumber", param.TenderNumber);
                    sqlCommand.Parameters.AddWithValue("TenderDate", param.TenderDate);
                    sqlCommand.Parameters.AddWithValue("Sarparast", param.Sarparast);
                    sqlCommand.Parameters.AddWithValue("Nemayande", param.Nemayande);
                    sqlCommand.Parameters.AddWithValue("Modir", param.Modir);
                    sqlCommand.Parameters.AddWithValue("Masahat", param.Masahat);
                    sqlCommand.Parameters.AddWithValue("TypeUsing", param.TypeUsing);
                    sqlCommand.Parameters.AddWithValue("CurrentStatus", param.CurrentStatus);
                    sqlCommand.Parameters.AddWithValue("Structure", param.Structure);
                    sqlCommand.Parameters.AddWithValue("Owner", param.Owner);
                    sqlCommand.Parameters.AddWithValue("DateFrom", param.DateFrom);
                    sqlCommand.Parameters.AddWithValue("DateEnd", param.DateEnd);
                    sqlCommand.Parameters.AddWithValue("Amount", param.Amount);
                    sqlCommand.Parameters.AddWithValue("AmountMonth", param.AmountMonth);
                    sqlCommand.Parameters.AddWithValue("Zemanat_Price", param.Zemanat_Price);
                    sqlCommand.Parameters.AddWithValue("ModatValue", param.ModatValue);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();

                }
            }
            return Ok("با موفقیت انجام شد");
        }

        [Route("ContractAmlakInfoDelete")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_ContractDelete([FromBody] PublicParamIdViewModel param)
        {
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

        [Route("SuppliersAmlakList")]
        [HttpGet]
        public async Task<ApiResult<List<SupplierAmlakInfoUpdateDto>>> Ac_SuppliersAmlakList(string txtSerach)
        {
            List<SupplierAmlakInfoUpdateDto> ContractView = new List<SupplierAmlakInfoUpdateDto>();
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
                            SupplierAmlakInfoUpdateDto data = new SupplierAmlakInfoUpdateDto();
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

        [Route("SuppliersAmlakRead")]
        [HttpGet]
        public async Task<ApiResult<List<SupplierAmlakInfoUpdateDto>>> Ac_SuppliersAmlakRead(PublicParamIdViewModel param)
        {
            List<SupplierAmlakInfoUpdateDto> ContractView = new List<SupplierAmlakInfoUpdateDto>();
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
                            SupplierAmlakInfoUpdateDto data = new SupplierAmlakInfoUpdateDto();
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

        [Route("SuppliersAmlakInsert")]
        [HttpPost]
        public async Task<ApiResult<SupplierAmlakInfoUpdateDto>> Ac_ContractAreaInsert([FromBody] SupplierAmlakInfoInsertDto param)
        {
            SupplierAmlakInfoUpdateDto supp = new SupplierAmlakInfoUpdateDto();
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

        [Route("SuppliersAmlakUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_ContractAreaUpdate([FromBody] SupplierAmlakInfoUpdateDto param)
        {
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

        [Route("SuppliersAmlakDelete")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_ContractAreaDelete([FromBody] PublicParamIdViewModel param)
        {
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

        [Route("AmlakInfoKindComBobox")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakInfoKindComViewModel>>> Ac_AmlakInfoKindCom()
        {
            List<AmlakInfoKindComViewModel> data = new List<AmlakInfoKindComViewModel>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP012_AmlakInfoKind_Com", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            AmlakInfoKindComViewModel row = new AmlakInfoKindComViewModel();
                            row.Id = int.Parse(dataReader["Id"].ToString());
                            row.AmlakInfoKindName = dataReader["AmlakInfoKindName"].ToString();
                            data.Add(row);
                        }
                    }
                    sqlconnect.Close();
                }
            }
            return Ok(data);
        }

        [Route("AmlakInfoSearch")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakInfoPrivateReadViewModel>>> Ac_AmlakInfoSearch(AmlakInfoSerachParamDto param)
        {
            List<AmlakInfoPrivateReadViewModel> data = new List<AmlakInfoPrivateReadViewModel>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP012_AmlakInfo_Search", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("AreaId", param.AreaId);
                        sqlCommand.Parameters.AddWithValue("AmlakInfoKindId", param.AmlakInfoKindId);
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            AmlakInfoPrivateReadViewModel row = new AmlakInfoPrivateReadViewModel();
                            row.Id = int.Parse(dataReader["Id"].ToString());
                            row.AreaId = int.Parse(dataReader["AreaId"].ToString());
                            row.AmlakInfoKindId = int.Parse(dataReader["AmlakInfoKindId"].ToString());
                            row.TotalContract = int.Parse(dataReader["TotalContract"].ToString());
                            row.IsSubmited = StringExtensions.ToNullablebool(dataReader["IsSubmited"].ToString());
                            row.IsContracted = StringExtensions.ToNullablebool(dataReader["IsContracted"].ToString());
                            row.Masahat = StringExtensions.ToNullablefloat(dataReader["Masahat"].ToString());
                            row.AreaName = dataReader["AreaName"].ToString();
                            row.AmlakInfoKindName = dataReader["AmlakInfoKindName"].ToString();
                            row.EstateInfoName = dataReader["EstateInfoName"].ToString();
                            row.EstateInfoAddress = dataReader["EstateInfoAddress"].ToString();
                            row.AmlakInfolate = dataReader["AmlakInfolate"].ToString();
                            row.AmlakInfolong = dataReader["AmlakInfolong"].ToString();
                            row.CodeUsing = dataReader["CodeUsing"].ToString();
                            row.TypeUsing = dataReader["TypeUsing"].ToString();
                            row.CurrentStatus = dataReader["CurrentStatus"].ToString();
                            row.Structure = dataReader["Structure"].ToString();
                            row.Owner = dataReader["Owner"].ToString();
                            data.Add(row);
                        }
                    }
                    sqlconnect.Close();
                }
            }
            return Ok(data);
        }

        [Route("AmlakInfoRead")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakInfoPrivateReadViewModel>>> Ac_AmlakInfoRead(PublicParamIdViewModel param)
        {
            List<AmlakInfoPrivateReadViewModel> data = new List<AmlakInfoPrivateReadViewModel>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP012_AmlakInfo_Read", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("Id", param.Id);
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            AmlakInfoPrivateReadViewModel row = new AmlakInfoPrivateReadViewModel();
                            row.Id = int.Parse(dataReader["Id"].ToString());
                            row.AreaId = int.Parse(dataReader["AreaId"].ToString());
                            row.AmlakInfoKindId = int.Parse(dataReader["AmlakInfoKindId"].ToString());
                            row.TotalContract = int.Parse(dataReader["TotalContract"].ToString());
                            row.IsSubmited = StringExtensions.ToNullablebool(dataReader["IsSubmited"].ToString());
                            row.IsContracted = StringExtensions.ToNullablebool(dataReader["IsContracted"].ToString());
                            row.Masahat = StringExtensions.ToNullablefloat(dataReader["Masahat"].ToString());
                            row.AreaName = dataReader["AreaName"].ToString();
                            row.AmlakInfoKindName = dataReader["AmlakInfoKindName"].ToString();
                            row.EstateInfoName = dataReader["EstateInfoName"].ToString();
                            row.EstateInfoAddress = dataReader["EstateInfoAddress"].ToString();
                            row.AmlakInfolate = dataReader["AmlakInfolate"].ToString();
                            row.AmlakInfolong = dataReader["AmlakInfolong"].ToString();
                            row.CodeUsing = dataReader["AmlakInfoId"].ToString();
                            row.TypeUsing = dataReader["TypeUsing"].ToString();
                            row.CodeUsing = dataReader["CodeUsing"].ToString();
                            row.CurrentStatus = dataReader["CurrentStatus"].ToString();
                            row.Structure = dataReader["Structure"].ToString();
                            row.Owner = dataReader["Owner"].ToString();
                            data.Add(row);
                        }
                    }
                    sqlconnect.Close();
                }
            }
            return Ok(data);
        }

        
        [Route("UploadContractFile")]
        [HttpPost]
        public async Task<ApiResult<string>> UploadContractFile(ContractFileUploadModel fileUpload)
        {
            string issuccess = "ناموفق";

            string fileName = await UploadFile(fileUpload.FormFile, "Contracts/"+fileUpload.ContractId);
            if (fileName!=""){
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("[SP0_ContractFileDetail_Insert]", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("ContractId", fileUpload.ContractId);
                        sqlCommand.Parameters.AddWithValue("FileName", fileName);
                        sqlCommand.Parameters.AddWithValue("Title", fileUpload.Title);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    }
                }
                issuccess = "موفق";
                
            }else{
                return BadRequest(new { message = "فایل نامعتبر می باشد" });
            }

            return Ok(issuccess);
        }

        private async Task<string> UploadFile(IFormFile file, string path,string extensions="jpg,png,gif,bmp"){

            if (!CheckFileType(file, extensions))
                return "";
            
            string fileName;

            var extension = "." + file.FileName.Split('.')[file.FileName.Split('.').Length - 1];
            fileName = DateTime.Now.Ticks + extension; //Create a new Name for the file due to security reasons.
            var folderPath = Path.Combine("wwwroot", "Upload", path);

            if (!Directory.Exists(folderPath)){
                Directory.CreateDirectory(folderPath);
            }

            var pathfile = Path.Combine(folderPath, fileName);

            using var stream = new FileStream(pathfile, FileMode.Create);
            await file.CopyToAsync(stream);

            return fileName;
        }

        private bool CheckFileType(IFormFile file, string extensions){
            if (file == null || string.IsNullOrEmpty(extensions)){
                return false;
            }
            
            var fileExtension = Path.GetExtension(file.FileName).ToLowerInvariant();

            var allowedExtensions = extensions.Split(',');
            foreach (var extension in allowedExtensions){
                if (fileExtension.Equals("."+extension.Trim().ToLowerInvariant(), StringComparison.OrdinalIgnoreCase)){
                    return true;
                }
            }

            return false;
        }

        
        [Route("GetContractAttachFiles")]
        [HttpGet]
        public async Task<ApiResult<List<GetListContractAttachFiles>>> GetContractAttachFiles(int contractId)
        {
            if (contractId == 0) BadRequest();

            List<GetListContractAttachFiles> output = new List<GetListContractAttachFiles>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP000_GetListContractAttachFiles", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("ContractId", contractId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    var prefixUrls = "/Upload/Contracts/"+contractId+"/";
                    while (dataReader.Read())
                    {
                        GetListContractAttachFiles fetchView = new GetListContractAttachFiles();
                        fetchView.AttachID = StringExtensions.ToNullableInt(dataReader["AttachID"].ToString());
                        fetchView.ContractId = StringExtensions.ToNullableInt(dataReader["ContractId"].ToString());
                        fetchView.FileName = prefixUrls+Path.GetFileName(dataReader["FileName"]+"");
                        fetchView.FileTitle = dataReader["FileTitle"].ToString();
                        output.Add(fetchView);

                        //dataReader.NextResult();
                    }
                }
            }
            return Ok(output);
        }

        [Route("UploadAmlakInfoFile")]
        [HttpPost]
        public async Task<ApiResult<string>> UploadAmlakInfoFile(AmlakInfoFileUploadModel fileUpload)
        {
            string issuccess = "ناموفق";

            string fileName = await UploadFile(fileUpload.FormFile, "AmlakInfos/"+fileUpload.AmlakInfoIf);
            if (fileName!=""){
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP0_AmlakInfoFileDetail_Insert", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("AmlakInfoId", fileUpload.AmlakInfoIf);
                        sqlCommand.Parameters.AddWithValue("FileName", fileName);
                        sqlCommand.Parameters.AddWithValue("Title", fileUpload.Title);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    }
                }
                issuccess = "موفق";
                
            }else{
                return BadRequest(new { message = "فایل نامعتبر می باشد" });
            }

            return Ok(issuccess);
        }

        [Route("GetAmlakInfoAttachFiles")]
        [HttpGet]
        public async Task<ApiResult<List<GetListAmlakInfoAttachFiles>>> GetAmlakInfoAttachFiles(int amlakInfoId)
        {
            if (amlakInfoId == 0) BadRequest();

            List<GetListAmlakInfoAttachFiles> output = new List<GetListAmlakInfoAttachFiles>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP000_GetListAmlakInfoAttachFiles", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("AmlakInfoId", amlakInfoId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    var prefixUrls = "/Upload/AmlakInfos/"+amlakInfoId+"/";
                    while (dataReader.Read())
                    {
                        GetListAmlakInfoAttachFiles fetchView = new GetListAmlakInfoAttachFiles();
                        fetchView.AttachID = StringExtensions.ToNullableInt(dataReader["AttachID"].ToString());
                        fetchView.AmlakInfoId = StringExtensions.ToNullableInt(dataReader["AmlakInfoId"].ToString());
                        fetchView.FileName = prefixUrls+Path.GetFileName(dataReader["FileName"]+"");
                        fetchView.FileTitle = dataReader["FileTitle"].ToString();
                        output.Add(fetchView);

                        //dataReader.NextResult();
                    }
                }
            }
            return Ok(output);
        }

        
        [Route("AmlakInfoUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_AmlakInfoUpdate([FromBody] AmlakInfoUpdateViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP012_AmlakInfo_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", param.Id);
                    sqlCommand.Parameters.AddWithValue("AreaId", param.AreaId);
                    sqlCommand.Parameters.AddWithValue("AmlakInfoKindId", param.AmlakInfoKindId);
                    sqlCommand.Parameters.AddWithValue("EstateInfoName", param.EstateInfoName);
                    sqlCommand.Parameters.AddWithValue("EstateInfoAddress", param.EstateInfoAddress);
                    sqlCommand.Parameters.AddWithValue("IsSubmited", param.IsSubmited);
                    sqlCommand.Parameters.AddWithValue("Masahat", param.Masahat);
                    sqlCommand.Parameters.AddWithValue("CurrentStatus", param.CurrentStatus);
                    sqlCommand.Parameters.AddWithValue("Structure", param.Structure);
                    sqlCommand.Parameters.AddWithValue("Owner", param.Owner);
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

        [Route("AmlakInfoDelete")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_AmlakInfoDelete([FromBody] PublicParamIdViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP012_AmlakInfo_Delete", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", param.Id);
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

    }
}