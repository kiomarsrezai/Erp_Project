using Microsoft.AspNetCore.Mvc;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using System.Collections.Generic;
using System.Data;
using System;
using System.Threading.Tasks;
using System.Data.SqlClient;
using NewsWebsite.Data.Contracts;
using Microsoft.Extensions.Configuration;
using NewsWebsite.ViewModels.Api.Report;

namespace NewsWebsite.Areas.Api.Controllers.v1
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class ReportApiController : Controller
    {
        public readonly IUnitOfWork _uw;
        public readonly IConfiguration _configuration;

        public ReportApiController(IUnitOfWork uw, IConfiguration configuration)
        {
            _uw = uw;
            _configuration = configuration;
        }

        [Route("ChartApi")]
        [HttpGet]
        public async Task<ApiResult<List<object>>> ChartApi(int yearId, int centerId, int budgetProcessId, int StructureId, bool revenue, bool sale, bool loan, bool niabati, int? areaId = null, int? codingId = null)
        {
            List<int> Id = new List<int>();
            List<string> Description = new List<string>();
            List<string> Code = new List<string>();
            List<object> data = new List<object>();
            List<string> lables = new List<string>();
            List<Int64> mosavab = new List<Int64>();
            List<double> percmosavab = new List<double>();
            List<double> percdaily = new List<double>();
            List<Int64> mosavabdaily = new List<Int64>();
            List<Int64> expense = new List<Int64>();


            if (areaId == null)
            {

                //List<ColumnChart> dataset = new List<ColumnChart>();
                using (SqlConnection sqlconnect1 = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand1 = new SqlCommand("SP500_Chart", sqlconnect1))
                    {
                        sqlconnect1.Open();
                        sqlCommand1.CommandType = CommandType.StoredProcedure;
                        sqlCommand1.Parameters.AddWithValue("YearId", yearId);
                        sqlCommand1.Parameters.AddWithValue("areaId", areaId);
                        sqlCommand1.Parameters.AddWithValue("CenterId", centerId);
                        sqlCommand1.Parameters.AddWithValue("BudgetProcessId", budgetProcessId);
                        sqlCommand1.Parameters.AddWithValue("revenue", revenue);
                        sqlCommand1.Parameters.AddWithValue("sale", sale);
                        sqlCommand1.Parameters.AddWithValue("loan", loan);
                        sqlCommand1.Parameters.AddWithValue("niabati", niabati);
                        sqlCommand1.Parameters.AddWithValue("StructureId", StructureId);
                        sqlCommand1.Parameters.AddWithValue("codingId", codingId);
                        SqlDataReader dataReader1 = await sqlCommand1.ExecuteReaderAsync();

                        while (dataReader1.Read())
                        {
                            lables.Add(dataReader1["AreaName"].ToString());
                            mosavab.Add(Int64.Parse(dataReader1["Mosavab"].ToString()));
                            mosavabdaily.Add(Int64.Parse(dataReader1["MosavabDaily"].ToString()));
                            expense.Add(Int64.Parse(dataReader1["Expense"].ToString()));
                            if (!string.IsNullOrEmpty(dataReader1["Mosavab"].ToString()) && Int64.Parse(dataReader1["Mosavab"].ToString()) > 0)
                            {
                                percmosavab.Add(_uw.Budget_001Rep.Divivasion(long.Parse(dataReader1["Expense"].ToString()), long.Parse(dataReader1["Mosavab"].ToString())));
                            }
                            else
                            {
                                percmosavab.Add(0);
                            }
                            if (!string.IsNullOrEmpty(dataReader1["MosavabDaily"].ToString()) && Int64.Parse(dataReader1["MosavabDaily"].ToString()) > 0)
                            {
                                percdaily.Add(_uw.Budget_001Rep.Divivasion(long.Parse(dataReader1["Expense"].ToString()), long.Parse(dataReader1["MosavabDaily"].ToString())));
                            }
                            else
                            {
                                percdaily.Add(0);
                            }
                            //dataset.AddRange(Int64.Parse(dataReader1["Mosavab"].ToString()), Int64.Parse(dataReader1["Expense"].ToString()), Int64.Parse(dataReader1["MosavabDaily"].ToString()));
                        }

                        data.Add(lables);
                        data.Add(mosavab);
                        data.Add(mosavabdaily);
                        data.Add(expense);
                        data.Add(percmosavab);
                        data.Add(percdaily);
                    }

                };
            }
            else
            if (areaId != null)
            {
                using (SqlConnection sqlconnect1 = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand1 = new SqlCommand("SP500_Chart", sqlconnect1))
                    {
                        sqlconnect1.Open();
                        sqlCommand1.CommandType = CommandType.StoredProcedure;
                        sqlCommand1.Parameters.AddWithValue("YearId", yearId);
                        sqlCommand1.Parameters.AddWithValue("areaId", areaId);
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

                            Id.Add(int.Parse(dataReader1["CodingId"].ToString()));
                            Code.Add(dataReader1["Code"].ToString());
                            Description.Add(dataReader1["Description"].ToString());
                            mosavab.Add(Int64.Parse(dataReader1["Mosavab"].ToString()));
                            expense.Add(Int64.Parse(dataReader1["Expense"].ToString()));
                            if (double.Parse(dataReader1["Mosavab"].ToString()) > 0)
                            {
                                percmosavab.Add(_uw.Budget_001Rep.Divivasion(double.Parse(dataReader1["Expense"].ToString()), double.Parse(dataReader1["Mosavab"].ToString())));
                            }
                            else
                            {
                                percmosavab.Add(0);
                            }

                        }

                        data.Add(Id);
                        data.Add(Code);
                        data.Add(Description);
                        data.Add(mosavab);
                        data.Add(expense);
                        data.Add(percmosavab);
                    }

                };
            }
            return data;

        }

        [Route("Chart_Ravand")]
        [HttpGet]
        public async Task<ApiResult<List<object>>> Chart_RavandApi(int budgetProcessId, int areaId)
        {
            List<object> data = new List<object>();
            List<string> yearName = new List<string>();
            List<string> yearId = new List<string>();
            List<Int64> mosavab = new List<Int64>();
            List<double> percmosavab = new List<double>();
            List<Int64> edit = new List<Int64>();
            List<Int64> expense = new List<Int64>();


            //List<ColumnChart> dataset = new List<ColumnChart>();
            using (SqlConnection sqlconnect1 = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand1 = new SqlCommand("SP500_Chart_Ravand", sqlconnect1))
                {
                    sqlconnect1.Open();
                    sqlCommand1.CommandType = CommandType.StoredProcedure;
                    sqlCommand1.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand1.Parameters.AddWithValue("BudgetProcessId", budgetProcessId);
                    SqlDataReader dataReader1 = await sqlCommand1.ExecuteReaderAsync();

                    while (dataReader1.Read())
                    {
                        yearId.Add(dataReader1["yearId"].ToString());
                        yearName.Add(dataReader1["YearName"].ToString());
                        mosavab.Add(Int64.Parse(dataReader1["Mosavab"].ToString()));
                        edit.Add(Int64.Parse(dataReader1["Edit"].ToString()));
                        expense.Add(Int64.Parse(dataReader1["Expense"].ToString()));
                    }

                    data.Add(yearId);
                    data.Add(mosavab);
                    data.Add(yearName);
                    data.Add(expense);
                    data.Add(percmosavab);
                    data.Add(edit);
                }

            };

            return data;

        }

        [Route("BudgetDeviation")]
        [HttpGet]
        public async Task<ApiResult<List<ChartBudgetDeviationViewModel>>> BudgetDeviation(int areaId, int yearId,int kindId)
        {
            List<ChartBudgetDeviationViewModel> data = new List<ChartBudgetDeviationViewModel>();


            using (SqlConnection sqlconnect1 = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand1 = new SqlCommand("SP500_BudgetShare", sqlconnect1))
                {
                    sqlconnect1.Open();
                    sqlCommand1.CommandType = CommandType.StoredProcedure;
                    sqlCommand1.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand1.Parameters.AddWithValue("yeaId", yearId);
                    sqlCommand1.Parameters.AddWithValue("KindId", kindId);
                    SqlDataReader dataReader1 = await sqlCommand1.ExecuteReaderAsync();

                    while (dataReader1.Read())
                    {
                        ChartBudgetDeviationViewModel row = new ChartBudgetDeviationViewModel();
                        row.AreaName = dataReader1["AreaName"].ToString();
                        row.code = dataReader1["Code"].ToString();
                        row.description = dataReader1["Description"].ToString();
                        row.mosavab = Int64.Parse(dataReader1["Mosavab"].ToString());
                        row.expense = Int64.Parse(dataReader1["Expense"].ToString());
                        if (double.Parse(dataReader1["Mosavab"].ToString()) > 0)
                        {
                            row.percmosavab = _uw.Budget_001Rep.Divivasion(double.Parse(dataReader1["Expense"].ToString()), double.Parse(dataReader1["Mosavab"].ToString()));
                        }
                        else
                        {
                            row.percmosavab = 0;
                        }

                        data.Add(row);

                    }

                }

            };

            return data;

        }

        [Route("ChartBudgetShare")]
        [HttpGet]
        public async Task<ApiResult<List<ChartBudgetDeviationViewModel>>> GetBudgetShare(int areaId, int yearId, int kindId)
        {
            List<ChartBudgetDeviationViewModel> data = new List<ChartBudgetDeviationViewModel>();


            using (SqlConnection sqlconnect1 = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand1 = new SqlCommand("SP500_BudgetShare", sqlconnect1))
                {
                    sqlconnect1.Open();
                    sqlCommand1.CommandType = CommandType.StoredProcedure;
                    sqlCommand1.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand1.Parameters.AddWithValue("yeaId", yearId);
                    sqlCommand1.Parameters.AddWithValue("KindId", kindId);
                    SqlDataReader dataReader1 = await sqlCommand1.ExecuteReaderAsync();

                    while (dataReader1.Read())
                    {
                        ChartBudgetDeviationViewModel row = new ChartBudgetDeviationViewModel();
                        row.code = dataReader1["Code"].ToString();
                        row.description = dataReader1["Description"].ToString();
                        row.mosavab = Int64.Parse(dataReader1["Mosavab"].ToString());
                        row.expense = Int64.Parse(dataReader1["Expense"].ToString());
                        row.AreaName = dataReader1["AreaName"].ToString();
                        data.Add(row);
                    }
                }
            };

            return data;

        }
    }
}
