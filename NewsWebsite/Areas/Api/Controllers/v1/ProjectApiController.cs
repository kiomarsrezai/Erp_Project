using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Budget.BudgetProject;
using NewsWebsite.ViewModels.Api.Commite;
using NewsWebsite.ViewModels.Project;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net.Http.Headers;
using System.Threading.Tasks;

namespace NewsWebsite.Areas.Api.Controllers.v1
{

    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class ProjectApiController : Controller
    {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        public ProjectApiController(IUnitOfWork uw, IConfiguration config)
        {
            _config = config;
            _uw = uw;
        }

        [Route("GetProject")]
        [HttpGet]
        public async Task<ApiResult<List<ProjectViewModel>>> GetProject(int id)
        {
            if (id == 0)
                return BadRequest("خطایی رخ داده است");

            List<ProjectViewModel> fetchViewlist = new List<ProjectViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP005_Project_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("id", id);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (await dataReader.ReadAsync())
                    {
                        ProjectViewModel fetchView = new ProjectViewModel();
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.ProjectCode = dataReader["ProjectCode"].ToString();
                        fetchView.ProjectName = dataReader["ProjectName"].ToString();
                        fetchView.Weight = StringExtensions.ToNullablefloat(dataReader["Weight"].ToString());
                        fetchView.AreaId = StringExtensions.ToNullableInt(dataReader["AreaId"].ToString());
                        fetchView.MotherId = StringExtensions.ToNullableInt(dataReader["MotherId"].ToString());
                        fetchViewlist.Add(fetchView);
                    }
                }
            }
            return Ok(fetchViewlist);
        }

        [Route("UploadFiles")]
        [HttpPost, DisableRequestSizeLimit]
        public async Task<ApiResult> UploadProjectFiles(int projectId,List<IFormFileCollection> formFiles)
        {
            try
            {
                var file=Request.Form.Files[0];
                var folderName = Path.Combine($"{_webHostEnvironment.WebRootPath}/Resources/Project/{projectId}/");
                var pathToSave = Path.Combine(Directory.GetCurrentDirectory(), folderName);
                if (file.Length > 0)
                {
                    var fileName = ContentDispositionHeaderValue.Parse(file.ContentDisposition).FileName.Trim('"');
                    var fullPath = Path.Combine(pathToSave, fileName);
                    using (var stream = new FileStream(fullPath, FileMode.Create))
                    {
                       await file.CopyToAsync(stream);
                    }
                    return Ok();
                }
                else
                {
                    return BadRequest();
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [Route("ProjectInsert")]
        [HttpPost]
        public async Task<ApiResult<string>> InsertProject(int id)
        {
            if (id == 0)
                return BadRequest("با خطا مواجه شد");
            if (id > 0)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP005_Project_Insert", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("id", id);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        sqlconnect.Close();
                    }
                }
            }
            return Ok("با موفقیت انجام شد");
        }

        [Route("ProjectDelete")]
        [HttpPost]
        public async Task<ApiResult<string>> Delete(int id)
        {
            if (id == 0)
                return BadRequest("با خطا مواجه شد");
            if (id > 0)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP005_Project_Delete", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("id", id);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        sqlconnect.Close();
                    }
                }
            }
            return Ok("با موفقیت انجام شد");
        }

        [Route("ProjectUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> Update(int id, string projectName, string projectCode, int motherId)
        {
            if (id == 0)
                return BadRequest("با خطا مواجه شد");
            if (id > 0)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP005_Project_Update", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("id", id);
                        sqlCommand.Parameters.AddWithValue("ProjectName", projectName);
                        sqlCommand.Parameters.AddWithValue("ProjectCode", projectCode);
                        sqlCommand.Parameters.AddWithValue("MotherId", motherId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    }
                }

            }
            return Ok("با موفقیت انجام شد");

        }

        [Route("ProjectCommitModal")]
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
                    using (SqlCommand sqlCommand = new SqlCommand("SP005_Commite_Modal", sqlconnect))
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

        [Route("ProjectCommiteDetailInsert")]
        [HttpPost]
        public async Task<ApiResult<List<CommiteModalViewModel>>> CommiteDetail_Insert(int CommiteKindId, int YearId)
        {
            List<CommiteModalViewModel> commiteViews = new List<CommiteModalViewModel>();

            if (CommiteKindId == 0)
                return BadRequest("با خطا مواجه شد");
            if (CommiteKindId > 0)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP005_Commite_Modal", sqlconnect))
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

        [Route("ProjectExecute_Modal")]
        [HttpGet]
        public async Task<ApiResult<List<CommiteExecuteModalViewModel>>> CommiteExecute_Modal(int CommiteKindId)
        {
            List<CommiteExecuteModalViewModel> commiteViews = new List<CommiteExecuteModalViewModel>();

            if (CommiteKindId == 0)
                return BadRequest("با خطا مواجه شد");
            if (CommiteKindId > 0)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP005_CommiteExecute_Modal", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("CommiteKindId", CommiteKindId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            CommiteExecuteModalViewModel commiteView = new CommiteExecuteModalViewModel();
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

        [Route("ProjectGetCommiteDetail")]
        [HttpGet]
        public async Task<ApiResult<List<CommiteViewModel>>> GetCommiteDetail(int id)
        {
            List<CommiteViewModel> commiteViews = new List<CommiteViewModel>();

            if (id == 0)
                return BadRequest("با خطا مواجه شد");
            if (id > 0)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP005_CommiteDetail_Read", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("Id", id);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            CommiteViewModel commiteView = new CommiteViewModel();
                            commiteView.Id = int.Parse(dataReader["Id"].ToString());
                            commiteView.ProjectId = StringExtensions.ToNullableInt(dataReader["ProjectId"].ToString());
                            commiteView.CommiteKindId = StringExtensions.ToNullableInt(dataReader["CommiteKindId"].ToString());
                            commiteView.CommiteName = dataReader["CommiteName"].ToString();
                            commiteView.Description = dataReader["Description"].ToString();
                            commiteView.ProjectName = dataReader["ProjectName"].ToString();
                            commiteViews.Add(commiteView);
                        }
                    }
                }
            }
            return Ok(commiteViews);
        }

        [Route("ProjectCommiteKindCombo")]
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

        [Route("ProjectScaleCom")]
        [HttpGet]
        public async Task<ApiResult<List<ProjectScaleComViewModel>>> ProjectScaleCom()
        {
            List<ProjectScaleComViewModel> ScaleCom = new List<ProjectScaleComViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP005_ProjectScale_Com", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (await dataReader.ReadAsync())
                    {
                        ProjectScaleComViewModel ScaleComview = new ProjectScaleComViewModel();
                        ScaleComview.Id = int.Parse(dataReader["Id"].ToString());
                        ScaleComview.ProjectScaleName = dataReader["ProjectScaleName"].ToString();
                        ScaleCom.Add(ScaleComview);
                    }
                }
            }

            return Ok(ScaleCom);
        }

        [Route("ProjectReportScale")]
        [HttpGet]
        public async Task<ApiResult<List<ProjectReportScaleViewModel>>> ProjectReportScale(int yearId,int areaId,int scaleId)
        {
            List<ProjectReportScaleViewModel> commiteViews = new List<ProjectReportScaleViewModel>();

            if (yearId == 0)
                return BadRequest("با خطا مواجه شد");
            if (yearId > 0)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP005_Report_ProjectScale", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("YearId", yearId);
                        sqlCommand.Parameters.AddWithValue("AreaId", areaId);
                        sqlCommand.Parameters.AddWithValue("ScaleId", scaleId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            ProjectReportScaleViewModel commiteView = new ProjectReportScaleViewModel();
                            commiteView.ProjectId = int.Parse(dataReader["ProjectId"].ToString());
                            commiteView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                            commiteView.Expense = Int64.Parse(dataReader["Expense"].ToString());
                            commiteView.ProjectCode = dataReader["ProjectCode"].ToString();
                            commiteView.ProjectName = dataReader["ProjectName"].ToString();
                            commiteViews.Add(commiteView);

                        }

                    }
                }

            }
            return Ok(commiteViews);
        }

        [Route("ProgramOperationUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> ProgramOperationUpdate([FromBody] ProgramOperationUpdateViewModel programOperationUpdate)
        {
            if (programOperationUpdate.Id == 0)
                return BadRequest("با خطا مواجه شد");
            if (programOperationUpdate.Id > 0)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP005_ProgramOperation_Update", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("Id", programOperationUpdate.Id);
                        sqlCommand.Parameters.AddWithValue("ScaleId", programOperationUpdate.ScaleId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();

                    }
                }

            }
            return Ok("بروزرسانی انجام شد");
        }

    }
}
