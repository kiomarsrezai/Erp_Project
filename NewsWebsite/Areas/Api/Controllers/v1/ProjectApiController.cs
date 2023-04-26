using Microsoft.AspNetCore.Mvc;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Commite;
using NewsWebsite.ViewModels.Project;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading;
using System.Threading.Tasks;

namespace NewsWebsite.Areas.Api.Controllers.v1
{

    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class ProjectApiController : Controller
    {
        public readonly IUnitOfWork _uw;
        public ProjectApiController(IUnitOfWork uw)
        {
            _uw = uw;
        }

        [Route("GetProject")]
        [HttpGet]
        public async Task<IActionResult> GetProject(int id)
        {
            if (id == 0)
                return BadRequest("خطایی رخ داده است");

            List<ProjectViewModel> fetchViewlist = new List<ProjectViewModel>();

            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;User Id=sa;Password=Az12345;Initial Catalog=ProgramBudDb;";
            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP005_Project_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("id", id);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
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

        [Route("ProjectInsert")]
        [HttpPost]
        public async Task<IActionResult> InsertProject(int id)
        {
            if (id == 0)
                return BadRequest("با خطا مواجه شد");
            if (id > 0)
            {
                string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";

                using (SqlConnection sqlconnect = new SqlConnection(connection))
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
                string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";

                using (SqlConnection sqlconnect = new SqlConnection(connection))
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
        public async Task<ApiResult<string>> Update(int id,string projectName,string projectCode,int motherId)
        {
            if (id == 0)
                return BadRequest("با خطا مواجه شد");
            if (id > 0)
            {
                string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
                //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;User Id=sa;Password=Az12345;Initial Catalog=ProgramBudDb;";
                using (SqlConnection sqlconnect = new SqlConnection(connection))
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
        public async Task<ApiResult<string>> Commite_Modal(int CommiteKindId, int YearId)
        {
            List<CommiteModalViewModel> commiteViews = new List<CommiteModalViewModel>();
            
            if (CommiteKindId == 0)
                return BadRequest("با خطا مواجه شد");
            if (CommiteKindId > 0)
            {
                string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
                using (SqlConnection sqlconnect = new SqlConnection(connection))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP005_Commite_Modal", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("CommiteKindId", CommiteKindId);
                        sqlCommand.Parameters.AddWithValue("YearId", YearId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (dataReader.HasRows)
                        {
                            CommiteModalViewModel commiteView = new CommiteModalViewModel();
                            commiteView.Id = int.Parse(dataReader["Id"].ToString());
                            commiteView.dates = dataReader["dates"].ToString();
                            commiteView.number= StringExtensions.ToNullableInt(dataReader["number"].ToString());
                            commiteViews.Add(commiteView);

                        }

                    }
                }

            }
            return Ok(commiteViews);

        }

        [Route("ProjectExecute_Modal")]
        [HttpGet]
        public async Task<ApiResult<string>> CommiteExecute_Modal(int id, int CommiteKindId, int YearId)
        {
            List<CommiteExecuteModalViewModel> commiteViews = new List<CommiteExecuteModalViewModel>();

            if (id == 0)
                return BadRequest("با خطا مواجه شد");
            if (id > 0)
            {
                string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
                using (SqlConnection sqlconnect = new SqlConnection(connection))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP005_CommiteExecute_Modal", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("Id", id);
                        sqlCommand.Parameters.AddWithValue("CommiteKindId", CommiteKindId);
                        sqlCommand.Parameters.AddWithValue("YearId", YearId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (dataReader.HasRows)
                        {
                            CommiteExecuteModalViewModel commiteView = new CommiteExecuteModalViewModel();
                            commiteView.Id = int.Parse(dataReader["Id"].ToString());
                            commiteView.FirstName = dataReader["FirstName"].ToString();
                            commiteView.LastName = dataReader["LastName"].ToString();
                            commiteView.DateStart= dataReader["DateStart"].ToString();
                            commiteView.DateEnd = dataReader["DateEnd"].ToString();
                            commiteView.Responsibility= dataReader["Responsibility"].ToString();
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
        public async Task<ApiResult<string>> GetCommiteDetail(int id, int CommiteKindId, int YearId)
        {
            List<CommiteViewModel> commiteViews = new List<CommiteViewModel>();

            if (id == 0)
                return BadRequest("با خطا مواجه شد");
            if (id > 0)
            {
                string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
                using (SqlConnection sqlconnect = new SqlConnection(connection))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP005_CommiteDetail_Read", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("Id", id);
                        sqlCommand.Parameters.AddWithValue("CommiteKindId", CommiteKindId);
                        sqlCommand.Parameters.AddWithValue("YearId", YearId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (dataReader.HasRows)
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
        public async Task<ApiResult<string>> CommiteKindCombo()
        {
            List<CommiteComboboxViewModel> commiteViews = new List<CommiteComboboxViewModel>();

                string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
                using (SqlConnection sqlconnect = new SqlConnection(connection))
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
