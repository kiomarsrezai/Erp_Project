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
using NewsWebsite.ViewModels.Api.GeneralVm;

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
                    sqlCommand.Parameters.AddWithValue("Id", viewModel.Id);
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
            if (paramModel.CodeingId == 0) return BadRequest("با خطا مواجه شدید");

            List<BudgetModalCodingViewModel> fecth = new List<BudgetModalCodingViewModel>();
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_BudgetModal1Coding", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", paramModel.YearId);
                    sqlCommand.Parameters.AddWithValue("AreaId", paramModel.AreaId);
                    sqlCommand.Parameters.AddWithValue("CodeingId", paramModel.CodeingId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetModalCodingViewModel BudgetView = new BudgetModalCodingViewModel();
                        //BudgetView.CodingId = int.Parse(dataReader["CodingId"].ToString());
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
            if (paramModel.Id == 0) return BadRequest("با خطا مواجه شدید");

            List<BudgetModalProjectViewModel> fecth = new List<BudgetModalProjectViewModel>();
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_BudgetModal2Project", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", paramModel.Id);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetModalProjectViewModel BudgetView = new BudgetModalProjectViewModel();
                        //BudgetView.CodingId = int.Parse(dataReader["CodingId"].ToString());
                        BudgetView.Id = int.Parse(dataReader["Id"].ToString());
                        BudgetView.ProjectId= int.Parse(dataReader["ProjectId"].ToString());
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
                using (SqlCommand sqlCommand = new SqlCommand("SP001_BudgetModal1Coding", sqlconnect))
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
