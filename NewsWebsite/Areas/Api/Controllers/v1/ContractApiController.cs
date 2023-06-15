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

namespace NewsWebsite.Areas.Api.Controllers.v1
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    //[ApiController]
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
                            data.Date = dataReader["Date"].ToString();
                            data.DateShamsi = DateTimeExtensions.ConvertMiladiToShamsi(StringExtensions.ToNullableDatetime(dataReader["Date"].ToString()), "yyyy/MM/dd");
                            data.Description = dataReader["Description"].ToString();
                            data.SuppliersId = int.Parse(dataReader["SuppliersId"].ToString());
                            data.SuppliersName = dataReader["SuppliersName"].ToString();
                            data.DateFrom = dataReader["DateFrom"].ToString();
                            data.DateFromShamsi = DateTimeExtensions.ConvertMiladiToShamsi(StringExtensions.ToNullableDatetime(dataReader["DateFrom"].ToString()), "yyyy/MM/dd");
                            data.DateEnd = dataReader["DateEnd"].ToString();
                            data.DateEndShamsi = DateTimeExtensions.ConvertMiladiToShamsi(StringExtensions.ToNullableDatetime(dataReader["DateEnd"].ToString()), "yyyy/MM/dd");
                            data.Amount = int.Parse(dataReader["Amount"].ToString());
                            data.Surplus = int.Parse(dataReader["Surplus"].ToString());
                            data.Final =bool.Parse(dataReader["Final"].ToString());
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
                            data.Date = dataReader["Date"].ToString();
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

        //[Route("CommiteDetailEstimatetInsert")]
        //[HttpPost]
        //public async Task<ApiResult<string>> Ac_CommiteDetailEstimatetInsert([FromBody] CommiteDetailEstimatetInsertParamViewModel param)
        //{
        //    string readercount = null;

        //    using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
        //    {
        //        using (SqlCommand sqlCommand = new SqlCommand("SP006_CommiteDetailEstimate_Insert", sqlconnect))
        //        {
        //            sqlconnect.Open();
        //            sqlCommand.Parameters.AddWithValue("CommiteDetailId", param.CommiteDetailId);
        //            sqlCommand.Parameters.AddWithValue("Description", param.Description);
        //            sqlCommand.Parameters.AddWithValue("Quantity", param.Quantity);
        //            sqlCommand.Parameters.AddWithValue("Price", param.Price);
        //            sqlCommand.CommandType = CommandType.StoredProcedure;
        //            SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
        //            while (dataReader.Read())
        //            {
        //                if (dataReader["Message_DB"].ToString() != null) readercount = dataReader["Message_DB"].ToString();
        //            }
        //        }
        //    }
        //    if (string.IsNullOrEmpty(readercount)) return Ok("با موفقیت انجام شد");
        //    else
        //        return BadRequest(readercount);
        //}

        //[Route("CommiteDetailEstimateUpdate")]
        //[HttpPost]
        //public async Task<ApiResult<string>> Ac_CommiteDetailEstimateUpdate([FromBody] CommiteDetailEstimatetUpdateParamViewModel param)
        //{
        //    string readercount = null;

        //    using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
        //    {
        //        using (SqlCommand sqlCommand = new SqlCommand("SP006_CommiteDetailEstimate_Update", sqlconnect))
        //        {
        //            sqlconnect.Open();
        //            sqlCommand.Parameters.AddWithValue("Id", param.Id);
        //            sqlCommand.Parameters.AddWithValue("Description", param.Description);
        //            sqlCommand.Parameters.AddWithValue("Quantity", param.Quantity);
        //            sqlCommand.Parameters.AddWithValue("Price", param.Price);
        //            sqlCommand.CommandType = CommandType.StoredProcedure;
        //            SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
        //            while (dataReader.Read())
        //            {
        //                if (dataReader["Message_DB"].ToString() != null) readercount = dataReader["Message_DB"].ToString();
        //            }
        //        }
        //    }
        //    if (string.IsNullOrEmpty(readercount)) return Ok("با موفقیت انجام شد");
        //    else
        //        return BadRequest(readercount);
        //}

        //[Route("CommiteDetailEstimateDelete")]
        //[HttpPost]
        //public async Task<ApiResult<string>> Ac_CommiteDetailEstimateDelete([FromBody] DeletePublicParamViewModel Param)
        //{
        //    string readercount = null;

        //    using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
        //    {
        //        using (SqlCommand sqlCommand = new SqlCommand("SP006_CommiteDetailEstimate_Delete", sqlconnect))
        //        {
        //            sqlconnect.Open();
        //            sqlCommand.Parameters.AddWithValue("Id", Param.Id);
        //            sqlCommand.CommandType = CommandType.StoredProcedure;
        //            SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
        //            while (dataReader.Read())
        //            {
        //                if (dataReader["Message_DB"].ToString() != null) readercount = dataReader["Message_DB"].ToString();
        //            }
        //        }
        //    }
        //    if (string.IsNullOrEmpty(readercount)) return Ok("با موفقیت انجام شد");
        //    else
        //        return BadRequest(readercount);
        //}

    }
}
