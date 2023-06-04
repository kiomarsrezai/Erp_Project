using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Budget.BudgetSeprator;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;
using System;
using System.Data.SqlClient;

namespace NewsWebsite.Areas.Api.Controllers.v1
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class TaminEtebarController : Controller
    {
        public readonly IUnitOfWork _uw;
        public readonly IConfiguration _configuration;

        public TaminEtebarController(IUnitOfWork uw, IConfiguration configuration)
        {
            _uw = uw;
            _configuration = configuration;
        }

        [HttpGet]
        [Route("Taminetebarat")]
        public async Task<ApiResult<List<BudgetSepTaminModal2ViewModel>>> Taminetebarat(int yearId, int areaId, int budgetProcessId)
        {
            List<BudgetSepTaminModal2ViewModel> fecthViewModel = new List<BudgetSepTaminModal2ViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_BudgetSepratorArea_TaminModal_2", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand.Parameters.AddWithValue("budgetProcessId", budgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
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
