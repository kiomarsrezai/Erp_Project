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
        public async Task<ApiResult> RequestInsert([FromBody] RequestInsertViewModel viewModel)
        {
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
                }
            }
            return Ok();
        }

        [Route("RequestRead")]
        [HttpGet]
        public async Task<ApiResult<RequestsViewModel>> GetRequest(RequestReadParamViewModel paramViewModel)
        {
            List<RequestsViewModel> requestsViewModels = new List<RequestsViewModel>(); 
            
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
                        RequestsViewModel request = new RequestsViewModel();
                        request.AreaId = int.Parse(dataReader["AreaId"].ToString());
                        request.Users = dataReader["Users"].ToString();
                        request.Number= dataReader["Number"].ToString();
                        request.DoingMethodId= int.Parse(dataReader["DoingMethodId"].ToString());
                        request.ResonDoingMethod = dataReader["ResonDoingMethod"].ToString();
                        request.Id= int.Parse(dataReader["Id"].ToString());
                        request.Date= dataReader["Date"].ToString();
                        request.DateS= dataReader["DateS"].ToString();
                        request.Description= dataReader["Description"].ToString();
                        request.EstimateAmount= long.Parse(dataReader["EstimateAmount"].ToString());
                        request.ExecuteDepartmanId= int.Parse(dataReader["ExecuteDepartmanId"].ToString());
                        requestsViewModels.Add(request);
                    }
                }
            }
            return Ok(requestsViewModels);
        }

    }
}
