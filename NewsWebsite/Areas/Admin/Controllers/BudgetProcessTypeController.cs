using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.Common.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.Entities;
using NewsWebsite.ViewModels.BudgetProcess;
using NewsWebsite.ViewModels.DynamicAccess;

namespace NewsWebsite.Areas.Admin.Controllers
{
    [DisplayName("مدیریت انواع بودجه")]
    public class BudgetProcessTypeController : BaseController
    {
        private readonly IUnitOfWork _uw;
        private readonly IConfiguration _config;
        private const string BudgetProcessNotFound = "نواع بودجه ی درخواستی یافت نشد.";
        private const string BudgetProcessDuplicate = "نام نواع بودجه تکراری است.";
        private readonly IMemoryCache _cache;
        public BudgetProcessTypeController(IUnitOfWork uw, IMemoryCache cache, IConfiguration config)
        {
            _uw = uw;
            _uw.CheckArgumentIsNull(nameof(_uw));

            _config = config;
            _uw.CheckArgumentIsNull(nameof(_config));

            _cache = cache;
            _cache.CheckArgumentIsNull(nameof(_cache));
        }

        [HttpGet, DisplayName("مشاهده")]
        //[Authorize(Policy = ConstantPolicies.DynamicPermission)]
        public IActionResult Index()
        {
            return View();
        }


        [HttpGet]
        public async Task<IActionResult> GetBudgetProceses()
        {
            List<BudgetProcessViewModel> categories;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP0_BudgetPr_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    //sqlCommand.Parameters.AddWithValue("MotherId", paramViewModel.MotherId);
                    //sqlCommand.Parameters.AddWithValue("AreaId", paramViewModel.AreaId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                }
            }
            
            return View();
        }

        //[HttpGet, AjaxOnly, DisplayName("درج و ویرایش")]
        ////[Authorize(Policy = ConstantPolicies.DynamicPermission)]
        //public async Task<IActionResult> RenderBudgetProcess(string BudgetProcessId)
        //{
        //    var BudgetProcessViewModel = new BudgetProcessViewModel();
        //    ViewBag.Categories = await _uw.BudgetProcessRepository.GetAllCategoriesAsync();
        //    if (BudgetProcessId.HasValue())
        //    {
        //        var BudgetProcess = await _uw.BaseRepository<BudgetProcess>().FindByIdAsync(BudgetProcessId);
        //        _uw._Context.Entry(BudgetProcess).Reference(c => c.Parent).Load();
        //        if (BudgetProcess != null)
        //            BudgetProcessViewModel = _mapper.Map<BudgetProcessViewModel>(BudgetProcess);
        //        else
        //            ModelState.AddModelError(string.Empty, BudgetProcessNotFound);
        //    }

        //    return PartialView("_RenderBudgetProcess", BudgetProcessViewModel);
        //}

        //[HttpPost, AjaxOnly]
        //public async Task<IActionResult> CreateOrUpdate(BudgetProcessViewModel viewModel)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        if (_uw.BudgetProcessRepository.IsExistBudgetProcess(viewModel.BudgetProcessName, viewModel.BudgetProcessId))
        //            ModelState.AddModelError(string.Empty, BudgetProcessDuplicate);
        //        else
        //        {
        //            _cache.Remove("CategoriesEntry");
        //            viewModel.Url = viewModel.Url.Trim();
        //            if (viewModel.ParentBudgetProcessName.HasValue())
        //            {
        //                var parentBudgetProcess = _uw.BudgetProcessRepository.FindByBudgetProcessName(viewModel.ParentBudgetProcessName);
        //                if (parentBudgetProcess != null)
        //                    viewModel.ParentBudgetProcessId = parentBudgetProcess.BudgetProcessId;
        //                else
        //                {
        //                    BudgetProcess parent = new BudgetProcess()
        //                    {
        //                        BudgetProcessId = StringExtensions.GenerateId(10),
        //                        BudgetProcessName = viewModel.BudgetProcessName,
        //                        Url = viewModel.BudgetProcessName,
        //                    };
        //                    await _uw.BaseRepository<BudgetProcess>().CreateAsync(parent);
        //                    viewModel.ParentBudgetProcessId = parent.BudgetProcessId;
        //                }
        //            }

