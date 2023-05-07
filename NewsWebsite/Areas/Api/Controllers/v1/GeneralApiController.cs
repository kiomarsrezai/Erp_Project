using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.GeneralVm;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace NewsWebsite.Areas.Api.Controllers.v1
{


    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class GeneralApiController : ControllerBase
    {
        ProgramBuddbContext _context;
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;

        public GeneralApiController(ProgramBuddbContext context, IUnitOfWork uw,IConfiguration configuration)
        {
            _config = configuration;
            _context = context;
            _uw = uw;
        }

        [Route("AreaFetch")]
        [HttpGet]
        public async Task<IActionResult> AreaFetch(int areaform)
        {

            return Ok(await _uw.Budget_001Rep.AreaFetchAsync(areaform));
        }

        [Route("YearFetch")]
        [HttpGet]
        public async Task<ApiResult<List<YearViewModel>>> YearFetch(YearParamViewModel yearParam)
        {
            if (yearParam.KindId==0) 
                BadRequest();

            List<YearViewModel> yearViews = new List<YearViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP000_Year", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("KindId", yearParam.KindId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        YearViewModel fetchView = new YearViewModel();
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.YearName = dataReader["YearName"].ToString();
                        yearViews.Add(fetchView);

                        //dataReader.NextResult();
                    }
                }
            }
            return Ok(yearViews);
        }

        [Route("BudgetProcessFetch")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetProcessViewModel>>> BudgetProcess()
        {
            return Ok(await _uw.Budget_001Rep.BudgetProcessFetchAsync());
        }

       

    }
}
