using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.ViewModels.Fetch;
using System.Collections.Generic;
using System.Data;
using System;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace NewsWebsite.Areas.Api.Controllers.v1
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiController]
    public class FetcesController : ControllerBase
    {
        public IActionResult Fetches(int yearId, int areaId, int budgetProcessId)
        {
            List<FetchViewModel> fecth = new List<FetchViewModel>();

            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";

            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                long _totalMosavab = 0; long _totalExpense = 0;
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
                        fetchView.Mosavab = long.Parse(dataReader["Mosavab"].ToString());
                        fetchView.Expense = long.Parse(dataReader["Expense"].ToString());
                        fetchView.Show = (bool)dataReader["Show"];
                        _totalMosavab += fetchView.Mosavab;
                        _totalExpense += fetchView.Expense;
                        if (fetchView.Mosavab != 0)
                        {
                            fetchView.PercentBud = (double)(long.Parse(dataReader["Expense"].ToString()) / long.Parse(dataReader["Mosavab"].ToString())) * 100;
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
            return Ok(fecth);
        }
    }
}
