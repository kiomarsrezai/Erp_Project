using Microsoft.AspNetCore.Mvc;
using NewsWebsite.Areas.Admin.Controllers;
using NewsWebsite.Common;
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
        public IActionResult Index(DeputyViewModel deputyView)
        {
            var deputys = _uw.GetAllDeputies();

            return View(deputys);
        }

        [HttpGet]
        public IActionResult ShowModal()
        {

            return View();
        }

        [HttpGet]
        public IActionResult GetDeputies(string search, string order, int offset, int limit, string sort)
        {
            List<DeputyViewModel> data;
            int total = _uw.GetAllDeputies().Count();
            if (!search.HasValue())
                search = "";

            if (limit == 0)
                limit = total;

            if (sort == "متولی")
            {
                if (order == "asc")
                    data = _uw.GetAllDeputiesAsync(offset, limit, "ProctorName", search);
                else
                    data = _uw.GetAllDeputiesAsync(offset, limit, "ProctorName desc", search);
            }

            else
                data = _uw.GetAllDeputiesAsync(offset, limit, "ProctorName", search);

            if (search != "")
                total = data.Count();

            return Json(new { total = total, rows = data });

            //int total = 0;
            //List<DeputyViewModel> _fecthViewModel = new List<DeputyViewModel>();
            //_fecthViewModel = _uw.GetAllDeputies(32);
            //total = _fecthViewModel.Count();
            //return Json(new { total = total, rows = _fecthViewModel });
        }

        //[HttpGet]
        [DisplayName("مشاهده جزئیات")]
        public IActionResult Details(int Id)
        {
            List<AreaProctorViewModel> fecthViewModel = new List<AreaProctorViewModel>();

            fecthViewModel = _uw.ProctorArea(Id);
            
            return PartialView(fecthViewModel);
        }

        //[HttpGet]
        [DisplayName("مشاهده جزئیات")]
        public IActionResult FnProctorAreaBudget(int yId, int pId, int aId, int bId)
        {
            //List<ProctorAreaBudgetViewModel> _proctorAreaBudgets = new List<ProctorAreaBudgetViewModel>();

            //_proctorAreaBudgets = await _uw.budgetViewModels(yearId, proctorId, areaId, budgetProcessId);

            List<ProctorAreaBudgetViewModel> fecthViewModel = new List<ProctorAreaBudgetViewModel>();

            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;User Id=sa;Password=Az12345;Initial Catalog=ProgramBudDb;";
            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP501_Proctor", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", yId);
                    sqlCommand.Parameters.AddWithValue("ProctorId", pId);
                    sqlCommand.Parameters.AddWithValue("AreaId", aId);
                    sqlCommand.Parameters.AddWithValue("BudgetProcessId", bId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = sqlCommand.ExecuteReader();
                    while (dataReader.Read())
                    {
                        ProctorAreaBudgetViewModel fetchView = new ProctorAreaBudgetViewModel();
                        fetchView.Code = dataReader["Code"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        fetchView.Expense = Int64.Parse(dataReader["Expense"].ToString());

                        if (fetchView.Percent != 0)
                        {
                            fetchView.Percent = _uw.Divivasion(fetchView.Expense, fetchView.Mosavab);
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
            return PartialView(fecthViewModel);
        }
    }
}
