using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Abstract;
using NewsWebsite.ViewModels.Api.Budget.BudgetProject;
using NewsWebsite.ViewModels.Api.Chart;
using NewsWebsite.ViewModels.Api.Deputy;
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
                                percmosavab.Add(_uw.Budget_001Rep.Division(long.Parse(dataReader1["Expense"].ToString()), long.Parse(dataReader1["Mosavab"].ToString())));
                            }
                            else
                            {
                                percmosavab.Add(0);
                            }
                            if (!string.IsNullOrEmpty(dataReader1["MosavabDaily"].ToString()) && Int64.Parse(dataReader1["MosavabDaily"].ToString()) > 0)
                            {
                                percdaily.Add(_uw.Budget_001Rep.Division(long.Parse(dataReader1["Expense"].ToString()), long.Parse(dataReader1["MosavabDaily"].ToString())));
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
                                percmosavab.Add(_uw.Budget_001Rep.Division(double.Parse(dataReader1["Expense"].ToString()), double.Parse(dataReader1["Mosavab"].ToString())));
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


        [Route("Chart_RevenueKindModal")]
        [HttpGet]
        public async Task<ApiResult<List<Chart_RevenueKindModalViewModel>>> ChartRevenueKindModal(int yearId, int StructureId)
        {
            List<Chart_RevenueKindModalViewModel> data = new List<Chart_RevenueKindModalViewModel>();

            using (SqlConnection sqlconnect1 = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand1 = new SqlCommand("SP500_Chart_RevenueKindModal", sqlconnect1))
                {
                    sqlconnect1.Open();
                    sqlCommand1.CommandType = CommandType.StoredProcedure;
                    sqlCommand1.Parameters.AddWithValue("yearId", yearId);
                    sqlCommand1.Parameters.AddWithValue("StructureId", StructureId);
                    SqlDataReader dataReader1 = await sqlCommand1.ExecuteReaderAsync();

                    while (dataReader1.Read())
                    {
                        Chart_RevenueKindModalViewModel row = new Chart_RevenueKindModalViewModel();
                        row.AreaId = int.Parse(dataReader1["AreaId"].ToString());
                        row.AreaName = dataReader1["AreaName"].ToString();
                        row.MosavabRevenue = Int64.Parse(dataReader1["MosavabRevenue"].ToString());
                        row.ExpenseRevenue = Int64.Parse(dataReader1["ExpenseRevenue"].ToString());
                        if (!string.IsNullOrEmpty(dataReader1["MosavabRevenue"].ToString()) && Int64.Parse(dataReader1["MosavabRevenue"].ToString()) > 0)
                        {
                            row.percentRevenue = _uw.Budget_001Rep.Division(long.Parse(dataReader1["ExpenseRevenue"].ToString()), long.Parse(dataReader1["MosavabRevenue"].ToString()));
                        }
                        else
                        {
                            row.percentRevenue = 0;
                        }
                        row.MosavabSale = Int64.Parse(dataReader1["MosavabSale"].ToString());
                        row.ExpenseSale = Int64.Parse(dataReader1["ExpenseSale"].ToString());
                        if (!string.IsNullOrEmpty(dataReader1["MosavabSale"].ToString()) &&
                                 Int64.Parse(dataReader1["MosavabSale"].ToString()) > 0)
                        {
                            row.percentSale = (_uw.Budget_001Rep.Division(Int64.Parse(dataReader1["ExpenseSale"].ToString()), Int64.Parse(dataReader1["MosavabSale"].ToString())));
                        }
                        else
                        {
                            row.percentSale = 0;
                        }
                        row.MosavabLoan = Int64.Parse(dataReader1["MosavabLoan"].ToString());
                        row.ExpenseLoan = Int64.Parse(dataReader1["ExpenseLoan"].ToString());
                        if (!string.IsNullOrEmpty(dataReader1["MosavabLoan"].ToString()) &&
                              Int64.Parse(dataReader1["MosavabLoan"].ToString()) > 0)
                        {
                            row.percentLoan = (_uw.Budget_001Rep.Division(Int64.Parse(dataReader1["ExpenseLoan"].ToString()), Int64.Parse(dataReader1["MosavabLoan"].ToString())));
                        }
                        else
                        {
                            row.percentLoan = 0;
                        }
                        row.MosavabDaryaftAzKhazane = Int64.Parse(dataReader1["MosavabDaryaftAzKhazane"].ToString());
                        row.ExpenseDaryaftAzKhazane = Int64.Parse(dataReader1["ExpenseDaryaftAzKhazane"].ToString());

                        if (!string.IsNullOrEmpty(dataReader1["MosavabDaryaftAzKhazane"].ToString()) && Int64.Parse(dataReader1["MosavabDaryaftAzKhazane"].ToString()) > 0)
                        {
                            row.percentDaryaftAzKhazane = (_uw.Budget_001Rep.Division(Int64.Parse(dataReader1["ExpenseDaryaftAzKhazane"].ToString()), Int64.Parse(dataReader1["MosavabDaryaftAzKhazane"].ToString())));
                        }
                        else
                        {
                            row.percentDaryaftAzKhazane = 0;
                        }

                        row.MosavabKol = Int64.Parse(dataReader1["MosavabKol"].ToString());
                        row.ExpenseKol = Int64.Parse(dataReader1["ExpenseKol"].ToString());

                        if (!string.IsNullOrEmpty(dataReader1["MosavabKol"].ToString()) && Int64.Parse(dataReader1["MosavabKol"].ToString()) > 0)
                        {
                            row.percentKol = (_uw.Budget_001Rep.Division(Int64.Parse(dataReader1["ExpenseKol"].ToString()), Int64.Parse(dataReader1["MosavabKol"].ToString())));
                        }
                        else
                        {
                            row.percentKol = 0;
                        }

                        data.Add(row);
                    }
                }
            };
            return data;
        }

        [Route("ChartRavand")]
        [HttpGet]
        public async Task<ApiResult<List<object>>> ChartRavand(int budgetProcessId, int areaId)
        {
            List<object> data = new List<object>();
            List<string> yearName = new List<string>();
            List<string> yearId = new List<string>();
            List<Int64> mosavab = new List<Int64>();
            List<double> percmosavab = new List<double>();
            List<Int64> edit = new List<Int64>();
            List<Int64> expense = new List<Int64>();


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
        public async Task<ApiResult<List<BudgetDeviationViewModel>>> BudgetDeviation(Param20ViewModel param)
        {
            List<BudgetDeviationViewModel> data = new List<BudgetDeviationViewModel>();


            using (SqlConnection sqlconnect1 = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand1 = new SqlCommand("SP500_BudgetDeviation", sqlconnect1))
                {
                    sqlconnect1.Open();
                    sqlCommand1.CommandType = CommandType.StoredProcedure;
                    sqlCommand1.Parameters.AddWithValue("areaId", param.areaId);
                    sqlCommand1.Parameters.AddWithValue("yearId", param.yearId);
                    SqlDataReader dataReader1 = await sqlCommand1.ExecuteReaderAsync();

                    while (dataReader1.Read())
                    {
                        BudgetDeviationViewModel row = new BudgetDeviationViewModel();
                        row.AreaName = dataReader1["AreaName"].ToString();
                        row.code = dataReader1["Code"].ToString();
                        row.description = dataReader1["Description"].ToString();
                        row.mosavab = Int64.Parse(dataReader1["Mosavab"].ToString());
                        row.CreditAmount = Int64.Parse(dataReader1["CreditAmount"].ToString());
                        if (double.Parse(dataReader1["Mosavab"].ToString()) > 0)
                        {
                            row.PercentCreditAmount = _uw.Budget_001Rep.Division(double.Parse(dataReader1["CreditAmount"].ToString()), double.Parse(dataReader1["Mosavab"].ToString()));
                        }
                        else
                        {
                            row.PercentCreditAmount = 0;
                        }
                        row.expense = Int64.Parse(dataReader1["Expense"].ToString());
                        if (double.Parse(dataReader1["Mosavab"].ToString()) > 0)
                        {
                            row.percmosavab = _uw.Budget_001Rep.Division(double.Parse(dataReader1["Expense"].ToString()), double.Parse(dataReader1["Mosavab"].ToString()));
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


        [Route("BudgetShare")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetShareViewModel>>> GetBudgetShare(Paream12ViewModel param)
        {
            List<BudgetShareViewModel> data = new List<BudgetShareViewModel>();
            using (SqlConnection sqlconnect1 = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand1 = new SqlCommand("SP500_BudgetShare", sqlconnect1))
                {
                    sqlconnect1.Open();
                    sqlCommand1.CommandType = CommandType.StoredProcedure;
                    sqlCommand1.Parameters.AddWithValue("areaId", param.areaId);
                    sqlCommand1.Parameters.AddWithValue("yearId", param.yearId);
                    //  sqlCommand1.Parameters.AddWithValue("KindId", param.kindId);
                    sqlCommand1.Parameters.AddWithValue("BudgetProcessId", param.BudgetProcessId);
                    SqlDataReader dataReader1 = await sqlCommand1.ExecuteReaderAsync();

                    while (dataReader1.Read())
                    {
                        BudgetShareViewModel row = new BudgetShareViewModel();
                        row.CodingId = int.Parse(dataReader1["CodingId"].ToString());
                        row.code = dataReader1["Code"].ToString();
                        row.description = dataReader1["Description"].ToString();
                        row.mosavab = Int64.Parse(dataReader1["Mosavab"].ToString());
                        row.CreditAmount = Int64.Parse(dataReader1["CreditAmount"].ToString());
                        if (Int64.Parse(dataReader1["mosavab"].ToString()) > 0)
                        {
                            row.PercentCreditAmount = (_uw.Budget_001Rep.Division(Int64.Parse(dataReader1["CreditAmount"].ToString()), Int64.Parse(dataReader1["Mosavab"].ToString())));
                        }
                        else
                        {
                            row.PercentCreditAmount = 0;
                        }
                        row.expense = Int64.Parse(dataReader1["Expense"].ToString());
                        if (Int64.Parse(dataReader1["mosavab"].ToString()) > 0)
                        {
                            row.Percent = (_uw.Budget_001Rep.Division(Int64.Parse(dataReader1["expense"].ToString()), Int64.Parse(dataReader1["Mosavab"].ToString())));
                        }
                        else
                        {
                            row.Percent = 0;
                        }
                        row.AreaName = dataReader1["AreaName"].ToString();
                        data.Add(row);
                    }
                }
            };

            return data;

        }


        [Route("BudgetShareModal")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetShareModalViewModel>>> AC_BudgetShareModal(Paream13ViewModel param)
        {
            List<BudgetShareModalViewModel> data = new List<BudgetShareModalViewModel>();
            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP500_BudgetShare_Modal", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("YearId", param.YearId);
                    sqlCommand.Parameters.AddWithValue("AreaId", param.AreaId);
                    sqlCommand.Parameters.AddWithValue("CodingId", param.CodingId);
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();

                    while (dataReader.Read())
                    {
                        BudgetShareModalViewModel row = new BudgetShareModalViewModel();
                        row.Number = dataReader["Number"].ToString();
                        row.Date = dataReader["Date"].ToString();
                        row.DateShamsi = DateTimeExtensions.ConvertMiladiToShamsi(StringExtensions.ToNullableDatetime(dataReader["Date"].ToString()), "yyyy/MM/dd");
                        row.Description = dataReader["Description"].ToString();
                        row.RequestBudgetAmount = Int64.Parse(dataReader["RequestBudgetAmount"].ToString());
                        data.Add(row);
                    }
                }
            };
            return data;
        }


        [Route("DetailChartApi")]
        [HttpGet]
        public async Task<ApiResult<List<ChartAreaViewModel>>> DetailChartApi(int yearId, int centerId, int budgetProcessId, int StructureId, bool revenue, bool sale, bool loan, bool niabati, int? codingId = null)
        {
            List<ChartAreaViewModel> dataset = new List<ChartAreaViewModel>();
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
                    sqlCommand.Parameters.AddWithValue("codingId", codingId);
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();

                    while (dataReader.Read())
                    {
                        ChartAreaViewModel row = new ChartAreaViewModel();

                        row.Id = int.Parse(dataReader["AreaId"].ToString());
                        row.Row = int.Parse(dataReader["AreaId"].ToString());
                        row.AreaId = int.Parse(dataReader["AreaId"].ToString());
                        row.AreaName = dataReader["AreaName"].ToString();
                        row.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        row.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        row.MosavabDaily = Int64.Parse(dataReader["MosavabDaily"].ToString());
                        row.NotGet = Int64.Parse(dataReader["NotGet"].ToString());
                        if (double.Parse(dataReader["Mosavab"].ToString()) > 0)
                        {
                            row.PercentMosavab = _uw.Budget_001Rep.Division(double.Parse(dataReader["Expense"].ToString()), double.Parse(dataReader["Mosavab"].ToString()));
                        }
                        else
                        {
                            row.PercentMosavab = 0;
                        }
                        if (double.Parse(dataReader["MosavabDaily"].ToString()) > 0)
                        {
                            row.PercentMosavabDaily = _uw.Budget_001Rep.Division(double.Parse(dataReader["Expense"].ToString()), double.Parse(dataReader["MosavabDaily"].ToString()));
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


        [Route("Proctor")]
        [HttpGet]
        public async Task<ApiResult<List<Proctor1ViewModel1>>> GetAllDeputy(ProctorParamViewModel ViewModel)
        {
            List<Proctor1ViewModel1> fecthViewModel = new List<Proctor1ViewModel1>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP500_Proctor", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", ViewModel.yearId);
                    sqlCommand.Parameters.AddWithValue("ProctorId", ViewModel.proctorId);
                    sqlCommand.Parameters.AddWithValue("AreaId", ViewModel.areaId);
                    sqlCommand.Parameters.AddWithValue("BudgetProcessId", ViewModel.budgetprocessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        Proctor1ViewModel1 row = new Proctor1ViewModel1();
                        row.Id = int.Parse(dataReader["Id"].ToString());
                        row.ProctorName = dataReader["ProctorName"].ToString();
                        row.MosavabCurrent = long.Parse(dataReader["MosavabCurrent"].ToString());
                        row.CreditAmountCurrent = long.Parse(dataReader["CreditAmountCurrent"].ToString());
                        if (row.MosavabCurrent != 0)
                        {
                            row.PercentCreditAmountCurrent = _uw.Budget_001Rep.Division(row.CreditAmountCurrent, row.MosavabCurrent);
                        }
                        else
                        {
                            row.PercentCreditAmountCurrent = 0;
                        }

                        row.ExpenseCurrent = long.Parse(dataReader["ExpenseCurrent"].ToString());

                        row.MosavabCivil = long.Parse(dataReader["MosavabCivil"].ToString());
                        row.CreditAmountCivil = long.Parse(dataReader["CreditAmountCivil"].ToString());
                        if (row.MosavabCivil != 0)
                        {
                            row.PercentCreditAmountCivil = _uw.Budget_001Rep.Division(row.CreditAmountCivil, row.MosavabCivil);
                        }
                        else
                        {
                            row.PercentCreditAmountCivil = 0;
                        }

                        row.ExpenseCivil = long.Parse(dataReader["ExpenseCivil"].ToString());

                        if (row.MosavabCurrent != 0)
                        {
                            row.PercentCurrent = _uw.Budget_001Rep.Division(row.ExpenseCurrent, row.MosavabCurrent);
                        }
                        else
                        {
                            row.MosavabCurrent = 0;
                        }


                        if (row.MosavabCivil != 0)
                        {
                            row.PercentCivil = _uw.Budget_001Rep.Division(row.ExpenseCivil, row.MosavabCivil);
                        }
                        else
                        { row.PercentCivil = 0; }


                        if (row.MosavabCurrent + row.MosavabCivil != 0)
                        {
                            row.PercentTotal = _uw.Budget_001Rep.Division(row.ExpenseCivil + row.ExpenseCurrent, row.MosavabCivil + row.MosavabCurrent);
                        }
                        else
                        {
                            row.PercentTotal = 0;
                        }

                        fecthViewModel.Add(row);
                    }
                }
            }

            return Ok(fecthViewModel);
        }


        [Route("ProctorArea")]
        [HttpGet]
        public async Task<ApiResult<List<AreaProctorViewModel>>> ProctorAreaBudget(ProctorParamViewModel viewModel)
        {
            List<AreaProctorViewModel> fecthViewModel = new List<AreaProctorViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP500_Proctor", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", viewModel.yearId);
                    sqlCommand.Parameters.AddWithValue("ProctorId", viewModel.proctorId);
                    sqlCommand.Parameters.AddWithValue("AreaId", viewModel.areaId);
                    sqlCommand.Parameters.AddWithValue("BudgetProcessId", viewModel.budgetprocessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        AreaProctorViewModel row = new AreaProctorViewModel();
                        row.AreaId = int.Parse(dataReader["AreaId"].ToString());
                        row.AreaName = dataReader["AreaName"].ToString();
                        row.MosavabCurrent = long.Parse(dataReader["MosavabCurrent"].ToString());
                        row.CreditAmountCurrent = long.Parse(dataReader["CreditAmountCurrent"].ToString());
                        if (row.MosavabCurrent != 0)
                        {
                            row.PercentCreditAmountCurrent = _uw.Budget_001Rep.Division(row.CreditAmountCurrent, row.MosavabCurrent);
                        }
                        else
                        {
                            row.PercentCreditAmountCurrent = 0;
                        }
                        row.ExpenseCurrent = long.Parse(dataReader["ExpenseCurrent"].ToString());
                        if (row.MosavabCurrent != 0)
                        {
                            row.PercentCurrent = _uw.Budget_001Rep.Division(row.ExpenseCurrent, row.MosavabCurrent);
                        }
                        else
                        {
                            row.PercentCurrent = 0;
                        }

                        row.MosavabCivil = long.Parse(dataReader["MosavabCivil"].ToString());
                        row.CreditAmountCivil = long.Parse(dataReader["CreditAmountCivil"].ToString());
                        if (row.MosavabCivil != 0)
                        {
                            row.PercentCreditAmountCivil = _uw.Budget_001Rep.Division(row.CreditAmountCivil, row.MosavabCivil);
                        }
                        else
                        {
                            row.PercentCreditAmountCivil = 0;
                        }

                        row.ExpenseCivil = long.Parse(dataReader["ExpenseCivil"].ToString());

                        if (row.MosavabCivil != 0)
                        {
                            row.PercentCivil = _uw.Budget_001Rep.Division(row.ExpenseCivil, row.MosavabCivil);
                        }
                        else
                        {
                            row.PercentCivil = 0;
                        }

                        if (row.MosavabCurrent + row.MosavabCivil != 0)
                        {
                            row.PercentTotal = _uw.Budget_001Rep.Division(row.ExpenseCurrent + row.ExpenseCivil, row.MosavabCurrent + row.MosavabCivil);
                        }
                        else
                        {
                            row.PercentTotal = 0;
                        }

                        fecthViewModel.Add(row);
                    }
                }
                return Ok(fecthViewModel);
            }
        }


        [Route("ProctorList")]
        [HttpGet]
        public async Task<IActionResult> ProctorList()
        {
            return Ok(await _uw.DeputyRepository.ProctorListAsync());
        }

        [Route("ProctorAreaBudget")]
        [HttpGet]
        public async Task<ApiResult<List<ProctorAreaBudgetViewModel>>> ProctorAreaBudgetDetail(ProctorParamViewModel viewModel)
        {
            if (viewModel.yearId == 0 | viewModel.areaId == 0 | viewModel.proctorId == 0)
            {
                return BadRequest("با خطا مواجه شدید");
            }
            List<ProctorAreaBudgetViewModel> fecthViewModel = new List<ProctorAreaBudgetViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP500_Proctor", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", viewModel.yearId);
                    sqlCommand.Parameters.AddWithValue("ProctorId", viewModel.proctorId);
                    sqlCommand.Parameters.AddWithValue("AreaId", viewModel.areaId);
                    sqlCommand.Parameters.AddWithValue("BudgetProcessId", viewModel.budgetprocessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        ProctorAreaBudgetViewModel fetchView = new ProctorAreaBudgetViewModel();
                        fetchView.Code = dataReader["Code"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        fetchView.Supply = Int64.Parse(dataReader["Supply"].ToString());
                        fetchView.Expense = Int64.Parse(dataReader["Expense"].ToString());

                        if (fetchView.Mosavab != 0)
                        {
                            fetchView.Percent = _uw.Budget_001Rep.Division(fetchView.Expense, fetchView.Mosavab);
                        }
                        else
                        {
                            fetchView.Percent = 0;
                        }
                        fecthViewModel.Add(fetchView);
                    }

                }
            }
            return Ok(fecthViewModel);
        }


        [Route("ProctorAutomationRead")]
        [HttpGet]
        public async Task<ApiResult<List<ProctorAutomationViewModel>>> AC_ProctorAutomation(Param11ViewModel param)
        {

            List<ProctorAutomationViewModel> fecthViewModel = new List<ProctorAutomationViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP500_ProctorAutomation", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", param.YearId);
                    sqlCommand.Parameters.AddWithValue("AreaId", param.AreaId);
                    sqlCommand.Parameters.AddWithValue("ProctorId", param.ProctorId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        ProctorAutomationViewModel row = new ProctorAutomationViewModel();
                        row.Number = dataReader["Number"].ToString();
                        row.Date = dataReader["Date"].ToString();
                        row.DateShamsi = DateTimeExtensions.ConvertMiladiToShamsi(StringExtensions.ToNullableDatetime(dataReader["Date"].ToString()), "yyyy/MM/dd");
                        row.Description = dataReader["Description"].ToString();
                        row.EstimateAmount = StringExtensions.ToNullableInt(dataReader["EstimateAmount"].ToString());
                        row.Code = dataReader["Code"].ToString();
                        row.title = dataReader["title"].ToString();
                        fecthViewModel.Add(row);
                    }
                }
            }
            return Ok(fecthViewModel);
        }


        [Route("AbstractRead")]
        [HttpGet]
        public async Task<ApiResult<List<AbstractViewModel>>> GetAbstractList(int yearId)
        {
            List<AbstractViewModel> abslist = new List<AbstractViewModel>();

            using (SqlConnection sqlConnection = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand cmd = new SqlCommand("SP500_Abstract", sqlConnection))
                {
                    sqlConnection.Open();
                    cmd.Parameters.AddWithValue("yearId", yearId);
                    // cmd.Parameters.AddWithValue("KindId", KindId);
                    //cmd.Parameters.AddWithValue("StructureId", StructureId);
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await cmd.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        AbstractViewModel fetchView = new AbstractViewModel();
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.AreaName = dataReader["AreaName"].ToString();
                        fetchView.MosavabCurrent = long.Parse(dataReader["MosavabCurrent"].ToString());
                        fetchView.MosavabCivil = long.Parse(dataReader["MosavabCivil"].ToString());
                        fetchView.MosavabRevenue = long.Parse(dataReader["MosavabRevenue"].ToString());
                        fetchView.MosavabDar_Khazane = long.Parse(dataReader["MosavabDar_Khazane"].ToString());
                        fetchView.MosavabNeyabati = long.Parse(dataReader["MosavabNeyabati"].ToString());
                        fetchView.MosavabFinancial = long.Parse(dataReader["MosavabFinancial"].ToString());
                        fetchView.MosavabPayMotomarkez = long.Parse(dataReader["MosavabPayMotomarkez"].ToString());
                        fetchView.MosavabSanavati = long.Parse(dataReader["MosavabSanavati"].ToString());
                        fetchView.balanceMosavab = long.Parse(dataReader["balanceMosavab"].ToString());
                        fetchView.Resoures = long.Parse(dataReader["Resoures"].ToString());
                        abslist.Add(fetchView);

                        //dataReader.NextResult();
                    }
                }
            }

            return Ok(abslist);
        }


        [Route("ProjectReportScale")]
        [HttpGet]
        public async Task<ApiResult<List<ProjectReportScaleViewModel>>> ProjectReportScale(int yearId, int areaId, int scaleId)
        {
            List<ProjectReportScaleViewModel> commiteViews = new List<ProjectReportScaleViewModel>();

            if (yearId == 0)
                return BadRequest("با خطا مواجه شد");
            if (yearId > 0)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP005_Report_ProjectScale", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("YearId", yearId);
                        sqlCommand.Parameters.AddWithValue("AreaId", areaId);
                        sqlCommand.Parameters.AddWithValue("ScaleId", scaleId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            ProjectReportScaleViewModel commiteView = new ProjectReportScaleViewModel();
                            commiteView.ProjectId = int.Parse(dataReader["ProjectId"].ToString());
                            commiteView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                            commiteView.Expense = Int64.Parse(dataReader["Expense"].ToString());
                            commiteView.ProjectCode = dataReader["ProjectCode"].ToString();
                            commiteView.ProjectName = dataReader["ProjectName"].ToString();
                            commiteViews.Add(commiteView);

                        }

                    }
                }

            }
            return Ok(commiteViews);
        }


        [Route("AbstractPerformanceBudget")]
        [HttpGet]
        public async Task<ApiResult<List<AbstractPerformanceBudgetViewModel>>> AC_AbstractPerformanceBudget(ParamViewModel param)
        {

            List<AbstractPerformanceBudgetViewModel> fecthViewModel = new List<AbstractPerformanceBudgetViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                if (param.StructureId == 2)
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP500_Abstract_Performance_Sazman", sqlconnect))
                    {
                        sqlconnect.Open();
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

                                AbstractPerformanceBudgetViewModel row = new AbstractPerformanceBudgetViewModel();
                                row.Id = int.Parse(dataReader["Id"].ToString());
                                row.AreaName = dataReader["AreaName"].ToString();
                                row.MosavabRevenue = long.Parse(dataReader["MosavabRevenue"].ToString());
                                row.ExpenseMonthRevenue = long.Parse(dataReader["ExpenseMonthRevenue"].ToString());
                                if (row.MosavabRevenue != 0)
                                {
                                    row.PercentRevenue = Math.Round(_uw.Budget_001Rep.Division(row.ExpenseMonthRevenue, row.MosavabRevenue));
                                }
                                else
                                {
                                    row.PercentRevenue = 0;
                                }


                                row.MosavabCurrent = long.Parse(dataReader["MosavabCurrent"].ToString());
                                row.CreditCurrent = long.Parse(dataReader["CreditCurrent"].ToString());
                                if (row.MosavabCurrent != 0)
                                {
                                    row.PercentCreditCurrent = Math.Round(_uw.Budget_001Rep.Division(row.CreditCurrent, row.MosavabCurrent));
                                }
                                else
                                {
                                    row.PercentCreditCurrent = 0;
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


                                row.MosavabCivil = long.Parse(dataReader["MosavabCivil"].ToString());
                                row.CreditAmountCivil = long.Parse(dataReader["CreditAmountCivil"].ToString());
                                if (row.MosavabCivil != 0)
                                {
                                    row.PercentCreditCivil = Math.Round(_uw.Budget_001Rep.Division(row.CreditAmountCivil, row.MosavabCivil));
                                }
                                else
                                {
                                    row.PercentCreditCivil = 0;
                                }

                                row.ExpenseCivil = long.Parse(dataReader["ExpenseCivil"].ToString());
                                if (row.MosavabCivil != 0)
                                {
                                    row.PercentCivil = Math.Round(_uw.Budget_001Rep.Division(row.ExpenseCivil, row.MosavabCivil));
                                }
                                else
                                {
                                    row.PercentCivil = 0;
                                }

                                row.MosavabFinancial = long.Parse(dataReader["MosavabFinancial"].ToString());
                                row.CreditFinancial = long.Parse(dataReader["CreditFinancial"].ToString());

                                if (row.MosavabFinancial != 0)
                                {
                                    row.PercentCreditFinancial = Math.Round(_uw.Budget_001Rep.Division(row.CreditFinancial, row.MosavabFinancial));
                                }
                                else
                                {
                                    row.PercentCreditFinancial = 0;
                                }


                                row.ExpenseFinancial = long.Parse(dataReader["ExpenseFinancial"].ToString());
                                if (row.MosavabFinancial != 0)
                                {
                                    row.PercentFinancial = Math.Round(_uw.Budget_001Rep.Division(row.ExpenseFinancial, row.MosavabFinancial));
                                }
                                else
                                {
                                    row.PercentFinancial = 0;
                                }

                                row.MosavabSanavati = long.Parse(dataReader["MosavabSanavati"].ToString());
                                row.CreditDoyonSanavati = long.Parse(dataReader["CreditDoyonSanavati"].ToString());
                                if (row.MosavabSanavati != 0)
                                {
                                    row.PercentDoyonSanavati = Math.Round(_uw.Budget_001Rep.Division(row.CreditDoyonSanavati, row.MosavabSanavati));
                                }
                                else
                                {
                                    row.PercentDoyonSanavati = 0;
                                }
                                row.ExpenseSanavati = long.Parse(dataReader["ExpenseSanavati"].ToString());
                                if (row.MosavabSanavati != 0)
                                {
                                    row.PercentSanavati = Math.Round(_uw.Budget_001Rep.Division(row.ExpenseSanavati, row.MosavabSanavati));
                                }
                                else
                                {
                                    row.PercentSanavati = 0;
                                }


                                row.MosavabPayMotomarkez = long.Parse(dataReader["MosavabPayMotomarkez"].ToString());
                                row.ExpensePayMotomarkez = long.Parse(dataReader["ExpensePayMotomarkez"].ToString());
                                if (row.MosavabPayMotomarkez != 0)
                                {
                                    row.PercentPayMotomarkez = Math.Round(_uw.Budget_001Rep.Division(row.ExpensePayMotomarkez, row.MosavabPayMotomarkez));
                                }
                                else
                                {
                                    row.PercentPayMotomarkez = 0;
                                }

                                row.MosavabDar_Khazane = long.Parse(dataReader["MosavabDar_Khazane"].ToString());
                                row.ExpenseMonthDarAzKhazane = long.Parse(dataReader["ExpenseMonthDarAzKhazane"].ToString());
                                if (row.MosavabDar_Khazane != 0)
                                {
                                    row.PercentDar_Khazane = Math.Round(_uw.Budget_001Rep.Division(row.ExpenseMonthDarAzKhazane, row.MosavabDar_Khazane));
                                }
                                else
                                {
                                    row.PercentDar_Khazane = 0;
                                }

                                row.MosavabNeyabati = long.Parse(dataReader["MosavabNeyabati"].ToString());
                                row.ExpenseMonthNeyabati = long.Parse(dataReader["ExpenseMonthNeyabati"].ToString());
                                if (row.MosavabNeyabati != 0)
                                {
                                    row.PercentNeyabati = Math.Round(_uw.Budget_001Rep.Division(row.ExpenseMonthNeyabati, row.MosavabNeyabati));
                                }
                                else
                                {
                                    row.PercentNeyabati = 0;
                                }

                                row.Resoures = long.Parse(dataReader["Resoures"].ToString());
                                row.balance = long.Parse(dataReader["balance"].ToString());

                                fecthViewModel.Add(row);
                            }

                        }
                    }
                    sqlconnect.Close();

                }

                if (param.StructureId == 1)
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP500_Abstract_Performance_Shahrdari", sqlconnect))
                    {
                        sqlconnect.Open();
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

                                AbstractPerformanceBudgetViewModel row = new AbstractPerformanceBudgetViewModel();
                                row.Id = int.Parse(dataReader["Id"].ToString());
                                row.AreaName = dataReader["AreaName"].ToString();
                                row.MosavabRevenue = long.Parse(dataReader["MosavabRevenue"].ToString());
                                row.ExpenseMonthRevenue = long.Parse(dataReader["ExpenseMonthRevenue"].ToString());
                                if (row.MosavabRevenue != 0)
                                {
                                    row.PercentRevenue = Math.Round(_uw.Budget_001Rep.Division(row.ExpenseMonthRevenue, row.MosavabRevenue));
                                }
                                else
                                {
                                    row.PercentRevenue = 0;
                                }

                                row.MosavabCurrent = long.Parse(dataReader["MosavabCurrent"].ToString());
                                row.CreditCurrent = long.Parse(dataReader["CreditCurrent"].ToString());
                                if (row.MosavabCurrent != 0)
                                {
                                    row.PercentCreditCurrent = Math.Round(_uw.Budget_001Rep.Division(row.CreditCurrent, row.MosavabCurrent));
                                }
                                else
                                {
                                    row.PercentCreditCurrent = 0;
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
                                row.MosavabCivil = long.Parse(dataReader["MosavabCivil"].ToString());
                                row.CreditAmountCivil = long.Parse(dataReader["CreditAmountCivil"].ToString());
                                if (row.MosavabCivil != 0)
                                {
                                    row.PercentCreditCivil = Math.Round(_uw.Budget_001Rep.Division(row.CreditAmountCivil, row.MosavabCivil));
                                }
                                else
                                {
                                    row.PercentCreditCivil = 0;
                                }

                                row.ExpenseCivil = long.Parse(dataReader["ExpenseCivil"].ToString());
                                if (row.MosavabCivil != 0)
                                {
                                    row.PercentCivil = Math.Round(_uw.Budget_001Rep.Division(row.ExpenseCivil, row.MosavabCivil));
                                }
                                else
                                {
                                    row.PercentCivil = 0;
                                }

                                row.MosavabFinancial = long.Parse(dataReader["MosavabFinancial"].ToString());
                                row.ExpenseFinancial = long.Parse(dataReader["ExpenseFinancial"].ToString());
                                if (row.MosavabFinancial != 0)
                                {
                                    row.PercentFinancial = Math.Round(_uw.Budget_001Rep.Division(row.ExpenseFinancial, row.MosavabFinancial));
                                }
                                else
                                {
                                    row.PercentFinancial = 0;
                                }

                                row.MosavabSanavati = long.Parse(dataReader["MosavabSanavati"].ToString());
                                row.ExpenseSanavati = long.Parse(dataReader["ExpenseSanavati"].ToString());
                                if (row.MosavabSanavati != 0)
                                {
                                    row.PercentSanavati = Math.Round(_uw.Budget_001Rep.Division(row.ExpenseSanavati, row.MosavabSanavati));
                                }
                                else
                                {
                                    row.PercentSanavati = 0;
                                }

                                row.MosavabPayMotomarkez = long.Parse(dataReader["MosavabPayMotomarkez"].ToString());
                                row.ExpensePayMotomarkez = long.Parse(dataReader["ExpensePayMotomarkez"].ToString());
                                if (row.MosavabPayMotomarkez != 0)
                                {
                                    row.PercentPayMotomarkez = Math.Round(_uw.Budget_001Rep.Division(row.ExpensePayMotomarkez, row.MosavabPayMotomarkez));
                                }
                                else
                                {
                                    row.PercentPayMotomarkez = 0;
                                }

                                row.MosavabDar_Khazane = long.Parse(dataReader["MosavabDar_Khazane"].ToString());
                                row.ExpenseMonthDarAzKhazane = long.Parse(dataReader["ExpenseMonthDarAzKhazane"].ToString());
                                if (row.MosavabDar_Khazane != 0)
                                {
                                    row.PercentDar_Khazane = Math.Round(_uw.Budget_001Rep.Division(row.ExpenseMonthDarAzKhazane, row.MosavabDar_Khazane));
                                }
                                else
                                {
                                    row.PercentDar_Khazane = 0;
                                }

                                row.Resoures = long.Parse(dataReader["Resoures"].ToString());
                                row.balance = long.Parse(dataReader["balance"].ToString());

                                fecthViewModel.Add(row);
                            }
                        }
                    }
                    sqlconnect.Close();
                }
            }


            return Ok(fecthViewModel);
        }


        [Route("AbstractPerformanceBudgetDetail")]
        [HttpGet]
        public async Task<ApiResult<List<AbstractPerformanceBudgetDetailViewModel>>> AC_AbstractPerformanceBudgetDetail(ParamsViewModel param)
        {
            List<AbstractPerformanceBudgetDetailViewModel> fecthViewModel = new List<AbstractPerformanceBudgetDetailViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP500_Abstract_Performance_Detail", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", param.YearId);
                    sqlCommand.Parameters.AddWithValue("areaId", param.AreaId);
                    sqlCommand.Parameters.AddWithValue("columnName", param.ColumnName);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        AbstractPerformanceBudgetDetailViewModel fetchView = new AbstractPerformanceBudgetDetailViewModel();
                        fetchView.Code = dataReader["Code"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        fetchView.Expense = Int64.Parse(dataReader["Expense"].ToString());

                        if (fetchView.Mosavab != 0)
                        {
                            fetchView.Percent = _uw.Budget_001Rep.Division(fetchView.Expense, fetchView.Mosavab);
                        }
                        else
                        {
                            fetchView.Percent = 0;
                        }
                        fecthViewModel.Add(fetchView);
                    }

                }
            }
            return Ok(fecthViewModel);
        }


        [Route("AbstractPerformanceShardari_Excel")]
        [HttpGet]
        public async Task<ApiResult<List<AbstractPerformanceShardari_ExcelViewModel>>> AC_AbstractPerformanceShardari_Excel(Param1ViewModel param)
        {
            List<AbstractPerformanceShardari_ExcelViewModel> fecthViewModel = new List<AbstractPerformanceShardari_ExcelViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP500_Abstract_Performance_Shahrdari_Excel", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandTimeout = 500;
                    sqlCommand.Parameters.AddWithValue("yearId", param.YearId);
                    sqlCommand.Parameters.AddWithValue("areaId", param.AreaId);
                    sqlCommand.Parameters.AddWithValue("monthId", param.MonthId);
                    sqlCommand.Parameters.AddWithValue("budgetProcessId", param.budgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        AbstractPerformanceShardari_ExcelViewModel fetchView = new AbstractPerformanceShardari_ExcelViewModel();
                        fetchView.Code = dataReader["Code"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        fetchView.Edit = Int64.Parse(dataReader["Edit"].ToString());
                        fetchView.CreditAmount = Int64.Parse(dataReader["CreditAmount"].ToString());

                        fetchView.ExpenseMonth = Int64.Parse(dataReader["ExpenseMonth"].ToString());
                        fetchView.levelNumber = int.Parse(dataReader["levelNumber"].ToString());

                        if (fetchView.Edit != 0)
                        {
                            fetchView.Percent = _uw.Budget_001Rep.Division(fetchView.ExpenseMonth, fetchView.Edit);
                        }
                        else
                        {
                            fetchView.Percent = 0;
                        }

                        if (fetchView.Edit != 0)
                        {
                            fetchView.PercentCredit = _uw.Budget_001Rep.Division(fetchView.CreditAmount, fetchView.Edit);
                        }
                        else
                        {
                            fetchView.PercentCredit = 0;
                        }




                        fecthViewModel.Add(fetchView);
                    }

                }
            }
            return Ok(fecthViewModel);
        }


        [Route("AbstractPerformanceSazman_Excel")]
        [HttpGet]
        public async Task<ApiResult<List<AbstractPerformanceShardari_ExcelViewModel>>> AC_AbstractPerformanceSazman_Excel(Param1ViewModel param)
        {
            List<AbstractPerformanceShardari_ExcelViewModel> fecthViewModel = new List<AbstractPerformanceShardari_ExcelViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP500_Abstract_Performance_Sazman_Excel", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandTimeout = 500;
                    sqlCommand.Parameters.AddWithValue("yearId", param.YearId);
                    sqlCommand.Parameters.AddWithValue("areaId", param.AreaId);
                    sqlCommand.Parameters.AddWithValue("monthId", param.MonthId);
                    sqlCommand.Parameters.AddWithValue("budgetProcessId", param.budgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        AbstractPerformanceShardari_ExcelViewModel fetchView = new AbstractPerformanceShardari_ExcelViewModel();
                        fetchView.Code = dataReader["Code"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        fetchView.Edit = Int64.Parse(dataReader["Edit"].ToString());
                        fetchView.CreditAmount = Int64.Parse(dataReader["CreditAmount"].ToString());
                        fetchView.ExpenseMonth = Int64.Parse(dataReader["ExpenseMonth"].ToString());
                        fetchView.levelNumber = int.Parse(dataReader["levelNumber"].ToString());

                        if (fetchView.Edit != 0)
                        {
                            fetchView.Percent = _uw.Budget_001Rep.Division(fetchView.ExpenseMonth, fetchView.Edit);
                        }
                        else
                        {
                            fetchView.Percent = 0;
                        }

                        if (fetchView.Edit != 0)
                        {
                            fetchView.PercentCredit = _uw.Budget_001Rep.Division(fetchView.CreditAmount, fetchView.Edit);
                        }
                        else
                        {
                            fetchView.PercentCredit = 0;
                        }
                        fecthViewModel.Add(fetchView);
                    }

                }
            }
            return Ok(fecthViewModel);
        }


        [Route("BudgetPerformanceAcceptRead")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetPerformanceAcceptReadViewModel>>> AC_BudgetPerformanceAcceptRead(Param2ViewModel param)
        {
            List<BudgetPerformanceAcceptReadViewModel> fecthViewModel = new List<BudgetPerformanceAcceptReadViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP500_Abstract_Performance_Detail", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", param.YearId);
                    sqlCommand.Parameters.AddWithValue("areaId", param.MonthId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetPerformanceAcceptReadViewModel data = new BudgetPerformanceAcceptReadViewModel();
                        data.Id = int.Parse(dataReader["Id"].ToString());
                        data.AreaName = dataReader["AreaName"].ToString();
                        data.FirstName = dataReader["FirstName"].ToString();
                        data.LastName = dataReader["LastName"].ToString();
                        data.Responsibility = dataReader["Responsibility"].ToString();
                        data.Date = dataReader["Date"].ToString();
                        data.DateShamsi = DateTimeExtensions.ConvertMiladiToShamsi(StringExtensions.ToNullableDatetime(dataReader["Date"].ToString()), "yyyy/MM/dd");
                        data.UserId = StringExtensions.ToNullableInt(dataReader["UserId"].ToString());

                        fecthViewModel.Add(data);
                    }

                }
            }
            return Ok(fecthViewModel);
        }


    }
}
