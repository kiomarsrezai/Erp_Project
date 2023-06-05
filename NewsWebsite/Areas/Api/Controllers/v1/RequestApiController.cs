//using AutoMapper.Configuration;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data;
using NewsWebsite.Data.Contracts;
using NewsWebsite.Entities.identity;
using NewsWebsite.ViewModels.Api.Budget.BudgetConnect;
using NewsWebsite.ViewModels.Api.Budget.BudgetSeprator;
using NewsWebsite.ViewModels.Api.Request;
using NewsWebsite.ViewModels.Api.RequestTable;
using System.Collections.Generic;
using System.Data;
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

        public RequestApiController(IUnitOfWork uw, IConfiguration configuration)
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
                    sqlCommand.Parameters.AddWithValue("DepartmentId", viewModel.DepartmentId);
                    sqlCommand.Parameters.AddWithValue("UserId", viewModel.UserId);
                    sqlCommand.Parameters.AddWithValue("RequestKindId", viewModel.RequestKindId);
                    sqlCommand.Parameters.AddWithValue("DoingMethodId", viewModel.DoingMethodId);
                    sqlCommand.Parameters.AddWithValue("Description", viewModel.Description);
                    sqlCommand.Parameters.AddWithValue("EstimateAmount", viewModel.EstimateAmount);
                    sqlCommand.Parameters.AddWithValue("SuppliersId", viewModel.SuppliersId);
                    sqlCommand.Parameters.AddWithValue("ResonDoingMethod", viewModel.ResonDoingMethod);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        request.Id = int.Parse(dataReader["Id"].ToString());
                        request.YearId = int.Parse(dataReader["YearId"].ToString());
                        request.AreaId = int.Parse(dataReader["AreaId"].ToString());
                        request.Employee = dataReader["Employee"].ToString();
                        request.RequestKindId = int.Parse(dataReader["RequestKindId"].ToString());
                        request.UserId = int.Parse(dataReader["UserId"].ToString());
                        request.EstimateAmount = long.Parse(dataReader["EstimateAmount"].ToString());
                        request.Number = dataReader["Number"].ToString();
                        request.ResonDoingMethod = dataReader["ResonDoingMethod"].ToString();
                        request.Description = dataReader["Description"].ToString();
                        request.DoingMethodId = dataReader["DoingMethodId"] == null ? 1 : int.Parse(dataReader["DoingMethodId"].ToString());
                        request.DepartmentId = StringExtensions.ToNullableInt(dataReader["DepartmentId"].ToString());
                        request.SuppliersId = StringExtensions.ToNullableInt(dataReader["SuppliersId"].ToString());

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
                using (SqlCommand sqlCommand = new SqlCommand("SP010_Request_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("RequestId", paramViewModel.RequestId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        requestsViewModels.Id = int.Parse(dataReader["Id"].ToString());
                        requestsViewModels.YearId = int.Parse(dataReader["YearId"].ToString());
                        requestsViewModels.AreaId = int.Parse(dataReader["AreaId"].ToString());
                        requestsViewModels.DepartmentId = StringExtensions.ToNullableInt(dataReader["DepartmentId"].ToString());
                        requestsViewModels.Employee = dataReader["Employee"].ToString();
                        requestsViewModels.DoingMethodId = dataReader["DoingMethodId"] == null ? 1 : int.Parse(dataReader["DoingMethodId"].ToString());
                        requestsViewModels.Number = dataReader["Number"].ToString();
                        requestsViewModels.Date = dataReader["Date"].ToString();
                        requestsViewModels.Description = dataReader["Description"].ToString();
                        requestsViewModels.EstimateAmount = long.Parse(dataReader["EstimateAmount"].ToString());
                        requestsViewModels.ResonDoingMethod = dataReader["ResonDoingMethod"].ToString();
                    }
                }
            }
            return Ok(requestsViewModels);
        }

        [Route("RequestUpdate")]
        [HttpPost]
        public async Task<ApiResult<RequestUpdateViewModel>> RequestUpdate([FromBody] RequestUpdateViewModel viewModel)
        {
            RequestUpdateViewModel request = new RequestUpdateViewModel();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP010_Request_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", viewModel.Id);
                    sqlCommand.Parameters.AddWithValue("RequestKindId", viewModel.RequestKindId);
                    sqlCommand.Parameters.AddWithValue("DoingMethodId", viewModel.DoingMethodId);
                    sqlCommand.Parameters.AddWithValue("Description", viewModel.Description);
                    sqlCommand.Parameters.AddWithValue("EstimateAmount", viewModel.EstimateAmount);
                    sqlCommand.Parameters.AddWithValue("SuppliersId", viewModel.SuppliersId);
                    sqlCommand.Parameters.AddWithValue("ResonDoingMethod", viewModel.ResonDoingMethod);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        request.Id = int.Parse(dataReader["Id"].ToString());
                        request.RequestKindId = int.Parse(dataReader["RequestKindId"].ToString());
                        request.DoingMethodId = int.Parse(dataReader["DoingMethodId"].ToString());
                        request.Description = dataReader["Description"].ToString();
                        request.EstimateAmount = long.Parse(dataReader["EstimateAmount"].ToString());
                        request.SuppliersId = int.Parse(dataReader["SuppliersId"].ToString());
                        request.ResonDoingMethod = dataReader["ResonDoingMethod"].ToString();
                    }
                }
            }
            return Ok(request);
        }

        [Route("GetRequestList")]
        [HttpGet]
        public async Task<ApiResult<List<RequestSearchViewModel>>> GetRequestList(RequestSearchParamViewModel paramViewModel)
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


