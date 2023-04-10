using Microsoft.AspNetCore.Mvc;
using NewsWebsite.ViewModels.Dashboard;
using NewsWebsite.ViewModels.Fetch;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace NewsWebSite.Controllers
{
    [Route("api/dashboard")]
    public class DashboardRestController : Controller
    {

        [HttpGet("findall")]
        [Produces("application/json")]
        public IActionResult findAll()
        {
            //try
            //{
            List<NumberOfVisitChartViewModel> fecthViewModel = new List<NumberOfVisitChartViewModel>();
            var numberOfVisits = new List<NumberOfVisitChartViewModel>();

            //string[] name;
            //SqlParameter YearId = new SqlParameter { ParameterName = "YearId", Value = yearId };
            //SqlParameter CenterId = new SqlParameter { ParameterName = "CenterId", Value = centerId };
            //SqlParameter BudgetProcessId = new SqlParameter { ParameterName = "BudgetProcessId", Value = budgetProcessId };

            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP500_Chart", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", 32);
                    sqlCommand.Parameters.AddWithValue("CenterId", 1);
                    sqlCommand.Parameters.AddWithValue("BudgetProcessId", 1);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = sqlCommand.ExecuteReader();
                    while (dataReader.Read())
                    {
                        NumberOfVisitChartViewModel fetchView = new NumberOfVisitChartViewModel();
                        fetchView.Name = dataReader["AreaName"].ToString();
                        fetchView.Value= int.Parse(dataReader["Expense"].ToString());
                        //fetchView.Mosavab = (int)dataReader["Mosavab"];
                        fecthViewModel.Add(fetchView);
                    }

                    //TempData["budgetSeprator"] = fecthViewModel;
                    //numberOfVisits.Add(fecthViewModel);
                    //ViewBag.NumberOfVisitChart = fecthViewModel;
                }
                return Json(fecthViewModel);

            }

            //var products = new List<NumberOfVisitChartViewModel>
            //{
            //    new Product { Id = "p01", Name = "Product 1", Price = 100, Quantity = 20 },
            //    new Product { Id = "p02", Name = "Product 2", Price = 120, Quantity = 12 },
            //    new Product { Id = "p03", Name = "Product 3", Price = 80, Quantity = 60 },
            //    new Product { Id = "p04", Name = "Product 4", Price = 290, Quantity = 34 },
            //    new Product { Id = "p05", Name = "Product 5", Price = 200, Quantity = 29 }
            //};
            //}
            //catch
            //{
            //    return  BadRequest();
            //}
        }
    }

}
