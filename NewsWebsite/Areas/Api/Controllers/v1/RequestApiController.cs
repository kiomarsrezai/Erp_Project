//using AutoMapper.Configuration;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Microsoft.OpenApi.Writers;
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
using System;
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
                        request.EstimateAmount = Int64.Parse(dataReader["EstimateAmount"].ToString());
                        request.Number = dataReader["Number"].ToString();
                        request.Date = dataReader["Date"].ToString();
                        request.DateShamsi = DateTimeExtensions.ConvertMiladiToShamsi(DateTime.Parse(dataReader["Date"].ToString()), "yyyy/MM/dd");
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
                        requestsViewModels.DateShamsi = DateTimeExtensions.ConvertMiladiToShamsi(DateTime.Parse(dataReader["Date"].ToString()), "yyyy/MM/dd");
                        requestsViewModels.Description = dataReader["Description"].ToString();
                        requestsViewModels.EstimateAmount = long.Parse(dataReader["EstimateAmount"].ToString());
                        requestsViewModels.ResonDoingMethod = dataReader["ResonDoingMethod"].ToString();
                        requestsViewModels.SuppliersId = int.Parse(dataReader["SuppliersId"].ToString());
                        requestsViewModels.SuppliersName = dataReader["SuppliersName"].ToString();
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
                        request.EstimateAmount = Int64.Parse(dataReader["EstimateAmount"].ToString());
                        request.SuppliersId = int.Parse(dataReader["SuppliersId"].ToString());
                        request.ResonDoingMethod = dataReader["ResonDoingMethod"].ToString();
                    }
                }
            }
            return Ok(request);
        }

        [Route("RequestSearch")]
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
                    sqlCommand.Parameters.AddWithValue("DepartmentId", paramViewModel.DepartmentId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        RequestSearchViewModel request = new RequestSearchViewModel();
                        request.Id = int.Parse(dataReader["Id"].ToString());
                        request.Employee = dataReader["Employee"].ToString();
                        request.Number = dataReader["Number"].ToString();
                        request.Date = dataReader["Date"].ToString();
                        request.DateShamsi = DateTimeExtensions.ConvertMiladiToShamsi(DateTime.Parse(dataReader["Date"].ToString()), "yyyy/MM/dd");
                        request.Description = dataReader["Description"].ToString();
                        request.EstimateAmount = Int64.Parse(dataReader["EstimateAmount"].ToString());
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

        [Route("RequestSupplierstUpdate")]
        [HttpGet]
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



        //نمایش لیست درخواست های جدولی
        [Route("RequestTableRead")]
        [HttpGet]
        public async Task<ApiResult<List<RequestTableReadViewModel>>> RequestTableRead(RequestTableReadParamViewModel paramViewModel )
        {
            List<RequestTableReadViewModel> requestsTable = new List<RequestTableReadViewModel>();
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP010_RequestTable_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("id", paramViewModel.Id);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        RequestTableReadViewModel request = new RequestTableReadViewModel();
                        request.Id = int.Parse(dataReader["Id"].ToString());
                        request.Description = dataReader["Description"].ToString();
                        request.Scale = dataReader["Scale"].ToString();
                        request.Quantity = StringExtensions.ToNullablefloat(dataReader["Quantity"].ToString());
                        request.Price = Int64.Parse(dataReader["Price"].ToString());
                        request.Amount = Int64.Parse(dataReader["Amount"].ToString());
                        request.OthersDescription = dataReader["OthersDescription"].ToString();
                        requestsTable.Add(request);
                    }
                }
            }
            return Ok(requestsTable);
        }

      
        [Route("RequestTableInsert")]
        [HttpPost]
        public async Task<ApiResult> RequestTableInsert([FromBody] RequestTableInsertViewModel viewModel)
        {
            if (viewModel.RequestId == 0)
                return BadRequest();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP010_RequestTable_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("RequestId", viewModel.RequestId);
                    sqlCommand.Parameters.AddWithValue("Description", viewModel.Description);
                    sqlCommand.Parameters.AddWithValue("Quantity", viewModel.Quantity);
                    sqlCommand.Parameters.AddWithValue("Scale", viewModel.Scale);
                    sqlCommand.Parameters.AddWithValue("Price", viewModel.Price);
                    sqlCommand.Parameters.AddWithValue("OthersDescription", viewModel.OthersDescription);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                }
            }
            return Ok();
        }

        [Route("RequestTableUpdatet")]
        [HttpPost]
        public async Task<ApiResult<RequestTableUpdateViewModel>> RequestUpdate([FromBody] RequestTableUpdateViewModel viewModel)
        {
            RequestTableUpdateViewModel request = new RequestTableUpdateViewModel();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP010_RequestTable_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", viewModel.Id);
                    sqlCommand.Parameters.AddWithValue("Description", viewModel.Description);
                    sqlCommand.Parameters.AddWithValue("Quantity", viewModel.Quantity);
                    sqlCommand.Parameters.AddWithValue("scale", viewModel.scale);
                    sqlCommand.Parameters.AddWithValue("Price", viewModel.Price);
                    sqlCommand.Parameters.AddWithValue("OthersDescription", viewModel.OthersDescription);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        request.Id = int.Parse(dataReader["Id"].ToString());
                        request.Quantity = (double.Parse(dataReader["Quantity"].ToString()));
                        request.Price = int.Parse(dataReader["Price"].ToString());
                        request.Description = dataReader["Description"].ToString();
                        request.scale = dataReader["scale"].ToString();
                        request.OthersDescription = dataReader["OthersDescription"].ToString();
                    }
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


        //نمایش لیست ردیف های بودجه که در اختیار واحد درخواست کننده می باشد
        [Route("RequestBudgetSearchModal")]
        [HttpGet]
        public async Task<ApiResult<List<RequestBudgetSearchViewModel>>> GetRequestBudget(RequestBudgetSearchParamViewModel paramViewModel)
        {
            List<RequestBudgetSearchViewModel> requestsViewModels = new List<RequestBudgetSearchViewModel>();

            if (paramViewModel.AreaId == 0)
                return BadRequest();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP010_RequestBudgetSearchModal_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", paramViewModel.YearId);
                    sqlCommand.Parameters.AddWithValue("areaId", paramViewModel.AreaId);
                    sqlCommand.Parameters.AddWithValue("departmentId", paramViewModel.DepartmentId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        RequestBudgetSearchViewModel request = new RequestBudgetSearchViewModel();
                        request.Id = int.Parse(dataReader["Id"].ToString());
                        request.YearName = dataReader["YearName"].ToString();
                        request.Code = dataReader["Code"].ToString();
                        request.Description = dataReader["Description"].ToString();
                        request.Project = dataReader["Project"].ToString();
                        request.MosavabDepartment = Int64.Parse(dataReader["MosavabDepartment"].ToString());
                        requestsViewModels.Add(request);
                    }
                }
            }
            return Ok(requestsViewModels);
        }


        //نمایش ردیف های بودجه مربوط به درخواست که در تب ردیف بودجه نمایش داده می شود
        [Route("RequestBudgetRead")]
        [HttpGet]
        public async Task<ApiResult<List<RequestBudgetReadTabViewModel>>> GetRequestBudgetTab(RequestBudgetTabReadParamViewModel paramViewModel)
        {
            List<RequestBudgetReadTabViewModel> requestsViewModels = new List<RequestBudgetReadTabViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP010_RequestBudget_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("RequestId", paramViewModel.RequestId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        RequestBudgetReadTabViewModel request = new RequestBudgetReadTabViewModel();
                        request.Id = int.Parse(dataReader["Id"].ToString());
                        request.YearName = dataReader["YearName"].ToString();
                        request.Code = dataReader["Code"].ToString();
                        request.Description = dataReader["Description"].ToString();
                        request.Project = dataReader["Project"].ToString();
                        request.RequestBudgetAmount = Int64.Parse(dataReader["RequestBudgetAmount"].ToString());
                        requestsViewModels.Add(request);
                    }
                }
            }
            return Ok(requestsViewModels);
        }

        //اضافه کردن  ردیف بودجه در فرم درخواست
        [Route("RequestBudgetInsert")]
        [HttpPost]
        public async Task<ApiResult> RequestBudgetInsertTab([FromBody] RequestBudgetInsertTabViewModel viewModel)
        {
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP010_RequestBudget_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("RequestId", viewModel.RequestId);
                    sqlCommand.Parameters.AddWithValue("BudgetDetailProjectAreaId", viewModel.BudgetDetailProjectAreatId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                }
            }
            return Ok();
        }

        //اصلاح مبلغ ردیف بودجه در تب درخواست
        [Route("RequestBudgetUpdate")]
        [HttpPost]
        public async Task<ApiResult> RequestBudgetUpdateTab([FromBody] RequestBudgetUpdateTabViewModel viewModel)
        {
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP010_RequestBudget_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", viewModel.Id);
                    sqlCommand.Parameters.AddWithValue("RequestBudgetAmount", viewModel.RequestBudgetAmount);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                }
            }
            return Ok();
        }

        // حذف ردیف بودجه در تب درخواست
        [Route("RequestBudgetDelete")]
        [HttpPost]
        public async Task<ApiResult> RequestBudgetDelete([FromBody] RequestBudgetDeleteViewModel viewModel)
        {
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP010_RequestBudget_Delete", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", viewModel.Id);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                }
            }
            return Ok();
        }
    }
}
