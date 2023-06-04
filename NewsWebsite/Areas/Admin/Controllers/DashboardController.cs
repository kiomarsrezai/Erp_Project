using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using NewsWebsite.Common;
using NewsWebsite.Common.Attributes;
using NewsWebsite.Data;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Chart;
using NewsWebsite.ViewModels.DynamicAccess;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

namespace NewsWebsite.Areas.Admin.Controllers
{
    [DisplayName("گزارش")]
    public class DashboardController : BaseController
    {
        private readonly ProgramBuddbContext _uw;
        private readonly IBudget_001Rep _rep;
        public DashboardController(ProgramBuddbContext uw, IBudget_001Rep rep)
        {
            _uw = uw;
            _rep = rep;
        }
        [HttpGet, DisplayName("نمودار")]
        //[Authorize(Policy = ConstantPolicies.DynamicPermission)]
        public IActionResult ShowData()
        {
            ViewBag.YearId = new SelectList(_uw.TblYears.Where(a => a.Id == 32).ToList(), "Id", "YearName");

            return View();
        }

        [HttpPost]
        public List<object> GetDataBudget(int yearId, int centerId, int budgetProcessId,int StructureId,bool revenue,bool sale,bool loan,bool niabati)
        {
            List<object> data = new List<object>();
            List<string> lables = new List<string>();
            List<Int64> mosavab = new List<Int64>();
            List<double> percmosavab = new List<double>();
            List<double> percdaily = new List<double>();
            List<Int64> mosavabdaily = new List<Int64>();
            List<Int64> expense = new List<Int64>();
            //List<ColumnChart> dataset = new List<ColumnChart>();
            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            using (SqlConnection sqlconnect1 = new SqlConnection(connection))
            {
                using (SqlCommand sqlCommand1 = new SqlCommand("SP500_Chart", sqlconnect1))
                {
                    sqlconnect1.Open();
                    sqlCommand1.CommandType = CommandType.StoredProcedure;
                    sqlCommand1.Parameters.AddWithValue("YearId", yearId);
                    sqlCommand1.Parameters.AddWithValue("CenterId", centerId);
                    sqlCommand1.Parameters.AddWithValue("BudgetProcessId", budgetProcessId);
                    sqlCommand1.Parameters.AddWithValue("revenue", revenue);
                    sqlCommand1.Parameters.AddWithValue("sale", sale);
                    sqlCommand1.Parameters.AddWithValue("loan", loan);
                    sqlCommand1.Parameters.AddWithValue("niabati", niabati);
                    sqlCommand1.Parameters.AddWithValue("StructureId", StructureId);
                    SqlDataReader dataReader1 = sqlCommand1.ExecuteReader();

                    while (dataReader1.Read())
                    {
                        double percmos = 0; double percdai = 0;
                        lables.Add(dataReader1["AreaName"].ToString());
                        mosavab.Add(Int64.Parse(dataReader1["Mosavab"].ToString()));
                        mosavabdaily.Add(Int64.Parse(dataReader1["MosavabDaily"].ToString()));
                        expense.Add(Int64.Parse(dataReader1["Expense"].ToString()));
                        if (Int64.Parse(dataReader1["Mosavab"].ToString()) > 0)
                        {
                            percmos = _rep.Divivasion(StringExtensions.ToNullableBigInt(dataReader1["Expense"].ToString()), StringExtensions.ToNullableBigInt(dataReader1["Mosavab"].ToString()));
                        }
                        else
                        {
                            percmos = 0;
                        }
                        if (Int64.Parse(dataReader1["MosavabDaily"].ToString()) > 0)
                        {
                            percdai = _rep.Divivasion(StringExtensions.ToNullableBigInt(dataReader1["Expense"].ToString()), StringExtensions.ToNullableBigInt(dataReader1["MosavabDaily"].ToString()));
                        }
                        else
                        {
                            percdai = 0;
                        }
                        //dataset.AddRange(Int64.Parse(dataReader1["Mosavab"].ToString()), Int64.Parse(dataReader1["Expense"].ToString()), Int64.Parse(dataReader1["MosavabDaily"].ToString()));
                    }

                    data.Add(lables);
                    data.Add(mosavab);
                    data.Add(expense);
                    data.Add(mosavabdaily);
                    data.Add(percmosavab);
                    data.Add(percdaily);
                }

            };
            return data;
        }
        
