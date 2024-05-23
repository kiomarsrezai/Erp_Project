using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Commite;
using NewsWebsite.ViewModels.Api.Public;
using NewsWebsite.ViewModels.Commite;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;
using System;
using System.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.ViewModels.Api.Contract;
using NewsWebsite.ViewModels.Api.Request;
using NewsWebsite.Common.PublicMethod;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System.Security.Claims;
using RestSharp;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Net;
using System.Security.Policy;
using System.Net.Mime;
using System.Text;

namespace NewsWebsite.Areas.Api.Controllers.v1
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class ContractApiController : ControllerBase
    {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;

        public ContractApiController(IUnitOfWork uw, IConfiguration config)
        {
            _config = config;
            _uw = uw;
        }

        [HttpGet]
        [Route("ResponseDataFromSdi")]

        public async Task<ResponseLayerDto> ResponseSdi()
        {
            var client = new RestClient("https://sdi.ahvaz.ir/geoapi/user/login/");
            //client.r = -1;
            var request = new RestRequest();
            request.Method= Method.Get;
            request.AddHeader("content-type", "application/json");
            request.AddHeader("Accept", "application/json, text/plain, */*");
            request.AddParameter("application/json", "{\n    \"username\": \"Erp_ahvaz\",\n    \"password\": \"123456\",\n    \"appId\": \"mobilegis\"\n}", ParameterType.RequestBody);
            var response =await client.ExecuteAsync(request);

            var resp = JsonConvert.DeserializeObject<ResponseLoginSdiDto>(response.Content.ToString());

            var options = new RestClientOptions("https://sdi.ahvaz.ir")
            {
                MaxTimeout = -1,
            };
            var clientLayer = new RestClient(options);
            var requestLayer = new RestRequest("/geoserver/ows?service=wfs&version=1.0.0&request=GetFeature&typeName=ahvazparcel_9320&srsname=EPSG:4326&outputFormat=application/json&maxFeatures=100&startIndex=0&authkey=fc4133ac632d3c8c4c534b4394808ff672b582d4", Method.Post);
            requestLayer.AddHeader("content-type", "application/json");
            requestLayer.AddHeader("Accept", "application/json, text/plain, */*");
            RestResponse responseLayer = await clientLayer.ExecuteAsync(requestLayer);
            var respLayer = JsonConvert.DeserializeObject<ResponseLayerDto>(responseLayer.Content.ToString());

            for (int i=0;i<=respLayer.totalFeatures;i++)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP012_AmlakInfo_Insert", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("AmlakInfoId", respLayer.features[i].id);
                        sqlCommand.Parameters.AddWithValue("AreaId", respLayer.features[i].properties.mantaqe);
                        sqlCommand.Parameters.AddWithValue("AmlakInfoKindId", 4);
                        sqlCommand.Parameters.AddWithValue("EstateInfoName", respLayer.features[i].properties.name);
                        sqlCommand.Parameters.AddWithValue("EstateInfoAddress", respLayer.features[i].properties.adress);
                        sqlCommand.Parameters.AddWithValue("EstateInfolate", respLayer.features[i].geometry.coordinates[0]);
                        sqlCommand.Parameters.AddWithValue("AmlakInfolong", respLayer.features[i].geometry.coordinates[1]);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                       
                    }
                }
            }
            return respLayer;
        }

        [Route("ContractRead")]
        [HttpGet]
        public async Task<ApiResult<List<ContractReadViewModel>>> Ac_ContractRead(PublicParamIdViewModel param)
        {
            List<ContractReadViewModel> ContractView = new List<ContractReadViewModel>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP012_Contract_Read", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("Id", param.Id);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            ContractReadViewModel data = new ContractReadViewModel();
                            data.Id = int.Parse(dataReader["Id"].ToString());
                            data.Number = dataReader["Number"].ToString();
                            data.Date = StringExtensions.ToNullableDatetime(dataReader["Date"].ToString());
                            data.DateShamsi = DateTimeExtensions.ConvertMiladiToShamsi(StringExtensions.ToNullableDatetime(dataReader["Date"].ToString()), "yyyy/MM/dd");
                            data.Description = dataReader["Description"].ToString();
                            data.SuppliersId = StringExtensions.ToNullableInt(dataReader["SuppliersId"].ToString());
                            data.DoingMethodId = StringExtensions.ToNullableInt(dataReader["DoingMethodId"].ToString());
                            data.SuppliersName = dataReader["SuppliersName"].ToString();
                            data.DateFrom = StringExtensions.ToNullableDatetime(dataReader["DateFrom"].ToString());
                            data.DateFromShamsi = DateTimeExtensions.ConvertMiladiToShamsi(StringExtensions.ToNullableDatetime(dataReader["DateFrom"].ToString()), "yyyy/MM/dd");
                            data.DateEnd = StringExtensions.ToNullableDatetime(dataReader["DateEnd"].ToString());
                            data.DateEndShamsi = DateTimeExtensions.ConvertMiladiToShamsi(StringExtensions.ToNullableDatetime(dataReader["DateEnd"].ToString()), "yyyy/MM/dd");
                            data.Amount = Int64.Parse(dataReader["Amount"].ToString());
                            data.Surplus = Int64.Parse(dataReader["Surplus"].ToString());
                            data.Final = bool.Parse(dataReader["Final"].ToString());
                            ContractView.Add(data);
                        }
                    }
                    sqlconnect.Close();
                }
            }
            return Ok(ContractView);
        }

        [Route("ContractSearch")]
        [HttpGet]
        public async Task<ApiResult<List<ContractSearchViewModel>>> Ac_ContractSearch(PublicParamAreaIdViewModel param)
        {
            List<ContractSearchViewModel> ContractSearchView = new List<ContractSearchViewModel>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP012_Contract_Search", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("AreaId", param.AreaId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            ContractSearchViewModel data = new ContractSearchViewModel();
                            data.Id = int.Parse(dataReader["Id"].ToString());
                            data.Number = dataReader["Number"].ToString();
                            data.Date = StringExtensions.ToNullableDatetime(dataReader["Date"].ToString());
                            data.DateShamsi = DateTimeExtensions.ConvertMiladiToShamsi(StringExtensions.ToNullableDatetime(dataReader["Date"].ToString()), "yyyy/MM/dd");
                            data.Description = dataReader["Description"].ToString();
                            data.SuppliersName = dataReader["SuppliersName"].ToString();
                            ContractSearchView.Add(data);
                        }
                    }
                    sqlconnect.Close();
                }
            }
            return Ok(ContractSearchView);
        }

        [Route("ContractInsert")]
        [HttpPost]
        public async Task<ApiResult<ContractReadViewModel>> Ac_ContractInsert([FromBody] ContractInsertParamViewModel param)
        {
            string readercount = null;
            ContractReadViewModel data = new ContractReadViewModel();
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP012_Contract_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("AreaId", param.AreaId);
                    sqlCommand.Parameters.AddWithValue("Number", param.Number);
                    sqlCommand.Parameters.AddWithValue("Date", param.Date);
                    sqlCommand.Parameters.AddWithValue("Description", param.Description);
                    sqlCommand.Parameters.AddWithValue("SuppliersId", param.SuppliersId);
                    sqlCommand.Parameters.AddWithValue("DoingMethodId", param.DoingMethodId);
                    sqlCommand.Parameters.AddWithValue("DateFrom", param.DateFrom);
                    sqlCommand.Parameters.AddWithValue("DateEnd", param.DateEnd);
                    sqlCommand.Parameters.AddWithValue("Amount", param.Amount);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        DataTable table = dataReader.GetSchemaTable();
                        if (table.Columns.Count == 1) readercount = dataReader["Message_DB"].ToString();
                        else
                        {
                            data.Id = int.Parse(dataReader["Id"].ToString());
                            data.Number = dataReader["Number"].ToString();
                            data.Date = StringExtensions.ToNullableDatetime(dataReader["Date"].ToString());
                            data.DateShamsi = DateTimeExtensions.ConvertMiladiToShamsi(StringExtensions.ToNullableDatetime(dataReader["Date"].ToString()), "yyyy/MM/dd");
                            data.Description = dataReader["Description"].ToString();
                            data.SuppliersId = int.Parse(dataReader["SuppliersId"].ToString());
                            data.SuppliersName = dataReader["SuppliersName"].ToString();
                            data.DoingMethodId = int.Parse(dataReader["DoingMethodId"].ToString());
                            data.DateFrom = StringExtensions.ToNullableDatetime(dataReader["DateFrom"].ToString());
                            data.DateFromShamsi = DateTimeExtensions.ConvertMiladiToShamsi(StringExtensions.ToNullableDatetime(dataReader["DateFrom"].ToString()), "yyyy/MM/dd");
                            data.DateEnd = StringExtensions.ToNullableDatetime(dataReader["DateEnd"].ToString());
                            data.DateEndShamsi = DateTimeExtensions.ConvertMiladiToShamsi(StringExtensions.ToNullableDatetime(dataReader["DateEnd"].ToString()), "yyyy/MM/dd");
                            data.Amount = Int64.Parse(dataReader["Amount"].ToString());
                            data.Surplus = Int64.Parse(dataReader["Surplus"].ToString());
                            data.Final = bool.Parse(dataReader["Final"].ToString());
                        }

                    }
                }
            }
            if (string.IsNullOrEmpty(readercount)) return Ok(data);
            else
                return BadRequest(readercount);
        }

        [Route("ContractUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_ContractUpdate([FromBody] ContractUpdateParamViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP012_Contract_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", param.Id);
                    sqlCommand.Parameters.AddWithValue("Number", param.Number);
                    sqlCommand.Parameters.AddWithValue("Date", param.Date);
                    sqlCommand.Parameters.AddWithValue("Description", param.Description);
                    sqlCommand.Parameters.AddWithValue("SuppliersId", param.SuppliersId);
                    sqlCommand.Parameters.AddWithValue("DateFrom", param.DateFrom);
                    sqlCommand.Parameters.AddWithValue("DateEnd", param.DateEnd);
                    sqlCommand.Parameters.AddWithValue("DoingMethodId", param.DoingMethodId);
                    sqlCommand.Parameters.AddWithValue("Amount", param.Amount);
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

        [Route("ContractDelete")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_ContractDelete([FromBody] PublicParamIdViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP012_Contract_Delete", sqlconnect))
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

        [Route("ContractAreaRead")]
        [HttpGet]
        public async Task<ApiResult<List<ContractAreaViewModel>>> Ac_ContractAreaRead(PublicParamIdViewModel param)
        {
            List<ContractAreaViewModel> ContractView = new List<ContractAreaViewModel>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP012_ContractArea_Read", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("Id", param.Id);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            ContractAreaViewModel data = new ContractAreaViewModel();
                            data.Id = int.Parse(dataReader["Id"].ToString());
                            data.AreaId = int.Parse(dataReader["AreaId"].ToString());
                            data.AreaName = dataReader["AreaName"].ToString();
                            data.ShareAmount = Int64.Parse(dataReader["ShareAmount"].ToString());
                            ContractView.Add(data);
                        }
                    }
                    sqlconnect.Close();
                }
            }
            return Ok(ContractView);
        }

        [Route("ContractAreaInsert")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_ContractAreaInsert([FromBody] ContractAreaInsertViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP012_ContractArea_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("ContractId", param.ContractId);
                    sqlCommand.Parameters.AddWithValue("AreaId", param.AreaId);
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

        [Route("ContractAreaUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_ContractAreaUpdate([FromBody] ContractAreaUpdateViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP012_ContractArea_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", param.Id);
                    sqlCommand.Parameters.AddWithValue("ShareAmount", param.ShareAmount);
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

        [Route("ContractAreaDelete")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_ContractAreaDelete([FromBody] PublicParamIdViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP012_ContractArea_Delete", sqlconnect))
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

        [Route("Contract_Request_Search")]
        [HttpGet]
        public async Task<ApiResult<List<ContractRequestSearchViewModel>>> Ac_Contract_Request_Search(ContractRequestSearchParamViewModel param)
        {
            List<ContractRequestSearchViewModel> ContractSearchView = new List<ContractRequestSearchViewModel>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP012_Contract_Request_Search", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("YearId", param.YearId);
                        sqlCommand.Parameters.AddWithValue("AreaId", param.AreaId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            ContractRequestSearchViewModel data = new ContractRequestSearchViewModel();
                            data.Id = int.Parse(dataReader["Id"].ToString());
                            data.Number = dataReader["Number"].ToString();
                            data.Date = StringExtensions.ToNullableDatetime(dataReader["Date"].ToString());
                            data.DateShamsi = DateTimeExtensions.ConvertMiladiToShamsi(StringExtensions.ToNullableDatetime(dataReader["Date"].ToString()), "yyyy/MM/dd");
                            data.Description = dataReader["Description"].ToString();
                            ContractSearchView.Add(data);
                        }
                    }
                    sqlconnect.Close();
                }
            }
            return Ok(ContractSearchView);
        }

        [Route("ContractRequestRead")]
        [HttpGet]
        public async Task<ApiResult<List<ContractRequestReadViewModel>>> Ac_ContractRequestRead(PublicParamIdViewModel param)
        {
            List<ContractRequestReadViewModel> ContractSearchView = new List<ContractRequestReadViewModel>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP012_ContractRequest_Read", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("YearId", param.Id);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            ContractRequestReadViewModel data = new ContractRequestReadViewModel();
                            data.Id = int.Parse(dataReader["Id"].ToString());
                            data.YearName = dataReader["YearName"].ToString();
                            data.AreaName = dataReader["AreaName"].ToString();
                            data.Number = dataReader["Number"].ToString();
                            data.Date = StringExtensions.ToNullableDatetime(dataReader["Date"].ToString());
                            data.DateShamsi = DateTimeExtensions.ConvertMiladiToShamsi(StringExtensions.ToNullableDatetime(dataReader["Date"].ToString()), "yyyy/MM/dd");
                            data.Description = dataReader["Description"].ToString();
                            ContractSearchView.Add(data);
                        }
                    }
                    sqlconnect.Close();
                }
            }
            return Ok(ContractSearchView);
        }

        [Route("AmlakInfoKindCom")]
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

        [Route("AmlakInfoRead")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakInfoPrivateReadViewModel>>> Ac_AmlakInfoRead()
        {
            List<AmlakInfoPrivateReadViewModel> data = new List<AmlakInfoPrivateReadViewModel>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP012_AmlakInfo_Read", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            AmlakInfoPrivateReadViewModel row = new AmlakInfoPrivateReadViewModel();
                            row.Id = int.Parse(dataReader["Id"].ToString());
                            row.AreaId = int.Parse(dataReader["AreaId"].ToString());
                            row.AmlakInfoKindId = int.Parse(dataReader["AmlakInfoKindId"].ToString());
                            row.AreaName = dataReader["AreaName"].ToString();
                            row.AmlakInfoKindName = dataReader["AmlakInfoKindName"].ToString();
                            row.EstateInfoName = dataReader["EstateInfoName"].ToString();
                            row.EstateInfoAddress = dataReader["EstateInfoAddress"].ToString();
                            data.Add(row);
                        }
                    }
                    sqlconnect.Close();
                }
            }
            return Ok(data);
        }

        [Route("AmlakInfoInsert")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_AmlakInfoInsert([FromBody] AmlakInfoPrivateInsertViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP012_AmlakInfo_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("AreaId", param.AreaId);
                    sqlCommand.Parameters.AddWithValue("AmlakInfoKindId", param.AmlakInfoKindId);
                    sqlCommand.Parameters.AddWithValue("EstateInfoName", param.EstateInfoName);
                    sqlCommand.Parameters.AddWithValue("EstateInfoAddress", param.EstateInfoAddress);
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


        [Route("AmlakInfoUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_AmlakInfoUpdate([FromBody] AmlakInfoPrivateUpdateViewModel param)
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

        [Route("AmlakPrivateRead")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakPrivateReadViewModel>>> Ac_AmlakPrivateRead(param20 param)
        {
            List<AmlakPrivateReadViewModel> ContractSearchView = new List<AmlakPrivateReadViewModel>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP012_AmlakPrivate_Read", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("AmlakInfoId", param.AmlakInfoId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            AmlakPrivateReadViewModel data = new AmlakPrivateReadViewModel();
                            data.Id = int.Parse(dataReader["Id"].ToString());
                            data.Masahat = double.Parse(dataReader["Masahat"].ToString());
                            data.NumberGhorfe = dataReader["NumberGhorfe"].ToString();
                            ContractSearchView.Add(data);
                        }
                    }
                    sqlconnect.Close();
                }
            }
            return Ok(ContractSearchView);
        }

        [Route("AmlakPrivateInsert")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_AmlakPrivateInsert([FromBody] AmlakPrivateInsertViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP012_AmlakPrivate_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("AmlakInfoId", param.AmlakInfoId);
                    sqlCommand.Parameters.AddWithValue("Masahat", param.Masahat);
                    sqlCommand.Parameters.AddWithValue("NumberGhorfe", param.NumberGhorfe);
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

        [Route("AmlakPrivateUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_AmlakPrivateUpdate([FromBody] AmlakPrivateUpdateViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP012_AmlakPrivate_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", param.Id);
                    sqlCommand.Parameters.AddWithValue("Masahat", param.Masahat);
                    sqlCommand.Parameters.AddWithValue("NumberGhorfe", param.NumberGhorfe);
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

        [Route("AmlakPrivateDelete")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_AmlakPrivateDelete([FromBody] PublicParamIdViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP012_AmlakPrivate_Delete", sqlconnect))
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

        [Route("ContractInstallmentsRead")]
        [HttpGet]
        public async Task<ApiResult<List<ContractInstallmentsReadViewModel>>> Ac_ContractInstallmentsRead(Param30 param)
        {
            List<ContractInstallmentsReadViewModel> data = new List<ContractInstallmentsReadViewModel>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP012_ContractInstallments_Read", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("ContractId", param.ContractId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            ContractInstallmentsReadViewModel row = new ContractInstallmentsReadViewModel();
                            row.Id = int.Parse(dataReader["Id"].ToString());
                            row.InstallmentsDate = dataReader["InstallmentsDate"].ToString();
                            row.DateShamsi = DateTimeExtensions.ConvertMiladiToShamsi(StringExtensions.ToNullableDatetime(dataReader["InstallmentsDate"].ToString()), "yyyy/MM/dd");
                            row.MonthlyAmount = Int64.Parse(dataReader["MonthlyAmount"].ToString());
                            data.Add(row);
                        }
                    }
                    sqlconnect.Close();
                }
            }
            return Ok(data);
        }

        [Route("ContractInstallmentsInsert")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_ContractInstallmentsInsert([FromBody] ContractInstallmentsInsertViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP012_ContractInstallments_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("ContractId", param.ContractId);
                    sqlCommand.Parameters.AddWithValue("Date", param.Date);
                    sqlCommand.Parameters.AddWithValue("Amount", param.Amount);
                    sqlCommand.Parameters.AddWithValue("Month", param.Month);
                    sqlCommand.Parameters.AddWithValue("YearName", param.YearName);
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

        [Route("ContractInstallmentsUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_ContractInstallmentsUpdate([FromBody] ContractInstallmentsUpdateViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP012_ContractInstallments_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", param.Id);
                    sqlCommand.Parameters.AddWithValue("Date", param.Date);
                    sqlCommand.Parameters.AddWithValue("Amount", param.Amount);
                    sqlCommand.Parameters.AddWithValue("Month", param.Month);
                    sqlCommand.Parameters.AddWithValue("YearName", param.YearName);
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

        [Route("ContractInstallmentsDelete")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_ContractInstallmentsDelete([FromBody] PublicParamIdViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP012_ContractInstallments_Delete", sqlconnect))
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

        [Route("ReciveBankRead")]
        [HttpGet]
        public async Task<ApiResult<List<ReciveBankViewModel>>> Ac_ReciveBankRead(param31 param)
        {
            List<ReciveBankViewModel> data = new List<ReciveBankViewModel>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP012_ReciveBank_Read", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("Date", param.Date);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            ReciveBankViewModel row = new ReciveBankViewModel();
                            row.Id = int.Parse(dataReader["Id"].ToString());
                            row.Date = StringExtensions.ToNullableDatetime(dataReader["Date"].ToString());
                            row.DateShamsi = DateTimeExtensions.ConvertMiladiToShamsi(StringExtensions.ToNullableDatetime(dataReader["Date"].ToString()), "yyyy/MM/dd");
                            row.Amount = Int64.Parse(dataReader["Amount"].ToString());
                            data.Add(row);
                        }
                    }
                    sqlconnect.Close();
                }
            }
            return Ok(data);
        }

        [Route("ContractInstallmentsReciveRead")]
        [HttpGet]
        public async Task<ApiResult<List<ContractInstallmentsReciveReadViewModel>>> Ac_ContractInstallmentsReciveRead(param32 param)
        {
            List<ContractInstallmentsReciveReadViewModel> data = new List<ContractInstallmentsReciveReadViewModel>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP012_ContractInstallmentsRecive_Read", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("ReciveBankId", param.ReciveBankId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            ContractInstallmentsReciveReadViewModel row = new ContractInstallmentsReciveReadViewModel();
                            row.Id = int.Parse(dataReader["Id"].ToString());
                            row.SuppliersName = dataReader["SuppliersName"].ToString();
                            row.Number = dataReader["Number"].ToString();
                            row.YearName = int.Parse(dataReader["YearName"].ToString());
                            row.MonthId = int.Parse(dataReader["MonthId"].ToString());
                            row.ReciveAmount = Int64.Parse(dataReader["ReciveAmount"].ToString());
                            data.Add(row);
                        }
                    }
                    sqlconnect.Close();
                }
            }
            return Ok(data);
        }

        [Route("ReciveBankModal")]
        [HttpGet]
        public async Task<ApiResult<List<ReciveBankModalViewModel>>> Ac_ReciveBankModal(param33 param)
        {
            List<ReciveBankModalViewModel> data = new List<ReciveBankModalViewModel>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP012_ReciveBank_Modal", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("SuppliersId", param.SuppliersId);
                        sqlCommand.Parameters.AddWithValue("ReciveBankId", param.ReciveBankId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            ReciveBankModalViewModel row = new ReciveBankModalViewModel();
                            row.Id = int.Parse(dataReader["Id"].ToString());
                            row.YearName = int.Parse(dataReader["YearName"].ToString());
                            row.MonthId = int.Parse(dataReader["MonthId"].ToString());
                            row.MonthlyAmount = Int64.Parse(dataReader["MonthlyAmount"].ToString());
                            row.Description = dataReader["Description"].ToString();
                            data.Add(row);
                        }
                    }
                    sqlconnect.Close();
                }
            }
            return Ok(data);
        }

        [Route("ContractInstallmentsReciveInsert")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_ContractInstallmentsReciveInsert([FromBody] ReciveBankSuppliersInsertViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP012_ContractInstallmentsRecive_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("ReciveBankId", param.ReciveBankId);
                    sqlCommand.Parameters.AddWithValue("ContractInstallmentsId", param.ContractInstallmentsId);
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

        [Route("ContractInstallmentsReciveUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_ContractInstallmentsReciveUpdate([FromBody] ContractInstallmentsReciveUpdateViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP012_ContractInstallmentsRecive_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", param.Id);
                    sqlCommand.Parameters.AddWithValue("ReciveAmount", param.ReciveAmount);
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
