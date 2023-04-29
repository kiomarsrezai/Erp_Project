using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using NewsWebsite.Data.Contracts;
using NewsWebsite.Data.Models;
using NewsWebsite.ViewModels.Fetch;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

namespace NewsWebsite.Areas.Admin.Controllers
{
    [DisplayName("بودجه")]
    public class FetchController : BaseController
    {
        private IBudget_001Rep _uw;
        private readonly ProgramBuddbContext _context;
        private const string TagNotFound = " یافت نشد.";
        private const string TagDuplicate = "نام  تکراری است.";
        //private const string DeleteSuccess = "حذف با موفقیت انجام شد";

        public FetchController(ProgramBuddbContext _dbContext, IBudget_001Rep uw)
        {
            _uw = uw;
            _context = _dbContext;

        }

        [DisplayName("مشاهده")]

        public IActionResult Index(int yearId, int areaId, int budgetProcessId)
        {
            ViewBag.YearId = new SelectList(_context.TblYears.Where(a => a.Id == 32).ToList(), "Id", "YearName");
            ViewBag.AreaId = new SelectList(_context.TblAreas.Where(a => a.Id == 10).ToList(), "Id", "AreaName");
            ViewBag.BudgetProcessId = new SelectList(_context.TblBudgetProcess, "Id", "ProcessName");
            List<FetchViewModel> fecth = new List<FetchViewModel>();

            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";

            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                Int64 _totalMosavab = 0; Int64 _totalExpense = 0;
                using (SqlCommand sqlCommand = new SqlCommand("SP001_ShowBudget", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", yearId);
                    sqlCommand.Parameters.AddWithValue("AreaId", areaId);
                    sqlCommand.Parameters.AddWithValue("BudgetProcessId", budgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = sqlCommand.ExecuteReader();
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
                            fetchView.PercentBud = _uw.Divivasion(fetchView.Expense, fetchView.Edit);
                        }
                        else
                        { 
                            fetchView.PercentBud = 0; 
                        }

                        fecth.Add(fetchView);
                        //dataReader.NextResult();
                    }
                }
            }
            return View(fecth);
        }


