using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.BudgetSeprator;
using NewsWebsite.ViewModels.Api.UsersApi;
using NewsWebsite.ViewModels.Fetch;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory.Database;

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
                using (SqlCommand sqlCommand = new SqlCommand("SP002_BudgetSepratorArea_TaminModal", sqlconnect))
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
                using (SqlCommand sqlCommand = new SqlCommand("SP002_BudgetSepratorArea_TaminModal_2", sqlconnect))
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
        public async Task<ApiResult<List<object>>> ChartApi(int yearId, int centerId, int budgetProcessId, int StructureId, bool revenue, bool sale, bool loan, bool niabati,int? areaId=null,int? codingId=null)
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
                            if (!string.IsNullOrEmpty(dataReader1["Mosavab"].ToString()) && Int64.Parse(dataReader1["Mosavab"].ToString())>0)
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
            }else 
            if (areaId!=null)
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

        [Route("ChartBudgetDeviation")]
        [HttpGet]
        public async Task<ApiResult<List<ChartBudgetDeviationViewModel>>> Chart_BudgetDeviation(int areaId, int yearId)
        {
            List<ChartBudgetDeviationViewModel> data = new List<ChartBudgetDeviationViewModel>();
           

            using (SqlConnection sqlconnect1 = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand1 = new SqlCommand("SP500_BudgetDeviation", sqlconnect1))
                {
                    sqlconnect1.Open();
                    sqlCommand1.CommandType = CommandType.StoredProcedure;
                    sqlCommand1.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand1.Parameters.AddWithValue("yeaId", yearId);
                    SqlDataReader dataReader1 = await sqlCommand1.ExecuteReaderAsync();

                    while (dataReader1.Read())
                    {
                        ChartBudgetDeviationViewModel row = new ChartBudgetDeviationViewModel();
                        row.areaname=dataReader1["AreaName"].ToString();
                        row.code=dataReader1["Code"].ToString();
                        row.description=dataReader1["Description"].ToString();
                        row.mosavab=Int64.Parse(dataReader1["Mosavab"].ToString());
                        row.expense=Int64.Parse(dataReader1["Expense"].ToString());
                        if (double.Parse(dataReader1["Mosavab"].ToString()) > 0)
                        {
                            row.percmosavab=_uw.Budget_001Rep.Divivasion(double.Parse(dataReader1["Expense"].ToString()), double.Parse(dataReader1["Mosavab"].ToString()));
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

        [Route("DetailChartApi")]
        [HttpGet]
        public async Task<ApiResult<List<ChartAreaViewModel>>> DetailChartApi(int yearId, int centerId, int budgetProcessId, int StructureId, bool revenue, bool sale, bool loan, bool niabati, int? codingId = null)
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
                    sqlCommand.Parameters.AddWithValue("codingId", codingId);
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();

                    while (dataReader.Read())
                    {
                        ViewModels.Fetch.ChartAreaViewModel row = new ViewModels.Fetch.ChartAreaViewModel();

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

        [Route("DeleteTamin")]
        [HttpPost]
        public virtual async Task<ApiResult> DeleteTamin([FromBody] DeleteSepViewModel deleteSep)
        {
            if (deleteSep.id == 0)
                return BadRequest();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_BudgetSepratorArea_TaminModal_Delete", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("id", deleteSep.id);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    TempData["notification"] = "ویرایش با موفقیت انجام شد";
                }
            }
            return Ok();
        }

        [Route("RefreshSeperator")]
        [HttpGet]
        public async Task<ApiResult> RefreshSeprator(RefreshFormViewModel refreshFormViewModel)
        {
            if (refreshFormViewModel.yearId == 32)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP9900_Akh_TO_Olden_Then_Budget_1401_Main", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("areaId", refreshFormViewModel.areaId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        await sqlCommand.ExecuteReaderAsync();
                        ViewBag.alertsucces = "بروزرسانی انجام شد";
                    }
                    //view["notification"] = "بروزرسانی با موفقیت انجام شد";
                }
            }
            else
            if (refreshFormViewModel.yearId == 33)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP9900_Akh_TO_Olden_Then_Budget_1402_Main", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("areaId", refreshFormViewModel.areaId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.ExecuteReader();
                        ViewBag.alertsucces = "بروزرسانی انجام شد";
                    }
                    //view["notification"] = "بروزرسانی با موفقیت انجام شد";
                }
            }
            return Ok();
        }

        [Route("TaminInsert")]
        [HttpPost]
        public async Task<ApiResult> TaminInsert([FromBody] InsertTaminSepViewModel insertTaminSep)
        {
            if (insertTaminSep.codingId == 0) return BadRequest();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_BudgetSepratorArea_TaminModal_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", insertTaminSep.yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", insertTaminSep.areaId);
                    sqlCommand.Parameters.AddWithValue("budgetProcessId", insertTaminSep.budgetProcessId);
                    sqlCommand.Parameters.AddWithValue("RequestRefStr", insertTaminSep.RequestRefStr);
                    sqlCommand.Parameters.AddWithValue("RequestDate", insertTaminSep.RequestDate);
                    sqlCommand.Parameters.AddWithValue("RequestPrice", insertTaminSep.RequestPrice);
                    sqlCommand.Parameters.AddWithValue("ReqDesc", insertTaminSep.ReqDesc);
                    sqlCommand.Parameters.AddWithValue("codingId", insertTaminSep.codingId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    TempData["notification"] = "ویرایش با موفقیت انجام شد";
                }
            }
            return Ok();
        }

        [Route("BudgetSepratorAreaAccModal")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetSepratorAreaAccModalViewModel>>> BudgetSepratorAreaAccModal(int yearId, int areaId, int codingId)
        {
            List<BudgetSepratorAreaAccModalViewModel> fecthViewModel = new List<BudgetSepratorAreaAccModalViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_BudgetSepratorArea_Acc_Modal", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand.Parameters.AddWithValue("codingId", codingId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetSepratorAreaAccModalViewModel fetchView = new BudgetSepratorAreaAccModalViewModel();
                        fetchView.NumberSanad = StringExtensions.ToNullableInt(dataReader["NumberSanad"].ToString());
                        fetchView.DateSanad = dataReader["DateSanad"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.Expense = Int64.Parse(dataReader["Expense"].ToString());

                        fecthViewModel.Add(fetchView);
                    }
                }
            }

            return Ok(fecthViewModel);
        }

        [Route("BudgetSepratorAreaProjectModal")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetSepratorAreaProjectModalViewModel>>> BudgetSepratorAreaProjectModal(int yearId, int areaId, int codingId)
        {
            List<BudgetSepratorAreaProjectModalViewModel> fecthViewModel = new List<BudgetSepratorAreaProjectModalViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_BudgetSepratorArea_Project_Modal", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand.Parameters.AddWithValue("codingId", codingId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetSepratorAreaProjectModalViewModel fetchView = new BudgetSepratorAreaProjectModalViewModel();
                        fetchView.Id = StringExtensions.ToNullableInt(dataReader["Id"].ToString());
                        fetchView.ProjectCode = dataReader["ProjectCode"].ToString();
                        fetchView.ProjectName = dataReader["ProjectName"].ToString();
                        fetchView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());

                        fecthViewModel.Add(fetchView);
                    }
                }
            }

            return Ok(fecthViewModel);
        }

        [Route("BudgetSepratorAreaProjectModal2")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetSepratorAreaProjectModal2ViewModel>>> BudgetSepratorAreaProjectModal2(int yearId, int areaId, int codingId)
        {
            List<BudgetSepratorAreaProjectModal2ViewModel> fecthViewModel = new List<BudgetSepratorAreaProjectModal2ViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_BudgetSepratorArea_Project_Modal2", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand.Parameters.AddWithValue("codingId", codingId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetSepratorAreaProjectModal2ViewModel fetchView = new BudgetSepratorAreaProjectModal2ViewModel();
                        fetchView.Id = StringExtensions.ToNullableInt(dataReader["Id"].ToString());
                        fetchView.ProjectCode = dataReader["ProjectCode"].ToString();
                        fetchView.ProjectName = dataReader["ProjectName"].ToString();
                        fetchView.AreaNameShort = dataReader["AreaNameShort"].ToString();

                        fecthViewModel.Add(fetchView);
                    }
                }
            }

            return Ok(fecthViewModel);
        }

        [Route("BudgetSepratorAreaProjectModal_Update")]
        [HttpPost]
        public async Task<ApiResult> BudgetSepratorAreaProjectModal_Update([FromBody] int BudgetDetailPrjectId,int ProgramOperationDetailId)
        {
            if (BudgetDetailPrjectId == 0) return BadRequest();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_BudgetSepratorArea_Project_Modal_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("BudgetDetailPrjectId", BudgetDetailPrjectId);
                    sqlCommand.Parameters.AddWithValue("ProgramOperationDetailId", ProgramOperationDetailId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    TempData["notification"] = "ویرایش با موفقیت انجام شد";
                }
            }
            return Ok();
        }



    }


}
