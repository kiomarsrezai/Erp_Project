using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Request;
using NewsWebsite.ViewModels.Api.RequestTable;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace NewsWebsite.Areas.Api.Controllers.v1
{


    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class RequestApiController : ControllerBase
    {
        public readonly IUnitOfWork _uw;
        private readonly IConfiguration _config;

        public RequestApiController(IUnitOfWork uw,IConfiguration configuration)
        {
            _config = configuration;
            _uw = uw;
        }

        [Route("RequestCreate")]
        [HttpPost]
        public async Task<ApiResult<RequestAfterInsertViewModel>> RequestCreate([FromBody] RequestInsertViewModel viewModel)
        {
            RequestAfterInsertViewModel request = new RequestAfterInsertViewModel();

            if (viewModel.AreaId == 0)
                return BadRequest();
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP010_Request_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", viewModel.YearId);
                    sqlCommand.Parameters.AddWithValue("areaId", viewModel.AreaId);
                    sqlCommand.Parameters.AddWithValue("ExecuteDepartmanId", viewModel.ExecuteDepartmanId);
                    sqlCommand.Parameters.AddWithValue("UserId", viewModel.UserId);
                    sqlCommand.Parameters.AddWithValue("SuppliersId", viewModel.SuppliersId);
                    sqlCommand.Parameters.AddWithValue("RequestKindId", viewModel.RequestKindId);
                    sqlCommand.Parameters.AddWithValue("Description", viewModel.Description);
                    sqlCommand.Parameters.AddWithValue("DoingMethodId", viewModel.DoingMethodId);
                    sqlCommand.Parameters.AddWithValue("EstimateAmount", viewModel.EstimateAmount);
                    sqlCommand.Parameters.AddWithValue("ResonDoingMethod", viewModel.ResonDoingMethod);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        request.Id = int.Parse(dataReader["Id"].ToString());
                        request.AreaId = int.Parse(dataReader["AreaId"].ToString());
                        request.UserId = int.Parse(dataReader["UserId"].ToString());
                        request.Number = dataReader["Number"].ToString();
                        request.DoingMethodId = dataReader["DoingMethodId"] == null ? 1 : int.Parse(dataReader["DoingMethodId"].ToString());
                        request.DateS = dataReader["DateS"].ToString();
                        request.ExecuteDepartmanId = StringExtensions.ToNullableInt(dataReader["ExecuteDepartmanId"].ToString());
                        request.DoingMethodId = StringExtensions.ToNullableInt(dataReader["ExecuteDepartmanId"].ToString());
                        request.SuppliersId = StringExtensions.ToNullableInt(dataReader["ExecuteDepartmanId"].ToString());
                        request.ExecuteDepartmanId = StringExtensions.ToNullableInt(dataReader["ExecuteDepartmanId"].ToString());

                    }
                }
                return Ok(request);
            }
        }

        [Route("RequestRead")]
        [HttpGet]
        public async Task<ApiResult<RequestsViewModel>> GetRequest(RequestReadParamViewModel paramViewModel)
        {
            RequestsViewModel requestsViewModels = new RequestsViewModel(); 
            
            if (paramViewModel.RequestId == 0)
                return BadRequest();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP010_RequestTable_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("RequestId", paramViewModel.RequestId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        requestsViewModels.AreaId = int.Parse(dataReader["AreaId"].ToString());
                        requestsViewModels.Users = dataReader["Users"].ToString();
                        requestsViewModels.Number= dataReader["Number"].ToString();
                        requestsViewModels.DoingMethodId= int.Parse(dataReader["DoingMethodId"].ToString());
                        requestsViewModels.ResonDoingMethod = dataReader["ResonDoingMethod"].ToString();
                        requestsViewModels.Id= int.Parse(dataReader["Id"].ToString());
                        requestsViewModels.Date= dataReader["Date"].ToString();
                        requestsViewModels.DateS= dataReader["DateS"].ToString();
                        requestsViewModels.Description= dataReader["Description"].ToString();
                        requestsViewModels.EstimateAmount= long.Parse(dataReader["EstimateAmount"].ToString());
                        requestsViewModels.ExecuteDepartmanId= int.Parse(dataReader["ExecuteDepartmanId"].ToString());
                    }
                }
            }
            return Ok(requestsViewModels);
        }

        [Route("RequestUpdate")]
        [HttpPost]
        public async Task<ApiResult<RequestAfterInsertViewModel>> RequestUpdate([FromBody] RequestInsertViewModel viewModel)
        {
            RequestAfterInsertViewModel request = new RequestAfterInsertViewModel();

            if (viewModel.AreaId == 0)
                return BadRequest();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP010_RequestTable_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", viewModel.YearId);
                    sqlCommand.Parameters.AddWithValue("areaId", viewModel.AreaId);
                    sqlCommand.Parameters.AddWithValue("ExecuteDepartmanId", viewModel.ExecuteDepartmanId);
                    sqlCommand.Parameters.AddWithValue("UserId", viewModel.UserId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        request.Id = int.Parse(dataReader["Id"].ToString());
                        request.AreaId = int.Parse(dataReader["AreaId"].ToString());
                        request.UserId = int.Parse(dataReader["UserId"].ToString());
                        request.Number = dataReader["Number"].ToString();
                        request.DoingMethodId = int.Parse(dataReader["DoingMethodId"].ToString());
                        request.DateS = dataReader["DateS"].ToString();
                        request.ExecuteDepartmanId = int.Parse(dataReader["ExecuteDepartmanId"].ToString());
                    }
                }
            }
            return Ok(request);
        }

        [Route("RequestDelete")]
        [HttpPost]
        public async Task<ApiResult> RequestDelete(int id)
        {
            if (id == 0)
                return BadRequest();
            if (id > 0)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP010_RequestTable_Delete", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("id", id);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        sqlconnect.Close();
                    }
                }
            }
            return Ok();
        }

        [Route("GetRequestTableList")]
        [HttpGet]
        public async Task<ApiResult<List<RequestSearchViewModel>>> GetRequestTableList(RequestSearchParamViewModel paramViewModel)
        {
            List<RequestSearchViewModel> requestsViewModels = new List<RequestSearchViewModel>();

            if (paramViewModel.AreaId == 0)
                return BadRequest();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP010_RequestSearch_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", paramViewModel.YearId);
                    sqlCommand.Parameters.AddWithValue("AreaId", paramViewModel.AreaId);
                    sqlCommand.Parameters.AddWithValue("ExecuteDepartmanId", paramViewModel.ExecuteDepartmanId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        RequestSearchViewModel request = new RequestSearchViewModel();
                        request.Id = int.Parse(dataReader["Id"].ToString());
                        request.Employee = dataReader["Employee"].ToString();
                        request.Number = dataReader["Number"].ToString();
                        request.DateS = dataReader["DateS"].ToString();
                        request.Description = dataReader["Description"].ToString();
                        request.EstimateAmount = StringExtensions.ToNullableBigInt(dataReader["EstimateAmount"].ToString());
                        requestsViewModels.Add(request);
                    }
                }
            }
            return Ok(requestsViewModels);
        }