        [HttpGet]
        public IActionResult GetDataBudget(int yearId, int codingId)
        {
            List<FetchDataBudgetViewModel> dataset = new List<FetchDataBudgetViewModel>();
            //List<ColumnChart> dataset = new List<ColumnChart>();
            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_ShowBudgetDetail", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("YearId", yearId);
                    sqlCommand.Parameters.AddWithValue("CodingId", codingId);
                    SqlDataReader dataReader = sqlCommand.ExecuteReader();

                    while (dataReader.Read())
                    {
                        FetchDataBudgetViewModel row = new FetchDataBudgetViewModel();

                        row.AreaId = int.Parse(dataReader["AreaId"].ToString());
                        row.Code= dataReader["Code"].ToString();
                        row.Description= dataReader["Description"].ToString();
                        row.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        row.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        row.LevelNumber= int.Parse(dataReader["LevelNumber"].ToString());
                        dataset.Add(row);
                    }

                }

            };
            return PartialView(dataset);
        }


        [HttpGet]
        public IActionResult FetchData(FetchSearchViewModel fetchSearch)
        {
            //ViewBag.YearId = new SelectList(_context.TblYears.ToList(), "Id", "YearName");
            //ViewBag.AreaId = new SelectList(_context.TblAreas.ToList(), "Id", "AreaName");
            //ViewBag.BudgetProcessId = new SelectList(_context.TblBudgetProcess.ToList(), "Id", "ProcessName");
            //fecth1 = fecth;

            ViewBag.YearId = new SelectList(_context.TblYears.Where(a => a.Id == 32).ToList(), "Id", "YearName");
            ViewBag.AreaId = new SelectList(_context.TblAreas.Where(a => a.Id == 10).ToList(), "Id", "AreaName");
            ViewBag.BudgetProcessId = new SelectList(_context.TblBudgetProcess, "Id", "ProcessName");

            List<FetchViewModel> fecthViewModel = new List<FetchViewModel>();

            SqlParameter YearId = new SqlParameter { ParameterName = "YearId", Value = fetchSearch.YearId };
            SqlParameter AreaId = new SqlParameter { ParameterName = "AreaId", Value = fetchSearch.AreaId };
            SqlParameter BudgetProcessId = new SqlParameter { ParameterName = "BudgetProcessId", Value = fetchSearch.BudgetProcessId };

            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";

            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                Int64 _totalMosavab = 0; Int64 _totalExpense = 0;

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
                            fetchView.PercentBud = _uw.Divivasion(fetchView.Expense, fetchView.Edit);
                        }
                        else
                        {
                            fetchView.PercentBud = 0;
                        }

                        fecthViewModel.Add(fetchView);
                        //dataReader.NextResult();
                    }
                }
            }
            return PartialView("FetchData", fecthViewModel);
        }

        public IActionResult AdvancedSearch(FetchSearchViewModel ViewModel)
        {
            List<FetchViewModel> fecth = new List<FetchViewModel>();

            SqlParameter YearId = new SqlParameter { ParameterName = "YearId", Value = ViewModel.YearId };
            SqlParameter AreaId = new SqlParameter { ParameterName = "AreaId", Value = ViewModel.AreaId };
            SqlParameter BudgetProcessId = new SqlParameter { ParameterName = "BudgetProcessId", Value = ViewModel.BudgetProcessId };

            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";

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
                        FetchViewModel fetchView = new FetchViewModel();
                        fetchView.Code = dataReader["Code"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.LevelNumber = int.Parse(dataReader["LevelNumber"].ToString());
                        fetchView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        fetchView.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        fetchView.Show = (bool)dataReader["Show"];
                        if (fetchView.Mosavab != 0)
                        {
                            fetchView.PercentBud = _uw.Divivasion(fetchView.Expense, fetchView.Edit);
                        }
                        else
                        { fetchView.PercentBud = 0; }
                        fecth.Add(fetchView);
                        //dataReader.NextResult();
                    }
                }
            }
            return View(fecth);
        }

        [HttpGet, DisplayName("درج و ویرایش")]
        public IActionResult RenderFetch()
        {
            var tagViewModel = new FetchViewModel();
            //if (fetchId>0)
            //{
            //    var tag = _context.fetc>().FindByIdAsync(tagId);
            //    if (tag != null)
            //        tagViewModel = _mapper.Map<TagViewModel>(tag);
            //    else
            //        ModelState.AddModelError(string.Empty, TagNotFound);
            //}
            return PartialView("_RenderTag", tagViewModel);
        }

        [HttpPost]
        public IActionResult CreateOrUpdate()
        {
            //if (ModelState.IsValid)
            //{
            //    if (_uw.TagRepository.IsExistTag(viewModel.TagName, viewModel.TagId))
            //        ModelState.AddModelError(string.Empty, TagDuplicate);
            //    else
            //    {
            //        if (viewModel.TagId.HasValue())
            //        {
            //            var tag = await _uw.BaseRepository<Tag>().FindByIdAsync(viewModel.TagId);
            //            if (tag != null)
            //            {
            //                //_uw.BaseRepository<Tag>().Update(_mapper.Map(viewModel, tag));
            //                await _uw.Commit();
            //                TempData["notification"] = EditSuccess;
            //            }
            //            else
            //                ModelState.AddModelError(string.Empty, TagNotFound);
            //        }

            //        else
            //        {
            //            viewModel.TagId = StringExtensions.GenerateId(10);
            //            //await _uw.BaseRepository<Tag>().CreateAsync(_mapper.Map<Tag>(viewModel));
            //            await _uw.Commit();
            //            TempData["notification"] = InsertSuccess;
            //        }
            //    }
            //}

            return PartialView("_RenderTag");
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