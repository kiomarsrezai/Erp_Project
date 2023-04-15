using Microsoft.AspNetCore.Mvc;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.BudgetSepratorViewModel;
using System.Collections.Generic;
using System.Data;
using System;
using System.Threading.Tasks;
using NewsWebsite.Common.Api;
using NewsWebsite.ViewModels.Fetch;
using System.Data.SqlClient;

namespace NewsWebsite.Areas.Api.Controllers.v1
{

    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class BudSepApiController : Controller
    {
        public readonly IUnitOfWork _uw;
        public BudSepApiController(IUnitOfWork uw)
        {
            _uw = uw;
        }

        //[Route("FetchSeprator")]
        [HttpGet]
        public async Task<IActionResult> FetchSeprators(int yearId,int areaId,int budgetprocessId)
        {
            return Ok(await _uw.Budget_001Rep.GetAllBudgetSeprtaorAsync(yearId, areaId, budgetprocessId));
        }

        [Route("ChartApi")]
        [HttpGet]
        public async Task<ApiResult<List<object>>> ChartApi(int yearId, int centerId, int budgetProcessId, int StructureId, bool revenue, bool sale, bool loan, bool niabati)
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
                    SqlDataReader dataReader1 = await sqlCommand1.ExecuteReaderAsync();

                    while (dataReader1.Read())
                    {
                        double percmos = 0; double percdai = 0;
                        lables.Add(dataReader1["AreaName"].ToString());
                        mosavab.Add(Int64.Parse(dataReader1["Mosavab"].ToString()));
                        mosavabdaily.Add(Int64.Parse(dataReader1["MosavabDaily"].ToString()));
                        expense.Add(Int64.Parse(dataReader1["Expense"].ToString()));
                        if (Int64.Parse(dataReader1["Mosavab"].ToString()) > 0)
                        {
                            percmos = _uw.Budget_001Rep.Divivasion(double.Parse(dataReader1["Expense"].ToString()), double.Parse(dataReader1["Mosavab"].ToString()));
                        }
                        else
                        {
                            percmos = 0;
                        }
                        if (Int64.Parse(dataReader1["MosavabDaily"].ToString()) > 0)
                        {
                            percdai = _uw.Budget_001Rep.Divivasion(double.Parse(dataReader1["Expense"].ToString()), double.Parse(dataReader1["MosavabDaily"].ToString()));
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

    }


}
