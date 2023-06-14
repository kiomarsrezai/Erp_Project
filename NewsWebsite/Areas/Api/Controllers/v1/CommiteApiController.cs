using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Commite;
using NewsWebsite.ViewModels.Api.Public;
using NewsWebsite.ViewModels.Api.Request;
using NewsWebsite.ViewModels.Commite;
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
                            commiteView.Row = StringExtensions.ToNullableInt(dataReader["Row"].ToString());
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
                            commiteView.Description = dataReader["Description"].ToString();
                            commiteView.DateStart = dataReader["DateStart"].ToString();
                            commiteView.DateStartShamsi = DateTimeExtensions.ConvertMiladiToShamsi(StringExtensions.ToNullableDatetime(dataReader["DateStart"].ToString()), "yyyy/MM/dd");
                            commiteView.DateEnd = dataReader["DateEnd"].ToString();
                            commiteView.DatteEndShamsi = DateTimeExtensions.ConvertMiladiToShamsi(StringExtensions.ToNullableDatetime(dataReader["DateEnd"].ToString()), "yyyy/MM/dd");
                            commiteView.Responsibility = dataReader["Responsibility"].ToString();
                            commiteViews.Add(commiteView);
                        }
                    }
                    sqlconnect.Close();
                }
            }
            return Ok(commiteViews);
        }


        [Route("CommiteDetailWbsInsert")]
        [HttpPost]
        public async Task<ApiResult<string>> CommiteDetailWbsInsert([FromBody] CommiteDetail_Wbs_insertParam_ViewModel insert)
        {
            string readercount = null;

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP006_CommiteDetailWbs_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("CommiteDetailId", insert.CommiteDetailId);
                    sqlCommand.Parameters.AddWithValue("UserId", insert.UserId);
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

        [Route("CommiteDetailWbsUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> CommiteDetailWbsUpdate([FromBody] CommiteDetail_Wbs_UpdateParam_ViewModel Param)
        {
            string readercount = null;

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP006_CommiteDetailWbs_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", Param.Id);
                    sqlCommand.Parameters.AddWithValue("Description", Param.Description);
                    sqlCommand.Parameters.AddWithValue("DateStart", DateTime.Parse(Param.DateStart).Date);
                    sqlCommand.Parameters.AddWithValue("DateEnd", DateTime.Parse(Param.DateEnd).Date);
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

        [Route("CommiteDetailWbsDelete")]
        [HttpPost]
        public async Task<ApiResult<string>> CommiteDetailWbsDelete([FromBody] CommiteDetailDeleteParamViewModel delete)
        {
            string readercount = null;

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP006_CommiteDetailWbs_Delete", sqlconnect))
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

        [Route("CommiteEmployee")]
        [HttpGet]
        public async Task<ApiResult<List<CommiteEmployeeViewModel>>> CommiteEmployee()
        {
            List<CommiteEmployeeViewModel> commiteViews = new List<CommiteEmployeeViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP006_Employee", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (await dataReader.ReadAsync())
                    {
                        CommiteEmployeeViewModel commiteView = new CommiteEmployeeViewModel();
                        commiteView.Id = int.Parse(dataReader["Id"].ToString());
                        commiteView.FirstName = dataReader["FirstName"].ToString();
                        commiteView.LastName = dataReader["LastName"].ToString();
                        commiteView.Bio = dataReader["Bio"].ToString();
                        commiteViews.Add(commiteView);
                    }
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


        [Route("CommiteDetailAcceptRead")]
        [HttpGet]
        public async Task<ApiResult<List<CommiteDetailAcceptReadViewModel>>> Ac_CommiteDetailAcceptRead(CommiteDetailAcceptReadParamViewModel param)
        {
            List<CommiteDetailAcceptReadViewModel> commiteAcceptView = new List<CommiteDetailAcceptReadViewModel>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP006_CommiteDetailAccept_Modal", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("CommiteDetailId", param.CommiteDetailId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            CommiteDetailAcceptReadViewModel data = new CommiteDetailAcceptReadViewModel();
                            data.Id = int.Parse(dataReader["Id"].ToString());
                            data.FirstName = dataReader["FirstName"].ToString();
                            data.LastName = dataReader["LastName"].ToString();
                            data.Resposibility = dataReader["Resposibility"].ToString();
                            data.DateAccept = dataReader["DateAccept"].ToString();
                            data.DateAcceptShamsi = DateTimeExtensions.ConvertMiladiToShamsi(StringExtensions.ToNullableDatetime(dataReader["DateAccept"].ToString()), "yyyy/MM/dd");
                            commiteAcceptView.Add(data);
                        }
                    }
                    sqlconnect.Close();
                }
            }
            return Ok(commiteAcceptView);
        }


        [Route("CommiteDetailAcceptInsert")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_CommiteDetailAcceptInsert([FromBody] CommiteDetail_Wbs_insertParam_ViewModel param)
        {
            string readercount = null;

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP006_CommiteDetailWbs_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("CommiteDetailId", param.CommiteDetailId);
                    sqlCommand.Parameters.AddWithValue("UserId", param.UserId);
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

        [Route("CommiteDetailAcceptUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_CommiteDetailAcceptUpdate([FromBody] CommiteDetailAcceptUpdateViewModel Param)
        {
            string readercount = null;

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP006_CommiteDetailAccept_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", Param.Id);
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

        [Route("CommiteDetailAcceptDelete")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_CommiteDetailAcceptDelete([FromBody] DeletePublicParamViewModel Param)
        {
            string readercount = null;

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP006_CommiteDetailAccept_Delete", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", Param.Id);
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
    }
}

