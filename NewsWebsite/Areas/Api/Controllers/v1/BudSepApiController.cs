using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.BudgetSeprator;
using NewsWebsite.ViewModels.Api.UsersApi;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace NewsWebsite.Areas.Api.Controllers.v1
{

    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class BudSepApiController : Controller
    {
        public readonly IUnitOfWork _uw;
        public readonly IConfiguration _configuration;
        public BudSepApiController(IUnitOfWork uw, IConfiguration configuration)
        {
            _configuration = configuration;
            _uw = uw;
        }

        [Route("FetchSeprator")]
        [HttpGet]
        public async Task<IActionResult> FetchSeprators(int yearId, int areaId, int budgetprocessId)
        {
            return Ok(await _uw.Budget_001Rep.GetAllBudgetSeprtaorAsync(yearId, areaId, budgetprocessId));
        }

        [HttpGet]
        [Route("Details")]
        public async Task<ApiResult<List<SepratorAreaRequestViewModel>>> Details(int yearId, int areaId, int budgetProcessId, int codingId)
        {
            List<SepratorAreaRequestViewModel> fecthViewModel = new List<SepratorAreaRequestViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_ShowBudgetSepratorArea_TaminModal", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand.Parameters.AddWithValue("budgetProcessId", budgetProcessId);
                    sqlCommand.Parameters.AddWithValue("codingId", codingId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        SepratorAreaRequestViewModel fetchView = new SepratorAreaRequestViewModel();
                        fetchView.id = StringExtensions.ToNullableInt(dataReader["id"].ToString());
                        fetchView.Number = dataReader["Number"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.Date = dataReader["Date"].ToString();
                        fetchView.EstimateAmount = Int64.Parse(dataReader["EstimateAmount"].ToString());

                        fecthViewModel.Add(fetchView);
                    }
                }
            }

            return Ok(fecthViewModel);
        }

        [HttpGet]
        [Route("Taminetebarat")]
        public async Task<ApiResult<List<BudgetSepTaminModal2ViewModel>>> Taminetebarat(int yearId, int areaId, int budgetProcessId)
        {
            List<BudgetSepTaminModal2ViewModel> fecthViewModel = new List<BudgetSepTaminModal2ViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_ShowBudgetSepratorArea_TaminModal_2", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand.Parameters.AddWithValue("budgetProcessId", budgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetSepTaminModal2ViewModel fetchView = new BudgetSepTaminModal2ViewModel();
                        fetchView.BodgetId = dataReader["BodgetId"].ToString();
                        fetchView.BodgetDesc = dataReader["BodgetDesc"].ToString();
                        fetchView.ReqDesc = dataReader["ReqDesc"].ToString();
                        fetchView.RequestDate = dataReader["RequestDate"].ToString();
                        fetchView.RequestRefStr = dataReader["RequestRefStr"].ToString();
                        fetchView.RequestPrice = Int64.Parse(dataReader["RequestPrice"].ToString());

                        fecthViewModel.Add(fetchView);
                    }
                }
            }

            return Ok(fecthViewModel);
        }

        [Route("ChartApi")]
        [HttpGet]
        public async Task<ApiResult<List<object>>> ChartApi(int yearId, int centerId, int budgetProcessId, int StructureId, bool revenue, bool sale, bool loan, bool niabati)
        {
            List<object> data = new List<object>();
            List<string> lables = new List<string>();
            List<Int64> mosavab = new List<Int64>();
            List<double> percmosavab = new List<double>();
            List<double> percdaily = new List<double>();
            List<Int64> mosavabdaily = new List<Int64>();
            List<Int64> expense = new List<Int64>();
            //List<ColumnChart> dataset = new List<ColumnChart>();
            using (SqlConnection sqlconnect1 = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand1 = new SqlCommand("SP500_Chart", sqlconnect1))
                {
                    sqlconnect1.Open();
                    sqlCommand1.CommandType = CommandType.StoredProcedure;
                    sqlCommand1.Parameters.AddWithValue("YearId", yearId);
                    sqlCommand1.Parameters.AddWithValue("CenterId", centerId);
                    sqlCommand1.Parameters.AddWithValue("BudgetProcessId", budgetProcessId);
                    sqlCommand1.Parameters.AddWithValue("revenue", revenue);
                    sqlCommand1.Parameters.AddWithValue("sale", sale);
                    sqlCommand1.Parameters.AddWithValue("loan", loan);
                    sqlCommand1.Parameters.AddWithValue("niabati", niabati);
                    sqlCommand1.Parameters.AddWithValue("StructureId", StructureId);
                    SqlDataReader dataReader1 = await sqlCommand1.ExecuteReaderAsync();

                    while (dataReader1.Read())
                    {
                        double percmos = 0; double percdai = 0;
                        lables.Add(dataReader1["AreaName"].ToString());
                        mosavab.Add(Int64.Parse(dataReader1["Mosavab"].ToString()));
                        mosavabdaily.Add(Int64.Parse(dataReader1["MosavabDaily"].ToString()));
                        expense.Add(Int64.Parse(dataReader1["Expense"].ToString()));
                        if (Int64.Parse(dataReader1["Mosavab"].ToString()) > 0)
                        {
                            percmos = _uw.Budget_001Rep.Divivasion(double.Parse(dataReader1["Expense"].ToString()), double.Parse(dataReader1["Mosavab"].ToString()));
                        }
                        else
                        {
                            percmos = 0;
                        }
                        if (Int64.Parse(dataReader1["MosavabDaily"].ToString()) > 0)
                        {
                            percdai = _uw.Budget_001Rep.Divivasion(double.Parse(dataReader1["Expense"].ToString()), double.Parse(dataReader1["MosavabDaily"].ToString()));
                        }
                        else
                        {
                            percdai = 0;
                        }
                        //dataset.AddRange(Int64.Parse(dataReader1["Mosavab"].ToString()), Int64.Parse(dataReader1["Expense"].ToString()), Int64.Parse(dataReader1["MosavabDaily"].ToString()));
                    }

                    data.Add(lables);
                    data.Add(mosavab);
                    data.Add(expense);
                    data.Add(mosavabdaily);
                    data.Add(percmosavab);
                    data.Add(percdaily);
                }

            };
            return data;

        }

        [Route("DetailChartApi")]
        [HttpGet]
        public async Task<ApiResult<List<ViewModels.Fetch.ChartAreaViewModel>>> DetailChartApi(int yearId, int centerId, int budgetProcessId, int StructureId, bool revenue, bool sale, bool loan, bool niabati)
        {
            List<ViewModels.Fetch.ChartAreaViewModel> dataset = new List<ViewModels.Fetch.ChartAreaViewModel>();
            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP500_Chart", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("YearId", yearId);
                    sqlCommand.Parameters.AddWithValue("CenterId", centerId);
                    sqlCommand.Parameters.AddWithValue("BudgetProcessId", budgetProcessId);
                    sqlCommand.Parameters.AddWithValue("StructureId", StructureId);
                    sqlCommand.Parameters.AddWithValue("revenue", revenue);
                    sqlCommand.Parameters.AddWithValue("sale", sale);
                    sqlCommand.Parameters.AddWithValue("loan", loan);
                    sqlCommand.Parameters.AddWithValue("niabati", niabati);
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();

                    while (dataReader.Read())
                    {
                        ViewModels.Fetch.ChartAreaViewModel row = new ViewModels.Fetch.ChartAreaViewModel();

                        row.Id = int.Parse(dataReader["AreaId"].ToString());
                        row.Row = int.Parse(dataReader["AreaId"].ToString());
                        row.AreaId = int.Parse(dataReader["AreaId"].ToString());
                        row.AreaName = dataReader["AreaName"].ToString();
                        row.BudgetProcessId = int.Parse(dataReader["BudgetProcessId"].ToString());
                        row.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        row.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        row.MosavabDaily = Int64.Parse(dataReader["MosavabDaily"].ToString());
                        row.NotGet = Int64.Parse(dataReader["NotGet"].ToString());

                        row.YearId = int.Parse(dataReader["YearId"].ToString());
                        if (row.Mosavab != 0)
                        {
                            row.PercentMosavab = _uw.Budget_001Rep.Divivasion(row.Expense, row.Mosavab);
                        }
                        else
                        {
                            row.PercentMosavab = 0;
                        }
                        if (row.MosavabDaily != 0)
                        {
                            row.PercentMosavabDaily = _uw.Budget_001Rep.Divivasion(row.Expense, row.MosavabDaily);
                        }
                        else
                        {
                            row.PercentMosavabDaily = 0;
                        }
                        dataset.Add(row);
                    }

                }

            };

            return dataset;

        }

        [Route("DeleteTamin")]
        [HttpPost]
        public virtual async Task<ApiResult> DeleteTamin([FromBody] int id)
        {
            if (id == 0)
                return BadRequest();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_ShowBudgetSepratorArea_TaminModal_Delete", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("id", id);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    TempData["notification"] = "ویرایش با موفقیت انجام شد";
                }
            }
            return Ok();
        }

        [Route("TaminInsert")]
        [HttpPost]
        public async Task<ApiResult> TaminInsert(int yearId, int areaId, int budgetProcessId, string RequestRefStr, string RequestDate, Int64 RequestPrice, string ReqDesc, int codingId)
        {
            if (codingId==0) return BadRequest();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_ShowBudgetSepratorArea_TaminModal_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand.Parameters.AddWithValue("budgetProcessId", budgetProcessId);
                    sqlCommand.Parameters.AddWithValue("RequestRefStr", RequestRefStr);
                    sqlCommand.Parameters.AddWithValue("RequestDate", RequestDate);
                    sqlCommand.Parameters.AddWithValue("RequestPrice", RequestPrice);
                    sqlCommand.Parameters.AddWithValue("ReqDesc", ReqDesc);
                    sqlCommand.Parameters.AddWithValue("codingId", codingId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader =await sqlCommand.ExecuteReaderAsync();
                    TempData["notification"] = "ویرایش با موفقیت انجام شد";
                }
            }
            return Ok();
        }


    }


}
