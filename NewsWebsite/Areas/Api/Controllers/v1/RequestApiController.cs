using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Request;
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

        [Route("RequestInsert")]
        [HttpPost]
        public async Task<ApiResult<RequestAfterInsertViewModel>> RequestInsert([FromBody] RequestInsertViewModel viewModel)
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
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        request.Id = int.Parse(dataReader["Id"].ToString());
                        request.AreaId = int.Parse(dataReader["AreaId"].ToString());
                        request.Users = dataReader["Users"].ToString();
                        request.Number = dataReader["Number"].ToString();
                        request.DoingMethodId = int.Parse(dataReader["DoingMethodId"].ToString());
                        request.DateS = dataReader["DateS"].ToString();
                        request.ExecuteDepartmanId = int.Parse(dataReader["ExecuteDepartmanId"].ToString());
                    }
                }
            }
            return Ok(request);
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
                using (SqlCommand sqlCommand = new SqlCommand("SP010_Request_Read", sqlconnect))
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

        [Route("GetRequestList")]
        [HttpGet]
        public async Task<ApiResult<RequestSearchViewModel>> GetRequestList(RequestSearchParamViewModel paramViewModel)
        {
            List<RequestSearchViewModel> requestsViewModels = new List<RequestSearchViewModel>();

            if (paramViewModel.ExecuteDepartmanId == 0)
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
                        request.Employee = dataReader["Employee"].ToString();
                        request.Number = dataReader["Number"].ToString();
                        request.Id = int.Parse(dataReader["Id"].ToString());
                        request.DateS = dataReader["DateS"].ToString();
                        request.Description = dataReader["Description"].ToString();
                        request.EstimateAmount = long.Parse(dataReader["EstimateAmount"].ToString());
                        requestsViewModels.Add(request);
                    }
                }
            }
            return Ok(requestsViewModels);
        }

    }
}