        [HttpGet,DisplayName("ریز مقادیر")]
        //[Authorize(Policy = ConstantPolicies.DynamicPermission)]
        public IActionResult GetDataAreaTable(int yearId, int centerId, int budgetProcessId, int structureId, bool revenue, bool sale, bool loan, bool niabati)
        {
            List<ChartAreaViewModel> dataset = new List<ChartAreaViewModel>();
            //List<ColumnChart> dataset = new List<ColumnChart>();
            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP500_Chart", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("YearId", yearId);
                    sqlCommand.Parameters.AddWithValue("CenterId", centerId);
                    sqlCommand.Parameters.AddWithValue("BudgetProcessId", budgetProcessId);
                    sqlCommand.Parameters.AddWithValue("StructureId", structureId);
                    sqlCommand.Parameters.AddWithValue("revenue", revenue);
                    sqlCommand.Parameters.AddWithValue("sale", sale);
                    sqlCommand.Parameters.AddWithValue("loan", loan);
                    sqlCommand.Parameters.AddWithValue("niabati", niabati);
                    SqlDataReader dataReader = sqlCommand.ExecuteReader();

                    while (dataReader.Read())
                    {
                        ChartAreaViewModel row = new ChartAreaViewModel();

                        row.Id = int.Parse(dataReader["AreaId"].ToString());
                        row.Row = int.Parse(dataReader["AreaId"].ToString());
                        row.AreaId = int.Parse(dataReader["AreaId"].ToString());
                        row.AreaName = dataReader["AreaName"].ToString();
                        row.BudgetProcessId = int.Parse(dataReader["BudgetProcessId"].ToString());
                        row.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        row.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        row.MosavabDaily = Int64.Parse(dataReader["MosavabDaily"].ToString());
                        row.NotGet = Int64.Parse(dataReader["NotGet"].ToString());

                        row.YearId = int.Parse(dataReader["YearId"].ToString());
                        if (row.Mosavab != 0)
                        {
                            row.PercentMosavab = _rep.Divivasion(row.Expense, row.Mosavab);
                        }
                        else
                        {
                            row.PercentMosavab = 0;
                        }
                        if (row.MosavabDaily != 0)
                        {
                            row.PercentMosavabDaily = _rep.Divivasion(row.Expense, row.MosavabDaily);
                        }
                        else
                        {
                            row.PercentMosavabDaily = 0;
                        }
                        dataset.Add(row);
                    }

                }

            };
            //TempData["TotalPercentDaily"] = _rep.Divivasion(dataset.Sum(a => a.Expense), dataset.Sum(a => a.MosavabDaily));
            //TempData["TotalPercentMosavab"] = _rep.Divivasion(dataset.Sum(a => a.Expense), dataset.Sum(a => a.Mosavab));
            return PartialView(dataset);
        }

        [HttpGet, DisplayName("صفحه اصلی")]
        //[Authorize(Policy = ConstantPolicies.DynamicPermission)]
        public IActionResult Index()
        {
            ViewBag.YearId = new SelectList(_uw.TblYears.Where(a => a.Id == 32).ToList(), "Id", "YearName");

            //ViewBag.News = _uw.NewsRepository.CountNews();
            //ViewBag.FuturePublishedNews = _uw.NewsRepository.CountFuturePublishedNews();
            //ViewBag.NewsPublished = _uw.NewsRepository.CountNewsPublishedOrDraft(true);
            //ViewBag.DraftNews = _uw.NewsRepository.CountNewsPublishedOrDraft(false);

            //var month = _uw.TblAreas.ToList();
            //int numberOfVisit;
            //var year = DateTimeExtensions.ConvertMiladiToShamsi(DateTime.Now, "yyyy");
            //DateTime StartDateTimeMiladi;
            //DateTime EndDateTimeMiladi;
            //var numberOfVisitList = new List<NumberOfVisitChartViewModel>();

            //for (int i = 0; i < month.Count; i++)
            //{
            //    //StartDateTimeMiladi = DateTimeExtensions.ConvertShamsiToMiladi($"{year}/{i + 1}/01");
            //    //if (i < 10)
            //    //    EndDateTimeMiladi = DateTimeExtensions.ConvertShamsiToMiladi($"{year}/{i + 2}/01");
            //    //else
            //    //    EndDateTimeMiladi = DateTimeExtensions.ConvertShamsiToMiladi($"{year}/01/01");

            //    //numberOfVisit = _uw._Context.News.Where(n => n.PublishDateTime < EndDateTimeMiladi && StartDateTimeMiladi <= n.PublishDateTime).Include(v => v.Visits).Select(k => k.Visits.Sum(v => v.NumberOfVisit)).AsEnumerable().Sum();
            //    numberOfVisitList.Add(new NumberOfVisitChartViewModel { Name = month[i], Value = numberOfVisit });
            //}

            //ViewBag.NumberOfVisitChart = numberOfVisitList;
            return View();
        }
    }
}