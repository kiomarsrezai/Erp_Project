using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using NewsWebsite.Common;
using NewsWebsite.Common.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.Data.Models;
using NewsWebsite.Entities.identity;
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
    [DisplayName("جدول واسط")]
    public class VasetSazmanhaController : BaseController
    {
        private IBudget_001Rep _uw;
        private readonly ProgramBuddbContext _context;
        private const string TagNotFound = "بودجه یافت نشد.";
        private const string TagDuplicate = "نام بودجه تکراری است.";
        private const string NotFoundeEacord = "آیتم مورد نظر یافت نشد";
        //private const string DeleteSuccess = "حذف با موفقیت انجام شد";

        public VasetSazmanhaController(ProgramBuddbContext dbContext, IBudget_001Rep uw)
        {
            _uw = uw;
            _context = dbContext;
        }
        
        [DisplayName("مشاهده")]
        public async Task<IActionResult> Index(int yearId, int areaId, int budgetProcessId)
        {
            ViewBag.YearId = new SelectList(_context.TblYears.Where(a => a.Id == 32).ToList(), "Id", "YearName");
            ViewBag.AreaId = new SelectList(await _uw.AreaFetchAsync(3), "Id", "AreaName");
            ViewBag.BudgetProcessId = new SelectList(_context.TblBudgetProcess.ToList(), "Id", "ProcessName");
            List<VasetSazmanhaViewModel> fecthViewModel = new List<VasetSazmanhaViewModel>();

            SqlParameter YearId = new SqlParameter { ParameterName = "yearId", Value = yearId };
            SqlParameter AreaId = new SqlParameter { ParameterName = "areaId", Value = areaId };
            SqlParameter BudgetProcessId = new SqlParameter { ParameterName = "budgetProcessId", Value = budgetProcessId };

            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP9000_Mapping_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.Add(YearId);
                    sqlCommand.Parameters.Add(AreaId);
                    sqlCommand.Parameters.Add(BudgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = sqlCommand.ExecuteReader();
                    while (dataReader.Read())
                    {
                        VasetSazmanhaViewModel fetchView = new VasetSazmanhaViewModel();
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.Code = dataReader["Code"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        fetchView.CodeAcc = dataReader["CodeAcc"].ToString();
                        fetchView.TitleAcc= dataReader["TitleAcc"].ToString();
                        fetchView.PercentBud= int.Parse(dataReader["PercentBud"].ToString());

                        fecthViewModel.Add(fetchView);
                        //dataReader.NextResult();
                    }
                    //TempData["budgetSeprator"] = fecthViewModel;
                }
                sqlconnect.Close();
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
                    }
                    //TempData["budgetSeprator"] = fecthViewModel;
                }
                sqlconnect.Close();
            }
            return View(fecthViewModel);
        }

        [HttpGet, DisplayName("درج و ویرایش")]
        public IActionResult Details(int yearId, int areaId, int budgetProcessId, int codingId)
        {
            List<SepratorAreaRequestViewModel> fecthViewModel = new List<SepratorAreaRequestViewModel>();


            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;User Id=sa;Password=Az12345;Initial Catalog=ProgramBudDb;";
            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_ShowBudgetSepratorArea_RequestModal", sqlconnect))
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
                        fetchView.Number = dataReader["Number"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.Date = dataReader["Date"].ToString();
                        fetchView.EstimateAmount = Int64.Parse(dataReader["EstimateAmount"].ToString());

                        fecthViewModel.Add(fetchView);
                    }

                }
                sqlconnect.Close();
            }

            return PartialView(fecthViewModel);
        }

        [HttpGet]
        public IActionResult UpdateCodeAcc(int id,string code,string description,int yearId, int areaId)
        {
            List<CodeAccUpdateViewModel> fecthViewModel = new List<CodeAccUpdateViewModel>();

            ViewBag.code = code;
            ViewBag.description = description;

            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;User Id=sa;Password=Az12345;Initial Catalog=ProgramBudDb;";
            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP9000_Mapping_Modal_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = sqlCommand.ExecuteReader();
                    while (dataReader.Read())
                    {
                        CodeAccUpdateViewModel codeAcc = new CodeAccUpdateViewModel();
                        codeAcc.Id = id;
                        codeAcc.IdKol = dataReader["IdKol"].ToString();
                        codeAcc.IdMoein = dataReader["IdMoien"].ToString();
                        codeAcc.IdTafsily = dataReader["IdTafsily"].ToString()==null ? "" : dataReader["IdTafsily"].ToString();
                        codeAcc.Name = dataReader["Name"].ToString();
                        codeAcc.IdTafsily5 = dataReader["IdTafsily5"].ToString() == null ? "": dataReader["IdTafsily5"].ToString();
                        codeAcc.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        codeAcc.MarkazHazine = dataReader["MarkazHazine"].ToString();
                        codeAcc.AreaId = areaId;
                        fecthViewModel.Add(codeAcc);
                        //dataReader.NextResult();
                    }
                    //TempData["budgetSeprator"] = fecthViewModel;
                }
            }
            return PartialView("_UpdateCodeACC", fecthViewModel);
        }

        [HttpPost]
        public IActionResult UpdateCodeAccPost(int id,int areaId,string codeAcc,string titleAcc)
        {
            if (id > 0)
            {
                string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
                //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;User Id=sa;Password=Az12345;Initial Catalog=ProgramBudDb;";
                using (SqlConnection sqlconnect = new SqlConnection(connection))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP9000_Mapping_Update", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("Id", id);
                        sqlCommand.Parameters.AddWithValue("areaId", areaId);
                        sqlCommand.Parameters.AddWithValue("codeAcc", codeAcc);
                        sqlCommand.Parameters.AddWithValue("titleAcc", titleAcc);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = sqlCommand.ExecuteReader();
                        TempData["notification"] = "ویرایش با موفقیت انجام شد";
                    }
                }
            }

            return PartialView("_UpdateCodeACC");
        }

        [HttpPost]
        public IActionResult InsertCodeAccPost(int id)
        {
            if (id > 0)
            {
                string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
                //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;User Id=sa;Password=Az12345;Initial Catalog=ProgramBudDb;";
                using (SqlConnection sqlconnect = new SqlConnection(connection))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP9000_Mapping_Insert", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("id", id);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = sqlCommand.ExecuteReader();
                        TempData["notification"] = "ویرایش با موفقیت انجام شد";
                        sqlconnect.Close();
                    }
                }
            }

            return PartialView("_UpdateCodeACC");
        }
        
        [HttpPost]
        public IActionResult DeleteCodeAccPost(int id)
        {
            if (id > 0)
            {
                string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
                //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;User Id=sa;Password=Az12345;Initial Catalog=ProgramBudDb;";
                using (SqlConnection sqlconnect = new SqlConnection(connection))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP9000_Mapping_Delete", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("id", id);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = sqlCommand.ExecuteReader();
                        TempData["notification"] = "حذف با موفقیت انجام شد";
                        sqlconnect.Close();
                    }
                }
            }

            return View("Index");
        }

        [HttpGet, DisplayName("حذف")]
        public IActionResult Delete(int id)
        {
            if (!id.ToString().HasValue())
                ModelState.AddModelError(string.Empty, NotFoundeEacord);
            else
            {
                return PartialView("_DeleteConfirmation");
            }
            return PartialView("_DeleteConfirmation");
        }


        //[HttpPost, ActionName("Delete")]
        //public async Task<IActionResult> DeleteConfirmed(int id)
        //{
            
        //    var user = await _userManager.FindByIdAsync(model.Id.ToString());
        //    if (user == null)
        //        ModelState.AddModelError(string.Empty, UserNotFound);
        //    else
        //    {
        //        var result = await _userManager.DeleteAsync(user);
        //        if (result.Succeeded)
        //        {
        //            FileExtensions.DeleteFile($"{_env.WebRootPath}/avatars/{user.Image}");
        //            TempData["notification"] = DeleteSuccess;
        //            return PartialView("_DeleteConfirmation", user);
        //        }
        //        else
        //            ModelState.AddErrorsFromResult(result);
        //    }

        //    return PartialView("_DeleteConfirmation");
        //}

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