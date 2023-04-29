using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Data.Contracts;
using NewsWebsite.Data.Models;
using NewsWebsite.ViewModels.Fetch;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace NewsWebsite.Areas.Admin.Controllers
{
    [DisplayName("بودجه تفکیکی")]
    public class BudgetSepratorController : BaseController
    {
        private IBudget_001Rep _uw;
        private readonly ProgramBuddbContext _context;
        private const string TagNotFound = "بودجه یافت نشد.";
        private const string TagDuplicate = "نام بودجه تکراری است.";
        //private const string DeleteSuccess = "حذف با موفقیت انجام شد";

        public BudgetSepratorController(ProgramBuddbContext dbContext, IBudget_001Rep uw)
        {
            _uw = uw;
            _context = dbContext;
        }


        [DisplayName("مشاهده")]
        public async Task<IActionResult> Index(int yearId, int areaId, int budgetProcessId)
        {
            ViewBag.YearId = new SelectList(_context.TblYears.Where(a => a.Id == 32).ToList(), "Id", "YearName");
            ViewBag.AreaId = new SelectList(await _uw.AreaFetchAsync(2), "Id", "AreaName");
            ViewBag.BudgetProcessId = new SelectList(_context.TblBudgetProcess.ToList(), "Id", "ProcessName");
            List<BudgetSepratorViewModel> fecthViewModel = new List<BudgetSepratorViewModel>();

            SqlParameter YearId = new SqlParameter { ParameterName = "YearId", Value = yearId };
            SqlParameter AreaId = new SqlParameter { ParameterName = "AreaId", Value = areaId };
            SqlParameter BudgetProcessId = new SqlParameter { ParameterName = "BudgetProcessId", Value = budgetProcessId };

            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;User Id=sa;Password=Az12345;Initial Catalog=ProgramBudDb;";
            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_ShowBudgetSepratorArea", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.Add(YearId);
                    sqlCommand.Parameters.Add(AreaId);
                    sqlCommand.Parameters.Add(BudgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = sqlCommand.ExecuteReader();
                    while (dataReader.Read())
                    {
                        BudgetSepratorViewModel fetchView = new BudgetSepratorViewModel();
                        fetchView.Code = dataReader["Code"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.CodingId = int.Parse(dataReader["CodingId"].ToString());
                        //fetchView.CodeVaset = dataReader["CodeVaset"].ToString();
                        fetchView.LevelNumber = int.Parse(dataReader["LevelNumber"].ToString());
                        fetchView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        fetchView.Edit = Int64.Parse(dataReader["Edit"].ToString());
                        fetchView.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        fetchView.CreditAmount = Int64.Parse(dataReader["CreditAmount"].ToString());
                        fetchView.Crud = bool.Parse(dataReader["Crud"].ToString());
                        fetchView.budgetProcessId = budgetProcessId;

                        if (fetchView.Mosavab != 0)
                        {
                            fetchView.PercentBud = Math.Round(_uw.Divivasion(fetchView.Expense, fetchView.Mosavab));
                        }
                        else
                        {
                            fetchView.PercentBud = 0;
                        }
                        fecthViewModel.Add(fetchView);
                        //dataReader.NextResult();
                    }
                    //TempData["budgetSeprator"] = fecthViewModel;
                }
            }
            return View(fecthViewModel);
        }


        public IActionResult AdvancedSearch(FetchSearchViewModel fetchSearchView)
        {
            List<BudgetSepratorViewModel> fecthViewModel = new List<BudgetSepratorViewModel>();

            SqlParameter YearId = new SqlParameter { ParameterName = "YearId", Value = fetchSearchView.YearId };
            SqlParameter AreaId = new SqlParameter { ParameterName = "AreaId", Value = fetchSearchView.AreaId };
            SqlParameter BudgetProcessId = new SqlParameter { ParameterName = "BudgetProcessId", Value = fetchSearchView.BudgetProcessId };

            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;User Id=sa;Password=Az12345;Initial Catalog=ProgramBudDb;";
            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_ShowBudget", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.Add(YearId);
                    sqlCommand.Parameters.Add(AreaId);
                    sqlCommand.Parameters.Add(BudgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = sqlCommand.ExecuteReader();
                    while (dataReader.Read())
                    {
                        BudgetSepratorViewModel fetchView = new BudgetSepratorViewModel();
                        fetchView.Code = dataReader["Code"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.CodingId = int.Parse(dataReader["CodingId"].ToString());
                        fetchView.CodeVaset = dataReader["CodeVaset"].ToString();
                        fetchView.LevelNumber = int.Parse(dataReader["LevelNumber"].ToString());
                        fetchView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        fetchView.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        if (fetchView.Mosavab != 0)
                        {
                            fetchView.PercentBud = (double)(Int64.Parse(dataReader["Expense"].ToString()) / Int64.Parse(dataReader["Mosavab"].ToString())) * 100;
                        }
                        else
                        { fetchView.PercentBud = 0; }
                        fecthViewModel.Add(fetchView);
                        //dataReader.NextResult();
                    }
                    //TempData["budgetSeprator"] = fecthViewModel;
                }
            }
            return View(fecthViewModel);
        }

        public IActionResult RefreshForm(int areaId, int yearId)
        {
            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;User Id=sa;Password=Az12345;Initial Catalog=ProgramBudDb;";
            if (yearId == 32)
            {
                using (SqlConnection sqlconnect = new SqlConnection(connection))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP9900_Akh_TO_Olden_Then_Budget_1401_Main", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("areaId", areaId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.ExecuteReader();
                        ViewBag.alertsucces = "بروزرسانی انجام شد";
                    }
                    //view["notification"] = "بروزرسانی با موفقیت انجام شد";
                }
            }
            else
            if (yearId == 33)
            {
                using (SqlConnection sqlconnect = new SqlConnection(connection))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP9900_Akh_TO_Olden_Then_Budget_1402_Main", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("areaId", areaId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.ExecuteReader();
                        ViewBag.alertsucces = "بروزرسانی انجام شد";
                    }
                    //view["notification"] = "بروزرسانی با موفقیت انجام شد";
                }
            }
            return Ok("با موفقیت انجام شد");
        }

        [HttpGet, DisplayName("درج و ویرایش")]
        public IActionResult Details(int yearId, int areaId, int budgetProcessId, int codingId)
        {
            ViewBag.codingId = codingId;

            List<SepratorAreaRequestViewModel> fecthViewModel = new List<SepratorAreaRequestViewModel>();


            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;User Id=sa;Password=Az12345;Initial Catalog=ProgramBudDb;";
            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_ShowBudgetSepratorArea_TaminModal", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand.Parameters.AddWithValue("budgetProcessId", budgetProcessId);
                    sqlCommand.Parameters.AddWithValue("codingId", codingId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = sqlCommand.ExecuteReader();
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

            return PartialView(fecthViewModel);
        }

        [HttpGet, DisplayName("درج و ویرایش")]
        public IActionResult Taminetebarat(int yearId, int areaId, int budgetProcessId)
        {
            List<BudgetSepTaminModal2ViewModel> fecthViewModel = new List<BudgetSepTaminModal2ViewModel>();


            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;User Id=sa;Password=Az12345;Initial Catalog=ProgramBudDb;";
            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_ShowBudgetSepratorArea_TaminModal_2", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand.Parameters.AddWithValue("budgetProcessId", budgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = sqlCommand.ExecuteReader();
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

            return PartialView(fecthViewModel);
        }

        [HttpPost]
        public IActionResult TaminInsertPost(int yearId, int areaId, int budgetProcessId, string RequestRefStr, string RequestDate, Int64 RequestPrice, string ReqDesc, int codingId)
        {
            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;User Id=sa;Password=Az12345;Initial Catalog=ProgramBudDb;";
            using (SqlConnection sqlconnect = new SqlConnection(connection))
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
                    SqlDataReader dataReader = sqlCommand.ExecuteReader();
                    TempData["notification"] = "ویرایش با موفقیت انجام شد";
                }
            }

            return PartialView("Details");
        }

        [HttpPost]
        public async Task<StatusCodeResult> TaminModalDelete(int? id)
        {
            if (id == 0 || id == null)
                return StatusCode(400);

            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            using (SqlConnection sqlconnect = new SqlConnection(connection))
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

            return StatusCode(200);
        }

        [HttpGet]
        public async Task<IActionResult> ParitialIndexTable(int yearId, int areaId, int budgetProcessId)
        {
            ViewBag.YearId = new SelectList(_context.TblYears.Where(a => a.Id == 32).ToList(), "Id", "YearName");
            ViewBag.AreaId = new SelectList(await _uw.AreaFetchAsync(2), "Id", "AreaName");
            ViewBag.BudgetProcessId = new SelectList(_context.TblBudgetProcess.ToList(), "Id", "ProcessName");
            List<BudgetSepratorViewModel> fecthViewModel = new List<BudgetSepratorViewModel>();

            SqlParameter YearId = new SqlParameter { ParameterName = "YearId", Value = yearId };
            SqlParameter AreaId = new SqlParameter { ParameterName = "AreaId", Value = areaId };
            SqlParameter BudgetProcessId = new SqlParameter { ParameterName = "BudgetProcessId", Value = budgetProcessId };

            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;User Id=sa;Password=Az12345;Initial Catalog=ProgramBudDb;";
            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_ShowBudgetSepratorArea", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.Add(YearId);
                    sqlCommand.Parameters.Add(AreaId);
                    sqlCommand.Parameters.Add(BudgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetSepratorViewModel fetchView = new BudgetSepratorViewModel();
                        fetchView.Code = dataReader["Code"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.CodingId = int.Parse(dataReader["CodingId"].ToString());
                        //fetchView.CodeVaset = dataReader["CodeVaset"].ToString();
                        fetchView.LevelNumber = int.Parse(dataReader["LevelNumber"].ToString());
                        fetchView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        fetchView.Edit = Int64.Parse(dataReader["Edit"].ToString());
                        fetchView.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        fetchView.CreditAmount = Int64.Parse(dataReader["CreditAmount"].ToString());
                        fetchView.Crud = bool.Parse(dataReader["Crud"].ToString());
                        fetchView.budgetProcessId = budgetProcessId;

                        if (fetchView.Mosavab != 0)
                        {
                            fetchView.PercentBud = Math.Round(_uw.Divivasion(fetchView.Expense, fetchView.Mosavab));
                        }
                        else
                        {
                            fetchView.PercentBud = 0;
                        }
                        fecthViewModel.Add(fetchView);
                        //dataReader.NextResult();
                    }
                    //TempData["budgetSeprator"] = fecthViewModel;
                }
            }
            return PartialView(fecthViewModel);
        }

        [HttpGet, DisplayName("حذف")]
        public IActionResult Delete()
        {
            //if (!tagId.HasValue())
            //    ModelState.AddModelError(string.Empty, TagNotFound);
            return PartialView("_DeleteConfirmation");
        }

        [HttpPost, ActionName("Delete")]
        public IActionResult DeleteConfirmed()
        {
            //if (model.TagId == null)
            //    ModelState.AddModelError(string.Empty, TagNotFound);

            return PartialView("_DeleteConfirmation");
        }

        [HttpPost, ActionName("DeleteGroup"), DisplayName("حذف گروهی")]
        public IActionResult DeleteGroupConfirmed(string[] btSelectItem)
        {
            if (btSelectItem.Count() == 0)
                ModelState.AddModelError(string.Empty, "هیچ برچسبی برای حذف انتخاب نشده است.");


            return PartialView("_DeleteGroup");
        }
    }
}