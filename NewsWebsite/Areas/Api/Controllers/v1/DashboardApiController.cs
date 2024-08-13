using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Budget.BudgetCoding;
using NewsWebsite.ViewModels.Api.Budget.BudgetSeprator;
using NewsWebsite.ViewModels.Api.Dashboard;
using NewsWebsite.ViewModels.Api.Public;
using NewsWebsite.ViewModels.Api.Report;
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
    public class DashboardApiController : Controller
    {
        public readonly IUnitOfWork _uw;
        public readonly IConfiguration _configuration;
        public readonly ISqlDataAccess _sqlDataAccess;
        public DashboardApiController(IUnitOfWork uw, IConfiguration configuration)
        {
            _configuration = configuration;
            _uw = uw;
        }

        [Route("DashboardCharts")]
        [HttpGet]
        public async Task<ApiResult<stractResult>> DashboardChartsReport(ParamViewModel param)
        {

            stractResult stractResultViewModel = new stractResult();
            List<DashboardResponse> fecthViewModel = new List<DashboardResponse>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                if (param.StructureId == 2)
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP500_Abstract_Performance_Sazman", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.CommandTimeout = 500;
                        sqlCommand.Parameters.AddWithValue("yearId ", param.YearId);
                        sqlCommand.Parameters.AddWithValue("structureId", param.StructureId);
                        sqlCommand.Parameters.AddWithValue("MonthId", param.MonthId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (dataReader.Read())
                        {
                            if ((long.Parse(dataReader["MosavabRevenue"].ToString()) != 0) ||
                               (long.Parse(dataReader["ExpenseMonthRevenue"].ToString()) != 0) ||
                                (long.Parse(dataReader["MosavabCurrent"].ToString()) != 0) ||
                                (long.Parse(dataReader["ExpenseCurrent"].ToString()) != 0) ||
                                (long.Parse(dataReader["MosavabCivil"].ToString()) != 0) ||
                                (long.Parse(dataReader["CreditAmountCivil"].ToString()) != 0) ||
                                (long.Parse(dataReader["MosavabFinancial"].ToString()) != 0) ||
                                (long.Parse(dataReader["ExpenseFinancial"].ToString()) != 0) ||
                                (long.Parse(dataReader["MosavabSanavati"].ToString()) != 0) ||
                                (long.Parse(dataReader["ExpenseSanavati"].ToString()) != 0) ||
                                (long.Parse(dataReader["MosavabPayMotomarkez"].ToString()) != 0) ||
                                (long.Parse(dataReader["ExpensePayMotomarkez"].ToString()) != 0) ||
                                (long.Parse(dataReader["MosavabDar_Khazane"].ToString()) != 0) ||
                                (long.Parse(dataReader["ExpenseMonthDarAzKhazane"].ToString()) != 0) ||
                                (long.Parse(dataReader["MosavabRevenue"].ToString()) != 0))
                            {

                                DashboardResponse row = new DashboardResponse();
                                row.Id = int.Parse(dataReader["Id"].ToString());
                                row.AreaName = dataReader["AreaName"].ToString();

                                row.MosavabCurrent = long.Parse(dataReader["MosavabCurrent"].ToString());
                                row.TaminEtebarCurrent = long.Parse(dataReader["CreditCurrent"].ToString());
                                if (row.MosavabCurrent != 0)
                                {
                                    row.PercentTaminEtebarCurrent= Math.Round(_uw.Budget_001Rep.Division(row.TaminEtebarCurrent, row.MosavabCurrent));
                                }
                                else
                                {
                                    row.PercentTaminEtebarCurrent = 0;
                                }
                                row.ExpenseMonthCurrent = long.Parse(dataReader["ExpenseMonthCurrent"].ToString());
                                if (row.MosavabCurrent != 0)
                                {
                                    row.PercentCurrent = Math.Round(_uw.Budget_001Rep.Division(row.ExpenseMonthCurrent, row.MosavabCurrent));
                                }
                                else
                                {
                                    row.PercentCurrent = 0;
                                }


                                row.MosavabTamalokSaramye = long.Parse(dataReader["MosavabCivil"].ToString());
                                row.TaminEtebarAmountTamalokSarmaye = long.Parse(dataReader["CreditAmountCivil"].ToString());
                                if (row.MosavabTamalokSaramye != 0)
                                {
                                    row.PercentTamalokSarmaye = Math.Round(_uw.Budget_001Rep.Division(row.TaminEtebarAmountTamalokSarmaye, row.MosavabTamalokSaramye));
                                }
                                else
                                {
                                    row.PercentTamalokSarmaye = 0;
                                }

                                row.ExpenseTamalokSarmaye = long.Parse(dataReader["ExpenseCivil"].ToString());
                                if (row.ExpenseTamalokSarmaye != 0)
                                {
                                    row.PercentExpenseTamalokSarmaye = Math.Round(_uw.Budget_001Rep.Division(row.ExpenseTamalokSarmaye, row.MosavabTamalokSaramye));
                                }
                                else
                                {
                                    row.PercentExpenseTamalokSarmaye = 0;
                                }

                                row.MosavabTamalokMali = long.Parse(dataReader["MosavabFinancial"].ToString());
                                row.TaminEtebarTamalokMali = long.Parse(dataReader["CreditFinancial"].ToString());

                                if (row.MosavabTamalokMali != 0)
                                {
                                    row.PercentTaminEtebarTamalokMali = Math.Round(_uw.Budget_001Rep.Division(row.TaminEtebarTamalokMali, row.MosavabTamalokMali));
                                }
                                else
                                {
                                    row.PercentTaminEtebarTamalokMali = 0;
                                }


                                row.PercentTamalokMali = long.Parse(dataReader["ExpenseFinancial"].ToString());
                                if (row.MosavabTamalokMali != 0)
                                {
                                    row.PercentExpenseTamalokMali = Math.Round(_uw.Budget_001Rep.Division(row.ExpenseTamalokMali, row.MosavabTamalokMali));
                                }
                                else
                                {
                                    row.PercentExpenseTamalokMali = 0;
                                }

                               
                                row.Manabe = long.Parse(dataReader["Resoures"].ToString());

                                fecthViewModel.Add(row);
                            }

                        }
                    }
                    sqlconnect.Close();
                    string dt = DateTimeExtensions.ConvertMiladiToShamsi(DateTime.Now.Date, "yyyy/MM/dd");
                    stractResultViewModel.monutnow= dt.Substring(5, 2);
                    stractResultViewModel.response = fecthViewModel;
                }

                if (param.StructureId == 1)
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP500_Abstract_Performance_Shahrdari", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.CommandTimeout = 500;
                        sqlCommand.Parameters.AddWithValue("yearId ", param.YearId);
                        sqlCommand.Parameters.AddWithValue("structureId", param.StructureId);
                        sqlCommand.Parameters.AddWithValue("MonthId", param.MonthId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (dataReader.Read())
                        {
                            if ((long.Parse(dataReader["MosavabRevenue"].ToString()) != 0) ||
                               (long.Parse(dataReader["ExpenseMonthRevenue"].ToString()) != 0) ||
                                (long.Parse(dataReader["MosavabCurrent"].ToString()) != 0) ||
                                (long.Parse(dataReader["ExpenseMonthCurrent"].ToString()) != 0) ||
                                (long.Parse(dataReader["MosavabCivil"].ToString()) != 0) ||
                                (long.Parse(dataReader["CreditAmountCivil"].ToString()) != 0) ||
                                (long.Parse(dataReader["ExpenseCivil"].ToString()) != 0) ||
                                (long.Parse(dataReader["MosavabFinancial"].ToString()) != 0) ||
                                (long.Parse(dataReader["ExpenseFinancial"].ToString()) != 0) ||
                                (long.Parse(dataReader["MosavabSanavati"].ToString()) != 0) ||
                                (long.Parse(dataReader["ExpenseSanavati"].ToString()) != 0) ||
                                (long.Parse(dataReader["MosavabPayMotomarkez"].ToString()) != 0) ||
                                (long.Parse(dataReader["ExpensePayMotomarkez"].ToString()) != 0) ||
                                (long.Parse(dataReader["MosavabDar_Khazane"].ToString()) != 0) ||
                                (long.Parse(dataReader["ExpenseMonthDarAzKhazane"].ToString()) != 0) ||
                                (long.Parse(dataReader["MosavabRevenue"].ToString()) != 0))
                            {

                                DashboardResponse row = new DashboardResponse();
                                row.Id = int.Parse(dataReader["Id"].ToString());
                                row.AreaName = dataReader["AreaName"].ToString();
                              
                                row.MosavabCurrent = long.Parse(dataReader["MosavabCurrent"].ToString());
                                row.TaminEtebarCurrent = long.Parse(dataReader["CreditCurrent"].ToString());
                                if (row.MosavabCurrent != 0)
                                {
                                    row.PercentTaminEtebarCurrent = Math.Round(_uw.Budget_001Rep.Division(row.TaminEtebarCurrent, row.MosavabCurrent));
                                }
                                else
                                {
                                    row.PercentTaminEtebarCurrent = 0;
                                }
                                row.ExpenseMonthCurrent = long.Parse(dataReader["ExpenseMonthCurrent"].ToString());
                                if (row.MosavabCurrent != 0)
                                {
                                    row.PercentCurrent = Math.Round(_uw.Budget_001Rep.Division(row.ExpenseMonthCurrent, row.MosavabCurrent));
                                }
                                else
                                {
                                    row.PercentCurrent = 0;
                                }


                                row.MosavabTamalokSaramye = long.Parse(dataReader["MosavabCivil"].ToString());
                                row.TaminEtebarAmountTamalokSarmaye = long.Parse(dataReader["CreditAmountCivil"].ToString());
                                if (row.MosavabTamalokSaramye != 0)
                                {
                                    row.PercentTamalokSarmaye = Math.Round(_uw.Budget_001Rep.Division(row.TaminEtebarAmountTamalokSarmaye, row.MosavabTamalokSaramye));
                                }
                                else
                                {
                                    row.PercentTamalokSarmaye = 0;
                                }

                                row.ExpenseTamalokSarmaye = long.Parse(dataReader["ExpenseCivil"].ToString());
                                if (row.ExpenseTamalokSarmaye != 0)
                                {
                                    row.PercentExpenseTamalokSarmaye = Math.Round(_uw.Budget_001Rep.Division(row.ExpenseTamalokSarmaye, row.MosavabTamalokSaramye));
                                }
                                else
                                {
                                    row.PercentExpenseTamalokSarmaye = 0;
                                }

                                row.MosavabTamalokMali = long.Parse(dataReader["MosavabFinancial"].ToString());
                                row.TaminEtebarTamalokMali = long.Parse(dataReader["CreditFinancial"].ToString());

                                if (row.MosavabTamalokMali != 0)
                                {
                                    row.PercentTaminEtebarTamalokMali = Math.Round(_uw.Budget_001Rep.Division(row.TaminEtebarTamalokMali, row.MosavabTamalokMali));
                                }
                                else
                                {
                                    row.PercentTaminEtebarTamalokMali = 0;
                                }


                                row.PercentTamalokMali = long.Parse(dataReader["ExpenseFinancial"].ToString());
                                if (row.MosavabTamalokMali != 0)
                                {
                                    row.PercentExpenseTamalokMali = Math.Round(_uw.Budget_001Rep.Division(row.ExpenseTamalokMali, row.MosavabTamalokMali));
                                }
                                else
                                {
                                    row.PercentExpenseTamalokMali = 0;
                                }


                                row.Manabe = long.Parse(dataReader["Resoures"].ToString());

                                fecthViewModel.Add(row);
                            }
                        }
                    }
                    sqlconnect.Close();
                    string dt = DateTimeExtensions.ConvertMiladiToShamsi(DateTime.Now.Date, "yyyy/MM/dd");
                    stractResultViewModel.monutnow = dt.Substring(5, 2);
                    stractResultViewModel.response = fecthViewModel;
                }
            }


            return Ok(stractResultViewModel);
        }



    }
}
