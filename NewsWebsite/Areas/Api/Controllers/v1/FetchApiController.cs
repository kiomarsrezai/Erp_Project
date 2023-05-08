using Microsoft.AspNetCore.Mvc;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.BudgetSeprator;
using System.Collections.Generic;
using System.Data;
using System;
using System.Threading.Tasks;
using NewsWebsite.Common.Api;
using System.Data.SqlClient;
using NewsWebsite.Common;
using NewsWebsite.ViewModels.Fetch;
using Microsoft.Extensions.Configuration;

namespace NewsWebsite.Areas.Api.Controllers.v1
{

    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class FetchController : Controller
    {
        public readonly IUnitOfWork _uw;
        private readonly IConfiguration _config;
        public FetchController(IUnitOfWork uw,IConfiguration configuration)
        {
            _config = configuration;
            _uw = uw;
        }

       

        //[HttpGet]
        //[Route("FetchDetails")]
        //public async Task<ApiResult<List<FetchDataBudgetViewModel>>> FetchDetails(int yearId, int areaId, int codingId)
        //{
        //    List<FetchDataBudgetViewModel> dataset = new List<FetchDataBudgetViewModel>();
            
        //    using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
        //    {
        //        using (SqlCommand sqlCommand = new SqlCommand("SP001_ShowBudgetDetail", sqlconnect))
        //        {
        //            sqlconnect.Open();
        //            sqlCommand.CommandType = CommandType.StoredProcedure;
        //            sqlCommand.Parameters.AddWithValue("YearId", yearId);
        //            sqlCommand.Parameters.AddWithValue("AreaId", areaId);
        //            sqlCommand.Parameters.AddWithValue("CodingId", codingId);
        //            SqlDataReader dataReader =await sqlCommand.ExecuteReaderAsync();

        //            while (dataReader.Read())
        //            {
        //                FetchDataBudgetViewModel row = new FetchDataBudgetViewModel();

        //                row.AreaId = int.Parse(dataReader["AreaId"].ToString());
        //                row.Code = dataReader["Code"].ToString();
        //                row.Description = dataReader["Description"].ToString();
        //                row.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
        //                row.Expense = Int64.Parse(dataReader["Expense"].ToString());
        //                row.LevelNumber = int.Parse(dataReader["LevelNumber"].ToString());
        //                dataset.Add(row);
        //            }

        //        }

        //    };
        //    return Ok(dataset);
        //}



    }


}