/// <summary>
/// RequestTable CRUD
/// </summary>
/// 
/// <returns></returns>
/// 
        [Route("RequestTableCreate")]
        [HttpPost]
        public async Task<ApiResult> RequestTableCreate([FromBody] RequestTableInsertViewModel viewModel)
        {
            if (viewModel.RequestId == 0)
                return BadRequest();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP010_RequestTable_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("RequestId", viewModel.RequestId);
                    sqlCommand.Parameters.AddWithValue("Price", viewModel.Price);
                    sqlCommand.Parameters.AddWithValue("OthersDescription", viewModel.OthersDescription);
                    sqlCommand.Parameters.AddWithValue("Quantity", viewModel.Quantity);
                    sqlCommand.Parameters.AddWithValue("Description", viewModel.Description);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                }
            }
            return Ok();
        }

        [Route("RequestTableRead{id}")]
        [HttpGet]
        public async Task<ApiResult<RequestTableReadViewModel>> RequestTableRead(int id)
        {
            RequestTableReadViewModel requestsViewModels = new RequestTableReadViewModel();

            if (id == 0)
                return BadRequest();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP010_RequestTable_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("id", id);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        requestsViewModels.Id = int.Parse(dataReader["AreaId"].ToString());
                        requestsViewModels.OthersDescription = dataReader["Users"].ToString();
                        requestsViewModels.Amount= StringExtensions.ToNullablefloat(dataReader["Number"].ToString());
                        requestsViewModels.Quantity= StringExtensions.ToNullablefloat(dataReader["DoingMethodId"].ToString());
                        requestsViewModels.Description= dataReader["ResonDoingMethod"].ToString();
                        requestsViewModels.Price= long.Parse(dataReader["Id"].ToString());
                    }
                }
            }
            return Ok(requestsViewModels);
        }

        [Route("RequestTableUpdate")]
        [HttpPost]
        public async Task<ApiResult<RequestAfterInsertViewModel>> RequestTableUpdate([FromBody] RequestTableUpdateParamViewModel viewModel)
        {
            RequestAfterInsertViewModel request = new RequestAfterInsertViewModel();

            if (viewModel.Id == 0)
                return BadRequest();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP010_RequestTable_Update", sqlconnect))
                {
                    sqlCommand.Parameters.AddWithValue("yearId", viewModel.Id);
                    sqlCommand.Parameters.AddWithValue("areaId", viewModel.Quantity);
                    sqlCommand.Parameters.AddWithValue("ExecuteDepartmanId", viewModel.Price);
                    sqlCommand.Parameters.AddWithValue("UserId", viewModel.Description);
                    sqlCommand.Parameters.AddWithValue("UserId", viewModel.OthersDescription);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                }
            }
            return Ok(request);
        }

        [Route("RequestDelete{id}")]
        [HttpPost]
        public async Task<ApiResult> RequestTableDelete(int id)
        {
            if (id == 0)
                return BadRequest();
            if (id > 0)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP010_RequestTable_Delete", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("id", id);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        sqlconnect.Close();
                    }
                }
            }
            return Ok();
        }


       

    }
}
