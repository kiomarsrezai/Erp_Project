using Microsoft.AspNetCore.Mvc;
using NewsWebsite.Areas.Admin.Controllers;
using NewsWebsite.Common;
using NewsWebsite.Data;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Report;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace NewsWebSite.Areas.Admin.Controllers
{
    [DisplayName("متولی")]

    public class DeputyController : BaseController
    {
        private readonly ProgramBuddbContext _context;
        private readonly IBudget_001Rep _uw;

        public DeputyController(ProgramBuddbContext context, IBudget_001Rep uw)
        {
            _context = context;
            _uw = uw;
        }



        [HttpGet]
        public IActionResult ShowModal()
        {

            return View();
        }

        //[HttpGet]
        //public IActionResult GetDeputies(string search, string order, int offset, int limit, string sort)
        //{
        //    List<DeputyViewModel> data;
        //    int total = _uw.GetAllDeputies().Count();
        //    if (!search.HasValue())
        //        search = "";

        //    if (limit == 0)
        //        limit = total;

        //    if (sort == "متولی")
        //    {
        //        if (order == "asc")
        //            data = _uw.GetAllDeputiesAsync(offset, limit, "ProctorName", search);
        //        else
        //            data = _uw.GetAllDeputiesAsync(offset, limit, "ProctorName desc", search);
        //    }

        //    else
        //        data = _uw.GetAllDeputiesAsync(offset, limit, "ProctorName", search);

        //    if (search != "")
        //        total = data.Count();

        //    return Json(new { total = total, rows = data });

        //    //int total = 0;
        //    //List<DeputyViewModel> _fecthViewModel = new List<DeputyViewModel>();
        //    //_fecthViewModel = _uw.GetAllDeputies(32);
        //    //total = _fecthViewModel.Count();
        //    //return Json(new { total = total, rows = _fecthViewModel });
        //}

        //[HttpGet]


        //[HttpGet]
    }
}
