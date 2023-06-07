using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Budget.BudgetProject;
using NewsWebsite.ViewModels.Api.Commite;
using NewsWebsite.ViewModels.Api.UploadFile;
using NewsWebsite.ViewModels.Project;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Threading.Tasks;

namespace NewsWebsite.Areas.Api.Controllers.v1
{

    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class CommiteApiController : Controller
    {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        public CommiteApiController(IUnitOfWork uw, IConfiguration config)
        {
            _config = config;
            _uw = uw;
        }

        [Route("CommiteModal")]
        [HttpGet]
        public async Task<ApiResult<List<CommiteModalViewModel>>> Commite_Modal(int CommiteKindId, int YearId)
        {
            List<CommiteModalViewModel> commiteViews = new List<CommiteModalViewModel>();

            if (CommiteKindId == 0)
                return BadRequest("با خطا مواجه شد");
            if (CommiteKindId > 0)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP006_Commite_Modal", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("CommiteKindId", CommiteKindId);
                        sqlCommand.Parameters.AddWithValue("YearId", YearId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            CommiteModalViewModel commiteView = new CommiteModalViewModel();
                            commiteView.Id = int.Parse(dataReader["Id"].ToString());
                            commiteView.dates = dataReader["dates"].ToString();
                            commiteView.number = dataReader["number"].ToString();
                            commiteViews.Add(commiteView);

                        }

                    }
                }

            }
            return Ok(commiteViews);
        }

        [Route("CommiteDetailRead")]
        [HttpGet]
        public async Task<ApiResult<List<CommiteViewModel>>> GetCommiteDetail(int id)
        {
            List<CommiteViewModel> commiteViews = new List<CommiteViewModel>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP006_CommiteDetail_Read", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("Id", id);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            CommiteViewModel commiteView = new CommiteViewModel();
                            commiteView.Id = int.Parse(dataReader["Id"].ToString());
                            commiteView.Row =       StringExtensions.ToNullableInt(dataReader["Row"].ToString());
                            commiteView.ProjectId = StringExtensions.ToNullableInt(dataReader["ProjectId"].ToString());
                            commiteView.Description = dataReader["Description"].ToString();
                            commiteView.ProjectName = dataReader["ProjectName"].ToString();
                            commiteViews.Add(commiteView);
                        }
                    }
                }
            }
            return Ok(commiteViews);
        }

        [Route("CommiteDetailInsert")]
        [HttpPost]
        public async Task<ApiResult<string>> CommiteDetailInsert([FromBody] CommiteDetailInsertParamViewModel insert)
        {
            string readercount = null;

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP006_CommiteDetail_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Row", insert.Row);
                    sqlCommand.Parameters.AddWithValue("CommiteId", insert.CommiteId);
                    sqlCommand.Parameters.AddWithValue("Description", insert.Description);
                    sqlCommand.Parameters.AddWithValue("ProjectId", insert.ProjectId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        if (dataReader["Message_DB"].ToString() != null) readercount = dataReader["Message_DB"].ToString();
                    }
                }
            }
            if (string.IsNullOrEmpty(readercount)) return Ok("با موفقیت انجام شد");
            else
                return BadRequest(readercount);
        }

        [Route("CommiteDetailUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> CommiteDetailUpdate([FromBody] CommiteDetailUpdateParamViewModel update)
        {
            string readercount = null;

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP006_CommiteDetail_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", update.Id);
                    sqlCommand.Parameters.AddWithValue("Row", update.Row);
                    sqlCommand.Parameters.AddWithValue("Description", update.Description);
                    sqlCommand.Parameters.AddWithValue("ProjectId", update.ProjectId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        if (dataReader["Message_DB"].ToString() != null) readercount = dataReader["Message_DB"].ToString();
                    }
                }
            }
            if (string.IsNullOrEmpty(readercount)) return Ok("با موفقیت انجام شد");
            else
                return BadRequest(readercount);
        }

        [Route("CommiteDetailDelete")]
        [HttpPost]
        public async Task<ApiResult<string>> CommiteDetailDelete([FromBody] CommiteDetailDeleteParamViewModel delete)
        {
            string readercount = null;

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP006_CommiteDetail_Delete", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", delete.Id);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        if (dataReader["Message_DB"].ToString() != null) readercount = dataReader["Message_DB"].ToString();
                    }
                }
            }
            if (string.IsNullOrEmpty(readercount)) return Ok("با موفقیت انجام شد");
            else
                return BadRequest(readercount);
        }

        [Route("CommiteDetailProjectModal")]
        [HttpGet]
        public async Task<ApiResult<List<CommiteDetailProjectModalViewModel>>> GetCommiteDetailProjectModal()
        {
            List<CommiteDetailProjectModalViewModel> commiteViews = new List<CommiteDetailProjectModalViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP006_CommiteDetail_ProjectModal_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (await dataReader.ReadAsync())
                    {
                        CommiteDetailProjectModalViewModel commiteView = new CommiteDetailProjectModalViewModel();
                        commiteView.Id = int.Parse(dataReader["Id"].ToString());
                        commiteView.ProjectCode = dataReader["ProjectCode"].ToString();
                        commiteView.ProjectName = dataReader["ProjectName"].ToString();
                        commiteViews.Add(commiteView);
                    }
                }
            }
            return Ok(commiteViews);
        }

        [Route("CommiteDetailWbsRead")]
        [HttpGet]
        public async Task<ApiResult<List<CommiteDetailWbsReadViewModel>>> GetCommiteDetailWbsModal(CommiteDetailWbsReadParamViewModel param)
        {
            List<CommiteDetailWbsReadViewModel> commiteViews = new List<CommiteDetailWbsReadViewModel>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP006_CommiteDetailWbs_Modal", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("CommiteDetailId", param.CommiteDetailId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            CommiteDetailWbsReadViewModel commiteView = new CommiteDetailWbsReadViewModel();
                            commiteView.Id = int.Parse(dataReader["Id"].ToString());
                            commiteView.FirstName = dataReader["FirstName"].ToString();
                            commiteView.LastName = dataReader["LastName"].ToString();
                            commiteView.DateStart = dataReader["DateStart"].ToString();
                            commiteView.DateEnd = dataReader["DateEnd"].ToString();
                            commiteView.Responsibility = dataReader["Responsibility"].ToString();
                            commiteViews.Add(commiteView);
                        }
                    }
                    sqlconnect.Close();
                }

            }
            return Ok(commiteViews);
        }

      










        [Route("CommiteKindCombo")]
        [HttpGet]
        public async Task<ApiResult<List<CommiteComboboxViewModel>>> CommiteKindCombo()
        {
            List<CommiteComboboxViewModel> commiteViews = new List<CommiteComboboxViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP005_CommiteKind_Com", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (await dataReader.ReadAsync())
                    {
                        CommiteComboboxViewModel commiteView = new CommiteComboboxViewModel();
                        commiteView.Id = int.Parse(dataReader["Id"].ToString());
                        commiteView.CommiteName = dataReader["CommiteName"].ToString();
                        commiteViews.Add(commiteView);
                    }
                }
            }

            return Ok(commiteViews);
        }

    }
}
