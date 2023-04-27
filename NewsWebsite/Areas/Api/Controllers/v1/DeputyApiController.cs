using Microsoft.AspNetCore.Mvc;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Deputy;
using System.Collections.Generic;
using System.Data;
using System;
using System.Threading.Tasks;
using NewsWebsite.Common.Api;
using System.Data.SqlClient;

namespace NewsWebsite.Areas.Api.Controllers.v1
{

    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class DeputyApiController : Controller
    {
        public readonly IUnitOfWork _uw;
        public readonly IBudget_001Rep _budgetuw;
        public DeputyApiController(IUnitOfWork uw, IBudget_001Rep budgetuw)
        {
            _uw = uw;
            _budgetuw = budgetuw;
        }

        [Route("GetAllDeputy")]
        [HttpGet]
        public async Task<IActionResult> FetchDeputys(int yearId, int proctorId, int areaId, int budgetprocessId)
        {
            return Ok(await _uw.DeputyRepository.GetAllDeputiesAsync(yearId, proctorId, areaId, budgetprocessId));
        }

        [Route("ProctorAreaBudget")]
        [HttpGet]
        public async Task<IActionResult> ProctorAreaBudget(int id)
        {
            return Ok(await _uw.DeputyRepository.ProctorAreaAsync(id));
        }

        [Route("ProctorList")]
        [HttpGet]
        public async Task<IActionResult> ProctorList()
        {
            return Ok(await _uw.DeputyRepository.ProctorListAsync());
        }

        [Route("ProctorAreaBudgetDetail")]
        [HttpGet]
        public async Task<ApiResult<List<ProctorAreaBudgetViewModel>>> ProctorAreaBudgetDetail(int yearId, int proctorId, int areaId, int budgetProcessId)
        {
            if (yearId == 0 | areaId==0 | proctorId==0)
            {
                return BadRequest("با خطا مواجه شدید");
            }
            List<ProctorAreaBudgetViewModel> fecthViewModel = new List<ProctorAreaBudgetViewModel>();

            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;User Id=sa;Password=Az12345;Initial Catalog=ProgramBudDb;";
            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP501_Proctor", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", yearId);
                    sqlCommand.Parameters.AddWithValue("ProctorId", proctorId);
                    sqlCommand.Parameters.AddWithValue("AreaId", areaId);
                    sqlCommand.Parameters.AddWithValue("BudgetProcessId", budgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        ProctorAreaBudgetViewModel fetchView = new ProctorAreaBudgetViewModel();
                        fetchView.Code = dataReader["Code"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        fetchView.Expense = Int64.Parse(dataReader["Expense"].ToString());

                        if (fetchView.Percent != 0)
                        {
                            fetchView.Percent = _budgetuw.Divivasion(fetchView.Expense, fetchView.Mosavab);
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
            return Ok(fecthViewModel);
        }

        [HttpGet]
        [Route("Taminetebarat")]
        public async Task<ApiResult<List<BudgetSepTaminModal2ViewModel>>> Taminetebarat(int yearId, int areaId, int budgetProcessId)
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
                    SqlDataReader dataReader =await sqlCommand.ExecuteReaderAsync();
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

            return Ok(fecthViewModel);
        }

    }
}
