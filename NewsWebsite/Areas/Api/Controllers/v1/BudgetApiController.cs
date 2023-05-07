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

        [Route("BudgetModal1Coding")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetViewModel>>> BudgetModalCodingList(BudgetParamModel paramModel)
        {
            if (paramModel.CodeingId == 0) return BadRequest("با خطا مواجه شدید");

            List<BudgetViewModel> fecth = new List<BudgetViewModel>();
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
                        BudgetViewModel BudgetView = new BudgetViewModel();
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
        public async Task<IActionResult> BudgetModalProjectList(BudgetParamModel paramModel)
        {
            if (paramModel.CodeingId == 0) return BadRequest("با خطا مواجه شدید");

            List<BudgetViewModel> fecth = new List<BudgetViewModel>();
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
                        BudgetViewModel BudgetView = new BudgetViewModel();
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

        [Route("BudgetModal3Area")]
        [HttpGet]
        public async Task<IActionResult> BudgetModalAreaList(BudgetParamModel paramModel)
        {
            if (paramModel.CodeingId == 0) return BadRequest("با خطا مواجه شدید");

            List<BudgetViewModel> fecth = new List<BudgetViewModel>();
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
                        BudgetViewModel BudgetView = new BudgetViewModel();
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




    }


}
