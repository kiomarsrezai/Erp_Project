using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using NewsWebsite.Data.Contracts;
using NewsWebsite.Common.Api;
using NewsWebsite.ViewModels.Api.Budget.BudgetSeprator;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;
using System;
using System.Data.SqlClient;
using NewsWebsite.ViewModels.Api.Public;
using NewsWebsite.ViewModels.Api.Budget.BudgetEdit;
using NewsWebsite.ViewModels.Api.Budget.BudgetCoding;
using NewsWebsite.Common.Api.Attributes;

namespace NewsWebsite.Areas.Api.Controllers.v1
{
   
    [Route("api/[controller]")]
    [ApiController]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class BudgetEditApiController : ControllerBase
    { 
        public readonly IUnitOfWork _uw;
        private readonly IConfiguration _config;

        public BudgetEditApiController(IUnitOfWork uw, IConfiguration config)
        {
            _uw = uw;
            _config = config;
        }

        [Route("BudgetEditRead")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetEditReadViewModel>>> Ac_BudgetEditRead(ReadPublicParamViewModel param)
        {
            List<BudgetEditReadViewModel> ViewModel = new List<BudgetEditReadViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP007_Edit_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", param.yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", param.areaId);
                    sqlCommand.Parameters.AddWithValue("budgetProcessId", param.budgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetEditReadViewModel data = new BudgetEditReadViewModel();
                        data.Id = int.Parse(dataReader["Id"].ToString());
                        data.BudgetDetailId = int.Parse(dataReader["BudgetDetailId"].ToString());
                        data.Code = dataReader["Code"].ToString();
                        data.Description = dataReader["Description"].ToString();
                        data.MosavabPublic = Int64.Parse(dataReader["MosavabPublic"].ToString());
                        data.Decrease = Int64.Parse(dataReader["Decrease"].ToString());
                        data.Increase = Int64.Parse(dataReader["Increase"].ToString());

                        ViewModel.Add(data);
                    }
                }
            }
            return Ok(ViewModel);
        }


        [Route("BudgetEditInsert")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_BudgetEditInsert(BudgetEditInsertParamViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP007_Edit_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("BudgetDetailId", param.BudgetDetailId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        if (dataReader["Message_DB"].ToString() != null) readercount = dataReader["Message_DB"].ToString();
                    }
                }
            }
            if (string.IsNullOrEmpty(readercount))
                return Ok("با موفقیت انجام شد");
            else
                return BadRequest(readercount);
        }


        [Route("BudgetEditUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_BudgetEditUpdate(BudgetEditUpdateParamViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP007_Edit_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", param.Id);
                    sqlCommand.Parameters.AddWithValue("Decrease", param.Decrease);
                    sqlCommand.Parameters.AddWithValue("Increase", param.Increase);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        if (dataReader["Message_DB"].ToString() != null) readercount = dataReader["Message_DB"].ToString();
                    }
                }
            }
            if (string.IsNullOrEmpty(readercount))
                return Ok("با موفقیت انجام شد");
            else
                return BadRequest(readercount);
        }


        [Route("BudgetEditDelete")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_BudgetEditDelete(DeletePublicParamViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP007_Edit_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", param.Id);

                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        if (dataReader["Message_DB"].ToString() != null) readercount = dataReader["Message_DB"].ToString();
                    }
                }
            }
            if (string.IsNullOrEmpty(readercount))
                return Ok("با موفقیت انجام شد");
            else
                return BadRequest(readercount);
        }

    }

}
