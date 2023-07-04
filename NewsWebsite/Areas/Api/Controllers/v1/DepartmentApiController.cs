
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Budget.BudgetSeprator;
using NewsWebsite.ViewModels.Api.Car;
using NewsWebsite.ViewModels.Api.Contract;
using NewsWebsite.ViewModels.Api.Department;
using NewsWebsite.ViewModels.Api.Public;
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
    public class DepartmentApiController : Controller
    {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        public DepartmentApiController(IUnitOfWork uw, IConfiguration config)
        {
            _config = config;
            _uw = uw;
        }

        [Route("DepartmentCom")]
        [HttpGet]
        public async Task<ApiResult<List<DepartmentComViewModel>>> AC_DepartmentCom()
        {
            List<DepartmentComViewModel> dataViews = new List<DepartmentComViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP003_Department_Com", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (await dataReader.ReadAsync())
                    {
                        DepartmentComViewModel data = new DepartmentComViewModel();
                        data.Id = int.Parse(dataReader["Id"].ToString());
                        data.DepartmentCode = dataReader["DepartmentCode"].ToString();
                        data.DepartmentName = dataReader["DepartmentName"].ToString();
                        dataViews.Add(data);
                    }
                }
            }
            return Ok(dataViews);
        }


        [Route("DepartmentAcceptorRead")]
        [HttpGet]
        public async Task<ApiResult<List<DepartmentAcceptorViewModel>>> Ac_DepartmentAcceptorRead()
        {
            List<DepartmentAcceptorViewModel> ContractView = new List<DepartmentAcceptorViewModel>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP003_DepartmentAcceptor_Read", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            DepartmentAcceptorViewModel data = new DepartmentAcceptorViewModel();
                            data.Id = int.Parse(dataReader["Id"].ToString());
                            data.DepartmanId = StringExtensions.ToNullableInt(dataReader["DepartmanId"].ToString());
                            data.AreaId = StringExtensions.ToNullableInt(dataReader["AreaId"].ToString());
                            data.DepartmentCode = dataReader["DepartmentCode"].ToString();
                            data.DepartmentName = dataReader["DepartmentName"].ToString();
                            data.AreaName = dataReader["AreaName"].ToString();
                            ContractView.Add(data);
                        }
                    }
                    sqlconnect.Close();
                }
            }
            return Ok(ContractView);
        }


        [Route("DepartmentAcceptorInsert")]
        [HttpPost]
        public async Task<ApiResult<string>> AC_DepartmentAcceptorInsert([FromBody] DepartmentAcceptorInsertViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP003_DepartmentAcceptor_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("DepartmanId", param.DepartmanId);
                    sqlCommand.Parameters.AddWithValue("AreaId", param.AreaId);
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

        [Route("DepartmentAcceptorDelete")]
        [HttpPost]
        public async Task<ApiResult<string>> AC_DepartmentAcceptorDelete([FromBody] PublicParamIdViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP003_DepartmentAcceptor_Delete", sqlconnect))
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
            if (string.IsNullOrEmpty(readercount)) return Ok("با موفقیت انجام شد");
            else
                return BadRequest(readercount);
        }


        [Route("DepartmentAcceptorUserRead")]
        [HttpGet]
        public async Task<ApiResult<List<DepartmentAcceptorUserReadViewModel>>> Ac_DepartmentAcceptorUserRead(PublicParamIdViewModel param)
        {
            List<DepartmentAcceptorUserReadViewModel> ContractView = new List<DepartmentAcceptorUserReadViewModel>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP003_DepartmentAcceptorUser_Read", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("Id", param.Id);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            DepartmentAcceptorUserReadViewModel data = new DepartmentAcceptorUserReadViewModel();
                     
                            data.Id = int.Parse(dataReader["Id"].ToString());
                            data.FirstName = dataReader["FirstName"].ToString();
                            data.LastName = dataReader["LastName"].ToString();
                            data.Resposibility = dataReader["Resposibility"].ToString();  
                            data.UserId = int.Parse(dataReader["UserId"].ToString());
                            ContractView.Add(data);
                        }
                    }
                    sqlconnect.Close();
                }
            }
            return Ok(ContractView);
        }

        [Route("EmployeeModal")]
        [HttpGet]
        public async Task<ApiResult<List<EmployeeModalViewModel>>> Ac_EmployeeModal(PublicParamIdViewModel param)
        {
            List<EmployeeModalViewModel> dataview = new List<EmployeeModalViewModel>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP003_Employee_Read", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            EmployeeModalViewModel data = new EmployeeModalViewModel();

                            data.Id = int.Parse(dataReader["Id"].ToString());
                            data.FirstName = dataReader["FirstName"].ToString();
                            data.LastName = dataReader["LastName"].ToString();
                            data.Bio = dataReader["Bio"].ToString();
                            dataview.Add(data);
                        }
                    }
                    sqlconnect.Close();
                }
            }
            return Ok(dataview);
        }

        [Route("DepartmentAcceptorEmployeeInsert")]
        [HttpPost]
        public async Task<ApiResult<string>> AC_DepartmentAcceptorEmployeeInsert([FromBody] DepartmentAcceptorEmployeeInsertViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP003_DepartmentAcceptorUser_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("EmployeeId", param.EmployeeId);
                    sqlCommand.Parameters.AddWithValue("DepartmentAcceptorId", param.DepartmentAcceptorId);
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

        [Route("DepartmentAcceptorEmployeeDelete")]
        [HttpPost]
        public async Task<ApiResult<string>> AC_DepartmentAcceptorEmployeeDelete([FromBody] PublicParamIdViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP003_DepartmentAcceptorUser_Delete", sqlconnect))
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
            if (string.IsNullOrEmpty(readercount)) return Ok("با موفقیت انجام شد");
            else
                return BadRequest(readercount);
        }

    }
}
