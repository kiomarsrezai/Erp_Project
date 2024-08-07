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
using NewsWebsite.Data.Repositories;
using NewsWebsite.ViewModels;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using NewsWebsite.ViewModels.Video;

namespace NewsWebsite.Areas.Api.Controllers.v1
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class ContractAmlakPrivateApiController : ControllerBase
    {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        protected readonly ProgramBuddbContext _db;

        public ContractAmlakPrivateApiController(IUnitOfWork uw, IConfiguration config, IWebHostEnvironment webHostEnvironment,ProgramBuddbContext db)
        {
            _config = config;
            _uw = uw;
            _webHostEnvironment = webHostEnvironment;
            _db=db;

        }

        
        [HttpGet]
        [Route("all_polygon_amlak_472")]
        public async Task<IActionResult> UpdateDataFromSdi_ahvaz_kiosk()
        {
            // var options = new RestClientOptions("https://sdi.ahvaz.ir")
            // {
            //     MaxTimeout = -1,
            // };
            // var client = new RestClient(options);
            // var request = new RestRequest("/geoapi/user/login/", Method.Post);
            // request.AddHeader("content-type", "application/json");
            // request.AddHeader("Accept", "application/json, text/plain, */*");
            // request.AddHeader("Cookie", "cookiesession1=678ADA629490114186F01A0EF409171D; csrftoken=dKwYwwwT5wcj60bhh4ojKy1R4JQrdxD7; sessionid=bsj9qwbunhlpl7bymk7o9uy3x6cr9ubg");
            // var body = @"{" + "\n" +
            // @" ""username"": ""ERP_Fava""," + "\n" +
            // @" ""password"":" + "\n" +
            // @"""123456""," + "\n" +
            // @" ""appId"": ""mobilegis""" + "\n" +
            // @"}";
            // request.AddStringBody(body, DataFormat.Json);
            // RestResponse responselogin = await client.ExecuteAsync(request);
            // var resplogin = JsonConvert.DeserializeObject<ResponseLoginSdiDto>(responselogin.Content.ToString());
            //
            // //var options2 = new RestClientOptions("https://sdi.ahvaz.ir")
            // //{
            // //    MaxTimeout = -1,
            // //};
            // //var client2 = new RestClient(options2);
            // //var request2 = new RestRequest("/geoserver/ows?service=wfs&version=1.0.0&request=GetFeature&typeName=ahvaz_kiosk14000719_8798&srsname=EPSG:4326&outputFormat=application/json&maxFeatures=10000&startIndex=0&authkey="+ resplogin.api_key.ToString(), Method.Get);
            // //request.AddHeader("content-type", "application/json");
            // //request.AddHeader("Accept", "application/json, text/plain, */*");
            // //request.AddHeader("Cookie", "cookiesession1=678ADA629490114186F01A0EF409171D; csrftoken=dKwYwwwT5wcj60bhh4ojKy1R4JQrdxD7; sessionid=bsj9qwbunhlpl7bymk7o9uy3x6cr9ubg");
            // //RestResponse response2 = await client2.ExecuteAsync(request2);
            // ////UTF8Encoding uTF8Encoding = new UTF8Encoding();
            // ////uTF8Encoding.GetBytes(response2.Content.ToString());
            // //byte[] messageBytes = Encoding.UTF8.GetBytes(response2.Content);
            // //string newmessage = Encoding.UTF8.GetString(messageBytes, 0, messageBytes.Length);
            // var options2 = new RestClientOptions("https://sdi.ahvaz.ir")
            // {
            //     MaxTimeout = -1,
            // };
            // var client2 = new RestClient(options2);
            // var request2 = new RestRequest("/geoserver/ows?service=wfs&version=1.0.0&request=GetFeature&typeName=all_polygon_amlak_472&srsname=EPSG:4326&outputFormat=application/json&maxFeatures=10000&startIndex=0&authkey=e434be85d126299659334f104feffb18f51328a6", Method.Post);
            // request2.AddHeader("content-type", "application/json");
            // request2.AddHeader("Accept", "application/json, text/plain, */*");
            // request2.AddHeader("Cookie", "cookiesession1=678ADA629490114186F01A0EF409171D; csrftoken=dKwYwwwT5wcj60bhh4ojKy1R4JQrdxD7; sessionid=bsj9qwbunhlpl7bymk7o9uy3x6cr9ubg");
            // RestResponse response2 = await client2.ExecuteAsync(request2);
            // byte[] messageBytes = Encoding.UTF8.GetBytes(response2.Content);
            // string newmessage = Encoding.UTF8.GetString(messageBytes, 0, messageBytes.Length);
            
            var filePath = Path.Combine(_webHostEnvironment.WebRootPath, "amlak.json");
            string newmessage = await System.IO.File.ReadAllTextAsync(filePath);
            
            var respLayer = JsonConvert.DeserializeObject<ResponseLayerDto>(newmessage.ToString());

            for (int i = 0; i <= respLayer.totalFeatures; i++)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP012_AmlakPrivateNew_Insert", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("Id", respLayer.features[i].id);
                        sqlCommand.Parameters.AddWithValue("@AreaId", respLayer.features[i].properties.mantaqe);
                        sqlCommand.Parameters.AddWithValue("@SdiId", 3);
                        sqlCommand.Parameters.AddWithValue("@Coordinates", respLayer.features[i].properties.name);
                        sqlCommand.Parameters.AddWithValue("@Masahat", respLayer.features[i].properties.adress);
                        sqlCommand.Parameters.AddWithValue("@Title", respLayer.features[i].geometry.coordinates[0][0].ToString());
                        sqlCommand.Parameters.AddWithValue("@TypeUsing", respLayer.features[i].geometry.coordinates[0][1].ToString());
                        sqlCommand.Parameters.AddWithValue("@SadaCode", respLayer.features[i].geometry.coordinates[0][1].ToString());
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


        [Route("AmlakPrivate/List")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakPrivateNew>>> AmlakPrivateList(AmlakPrivateReadInputVm param)
        {
            
            var data = await _db.AmlakPrivateNews.ToListAsync();

            // var data = MyMapper.MapTo<AmlakPrivateNew, AmlakPrivateReadVm>(res);
            
            
            // List<AmlakPrivateReadVm> data = new List<AmlakPrivateReadVm>();
            // {
            //     using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            //     {
            //         using (SqlCommand sqlCommand = new SqlCommand("SP012_AmlakPrivate_Search", sqlconnect))
            //         {
            //             sqlconnect.Open();
            //             sqlCommand.CommandType = CommandType.StoredProcedure;
            //             sqlCommand.Parameters.AddWithValue("AreaId", param.AreaId);
            //             SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
            //             while (await dataReader.ReadAsync())
            //             {
            //                 AmlakPrivateReadVm row = new AmlakPrivateReadVm();
            //                 row.Id = int.Parse(dataReader["Id"].ToString());
            //                 row.AreaId = int.Parse(dataReader["AreaId"].ToString());
            //                 row.SdiId = dataReader["SdiId"].ToString();
            //                 row.Coordinates = dataReader["Coordinates"].ToString();
            //                 row.Masahat = StringExtensions.ToNullablefloat(dataReader["Masahat"].ToString());
            //                 row.Title = dataReader["Title"].ToString();
            //                 row.TypeUsing = dataReader["TypeUsing"].ToString();
            //                 row.SadaCode = dataReader["SadaCode"].ToString();
            //                 data.Add(row);
            //             }
            //         }
            //         sqlconnect.Close();
            //     }
            // }
            return Ok(data);
        }

        [Route("AmlakPrivate/Read")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakPrivateReadVm>>> AmlakPrivateRead(PublicParamIdViewModel param)
        {
            List<AmlakPrivateReadVm> data = new List<AmlakPrivateReadVm>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP012_AmlakPrivate_Read", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("Id", param.Id);
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            AmlakPrivateReadVm row = new AmlakPrivateReadVm();
                            row.Id = int.Parse(dataReader["Id"].ToString());
                            row.AreaId = int.Parse(dataReader["AreaId"].ToString());
                            row.SdiId = dataReader["SdiId"].ToString();
                            row.Coordinates = dataReader["Coordinates"].ToString();
                            row.Masahat = StringExtensions.ToNullablefloat(dataReader["Masahat"].ToString());
                            row.Title = dataReader["Title"].ToString();
                            row.TypeUsing = dataReader["TypeUsing"].ToString();
                            row.SadaCode = dataReader["SadaCode"].ToString();
                            data.Add(row);
                        }
                    }
                    sqlconnect.Close();
                }
            }
            return Ok(data);
        }

        
        [Route("AmlakPrivate/Update")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakPrivateUpdate([FromBody] AmlakPrivateUpdateVm param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP012_AmlakPrivate_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", param.Id);
                    sqlCommand.Parameters.AddWithValue("AreaId", param.AreaId);
                    sqlCommand.Parameters.AddWithValue("Masahat", param.Masahat);
                    sqlCommand.Parameters.AddWithValue("Title", param.Title);
                    sqlCommand.Parameters.AddWithValue("TypeUsing", param.TypeUsing);
                    sqlCommand.Parameters.AddWithValue("SadaCode", param.SadaCode);
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


              
        [Route("AmlakPrivate/Upload")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakPrivateUploadFile(AmlakPrivateFileUploadVm fileUpload)
        {
            string issuccess = "ناموفق";

            string fileName = await UploadHelper.UploadFile(fileUpload.FormFile, "AmlakPrivates/"+fileUpload.AmlakPrivateId);
            if (fileName!=""){
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP0_AmlakPrivateFileDetail_Insert", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("AmlakPrivateId", fileUpload.AmlakPrivateId);
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

        [Route("AmlakPrivate/Files")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakPrivateFilesListVm>>> AmlakPrivateAttachFiles(int AmlakPrivateId)
        {
            if (AmlakPrivateId == 0) BadRequest();

            List<AmlakPrivateFilesListVm> output = new List<AmlakPrivateFilesListVm>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP000_GetListAmlakPrivateAttachFiles", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("AmlakPrivateId", AmlakPrivateId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    var prefixUrls = "/Upload/AmlakPrivates/"+AmlakPrivateId+"/";
                    while (dataReader.Read())
                    {
                        AmlakPrivateFilesListVm fetchView = new AmlakPrivateFilesListVm();
                        fetchView.AttachID = StringExtensions.ToNullableInt(dataReader["AttachID"].ToString());
                        fetchView.AmlakPrivateId = StringExtensions.ToNullableInt(dataReader["AmlakPrivateId"].ToString());
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

        
        [Route("Test111")]
        [HttpGet]
        public async Task<ApiResult<TblBudgets>> Test11(int ContractId){

            TblBudgets b = _db.TblBudgets.FirstOrDefault();
            
            return Ok( b);

        }
    }
}
