using Microsoft.AspNetCore.Mvc;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.BudgetSeprator;
using System.Collections.Generic;
using System.Data;
using System;
using System.Threading.Tasks;
using NewsWebsite.Common.Api;
using System.Data.SqlClient;
using NewsWebsite.Common;
using NewsWebsite.ViewModels.Budget;
using Microsoft.Extensions.Configuration;
using NewsWebsite.ViewModels.Api.Budget;
using NewsWebsite.ViewModels.Fetch;

namespace NewsWebsite.Areas.Api.Controllers.v1
{

    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class BudgetController : Controller
    {
        public readonly IUnitOfWork _uw;
        private readonly IConfiguration _config;
        public BudgetController(IUnitOfWork uw,IConfiguration configuration)
        {
            _config = configuration;
            _uw = uw;
        }

        [Route("FetchIndex")]
        [HttpGet]
        public async Task<ApiResult<List<FetchViewModel>>> FetchIndex(int yearId, int areaId, int budgetProcessId)
        {
            if (yearId == 0) return BadRequest("با خطا مواجه شدید");

            List<FetchViewModel> fecth = new List<FetchViewModel>();
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                Int64 _totalMosavab = 0; Int64 _totalExpense = 0;
                using (SqlCommand sqlCommand = new SqlCommand("SP001_Budget", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", yearId);
                    sqlCommand.Parameters.AddWithValue("AreaId", areaId);
                    sqlCommand.Parameters.AddWithValue("BudgetProcessId", budgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        FetchViewModel fetchView = new FetchViewModel();
                        fetchView.CodingId = int.Parse(dataReader["CodingId"].ToString());
                        fetchView.Code = dataReader["Code"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.LevelNumber = int.Parse(dataReader["LevelNumber"].ToString());
                        fetchView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        fetchView.Edit = Int64.Parse(dataReader["Edit"].ToString());
                        fetchView.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        fetchView.Show = (bool)dataReader["Show"];
                        _totalMosavab += fetchView.Mosavab;
                        _totalExpense += fetchView.Expense;
                        if ((!string.IsNullOrEmpty(dataReader["Mosavab"].ToString()) && Int64.Parse(dataReader["Mosavab"].ToString()) > 0))
                        {
                            fetchView.PercentBud=_uw.Budget_001Rep.Divivasion(StringExtensions.ToNullableBigInt(dataReader["Expense"].ToString()), StringExtensions.ToNullableBigInt(dataReader["Mosavab"].ToString()));
                        }
                        else
                        {
                            fetchView.PercentBud=0;
                        }
                        
                        fecth.Add(fetchView);
                    }
                }
            }
            return Ok(fecth);
        }

        [Route("GetCodingList")]
        [HttpGet]
        public async Task<ApiResult<List<CodingViewModel>>> GetCodingList(CodingParamViewModel viewModel)
        {
            List<CodingViewModel> fecthViewModel = new List<CodingViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP000_Coding", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("MotherId", viewModel.MotherId);
                    sqlCommand.Parameters.AddWithValue("BudgetProcessId", viewModel.BudgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        CodingViewModel fetchView = new CodingViewModel();
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.MotherId = StringExtensions.ToNullableInt(dataReader["MotherId"].ToString());
                        fetchView.Code = dataReader["Code"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.levelNumber = int.Parse(dataReader["levelNumber"].ToString());
                        fetchView.Crud = bool.Parse(dataReader["Crud"].ToString());
                        fetchView.CodingRevenueKind = int.Parse(dataReader["CodingRevenueKind"].ToString());

                        fecthViewModel.Add(fetchView);
                    }
                }
            }

            return Ok(fecthViewModel);
        }

        [Route("BudgetModal1Coding")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetModalCodingViewModel>>> BudgetModalCodingList(BudgetCodingParamModel paramModel)
        {
            if (paramModel.CodingId == 0) return BadRequest("با خطا مواجه شدید");

            List<BudgetModalCodingViewModel> fecth = new List<BudgetModalCodingViewModel>();
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_BudgetModal1Coding", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", paramModel.YearId);
                    sqlCommand.Parameters.AddWithValue("AreaId", paramModel.AreaId);
                    sqlCommand.Parameters.AddWithValue("CodingId", paramModel.CodingId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetModalCodingViewModel BudgetView = new BudgetModalCodingViewModel();
                        BudgetView.Id = int.Parse(dataReader["Id"].ToString());
                        BudgetView.Code = dataReader["Code"].ToString();
                        BudgetView.Description = dataReader["Description"].ToString();
                        //BudgetView.LevelNumber = int.Parse(dataReader["LevelNumber"].ToString());
                        BudgetView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        BudgetView.Edit = Int64.Parse(dataReader["Edit"].ToString());
                        BudgetView.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        //BudgetView.Show = (bool)dataReader["Show"];
                        if (BudgetView.Mosavab != 0)
                        {
                            BudgetView.PercentBud = _uw.Budget_001Rep.Divivasion(BudgetView.Expense, BudgetView.Mosavab);
                        }
                        else
                        {
                            BudgetView.PercentBud = 0;
                        }
                        fecth.Add(BudgetView);
                    }
                }
            }
            return Ok(fecth);
        }

        [Route("BudgetModal2Project")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetModalProjectViewModel>>> BudgetModalProjectList(BudgetProjectParamModel paramModel)
        {
            if (paramModel.YearId == 0) return BadRequest("با خطا مواجه شدید");

            List<BudgetModalProjectViewModel> fecth = new List<BudgetModalProjectViewModel>();
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_BudgetModal2CodingProject_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("AreaId", paramModel.AreaId);
                    sqlCommand.Parameters.AddWithValue("CodingId", paramModel.CodingId);
                    sqlCommand.Parameters.AddWithValue("YearId", paramModel.YearId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetModalProjectViewModel BudgetView = new BudgetModalProjectViewModel();
                        //BudgetView.CodingId = int.Parse(dataReader["CodingId"].ToString());
                        BudgetView.ProjectId= int.Parse(dataReader["ProjectId"].ToString());
                        BudgetView.ProjectCode = int.Parse(dataReader["ProjectCode"].ToString());
                        BudgetView.ProjectName = dataReader["ProjectName"].ToString();
                        //BudgetView.LevelNumber = int.Parse(dataReader["LevelNumber"].ToString());
                        BudgetView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        BudgetView.Edit = Int64.Parse(dataReader["Edit"].ToString());
                        BudgetView.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        //BudgetView.Show = (bool)dataReader["Show"];
                        if (BudgetView.Mosavab != 0)
                        {
                            BudgetView.PercentBud = _uw.Budget_001Rep.Divivasion(BudgetView.Expense, BudgetView.Mosavab);
                        }
                        else
                        {
                            BudgetView.PercentBud = 0;
                        }
                        fecth.Add(BudgetView);
                    }
                }
            }
            return Ok(fecth);
        }

        [Route("BudgetModal3Area")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetAreaModalViewModel>>> BudgetModalAreaList(BudgetAreaParamModel paramModel)
        {
            if (paramModel.Id == 0) return BadRequest("با خطا مواجه شدید");

            List<BudgetAreaModalViewModel> fecth = new List<BudgetAreaModalViewModel>();
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_BudgetModal3CodingProjectArea_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", paramModel.Id);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetAreaModalViewModel BudgetView = new BudgetAreaModalViewModel();
                        BudgetView.Id = int.Parse(dataReader["Id"].ToString());
                        BudgetView.AreaName = dataReader["AreaName"].ToString();
                        //BudgetView.LevelNumber = int.Parse(dataReader["LevelNumber"].ToString());
                        BudgetView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        BudgetView.Edit = Int64.Parse(dataReader["Edit"].ToString());
                        BudgetView.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        //BudgetView.Show = (bool)dataReader["Show"];
                        if (BudgetView.Mosavab != 0)
                        {
                            BudgetView.PercentBud = _uw.Budget_001Rep.Divivasion(BudgetView.Expense, BudgetView.Mosavab);
                        }
                        else
                        {
                            BudgetView.PercentBud = 0;
                        }
                        fecth.Add(BudgetView);
                    }
                }
            }
            return Ok(fecth);
        }




    }


}
