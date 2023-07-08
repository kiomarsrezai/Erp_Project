using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
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
        public async Task<ApiResult<List<ChartBudgetDeviationViewModel>>> BudgetDeviation(int areaId, int yearId)
        {
            List<ChartBudgetDeviationViewModel> data = new List<ChartBudgetDeviationViewModel>();


            using (SqlConnection sqlconnect1 = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand1 = new SqlCommand("SP500_BudgetDeviation", sqlconnect1))
                {
                    sqlconnect1.Open();
                    sqlCommand1.CommandType = CommandType.StoredProcedure;
                    sqlCommand1.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand1.Parameters.AddWithValue("yearId", yearId);
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
        public async Task<ApiResult<List<ChartBudgetDeviationViewModel>>> GetBudgetShare(ChartBudgetDeviationParamViewModel param)
        {
            List<ChartBudgetDeviationViewModel> data = new List<ChartBudgetDeviationViewModel>();
            using (SqlConnection sqlconnect1 = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand1 = new SqlCommand("SP500_BudgetShare", sqlconnect1))
                {
                    sqlconnect1.Open();
                    sqlCommand1.CommandType = CommandType.StoredProcedure;
                    sqlCommand1.Parameters.AddWithValue("areaId", param.areaId);
                    sqlCommand1.Parameters.AddWithValue("yearId", param.yearId);
                    sqlCommand1.Parameters.AddWithValue("KindId", param.kindId);
                    sqlCommand1.Parameters.AddWithValue("BudgetProcessId", param.BudgetProcessId);
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
                        row.ExpenseCurrent = long.Parse(dataReader["ExpenseCurrent"].ToString());

                        row.MosavabCivil = long.Parse(dataReader["MosavabCivil"].ToString());
                        row.ExpenseCivil = long.Parse(dataReader["ExpenseCivil"].ToString());
                        //fetchView.MosavabCurrentStr = Common.StringExtensions.En2Fa(Common.StringExtensions.ToNumeric(long.Parse(dataReader["MosavabCurrent"].ToString())));

                        //fetchView.MosavabCivilStr = Common.StringExtensions.En2Fa(Common.StringExtensions.ToNumeric(long.Parse(dataReader["MosavabCivil"].ToString())));

                        //fetchView.ExpenseCurrentStr = Common.StringExtensions.En2Fa(Common.StringExtensions.ToNumeric(long.Parse(dataReader["ExpenseCurrent"].ToString())));

                        //fetchView.ExpenseCivilStr = Common.StringExtensions.En2Fa(Common.StringExtensions.ToNumeric(long.Parse(dataReader["ExpenseCivil"].ToString())));

                        //fetchView.Row = int.Parse(dataReader["Id"].ToString());

                        if (row.MosavabCurrent != 0)
                        {
                            row.PercentCurrent = _uw.Budget_001Rep.Division(row.ExpenseCurrent, row.MosavabCurrent);
                            //row.PercentCurrentStr = Common.StringExtensions.En2Fa(_uw.Budget_001Rep.Divivasion(fetchView.ExpenseCurrent, fetchView.MosavabCurrent).ToString()) + "%";
                        }
                        else
                        {
                            row.MosavabCurrent = 0;
                        }


                        if (row.MosavabCivil != 0)
                        {
                            row.PercentCivil = _uw.Budget_001Rep.Division(row.ExpenseCivil, row.MosavabCivil);
                            //row.PercentCivilStr = Common.StringExtensions.En2Fa(_uw.Budget_001Rep.Divivasion(fetchView.ExpenseCivil, fetchView.MosavabCivil).ToString()) + "%";
                        }
                        else
                        { row.PercentCivil = 0; }


                        if (row.MosavabCurrent + row.MosavabCivil != 0)
                        {
                            row.PercentTotal = _uw.Budget_001Rep.Division(row.ExpenseCivil + row.ExpenseCurrent, row.MosavabCivil + row.MosavabCurrent);
                            //fetchView.PercentTotalStr = Common.StringExtensions.En2Fa(_uw.Budget_001Rep.Divivasion(fetchView.ExpenseCivil + fetchView.ExpenseCurrent, fetchView.MosavabCivil + fetchView.MosavabCurrent).ToString()) + "%";
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
                        AreaProctorViewModel fetchView = new AreaProctorViewModel();
                        fetchView.AreaId = int.Parse(dataReader["AreaId"].ToString());
                        fetchView.AreaName = dataReader["AreaName"].ToString();
                        fetchView.MosavabCurrent = long.Parse(dataReader["MosavabCurrent"].ToString());
                        fetchView.ExpenseCurrent = long.Parse(dataReader["ExpenseCurrent"].ToString());
                        if (fetchView.MosavabCurrent != 0)
                        {
                            fetchView.PercentCurrent = _uw.Budget_001Rep.Division(fetchView.ExpenseCurrent, fetchView.MosavabCurrent);
                        }
                        else
                        {
                            fetchView.PercentCurrent = 0;
                        }

                        fetchView.MosavabCivil = long.Parse(dataReader["MosavabCivil"].ToString());
                        fetchView.ExpenseCivil = long.Parse(dataReader["ExpenseCivil"].ToString());

                        if (fetchView.MosavabCivil != 0)
                        {
                            fetchView.PercentCivil = _uw.Budget_001Rep.Division(fetchView.ExpenseCivil, fetchView.MosavabCivil);
                        }
                        else
                        {
                            fetchView.PercentCivil = 0;
                        }

                        if (fetchView.MosavabCurrent + fetchView.MosavabCivil != 0)
                        {
                            fetchView.PercentTotal = _uw.Budget_001Rep.Division(fetchView.ExpenseCurrent + fetchView.ExpenseCivil, fetchView.MosavabCurrent + fetchView.MosavabCivil);
                        }
                        else
                        {
                            fetchView.PercentTotal = 0;
                        }

                        fecthViewModel.Add(fetchView);
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
                               (long.Parse(dataReader["ExpenseRevenue"].ToString()) != 0) ||
                                (long.Parse(dataReader["MosavabCurrent"].ToString()) != 0) ||
                                (long.Parse(dataReader["ExpenseCurrent"].ToString()) != 0) ||
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
                                (long.Parse(dataReader["ExpenseDar_Khazane"].ToString()) != 0) ||
                                (long.Parse(dataReader["MosavabRevenue"].ToString()) != 0))
                            {

                                AbstractPerformanceBudgetViewModel fetchdata = new AbstractPerformanceBudgetViewModel();
                                fetchdata.Id = int.Parse(dataReader["Id"].ToString());
                                fetchdata.AreaName = dataReader["AreaName"].ToString();
                                fetchdata.MosavabRevenue = long.Parse(dataReader["MosavabRevenue"].ToString());
                                fetchdata.ExpenseRevenue = long.Parse(dataReader["ExpenseRevenue"].ToString());
                                if (fetchdata.MosavabRevenue != 0)
                                {
                                    fetchdata.PercentRevenue = Math.Round(_uw.Budget_001Rep.Division(fetchdata.ExpenseRevenue, fetchdata.MosavabRevenue));
                                }
                                else
                                {
                                    fetchdata.PercentRevenue = 0;
                                }

                                fetchdata.MosavabCurrent = long.Parse(dataReader["MosavabCurrent"].ToString());
                                fetchdata.ExpenseCurrent = long.Parse(dataReader["ExpenseCurrent"].ToString());
                                if (fetchdata.MosavabCurrent != 0)
                                {
                                    fetchdata.PercentCurrent = Math.Round(_uw.Budget_001Rep.Division(fetchdata.ExpenseCurrent, fetchdata.MosavabCurrent));
                                }
                                else
                                {
                                    fetchdata.PercentCurrent = 0;
                                }
                                fetchdata.MosavabCivil = long.Parse(dataReader["MosavabCivil"].ToString());
                                fetchdata.CreditAmountCivil = long.Parse(dataReader["CreditAmountCivil"].ToString());
                                if (fetchdata.MosavabCivil != 0)
                                {
                                    fetchdata.PercentCreditCivil = Math.Round(_uw.Budget_001Rep.Division(fetchdata.CreditAmountCivil, fetchdata.MosavabCivil));
                                }
                                else
                                {
                                    fetchdata.PercentCreditCivil = 0;
                                }

                                fetchdata.ExpenseCivil = long.Parse(dataReader["ExpenseCivil"].ToString());
                                if (fetchdata.MosavabCivil != 0)
                                {
                                    fetchdata.PercentCivil = Math.Round(_uw.Budget_001Rep.Division(fetchdata.ExpenseCivil, fetchdata.MosavabCivil));
                                }
                                else
                                {
                                    fetchdata.PercentCivil = 0;
                                }

                                fetchdata.MosavabFinancial = long.Parse(dataReader["MosavabFinancial"].ToString());
                                fetchdata.ExpenseFinancial = long.Parse(dataReader["ExpenseFinancial"].ToString());
                                if (fetchdata.MosavabFinancial != 0)
                                {
                                    fetchdata.PercentFinancial = Math.Round(_uw.Budget_001Rep.Division(fetchdata.ExpenseFinancial, fetchdata.MosavabFinancial));
                                }
                                else
                                {
                                    fetchdata.PercentFinancial = 0;
                                }

                                fetchdata.MosavabSanavati = long.Parse(dataReader["MosavabSanavati"].ToString());
                                fetchdata.ExpenseSanavati = long.Parse(dataReader["ExpenseSanavati"].ToString());
                                if (fetchdata.MosavabSanavati != 0)
                                {
                                    fetchdata.PercentSanavati = Math.Round(_uw.Budget_001Rep.Division(fetchdata.ExpenseSanavati, fetchdata.MosavabSanavati));
                                }
                                else
                                {
                                    fetchdata.PercentSanavati = 0;
                                }


                                fetchdata.MosavabPayMotomarkez = long.Parse(dataReader["MosavabPayMotomarkez"].ToString());
                                fetchdata.ExpensePayMotomarkez = long.Parse(dataReader["ExpensePayMotomarkez"].ToString());
                                if (fetchdata.MosavabPayMotomarkez != 0)
                                {
                                    fetchdata.PercentPayMotomarkez = Math.Round(_uw.Budget_001Rep.Division(fetchdata.ExpensePayMotomarkez, fetchdata.MosavabPayMotomarkez));
                                }
                                else
                                {
                                    fetchdata.PercentPayMotomarkez = 0;
                                }

                                fetchdata.MosavabDar_Khazane = long.Parse(dataReader["MosavabDar_Khazane"].ToString());
                                fetchdata.ExpenseDar_Khazane = long.Parse(dataReader["ExpenseDar_Khazane"].ToString());
                                if (fetchdata.MosavabDar_Khazane != 0)
                                {
                                    fetchdata.PercentDar_Khazane = Math.Round(_uw.Budget_001Rep.Division(fetchdata.ExpenseDar_Khazane, fetchdata.MosavabDar_Khazane));
                                }
                                else
                                {
                                    fetchdata.PercentDar_Khazane = 0;
                                }


                                fetchdata.Resoures = long.Parse(dataReader["Resoures"].ToString());
                                fetchdata.balance = long.Parse(dataReader["balance"].ToString());


                                fecthViewModel.Add(fetchdata);
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
                               (long.Parse(dataReader["ExpenseRevenue"].ToString()) != 0) ||
                                (long.Parse(dataReader["MosavabCurrent"].ToString()) != 0) ||
                                (long.Parse(dataReader["ExpenseCurrent"].ToString()) != 0) ||
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
                                (long.Parse(dataReader["ExpenseDar_Khazane"].ToString()) != 0) ||
                                (long.Parse(dataReader["MosavabRevenue"].ToString()) != 0))
                            {

                                AbstractPerformanceBudgetViewModel fetchdata = new AbstractPerformanceBudgetViewModel();
                                fetchdata.Id = int.Parse(dataReader["Id"].ToString());
                                fetchdata.AreaName = dataReader["AreaName"].ToString();
                                fetchdata.MosavabRevenue = long.Parse(dataReader["MosavabRevenue"].ToString());
                                fetchdata.ExpenseRevenue = long.Parse(dataReader["ExpenseRevenue"].ToString());
                                if (fetchdata.MosavabRevenue != 0)
                                {
                                    fetchdata.PercentRevenue = Math.Round(_uw.Budget_001Rep.Division(fetchdata.ExpenseRevenue, fetchdata.MosavabRevenue));
                                }
                                else
                                {
                                    fetchdata.PercentRevenue = 0;
                                }

                                fetchdata.MosavabCurrent = long.Parse(dataReader["MosavabCurrent"].ToString());
                                fetchdata.ExpenseCurrent = long.Parse(dataReader["ExpenseCurrent"].ToString());
                                if (fetchdata.MosavabCurrent != 0)
                                {
                                    fetchdata.PercentCurrent = Math.Round(_uw.Budget_001Rep.Division(fetchdata.ExpenseCurrent, fetchdata.MosavabCurrent));
                                }
                                else
                                {
                                    fetchdata.PercentCurrent = 0;
                                }
                                fetchdata.MosavabCivil = long.Parse(dataReader["MosavabCivil"].ToString());
                                fetchdata.CreditAmountCivil = long.Parse(dataReader["CreditAmountCivil"].ToString());
                                if (fetchdata.MosavabCivil != 0)
                                {
                                    fetchdata.PercentCreditCivil = Math.Round(_uw.Budget_001Rep.Division(fetchdata.CreditAmountCivil, fetchdata.MosavabCivil));
                                }
                                else
                                {
                                    fetchdata.PercentCreditCivil = 0;
                                }

                                fetchdata.ExpenseCivil = long.Parse(dataReader["ExpenseCivil"].ToString());
                                if (fetchdata.MosavabCivil != 0)
                                {
                                    fetchdata.PercentCivil = Math.Round(_uw.Budget_001Rep.Division(fetchdata.ExpenseCivil, fetchdata.MosavabCivil));
                                }
                                else
                                {
                                    fetchdata.PercentCivil = 0;
                                }

                                fetchdata.MosavabFinancial = long.Parse(dataReader["MosavabFinancial"].ToString());
                                fetchdata.ExpenseFinancial = long.Parse(dataReader["ExpenseFinancial"].ToString());
                                if (fetchdata.MosavabFinancial != 0)
                                {
                                    fetchdata.PercentFinancial = Math.Round(_uw.Budget_001Rep.Division(fetchdata.ExpenseFinancial, fetchdata.MosavabFinancial));
                                }
                                else
                                {
                                    fetchdata.PercentFinancial = 0;
                                }

                                fetchdata.MosavabSanavati = long.Parse(dataReader["MosavabSanavati"].ToString());
                                fetchdata.ExpenseSanavati = long.Parse(dataReader["ExpenseSanavati"].ToString());
                                if (fetchdata.MosavabSanavati != 0)
                                {
                                    fetchdata.PercentSanavati = Math.Round(_uw.Budget_001Rep.Division(fetchdata.ExpenseSanavati, fetchdata.MosavabSanavati));
                                }
                                else
                                {
                                    fetchdata.PercentSanavati = 0;
                                }


                                fetchdata.MosavabPayMotomarkez = long.Parse(dataReader["MosavabPayMotomarkez"].ToString());
                                fetchdata.ExpensePayMotomarkez = long.Parse(dataReader["ExpensePayMotomarkez"].ToString());
                                if (fetchdata.MosavabPayMotomarkez != 0)
                                {
                                    fetchdata.PercentPayMotomarkez = Math.Round(_uw.Budget_001Rep.Division(fetchdata.ExpensePayMotomarkez, fetchdata.MosavabPayMotomarkez));
                                }
                                else
                                {
                                    fetchdata.PercentPayMotomarkez = 0;
                                }

                                fetchdata.MosavabDar_Khazane = long.Parse(dataReader["MosavabDar_Khazane"].ToString());
                                fetchdata.ExpenseDar_Khazane = long.Parse(dataReader["ExpenseDar_Khazane"].ToString());
                                if (fetchdata.MosavabDar_Khazane != 0)
                                {
                                    fetchdata.PercentDar_Khazane = Math.Round(_uw.Budget_001Rep.Division(fetchdata.ExpenseDar_Khazane, fetchdata.MosavabDar_Khazane));
                                }
                                else
                                {
                                    fetchdata.PercentDar_Khazane = 0;
                                }


                                fetchdata.Resoures = long.Parse(dataReader["Resoures"].ToString());
                                fetchdata.balance = long.Parse(dataReader["balance"].ToString());


                                fecthViewModel.Add(fetchdata);
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





    }
}
