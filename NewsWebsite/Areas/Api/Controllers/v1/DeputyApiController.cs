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
using Microsoft.Extensions.Configuration;

namespace NewsWebsite.Areas.Api.Controllers.v1
{

    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class DeputyApiController : Controller
    {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        public readonly IBudget_001Rep _budgetuw;
        public DeputyApiController(IUnitOfWork uw, IBudget_001Rep budgetuw,IConfiguration configuration)
        {
            _config = configuration;
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

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
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

        

    }
}
