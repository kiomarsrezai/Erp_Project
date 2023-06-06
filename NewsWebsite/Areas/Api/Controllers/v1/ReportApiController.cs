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
using NewsWebsite.ViewModels.Api.Budget.BudgetSeprator;
using NewsWebsite.Common;
using NewsWebsite.ViewModels.Api.Abstract;
using NewsWebsite.ViewModels.Api.Budget.BudgetProject;
using NewsWebsite.ViewModels.Api.Chart;

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

        [Route("BudgetShare")]
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
                    sqlCommand1.Parameters.AddWithValue("yearId", yearId);
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
                        //row.BudgetProcessId = int.Parse(dataReader["BudgetProcessId"].ToString());
                        row.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        row.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        row.MosavabDaily = Int64.Parse(dataReader["MosavabDaily"].ToString());
                        row.NotGet = Int64.Parse(dataReader["NotGet"].ToString());

                        //row.YearId = int.Parse(dataReader["YearId"].ToString());
                        if (double.Parse(dataReader["Mosavab"].ToString()) > 0)
                        {
                            row.PercentMosavab = _uw.Budget_001Rep.Divivasion(double.Parse(dataReader["Expense"].ToString()), double.Parse(dataReader["Mosavab"].ToString()));
                        }
                        else
                        {
                            row.PercentMosavab = 0;
                        }
                        if (double.Parse(dataReader["MosavabDaily"].ToString()) > 0)
                        {
                            row.PercentMosavabDaily = _uw.Budget_001Rep.Divivasion(double.Parse(dataReader["Expense"].ToString()), double.Parse(dataReader["MosavabDaily"].ToString()));
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

        [Route("AllDeputy")]
        [HttpGet]
        public async Task<IActionResult> GetAllDeputy(int yearId, int proctorId, int areaId, int budgetprocessId)
        {
            return Ok(await _uw.DeputyRepository.GetAllDeputiesAsync(yearId, proctorId, areaId, budgetprocessId));
        }

        [Route("ProctorAreaBudget")]
        [HttpGet]
        public async Task<IActionResult> ProctorAreaBudget(int id)
        {
            return Ok(await _uw.DeputyRepository.ProctorAreaAsync(id));
        }

        [Route("ProctorList")]
        [HttpGet]
        public async Task<IActionResult> ProctorList()
        {
            return Ok(await _uw.DeputyRepository.ProctorListAsync());
        }

        [Route("ProctorAreaBudgetDetail")]
        [HttpGet]
        public async Task<ApiResult<List<ProctorAreaBudgetViewModel>>> ProctorAreaBudgetDetail(int yearId, int proctorId, int areaId, int budgetProcessId)
        {
            if (yearId == 0 | areaId == 0 | proctorId == 0)
            {
                return BadRequest("با خطا مواجه شدید");
            }
            List<ProctorAreaBudgetViewModel> fecthViewModel = new List<ProctorAreaBudgetViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP501_Proctor", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", yearId);
                    sqlCommand.Parameters.AddWithValue("ProctorId", proctorId);
                    sqlCommand.Parameters.AddWithValue("AreaId", areaId);
                    sqlCommand.Parameters.AddWithValue("BudgetProcessId", budgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        ProctorAreaBudgetViewModel fetchView = new ProctorAreaBudgetViewModel();
                        fetchView.Code = dataReader["Code"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        fetchView.Expense = Int64.Parse(dataReader["Expense"].ToString());

                        if (fetchView.Percent != 0)
                        {
                            fetchView.Percent = _uw.Budget_001Rep.Divivasion(fetchView.Expense, fetchView.Mosavab);
                        }
                        else
                        {
                            fetchView.Percent = 0;
                        }

                        fecthViewModel.Add(fetchView);

                        //dataReader.NextResult();
                    }
                    //TempData["budgetSeprator"] = fecthViewModel;
                }
            }
            return Ok(fecthViewModel);
        }

        [Route("AbstractList")]
        [HttpGet]
        public async Task<ApiResult<List<AbstractViewModel>>> GetAbstractList(int yearId, int KindId, int StructureId)
        {
            List<AbstractViewModel> abslist = new List<AbstractViewModel>();

            using (SqlConnection sqlConnection = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand cmd = new SqlCommand("SP500_Abstract", sqlConnection))
                {
                    sqlConnection.Open();
                    cmd.Parameters.AddWithValue("yearId", yearId);
                    cmd.Parameters.AddWithValue("KindId", KindId);
                    cmd.Parameters.AddWithValue("StructureId", StructureId);
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
    }
}
