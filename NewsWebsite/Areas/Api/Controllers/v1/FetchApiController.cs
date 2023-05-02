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
using NewsWebsite.ViewModels.Fetch;
using Microsoft.Extensions.Configuration;

namespace NewsWebsite.Areas.Api.Controllers.v1
{

    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class FetchController : Controller
    {
        public readonly IUnitOfWork _uw;
        private readonly IConfiguration _config;
        public FetchController(IUnitOfWork uw,IConfiguration configuration)
        {
            _config = configuration;
            _uw = uw;
        }

        [Route("FetchIndex")]
        [HttpGet]
        public async Task<IActionResult> FetchIndex(int yearId, int areaId, int budgetProcessId)
        {
            if (yearId == 0) return BadRequest("با خطا مواجه شدید");

            List<FetchViewModel> fecth = new List<FetchViewModel>();
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                Int64 _totalMosavab = 0; Int64 _totalExpense = 0;
                using (SqlCommand sqlCommand = new SqlCommand("SP001_ShowBudget", sqlconnect))
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
                        if (fetchView.Mosavab != 0)
                        {
                            fetchView.PercentBud = _uw.Budget_001Rep.Divivasion(fetchView.Expense, fetchView.Edit);
                        }
                        else
                        {
                            fetchView.PercentBud = 0;
                        }
                        fecth.Add(fetchView);
                    }
                }
            }
            return Ok(fecth);
        }

        [HttpGet]
        [Route("FetchDetails")]
        public async Task<ApiResult<List<FetchDataBudgetViewModel>>> FetchDetails(int yearId, int codingId)
        {
            List<FetchDataBudgetViewModel> dataset = new List<FetchDataBudgetViewModel>();
            
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_ShowBudgetDetail", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("YearId", yearId);
                    sqlCommand.Parameters.AddWithValue("CodingId", codingId);
                    SqlDataReader dataReader =await sqlCommand.ExecuteReaderAsync();

                    while (dataReader.Read())
                    {
                        FetchDataBudgetViewModel row = new FetchDataBudgetViewModel();

                        row.AreaId = int.Parse(dataReader["AreaId"].ToString());
                        row.Code = dataReader["Code"].ToString();
                        row.Description = dataReader["Description"].ToString();
                        row.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        row.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        row.LevelNumber = int.Parse(dataReader["LevelNumber"].ToString());
                        dataset.Add(row);
                    }

                }

            };
            return Ok(dataset);
        }



    }


}