//مدال لیست پیمانکاران را نمایش می دهد
        [Route("RequestSuppliersSearch")]
        [HttpGet]
        public async Task<ApiResult<List<RequestSuppliersSearchViewModel>>> GetSuppliers()
        {
            List<RequestSuppliersSearchViewModel> fecthViewModel = new List<RequestSuppliersSearchViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP010_RequestSuppliersSearch_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        RequestSuppliersSearchViewModel Suppliers = new RequestSuppliersSearchViewModel();
                        Suppliers.Id = int.Parse(dataReader["Id"].ToString());
                        Suppliers.SuppliersName = dataReader["SuppliersName"].ToString();
                        fecthViewModel.Add(Suppliers);
                    }
                }
            }
            return Ok(fecthViewModel);
        }
        //بعد از نمایش لیست پیمانکاران در اکشن قبلی و پس از زدن دکمه تایید نام پیمانکار در فرم درخواست تغییر می کند
        public async Task<ApiResult<RequestSuppliersUpdateViewModel>> SupplierstUpdate([FromBody] RequestSuppliersUpdateParameterViewModel viewModel)
        {
            RequestSuppliersUpdateViewModel request = new RequestSuppliersUpdateViewModel();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP010_RequestSuppliersSearch_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("RequestId", viewModel.RequestId);
                    sqlCommand.Parameters.AddWithValue("SuppliersId", viewModel.SuppliersId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        request.RequestId = int.Parse(dataReader["RequestId"].ToString());
                        request.SuppliersId = int.Parse(dataReader["SuppliersId"].ToString());
                    }
                }
            }
            return Ok(request);
        }






        //[Route("RequestDelete")]
        //[HttpPost]
        //public async Task<ApiResult> RequestDelete(int id)
        //{
        //    if (id == 0)
        //        return BadRequest();
        //    if (id > 0)
        //    {
        //        using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
        //        {
        //            using (SqlCommand sqlCommand = new SqlCommand("SP010_Request_Delete", sqlconnect))
        //            {
        //                sqlconnect.Open();
        //                sqlCommand.Parameters.AddWithValue("id", id);
        //                sqlCommand.CommandType = CommandType.StoredProcedure;
        //                SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
        //                sqlconnect.Close();
        //            }
        //        }
        //    }
        //    return Ok();
        //}

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
                        requestsViewModels.Amount = StringExtensions.ToNullablefloat(dataReader["Number"].ToString());
                        requestsViewModels.Quantity = StringExtensions.ToNullablefloat(dataReader["DoingMethodId"].ToString());
                        requestsViewModels.Description = dataReader["ResonDoingMethod"].ToString();
                        requestsViewModels.Price = long.Parse(dataReader["Id"].ToString());
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

        [Route("RequestTableDelete{id}")]
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