        //            if (viewModel.BudgetProcessId.HasValue())
        //            {
        //                var BudgetProcess = await _uw.BaseRepository<BudgetProcess>().FindByIdAsync(viewModel.BudgetProcessId);
        //                if (BudgetProcess != null)
        //                {
        //                    _uw.BaseRepository<BudgetProcess>().Update(_mapper.Map(viewModel, BudgetProcess));
        //                    await _uw.Commit();
        //                    TempData["notification"] = EditSuccess;
        //                }
        //                else
        //                    ModelState.AddModelError(string.Empty, BudgetProcessNotFound);
        //            }

        //            else
        //            {
        //                viewModel.BudgetProcessId = StringExtensions.GenerateId(10);
        //                await _uw.BaseRepository<BudgetProcess>().CreateAsync(_mapper.Map<BudgetProcess>(viewModel));
        //                await _uw.Commit();
        //                TempData["notification"] = InsertSuccess;
        //            }
        //        }
        //    }

        //    return PartialView("_RenderBudgetProcess", viewModel);
        //}


        //[HttpGet, AjaxOnly, DisplayName("حذف")]
        ////[Authorize(Policy = ConstantPolicies.DynamicPermission)]
        //public async Task<IActionResult> Delete(string BudgetProcessId)
        //{
        //    if (!BudgetProcessId.HasValue())
        //        ModelState.AddModelError(string.Empty, BudgetProcessNotFound);
        //    else
        //    {
        //        var BudgetProcess = await _uw.BaseRepository<BudgetProcess>().FindByIdAsync(BudgetProcessId);
        //        if (BudgetProcess == null)
        //            ModelState.AddModelError(string.Empty, BudgetProcessNotFound);
        //        else
        //            return PartialView("_DeleteConfirmation", BudgetProcess);
        //    }
        //    return PartialView("_DeleteConfirmation");
        //}


        //[HttpPost, ActionName("Delete"), AjaxOnly]
        //public async Task<IActionResult> DeleteConfirmed(BudgetProcess model)
        //{
        //    if (model.BudgetProcessId == null)
        //        ModelState.AddModelError(string.Empty, BudgetProcessNotFound);
        //    else
        //    {
        //        var BudgetProcess = await _uw.BaseRepository<BudgetProcess>().FindByIdAsync(model.BudgetProcessId);

        //        if (BudgetProcess == null)
        //            ModelState.AddModelError(string.Empty, BudgetProcessNotFound);
        //        else
        //        {
        //            var childBudgetProcess = _uw.BaseRepository<BudgetProcess>().FindByConditionAsync(c => c.ParentBudgetProcessId == BudgetProcess.BudgetProcessId).Result.ToList();
        //            if (childBudgetProcess.Count() != 0)
        //            {
        //                _uw.BaseRepository<BudgetProcess>().DeleteRange(childBudgetProcess);
        //                await _uw.Commit();
        //            }

        //            _uw.BaseRepository<BudgetProcess>().Delete(BudgetProcess);
        //            await _uw.Commit();
        //            TempData["notification"] = DeleteSuccess;
        //            return PartialView("_DeleteConfirmation", BudgetProcess);
        //        }
        //    }
        //    return PartialView("_DeleteConfirmation");
        //}


        //[HttpPost, ActionName("DeleteGroup"), AjaxOnly, DisplayName("حذف گروهی")]
        ////[Authorize(Policy = ConstantPolicies.DynamicPermission)]
        //public async Task<IActionResult> DeleteGroupConfirmed(string[] btSelectItem)
        //{
        //    if (btSelectItem.Count() == 0)
        //        ModelState.AddModelError(string.Empty, "هیچ دسته بندی برای حذف انتخاب نشده است.");
        //    else
        //    {
        //        foreach (var item in btSelectItem)
        //        {
        //            var childBudgetProcess = _uw.BaseRepository<BudgetProcess>().FindByConditionAsync(c => c.ParentBudgetProcessId == item).Result.ToList();
        //            if (childBudgetProcess.Count() != 0)
        //            {
        //                _uw.BaseRepository<BudgetProcess>().DeleteRange(childBudgetProcess);
        //                await _uw.Commit();
        //            }
        //            var BudgetProcess = await _uw.BaseRepository<BudgetProcess>().FindByIdAsync(item);
        //            _uw.BaseRepository<BudgetProcess>().Delete(BudgetProcess);
        //            await _uw.Commit();
        //        }
        //        TempData["notification"] = "حذف گروهی اطلاعات با موفقیت انجام شد.";
        //    }

        //    return PartialView("_DeleteGroup");
        //}

    }
}