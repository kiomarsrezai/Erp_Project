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
using NewsWebsite.Common;

namespace NewsWebsite.Areas.Api.Controllers.v1
{
   
    [Route("api/v{version:apiVersion}/[controller]")]
    //[ApiController]
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


        [Route("EditRead")]
        [HttpGet]
        public async Task<ApiResult<List<EditReadViewModel>>> Ac_BudgetEditRead(Param22ViewModel param)
        {
            List<EditReadViewModel> data = new List<EditReadViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP007_Edit_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", param.yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", param.areaId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        EditReadViewModel row = new EditReadViewModel();
                        row.Id = int.Parse(dataReader["Id"].ToString());
                        row.Number = dataReader["Number"].ToString();
                        row.Date = dataReader["Date"].ToString();
                        row.DateShamsi = DateTimeExtensions.ConvertMiladiToShamsi(DateTime.Parse(dataReader["Date"].ToString()), "yyyy/MM/dd");
                        data.Add(row);
                    }
                }
            }
            return Ok(data);
        }


        [Route("EditDetailRead")]
        [HttpGet]
        public async Task<ApiResult<List<EditDetailViewModel>>> Ac_EditDetailRead(paramIdViewModel param)
        {
            List<EditDetailViewModel> data = new List<EditDetailViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP007_EditDetail_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", param.Id);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        EditDetailViewModel row = new EditDetailViewModel();
                        row.Id = int.Parse(dataReader["Id"].ToString());
                        row.Code = dataReader["Code"].ToString();
                        row.Description = dataReader["Description"].ToString();
                        row.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        row.EditArea = Int64.Parse(dataReader["EditArea"].ToString());
                        row.Decrease = Int64.Parse(dataReader["Decrease"].ToString());
                        row.Increase = Int64.Parse(dataReader["Increase"].ToString());
                        data.Add(row);
                    }
                }
            }
            return Ok(data);
        }


        [Route("BudgetEditInsert")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_BudgetEditInsert([FromBody] BudgetEditInsertParamViewModel param)
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
        public async Task<ApiResult<string>> Ac_BudgetEditUpdate([FromBody] BudgetEditUpdateParamViewModel param)
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
        public async Task<ApiResult<string>> Ac_BudgetEditDelete([FromBody] DeletePublicParamViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP007_Edit_Delete", sqlconnect))
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

        [Route("Edit")]
        [HttpGet]
        public async Task<ApiResult<List<EditrowViewModel>>> Ac_Edit(EditParamViewModel param)
        {
            List<EditrowViewModel> data = new List<EditrowViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_Edit", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", param.yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", param.areaId);
                    sqlCommand.Parameters.AddWithValue("budgetProcessId", param.budgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        EditrowViewModel row = new EditrowViewModel();
                        row.CodingId = int.Parse(dataReader["CodingId"].ToString());
                        row.Code = dataReader["Code"].ToString();
                        row.Description = dataReader["Description"].ToString();
                        row.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        row.Supply = Int64.Parse(dataReader["Supply"].ToString());
                        row.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        row.NeesEditYearNow = Int64.Parse(dataReader["NeesEditYearNow"].ToString());
                        row.Edit = Int64.Parse(dataReader["Edit"].ToString());
                        row.levelNumber = int.Parse(dataReader["levelNumber"].ToString());
                        row.Crud = int.Parse(dataReader["Crud"].ToString());
                        data.Add(row);
                    }
                }
            }
            return Ok(data);
        }
 
    }

}
