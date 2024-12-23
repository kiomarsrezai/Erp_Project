using Dapper;
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
using System.Data.Common;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using NPOI.SS.UserModel;
using NPOI.SS.Util;
using NPOI.XSSF.UserModel;

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
        public async Task<ApiResult<List<object>>> ChartApi(int yearId, int centerId, int budgetProcessId, int StructureId, int? areaId = null, int? codingId = null)
        {
            List<int> Id = new List<int>();
            List<string> Description = new List<string>();
            List<string> Code = new List<string>();
            List<object> data = new List<object>();
            List<string> lables = new List<string>();
            List<Int64> mosavab = new List<Int64>();
            List<Int64> Supply = new List<Int64>();
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
                        //sqlCommand1.Parameters.AddWithValue("revenue", revenue);
                        //sqlCommand1.Parameters.AddWithValue("sale", sale);
                        //sqlCommand1.Parameters.AddWithValue("loan", loan);
                        //sqlCommand1.Parameters.AddWithValue("niabati", niabati);
                        sqlCommand1.Parameters.AddWithValue("StructureId", StructureId);
                        sqlCommand1.Parameters.AddWithValue("codingId", codingId);
                        SqlDataReader dataReader1 = await sqlCommand1.ExecuteReaderAsync();

                        while (dataReader1.Read())
                        {
                            lables.Add(dataReader1["AreaName"].ToString());
                            mosavab.Add(Int64.Parse(dataReader1["Mosavab"].ToString()));
                            Supply.Add(Int64.Parse(dataReader1["Supply"].ToString()));
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
                        //sqlCommand1.Parameters.AddWithValue("revenue", revenue);
                        //sqlCommand1.Parameters.AddWithValue("sale", sale);
                        //sqlCommand1.Parameters.AddWithValue("loan", loan);
                        //sqlCommand1.Parameters.AddWithValue("niabati", niabati);
                        sqlCommand1.Parameters.AddWithValue("StructureId", StructureId);
                        SqlDataReader dataReader1 = await sqlCommand1.ExecuteReaderAsync();

                        while (dataReader1.Read())
                        {

                            Id.Add(int.Parse(dataReader1["CodingId"].ToString()));
                            Code.Add(dataReader1["Code"].ToString());
                            Description.Add(dataReader1["Description"].ToString());
                            mosavab.Add(Int64.Parse(dataReader1["Mosavab"].ToString()));
                            Supply.Add(Int64.Parse(dataReader1["Supply"].ToString()));
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
            List<Int64> edit = new List<Int64>();
            List<Int64> expense = new List<Int64>();
            List<double> percmosavab = new List<double>();
            List<double> percEdit = new List<double>();



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
                        if (Int64.Parse(dataReader1["Mosavab"].ToString()) > 0)
                        {
                            percmosavab.Add(_uw.Budget_001Rep.Division(long.Parse(dataReader1["Expense"].ToString()), long.Parse(dataReader1["Mosavab"].ToString())));
                        }
                        else
                        {
                            percmosavab.Add(0);
                        }
                        if (Int64.Parse(dataReader1["Edit"].ToString()) > 0)
                        {
                            percEdit.Add(_uw.Budget_001Rep.Division(long.Parse(dataReader1["Expense"].ToString()), long.Parse(dataReader1["Edit"].ToString())));
                        }
                        else
                        {
                            percEdit.Add(0);
                        }


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
                        row.Edit = Int64.Parse(dataReader1["Edit"].ToString());
                        row.CreditAmount = Int64.Parse(dataReader1["CreditAmount"].ToString());
                        if (double.Parse(dataReader1["Edit"].ToString()) > 0)
                        {
                            row.PercentCreditAmount = _uw.Budget_001Rep.Division(double.Parse(dataReader1["CreditAmount"].ToString()), double.Parse(dataReader1["Edit"].ToString()));
                        }
                        else
                        {
                            row.PercentCreditAmount = 0;
                        }
                        row.expense = Int64.Parse(dataReader1["Expense"].ToString());
                        if (double.Parse(dataReader1["Edit"].ToString()) > 0)
                        {
                            row.percmosavab = _uw.Budget_001Rep.Division(double.Parse(dataReader1["Expense"].ToString()), double.Parse(dataReader1["Edit"].ToString()));
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
                        row.edit = Int64.Parse(dataReader1["edit"].ToString());
                        row.CreditAmount = Int64.Parse(dataReader1["CreditAmount"].ToString());
                        if (Int64.Parse(dataReader1["edit"].ToString()) > 0)
                        {
                            row.PercentCreditAmount = (_uw.Budget_001Rep.Division(Int64.Parse(dataReader1["CreditAmount"].ToString()), Int64.Parse(dataReader1["edit"].ToString())));
                        }
                        else
                        {
                            row.PercentCreditAmount = 0;
                        }
                        row.expense = Int64.Parse(dataReader1["Expense"].ToString());
                        if (Int64.Parse(dataReader1["edit"].ToString()) > 0)
                        {
                            row.Percent = (_uw.Budget_001Rep.Division(Int64.Parse(dataReader1["expense"].ToString()), Int64.Parse(dataReader1["edit"].ToString())));
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
        public async Task<ApiResult<List<ChartAreaViewModel>>> DetailChartApi(int yearId, int centerId, int budgetProcessId, int StructureId, int? codingId = null)
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
                        row.EditCurrent = long.Parse(dataReader["EditCurrent"].ToString());
                        row.CreditAmountCurrent = long.Parse(dataReader["CreditAmountCurrent"].ToString());
                        if (row.EditCurrent != 0)
                        {
                            row.PercentCreditAmountCurrent = _uw.Budget_001Rep.Division(row.CreditAmountCurrent, row.EditCurrent);
                        }
                        else
                        {
                            row.PercentCreditAmountCurrent = 0;
                        }

                        row.ExpenseCurrent = long.Parse(dataReader["ExpenseCurrent"].ToString());
                        
                        if (row.EditCurrent != 0)
                        {
                            row.PercentCurrent = _uw.Budget_001Rep.Division(row.ExpenseCurrent, row.EditCurrent);
                        }
                        else
                        {
                            row.PercentCurrent = 0;
                        }


                        row.MosavabCivil = long.Parse(dataReader["MosavabCivil"].ToString());
                        row.EditCivil = long.Parse(dataReader["EditCivil"].ToString());
                        row.CreditAmountCivil = long.Parse(dataReader["CreditAmountCivil"].ToString());
                        if (row.EditCivil != 0)
                        {
                            row.PercentCreditAmountCivil = _uw.Budget_001Rep.Division(row.CreditAmountCivil, row.EditCivil);
                        }
                        else
                        {
                            row.PercentCreditAmountCivil = 0;
                        }

                        row.ExpenseCivil = long.Parse(dataReader["ExpenseCivil"].ToString());
   
                        if (row.EditCivil != 0)
                        {
                            row.PercentCivil = _uw.Budget_001Rep.Division(row.ExpenseCivil, row.EditCivil);
                        }
                        else
                        { row.PercentCivil = 0; }


                        if (row.EditCurrent + row.EditCivil != 0)
                        {
                            row.PercentTotal = _uw.Budget_001Rep.Division(row.ExpenseCivil + row.ExpenseCurrent, row.EditCivil + row.EditCurrent);
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
                        row.EditCurrent = long.Parse(dataReader["EditCurrent"].ToString());
                        row.CreditAmountCurrent = long.Parse(dataReader["CreditAmountCurrent"].ToString());
                        if (row.EditCurrent != 0)
                        {
                            row.PercentCreditAmountCurrent = _uw.Budget_001Rep.Division(row.CreditAmountCurrent, row.EditCurrent);
                        }
                        else
                        {
                            row.PercentCreditAmountCurrent = 0;
                        }
                        row.ExpenseCurrent = long.Parse(dataReader["ExpenseCurrent"].ToString());
                        if (row.EditCurrent != 0)
                        {
                            row.PercentCurrent = _uw.Budget_001Rep.Division(row.ExpenseCurrent, row.EditCurrent);
                        }
                        else
                        {
                            row.PercentCurrent = 0;
                        }

                        row.MosavabCivil = long.Parse(dataReader["MosavabCivil"].ToString());
                        row.EditCivil = long.Parse(dataReader["EditCivil"].ToString());
                        row.CreditAmountCivil = long.Parse(dataReader["CreditAmountCivil"].ToString());
                        if (row.EditCivil != 0)
                        {
                            row.PercentCreditAmountCivil = _uw.Budget_001Rep.Division(row.CreditAmountCivil, row.EditCivil);
                        }
                        else
                        {
                            row.PercentCreditAmountCivil = 0;
                        }

                        row.ExpenseCivil = long.Parse(dataReader["ExpenseCivil"].ToString());

                        if (row.EditCivil != 0)
                        {
                            row.PercentCivil = _uw.Budget_001Rep.Division(row.ExpenseCivil, row.EditCivil);
                        }
                        else
                        {
                            row.PercentCivil = 0;
                        }

                        if (row.EditCurrent + row.EditCivil != 0)
                        {
                            row.PercentTotal = _uw.Budget_001Rep.Division(row.ExpenseCurrent + row.ExpenseCivil, row.EditCurrent + row.EditCivil);
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
                        ProctorAreaBudgetViewModel row = new ProctorAreaBudgetViewModel();
                        row.Code = dataReader["Code"].ToString();
                        row.Description = dataReader["Description"].ToString();
                        row.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        row.Edit = Int64.Parse(dataReader["Edit"].ToString());
                        row.Supply = Int64.Parse(dataReader["Supply"].ToString());
                        if (row.Edit != 0)
                        {
                            row.PercentSupply = _uw.Budget_001Rep.Division(row.Supply, row.Edit);
                        }
                        else
                        {
                            row.PercentSupply = 0;
                        }

                        row.Expense = Int64.Parse(dataReader["Expense"].ToString());

                        if (row.Edit != 0)
                        {
                            row.Percent = _uw.Budget_001Rep.Division(row.Expense, row.Edit);
                        }
                        else
                        {
                            row.Percent = 0;
                        }
                        fecthViewModel.Add(row);
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
        public async Task<ApiResult<List<AbstractViewModel>>> GetAbstractList(int yearId,string type)
        {
            List<AbstractViewModel> abslist = new List<AbstractViewModel>();

            using (SqlConnection sqlConnection = new SqlConnection(_configuration.GetConnectionString("SqlErp"))){
                using (SqlCommand cmd = new SqlCommand("SP500_Abstract", sqlConnection))
                {
                    sqlConnection.Open();
                    cmd.Parameters.AddWithValue("yearId", yearId);
                    cmd.Parameters.AddWithValue("type", type);
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
                        fetchView.MosavabHagholamal = long.Parse(dataReader["MosavabHagholamal"].ToString());
                        fetchView.MosavabFinancial = long.Parse(dataReader["MosavabFinancial"].ToString());
                        fetchView.MosavabPayMotomarkez = long.Parse(dataReader["MosavabPayMotomarkez"].ToString());
                        fetchView.MosavabSanavati = long.Parse(dataReader["MosavabSanavati"].ToString());
                        fetchView.balanceMosavab = long.Parse(dataReader["balanceMosavab"].ToString());
                        fetchView.Resoures = long.Parse(dataReader["Resoures"].ToString());
                        fetchView.Costs = long.Parse(dataReader["Costs"].ToString());
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
            List<ProjectReportScaleViewModel> data = new List<ProjectReportScaleViewModel>();
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
                            ProjectReportScaleViewModel row = new ProjectReportScaleViewModel();
                            row.ProjectId = int.Parse(dataReader["ProjectId"].ToString());
                            row.AreaId = int.Parse(dataReader["AreaId"].ToString());
                            row.AreaName = dataReader["AreaName"].ToString();
                            row.ProjectCode = dataReader["ProjectCode"].ToString();
                            row.ProjectName = dataReader["ProjectName"].ToString();
                            row.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                            row.Edit = Int64.Parse(dataReader["Edit"].ToString());
                            row.Supply = Int64.Parse(dataReader["Supply"].ToString());
                            row.Expense = Int64.Parse(dataReader["Expense"].ToString());
                            row.BudgetNext = Int64.Parse(dataReader["BudgetNext"].ToString());
                           data.Add(row);
                        }
                    }
                }
            }
            return Ok(data);
        }

        [Route("ProjectReportScaleBudgetModal")]
        [HttpGet]
        public async Task<ApiResult<List<ProjectReportScaleBudgetViewModel>>> AC_ProjectReportScaleBudgetModal(int yearId, int areaId, int scaleId)
        {
            List<ProjectReportScaleBudgetViewModel> data = new List<ProjectReportScaleBudgetViewModel>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP005_Report_ProjectScaleBudgetModal_Read", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("YearId", yearId);
                        sqlCommand.Parameters.AddWithValue("AreaId", areaId);
                        sqlCommand.Parameters.AddWithValue("ScaleId", scaleId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            ProjectReportScaleBudgetViewModel row = new ProjectReportScaleBudgetViewModel();
                            row.Code = dataReader["Code"].ToString();
                            row.Description = dataReader["Description"].ToString();
                            row.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                            row.Edit = Int64.Parse(dataReader["Edit"].ToString());
                            row.Supply = Int64.Parse(dataReader["Supply"].ToString());
                            row.Expense = Int64.Parse(dataReader["Expense"].ToString());
                            data.Add(row);
                        }
                    }
                }
            }
            return Ok(data);
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
                    sqlCommand.CommandTimeout = 500;
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


        [Route("RequestAnalyzeRead")]
        [HttpGet]
        public async Task<ApiResult<List<RequestAnalyzeViewModel>>> AC_RequestAnalyzeRead(RequestAnalyzeParam param)
        {
            List<RequestAnalyzeViewModel> data = new List<RequestAnalyzeViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP500_Request_Analyze", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("AreaId", param.AreaId);
                    sqlCommand.Parameters.AddWithValue("KindId", param.KindId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        RequestAnalyzeViewModel row = new RequestAnalyzeViewModel();
                        row.RequestRef = int.Parse(dataReader["RequestRef"].ToString());
                        row.ConfirmDocNo = dataReader["ConfirmDocNo"].ToString();
                        row.ConfirmDocDate = dataReader["ConfirmDocDate"].ToString();
                        row.RequestRefStr = dataReader["RequestRefStr"].ToString();
                        row.RequestDate = dataReader["RequestDate"].ToString();
                        row.ReqDesc = dataReader["ReqDesc"].ToString();
                        row.RequestPrice = Int64.Parse(dataReader["RequestPrice"].ToString());
                        row.CnfirmedPrice = Int64.Parse(dataReader["CnfirmedPrice"].ToString());
                        row.Diff = Int64.Parse(dataReader["Diff"].ToString());
                        row.SectionId = int.Parse(dataReader["SectionId"].ToString());
                        data.Add(row);
                    }
                }
            }
            return Ok(data);
        }


        [Route("ComparErpAndTaminRead")]
        [HttpGet]
        public async Task<ApiResult<List<ComparErpAndTaminViewModel>>> AC_ComparErpAndTaminRead(param100 param)
        {
            List<ComparErpAndTaminViewModel> dataModel = new List<ComparErpAndTaminViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP500_ComparErpAndTaminRead", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandTimeout = 500;
                    sqlCommand.Parameters.AddWithValue("yearId", param.YearId);
                    sqlCommand.Parameters.AddWithValue("areaId", param.AreaId);
                    sqlCommand.Parameters.AddWithValue("BudgetProcessId", param.BudgetProcessId);
                    sqlCommand.Parameters.AddWithValue("Number", param.Number);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        ComparErpAndTaminViewModel row = new ComparErpAndTaminViewModel();
                        row.AreaId = int.Parse(dataReader["AreaId"].ToString());
                        row.Code = dataReader["Code"].ToString();
                        row.Description = dataReader["Description"].ToString();
                        row.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        row.Edit = Int64.Parse(dataReader["Edit"].ToString());
                        row.Supply = Int64.Parse(dataReader["Supply"].ToString());
                        row.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        row.Total_Res = Int64.Parse(dataReader["Total_Res"].ToString());
                        row.Diff = Int64.Parse(dataReader["Diff"].ToString());

                        dataModel.Add(row);
                    }

                }
            }
            return Ok(dataModel);
        }
        
        //-------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------
        
        
        
        [Route("BudgetBookExport")]
        [HttpGet]
        public async Task<ApiResult<object>> AC_BudgetBookExport(BudgetBookInputs param){
            await using SqlConnection sqlConnect = new SqlConnection(_configuration.GetConnectionString("SqlErp"));
            sqlConnect.Open();
        
            var workbook = GetExcelFile();
            
            // sheet1
            Sheet1Data sheet1Data=await GetDataSheet1(sqlConnect,param);
            workbook = WriteSheet1(workbook,sheet1Data,param.YearId);

             
            // sheet3
            Sheet3Data sheet3Data=await GetDataSheet3(sqlConnect,param);
            workbook = WriteSheet3(workbook,sheet3Data);

            // sheet6
            Sheet3Data sheet6Data=await GetDataSheet6(sqlConnect,param);
            workbook = WriteSheet6(workbook,sheet6Data);

            
            var finalFilePath = CreateFinalFile(workbook);
            return Ok(finalFilePath);
        }



        // ------------------------------------------ sheet 1  ------------------------------------------------------------------------------------------------------------------------

        private static async Task<Sheet1Data> GetDataSheet1(SqlConnection sqlconnect , BudgetBookInputs param){
            await using SqlCommand sqlCommand = new SqlCommand("SP500_BudgetBook", sqlconnect);
            sqlCommand.CommandTimeout = 500;
            sqlCommand.Parameters.AddWithValue("yearId", param.YearId);
            sqlCommand.Parameters.AddWithValue("areaId", param.AreaId);
            sqlCommand.CommandType = CommandType.StoredProcedure;
            SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
            Sheet1Data data1 = new Sheet1Data();
            while (dataReader.Read()){
                data1.M_Resources = Int64.Parse(dataReader["M_Resources"].ToString());
                data1.M_Khazane = Int64.Parse(dataReader["M_Khazane"].ToString());
                data1.M_Costs = Int64.Parse(dataReader["M_Costs"].ToString());
                data1.P_Resources = Int64.Parse(dataReader["P_Resources"].ToString());
                data1.P_Khazane = Int64.Parse(dataReader["P_Khazane"].ToString());
                data1.P_Costs = Int64.Parse(dataReader["P_Costs"].ToString());
            }
            await dataReader.CloseAsync();

            
            string[] codings ={ "110000", "120000", "130000", "140000", "150000", "160000", "100000", "200000", "300000" };
            ReportCoding dataReportCodings = await GetCodingsAmount(sqlconnect, codings, param.YearId, param.AreaId, 1);
            
            data1.ReportCodings = dataReportCodings;

            return data1;
        }
        
        
        private IWorkbook WriteSheet1( IWorkbook workbook, Sheet1Data data,int yearId){
            ISheet sheet = workbook.GetSheetAt(0);

            SetCell(sheet,"C8", GetAmount(data.ReportCodings,"p","110000"));
            SetCell(sheet,"D8", GetAmount(data.ReportCodings,"m","110000"));
            SetCell(sheet,"C9", GetAmount(data.ReportCodings,"p","120000"));
            SetCell(sheet,"D9", GetAmount(data.ReportCodings,"m","120000"));
            SetCell(sheet,"C10", GetAmount(data.ReportCodings,"p","130000"));
            SetCell(sheet,"D10", GetAmount(data.ReportCodings,"m","130000"));
            SetCell(sheet,"C11", GetAmount(data.ReportCodings,"p","140000"));
            SetCell(sheet,"D11", GetAmount(data.ReportCodings,"m","140000"));
            SetCell(sheet,"C12", GetAmount(data.ReportCodings,"p","150000"));
            SetCell(sheet,"D12", GetAmount(data.ReportCodings,"m","150000"));
            SetCell(sheet,"C13", GetAmount(data.ReportCodings,"p","160000"));
            SetCell(sheet,"D13", GetAmount(data.ReportCodings,"m","160000"));
            SetCell(sheet,"C14", GetAmount(data.ReportCodings,"p","100000"));
            SetCell(sheet,"D14", GetAmount(data.ReportCodings,"m","100000"));
            SetCell(sheet,"C15", GetAmount(data.ReportCodings,"p","200000"));
            SetCell(sheet,"D15", GetAmount(data.ReportCodings,"m","200000"));
            SetCell(sheet,"C16", GetAmount(data.ReportCodings,"p","300000"));
            SetCell(sheet,"D16", GetAmount(data.ReportCodings,"m","300000"));
            
            
            SetCell(sheet,"C19", data.P_Resources);
            SetCell(sheet,"D19", data.M_Resources);
            SetCell(sheet,"H19", data.P_Costs);
            SetCell(sheet,"I19", data.M_Costs);
            
            SetCell(sheet,"C21", data.P_Khazane);
            SetCell(sheet,"D21", data.M_Khazane);
            SetCell(sheet,"H21", data.P_Khazane);
            SetCell(sheet,"I21", data.M_Khazane);


            var year = yearId + 1369;
            SetCell(sheet,"A25", year);
            SetCell(sheet,"A26", year-1);
            SetCell(sheet,"A27", year-2);
            

            return workbook;
        }

        
        // ------------------------------------------ sheet 3  ------------------------------------------------------------------------------------------------------------------------

        private static async Task<Sheet3Data> GetDataSheet3(SqlConnection sqlconnect , BudgetBookInputs param){
            await using SqlCommand sqlCommand = new SqlCommand("SP004_BudgetBook_List", sqlconnect);
            sqlCommand.CommandTimeout = 500;
            sqlCommand.Parameters.AddWithValue("yearId", param.YearId);
            sqlCommand.Parameters.AddWithValue("areaId", param.AreaId);
            sqlCommand.Parameters.AddWithValue("budgetProcessId", 1);
            sqlCommand.CommandType = CommandType.StoredProcedure;
            SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
            Sheet3Data datas = new Sheet3Data();
            datas.dataList = new List<Sheet3DataSingle>();
            while (dataReader.Read()){

                var data1 = new Sheet3DataSingle();
                
                data1.CodingId =dataReader["CodingId"].ToString();
                data1.Code =dataReader["Code"].ToString();
                data1.Description =dataReader["Description"].ToString();
                data1.MosavabLastYear = Int64.Parse(dataReader["MosavabLastYear"].ToString());
                data1.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                data1.Edit = Int64.Parse(dataReader["Edit"].ToString());
                data1.CreditAmount = Int64.Parse(dataReader["CreditAmount"].ToString());
                data1.Expense = Int64.Parse(dataReader["Expense"].ToString());
                data1.PishnahadiCash = Int64.Parse(dataReader["PishnahadiCash"].ToString());
                data1.PishnahadiNonCash = Int64.Parse(dataReader["PishnahadiNonCash"].ToString());
                data1.Pishnahadi = Int64.Parse(dataReader["Pishnahadi"].ToString());
                data1.levelNumber = int.Parse(dataReader["levelNumber"].ToString());
                // data1.Crud = int.Parse(dataReader["Crud"].ToString());
                data1.ConfirmStatus = int.Parse(dataReader["ConfirmStatus"].ToString());
                data1.isNewYear = int.Parse(dataReader["isNewYear"].ToString());
                datas.dataList.Add(data1);
            }
            await dataReader.CloseAsync();

            

            return datas;
        }
        
        
        private IWorkbook WriteSheet3( IWorkbook workbook, Sheet3Data data){
            ISheet sheet = workbook.GetSheetAt(2);

            var rowIndex = 7;
            

            Int64 SumMosavabLastYear=0;
            Int64 SumLast3Month=0;
            Int64 SumLast9Month=0;
            Int64 SumPishnahadi=0;
            Int64 SumMosavab=0;
            
            XSSFColor redColor = new XSSFColor(Color.FromArgb(244, 176, 132));
            XSSFColor greenColor = new XSSFColor(Color.FromArgb(198, 224, 180));
            XSSFColor blueColor = new XSSFColor(Color.FromArgb(180, 198, 231));
            XSSFColor yellowColor = new XSSFColor(Color.FromArgb(255, 255, 153));
            for (int i =0;i<data.dataList.Count;i++){

                if (data.dataList[i].levelNumber >4 )
                    continue;

                ICellStyle style = GetBaseStyle(workbook);
                

                if (data.dataList[i].levelNumber == 1) {
                    ((XSSFCellStyle)style).SetFillForegroundColor(redColor);
                    style.FillPattern = FillPattern.SolidForeground;
                } else if (data.dataList[i].levelNumber == 2) {
                    ((XSSFCellStyle)style).SetFillForegroundColor(greenColor);
                    style.FillPattern = FillPattern.SolidForeground;
                } else if (data.dataList[i].levelNumber == 3) {
                    ((XSSFCellStyle)style).SetFillForegroundColor(blueColor);
                    style.FillPattern = FillPattern.SolidForeground;
                } else if (data.dataList[i].levelNumber == 4) {
                    ((XSSFCellStyle)style).SetFillForegroundColor(yellowColor);
                    style.FillPattern = FillPattern.SolidForeground;
                }
                
                SetCell(sheet,"A"+rowIndex,data.dataList[i].Code,style);
                SetCell(sheet,"B"+rowIndex,data.dataList[i].Description,style);
                SetCell(sheet,"C"+rowIndex,0,style);
                SetCell(sheet,"D"+rowIndex,data.dataList[i].MosavabLastYear/1000,style);
                SetCell(sheet,"E"+rowIndex,0,style);
                SetCell(sheet,"F"+rowIndex,data.dataList[i].Last3Month/1000,style);
                SetCell(sheet,"G"+rowIndex,data.dataList[i].Last9Month/1000,style);
                SetCell(sheet,"H"+rowIndex,data.dataList[i].Last3Month/1000+data.dataList[i].Last9Month/1000,style);
                SetCell(sheet,"I"+rowIndex,data.dataList[i].Pishnahadi/1000,style);
                SetCell(sheet,"J"+rowIndex,data.dataList[i].Mosavab/1000,style);

                if (data.dataList[i].levelNumber == 1){
                    SumMosavabLastYear += data.dataList[i].MosavabLastYear / 1000;
                    SumLast3Month += data.dataList[i].Last3Month / 1000;
                    SumLast9Month += data.dataList[i].Last9Month / 1000;
                    SumPishnahadi += data.dataList[i].Pishnahadi / 1000;
                    SumMosavab += data.dataList[i].Mosavab / 1000;
                    
                }

                rowIndex++;
            }



            // Helpers.dd(rowIndex);
            CellRangeAddress mergeRegion = new CellRangeAddress(rowIndex-1, rowIndex-1, 0, 1);
            sheet.AddMergedRegion(mergeRegion);

            ICellStyle styleSum = GetBaseStyle(workbook);
            ((XSSFCellStyle)styleSum).SetFillForegroundColor(blueColor);
            styleSum.FillPattern = FillPattern.SolidForeground;
            
            SetCell(sheet,"A"+rowIndex,"جمع کل",styleSum);
            SetCell(sheet,"C"+rowIndex,0,styleSum);
            SetCell(sheet,"D"+rowIndex,SumMosavabLastYear,styleSum);
            SetCell(sheet,"E"+rowIndex,0,styleSum);
            SetCell(sheet,"F"+rowIndex,SumLast3Month,styleSum);
            SetCell(sheet,"G"+rowIndex,SumLast9Month,styleSum);
            SetCell(sheet,"H"+rowIndex,SumLast3Month+SumLast9Month,styleSum);
            SetCell(sheet,"I"+rowIndex,SumPishnahadi,styleSum);
            SetCell(sheet,"J"+rowIndex,SumMosavab,styleSum);

            return workbook;
        }

        
        // ------------------------------------------ sheet 6  ------------------------------------------------------------------------------------------------------------------------

        private static async Task<Sheet3Data> GetDataSheet6(SqlConnection sqlconnect , BudgetBookInputs param){
            await using SqlCommand sqlCommand = new SqlCommand("SP004_BudgetBook_List", sqlconnect);
            sqlCommand.CommandTimeout = 500;
            sqlCommand.Parameters.AddWithValue("yearId", param.YearId);
            sqlCommand.Parameters.AddWithValue("areaId", param.AreaId);
            sqlCommand.Parameters.AddWithValue("budgetProcessId", 2);
            sqlCommand.CommandType = CommandType.StoredProcedure;
            SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
            Sheet3Data datas = new Sheet3Data();
            datas.dataList = new List<Sheet3DataSingle>();
            while (dataReader.Read()){

                var data1 = new Sheet3DataSingle();
                
                data1.CodingId =dataReader["CodingId"].ToString();
                data1.Code =dataReader["Code"].ToString();
                data1.Description =dataReader["Description"].ToString();
                data1.MosavabLastYear = Int64.Parse(dataReader["MosavabLastYear"].ToString());
                data1.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                data1.Edit = Int64.Parse(dataReader["Edit"].ToString());
                data1.CreditAmount = Int64.Parse(dataReader["CreditAmount"].ToString());
                data1.Expense = Int64.Parse(dataReader["Expense"].ToString());
                data1.PishnahadiCash = Int64.Parse(dataReader["PishnahadiCash"].ToString());
                data1.PishnahadiNonCash = Int64.Parse(dataReader["PishnahadiNonCash"].ToString());
                data1.Pishnahadi = Int64.Parse(dataReader["Pishnahadi"].ToString());
                data1.levelNumber = int.Parse(dataReader["levelNumber"].ToString());
                // data1.Crud = int.Parse(dataReader["Crud"].ToString());
                data1.ConfirmStatus = int.Parse(dataReader["ConfirmStatus"].ToString());
                data1.isNewYear = int.Parse(dataReader["isNewYear"].ToString());
                datas.dataList.Add(data1);
            }
            await dataReader.CloseAsync();

            

            return datas;
        }
        
        
        private IWorkbook WriteSheet6( IWorkbook workbook, Sheet3Data data){
            ISheet sheet = workbook.GetSheetAt(5);

            var rowIndex = 6;
            

            Int64 SumMosavabLastYear=0;
            Int64 SumPishnahadi=0;
            Int64 SumMosavab=0;
            
            XSSFColor greenColor = new XSSFColor(Color.FromArgb(198, 224, 180));
            XSSFColor redColor2 = new XSSFColor(Color.FromArgb(252, 228, 214));
            XSSFColor yellowColor = new XSSFColor(Color.FromArgb(255, 255, 153));
            XSSFColor blueColor = new XSSFColor(Color.FromArgb(180, 198, 231));
            for (int i =0;i<data.dataList.Count;i++){

                if (data.dataList[i].levelNumber >3 )
                    continue;

                ICellStyle style = GetBaseStyle(workbook);
                

                if (data.dataList[i].levelNumber == 1) {
                    ((XSSFCellStyle)style).SetFillForegroundColor(greenColor);
                    style.FillPattern = FillPattern.SolidForeground;
                } else if (data.dataList[i].levelNumber == 2) {
                    ((XSSFCellStyle)style).SetFillForegroundColor(redColor2);
                    style.FillPattern = FillPattern.SolidForeground;
                } else if (data.dataList[i].levelNumber == 3) {
                    ((XSSFCellStyle)style).SetFillForegroundColor(yellowColor);
                    style.FillPattern = FillPattern.SolidForeground;
                }
                
                SetCell(sheet,"A"+rowIndex,data.dataList[i].Code,style);
                SetCell(sheet,"B"+rowIndex,data.dataList[i].Description,style);
                SetCell(sheet,"C"+rowIndex,0,style);
                SetCell(sheet,"D"+rowIndex,data.dataList[i].MosavabLastYear/1000,style);
                SetCell(sheet,"E"+rowIndex,data.dataList[i].Pishnahadi/1000,style);
                SetCell(sheet,"F"+rowIndex,data.dataList[i].Mosavab/1000,style);

                if (data.dataList[i].levelNumber == 1){
                    SumMosavabLastYear += data.dataList[i].MosavabLastYear / 1000;
                    SumPishnahadi += data.dataList[i].Pishnahadi / 1000;
                    SumMosavab += data.dataList[i].Mosavab / 1000;
                    
                }

                rowIndex++;
            }



            // Helpers.dd(rowIndex);
            CellRangeAddress mergeRegion = new CellRangeAddress(rowIndex-1, rowIndex-1, 0, 1);
            sheet.AddMergedRegion(mergeRegion);

            
            ICellStyle styleSum = GetBaseStyle(workbook);
            ((XSSFCellStyle)styleSum).SetFillForegroundColor(blueColor);
            styleSum.FillPattern = FillPattern.SolidForeground;
            
            SetCell(sheet,"A"+rowIndex,"جمع کل",styleSum);
            SetCell(sheet,"C"+rowIndex,0,styleSum);
            SetCell(sheet,"D"+rowIndex,SumMosavabLastYear,styleSum);
            SetCell(sheet,"E"+rowIndex,SumPishnahadi,styleSum);
            SetCell(sheet,"F"+rowIndex,SumMosavab,styleSum);

            return workbook;
        }

        //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        //------------------------------------------------------------------------- Data Functions --------------------------------------------------------------------------------------------
        //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


        private static async Task<ReportCoding> GetCodingsAmount(SqlConnection sqlconnect, string[] codings, int yearId, int areaId, int budgetProcessId){
            var dataCoding = new ReportCoding();
            dataCoding.CodeAmounts = new List<CodingAmount>();
            
            await using SqlCommand sqlCommand = new SqlCommand("SP500_BudgetBook_Codings", sqlconnect);
            sqlCommand.CommandTimeout = 500;
            sqlCommand.Parameters.AddWithValue("yearId", yearId);
            sqlCommand.Parameters.AddWithValue("areaId", areaId);
            sqlCommand.Parameters.AddWithValue("budgetProcessId", budgetProcessId);
            sqlCommand.Parameters.AddWithValue("codings", string.Join(",", codings)); // Send codings as a comma-separated string
            sqlCommand.CommandType = CommandType.StoredProcedure;
            // Helpers.dd(string.Join(",", codings));

            await using SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
            while (await dataReader.ReadAsync()){
                var codingAmount = new CodingAmount{
                    Code = dataReader["Code"].ToString(),
                    Pishnahadi = Int64.Parse(dataReader["Pishnahadi"].ToString()),
                    Mosavab = Int64.Parse(dataReader["Mosavab"].ToString())
                };
                dataCoding.CodeAmounts.Add(codingAmount);
            }

            await dataReader.CloseAsync();

            return dataCoding;
        }


        public static Int64 GetAmount(ReportCoding dataReportCodings, string property, string code){
            var codingAmount = dataReportCodings.CodeAmounts.FirstOrDefault(c => c.Code == code);

            if (codingAmount == null){
                return 0; // Return 0 if no matching code is found
            }

            // Use reflection to access the specified property dynamically
            if (property.ToLower() == "p"){
                return codingAmount.Pishnahadi;
            }
            else if (property.ToLower() == "m"){
                return codingAmount.Mosavab;
            }

            return 0; // Return 0 if an invalid property is specified
        }

        
        
        //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        //------------------------------------------------------------------------- Excel functions --------------------------------------------------------------------------------------------
        //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        
        
        
         private static IWorkbook GetExcelFile()
        {
            string templatePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/excel_templates/budget_book.xlsx");
            using (FileStream file = new FileStream(templatePath, FileMode.Open, FileAccess.Read))
            {
                return new XSSFWorkbook(file); // Read the file into memory
            }
        }

        
         private static void SetCell(ISheet sheet , string cellReference, object value,ICellStyle style=null){
            var cellCoordinates = ParseCellReference(cellReference);
            int rowIndex = cellCoordinates.Item1;
            int colIndex = cellCoordinates.Item2;

            IRow row = sheet.GetRow(rowIndex) ?? sheet.CreateRow(rowIndex);
            ICell cell = row.GetCell(colIndex) ?? row.CreateCell(colIndex);
            
            switch (value)
            {
                case double numericValue:
                    cell.SetCellType(CellType.Numeric);
                    cell.SetCellValue(numericValue);
                    break;

                case int intValue:
                    cell.SetCellType(CellType.Numeric);
                    cell.SetCellValue(intValue);
                    break;

                case Int64 int64Value:
                    cell.SetCellType(CellType.Numeric);
                    cell.SetCellValue(int64Value);
                    break;

                case string stringValue:
                    cell.SetCellType(CellType.String);
                    cell.SetCellValue(stringValue);
                    break;

                case DateTime dateValue:
                    cell.SetCellType(CellType.Numeric);
                    cell.SetCellValue(dateValue); // Automatically applies Excel's date format
                    break;

                case null:
                    cell.SetCellType(CellType.Blank);
                    break;

            }

            cell.CellStyle = style;

         }

        private static (int, int) ParseCellReference(string cellReference){
            // Example: "B5" -> (4, 1)  (Row 5, Column B)

            // Split the cell reference into column letter and row number
            string columnLetter = new string(cellReference.TakeWhile(char.IsLetter).ToArray());
            string rowNumber = new string(cellReference.SkipWhile(char.IsLetter).ToArray());

            // Convert column letter to column index (0-based)
            int columnIndex = GetColumnIndexFromLetter(columnLetter);

            // Convert row number to 0-based index
            int rowIndex = int.Parse(rowNumber) - 1;

            return (rowIndex, columnIndex);
        }

        private static int GetColumnIndexFromLetter(string columnLetter){
            int columnIndex = 0;
            int length = columnLetter.Length;

            for (int i = 0; i < length; i++){
                columnIndex += (columnLetter[i] - 'A' + 1) * (int)Math.Pow(26, length - i - 1);
            }

            return columnIndex - 1; // Convert to 0-based index
        }
        
        
        
        
        private static string CreateFinalFile(IWorkbook workbook){

            // Recalculate formulas
            RecalculateFormulas(workbook);
            
            // Save the file to a temporary location
            string tmpPath = "/tmp/"+$"book1403_{DateTimeOffset.Now.ToUnixTimeMilliseconds()}.xlsx";
            string tempFilePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot"+tmpPath);
    
            using (FileStream outputFile = new FileStream(tempFilePath, FileMode.Create, FileAccess.Write)){
                workbook.Write(outputFile); // Write to the file
            }
            workbook.Close();
        
            return tmpPath; // Return the path to the saved file
        }


        private static void RecalculateFormulas(IWorkbook workbook){
            // Get the formula evaluator for the workbook
            IFormulaEvaluator evaluator = workbook.GetCreationHelper().CreateFormulaEvaluator();

            // Iterate through all sheets in the workbook
            for (int i = 0; i < workbook.NumberOfSheets; i++){
                ISheet sheet = workbook.GetSheetAt(i);
                // Iterate through all rows in the sheet
                for (int rowIndex = sheet.FirstRowNum; rowIndex <= sheet.LastRowNum; rowIndex++){
                    IRow row = sheet.GetRow(rowIndex);
                    if (row == null) continue;

                    // Iterate through all cells in the row
                    for (int cellIndex = row.FirstCellNum; cellIndex < row.LastCellNum; cellIndex++){
                        ICell cell = row.GetCell(cellIndex);
                        if (cell == null) continue;

                        // Recalculate if the cell contains a formula
                        if (cell.CellType == CellType.Formula){
                            evaluator.EvaluateFormulaCell(cell);
                        }
                    }
                }
            }
        }
        
        
        private ICellStyle GetBaseStyle(IWorkbook workbook){
            ICellStyle style = workbook.CreateCellStyle();
            // aligment
            style.Alignment = HorizontalAlignment.Center;
            style.VerticalAlignment = VerticalAlignment.Center;
            
            // format number
            IDataFormat format = workbook.CreateDataFormat();
            style.DataFormat = format.GetFormat("#,##0");
            
            // font
            IFont font = workbook.CreateFont();
            font.FontName = "B Titr";
            font.FontHeightInPoints = 10;
            style.SetFont(font);
            
            return style;
        }
        
    }
}
