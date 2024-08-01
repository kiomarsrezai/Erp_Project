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
using NewsWebsite.Data;
using NewsWebsite.Data.Models;
using NewsWebsite.Data.Repositories;
using NewsWebsite.ViewModels.Api.Contract.AmlakInfo;

namespace NewsWebsite.Areas.Api.Controllers.v1
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class ContractAmlakInfoApiController : ControllerBase
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
        public async Task<ApiResult<List<AmlakInfoContractListVm>>> ContractList(int AmlakInfoId)
        {
            List<AmlakInfoContractListVm> ContractView = new List<AmlakInfoContractListVm>();
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
                            AmlakInfoContractListVm data = new AmlakInfoContractListVm();
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

        [Route("Contract/List/ByArea")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakInfoContractListVm>>> ContractListByAreaId(int AreaId)
        {
            List<AmlakInfoContractListVm> ContractView = new List<AmlakInfoContractListVm>();
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
                            AmlakInfoContractListVm data = new AmlakInfoContractListVm();
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

       

        [Route("Contract/Read")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakInfoContractReadVm>>> ContractRead(int ContractId)
        {
            List<AmlakInfoContractReadVm> ContractSearchView = new List<AmlakInfoContractReadVm>();
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
                            AmlakInfoContractReadVm data = new AmlakInfoContractReadVm();
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
                            data.DoingMethodId = dataReader["DoingMethodId"].ToString();
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

        [Route("Contract/Insert")]
        [HttpPost]
        public async Task<ApiResult<AmlakInfoContractListVm>> ContractInsert([FromBody] AmlakInfoContractInsertVm param)
        {
            AmlakInfoContractListVm data = new AmlakInfoContractListVm();
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

        [Route("Contract/Update")]
        [HttpPost]
        public async Task<ApiResult<string>> ContractUpdate([FromBody] AmlakInfoContractUpdateVm param)
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

        [Route("Contract/Delete")]
        [HttpPost]
        public async Task<ApiResult<string>> ContractDelete([FromBody] PublicParamIdViewModel param)
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
        
          [Route("Contract/Upload")]
        [HttpPost]
        public async Task<ApiResult<string>> ContractUploadFile(ContractFileUploadVm fileUpload)
        {
            string issuccess = "ناموفق";

            string fileName = await UploadHelper.UploadFile(fileUpload.FormFile, "Contracts/"+fileUpload.ContractId);
            if (fileName!=""){
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("[SP0_ContractFileDetail_Insert]", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("ContractId", fileUpload.ContractId);
                        sqlCommand.Parameters.AddWithValue("FileName", fileName);
                        sqlCommand.Parameters.AddWithValue("Title", fileUpload.FileTitle);
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

        
        [Route("Contract/Files")]
        [HttpGet]
        public async Task<ApiResult<List<ContractFilesListVm>>> ContractAttachFiles(int contractId)
        {
            if (contractId == 0) BadRequest();

            List<ContractFilesListVm> output = new List<ContractFilesListVm>();

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
                        ContractFilesListVm fetchView = new ContractFilesListVm();
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
        
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        
        
        [Route("Supplier/List")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakInfoSupplierUpdateVm>>> SuppliersList(string txtSerach)
        {
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
        public async Task<ApiResult<List<AmlakInfoSupplierUpdateVm>>> SuppliersRead(PublicParamIdViewModel param)
        {
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
        public async Task<ApiResult<AmlakInfoSupplierUpdateVm>> SupplierInsert([FromBody] AmlakInfoSupplierInsertVm param)
        {
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
        public async Task<ApiResult<string>> SupplierUpdate([FromBody] AmlakInfoSupplierUpdateVm param)
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

        [Route("Supplier/Delete")]
        [HttpPost]
        public async Task<ApiResult<string>> SupplierDelete([FromBody] PublicParamIdViewModel param)
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

        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------

        [Route("AmlakInfo/List")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakInfoReadVm>>> AmlakInfoList(AmlakInfoReadInputVm param)
        {
            List<AmlakInfoReadVm> data = new List<AmlakInfoReadVm>();
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
                            AmlakInfoReadVm row = new AmlakInfoReadVm();
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

        [Route("AmlakInfo/Read")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakInfoReadVm>>> AmlakInfoRead(PublicParamIdViewModel param)
        {
            List<AmlakInfoReadVm> data = new List<AmlakInfoReadVm>();
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
                            AmlakInfoReadVm row = new AmlakInfoReadVm();
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

        
        [Route("AmlakInfo/Update")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakInfoUpdate([FromBody] AmlakInfoUpdateVm param)
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

        [Route("AmlakInfo/Delete")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakInfoDelete([FromBody] PublicParamIdViewModel param)
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

        
        
        
        [Route("AmlakInfo/Kind")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakInfoKindVm>>> AmlakInfoKind()
        {
            List<AmlakInfoKindVm> data = new List<AmlakInfoKindVm>();
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
                            AmlakInfoKindVm row = new AmlakInfoKindVm();
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

              
        [Route("AmlakInfo/Upload")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakInfoUploadFile(AmlakInfoFileUploadVm fileUpload)
        {
            string issuccess = "ناموفق";

            string fileName = await UploadHelper.UploadFile(fileUpload.FormFile, "AmlakInfos/"+fileUpload.AmlakInfoId);
            if (fileName!=""){
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP0_AmlakInfoFileDetail_Insert", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("AmlakInfoId", fileUpload.AmlakInfoId);
                        sqlCommand.Parameters.AddWithValue("FileName", fileName);
                        sqlCommand.Parameters.AddWithValue("Title", fileUpload.FileTitle);
                        sqlCommand.Parameters.AddWithValue("Type", fileUpload.Type);
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

        [Route("AmlakInfo/Files")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakInfoFilesListVm>>> AmlakInfoAttachFiles(int amlakInfoId)
        {
            if (amlakInfoId == 0) BadRequest();

            List<AmlakInfoFilesListVm> output = new List<AmlakInfoFilesListVm>();

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
                        AmlakInfoFilesListVm fetchView = new AmlakInfoFilesListVm();
                        fetchView.AttachID = StringExtensions.ToNullableInt(dataReader["AttachID"].ToString());
                        fetchView.AmlakInfoId = StringExtensions.ToNullableInt(dataReader["AmlakInfoId"].ToString());
                        fetchView.FileName = prefixUrls+Path.GetFileName(dataReader["FileName"]+"");
                        fetchView.FileTitle = dataReader["FileTitle"].ToString();
                        fetchView.Type = dataReader["Type"].ToString();
                        output.Add(fetchView);

                        //dataReader.NextResult();
                    }
                }
            }
            return Ok(output);
        }

        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------

        
        [Route("Test11")]
        [HttpGet]
        public async Task<ApiResult<TblBudgets>> Test11(int ContractId){

            TblBudgets b = _db.TblBudgets.FirstOrDefault();
            
            return Ok( b);

        }
    }
}
