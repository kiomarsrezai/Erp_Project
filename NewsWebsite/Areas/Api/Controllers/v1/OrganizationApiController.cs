using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Areas.Admin.Controllers;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Organization;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace NewsWebsite.Areas.Api.Controllers.v1
{


    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class OrganizationApiController : BaseController
    {
        public readonly IUnitOfWork _uw;
        private readonly IConfiguration _config;

        public OrganizationApiController(IUnitOfWork uw,IConfiguration configuration)
        {
            _config = configuration;
            _uw = uw;
        }

        [Route("DepartmentDelete")]
        [HttpPost]
        public async Task<ApiResult<string>> OrganizationDelete([FromBody] OrganizationDelParamViewModel viewModel)
        {            
            if (viewModel.Id == 0) 
                return BadRequest("با خطا مواجه شد");

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP003_Department_Delete", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("id", viewModel.Id);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                }
            }
            return Ok("با موفقیت انجام شد");
        }

        [Route("DepartmentInsert")]
        [HttpPost]
        public virtual async Task<ApiResult<string>> GetOrganization([FromBody] OrganizationInsertViewModel paramViewModel)
        {
            if (paramViewModel.MotherId == 0)
                paramViewModel.MotherId = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP003_Department_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("MotherId", paramViewModel.MotherId);
                    sqlCommand.Parameters.AddWithValue("AreaId", paramViewModel.AreaId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                }
            }
            return Ok("با موفقیت انجام شد");
        }

        [Route("DepartmentRead")]
        [HttpGet]
        public async Task<ApiResult<List<OrganizationsViewModel>>> GetOrganizationList(OrganizationReadParamViewModel paramViewModel)
        {
            List<OrganizationsViewModel> OrganizationsViewModels = new List<OrganizationsViewModel>();

            if (paramViewModel.AreaId == 0)
                return BadRequest();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP003_Department_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("AreaId", paramViewModel.AreaId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        OrganizationsViewModel Organization = new OrganizationsViewModel();
                        Organization.Id = int.Parse(dataReader["Id"].ToString());
                        Organization.DepartmentName = dataReader["DepartmentName"].ToString();
                        Organization.MotherId = StringExtensions.ToNullableInt(dataReader["MotherId"].ToString());
                        Organization.DepartmentCode = dataReader["DepartmentCode"].ToString();
                        OrganizationsViewModels.Add(Organization);
                    }
                }
            }
            return Ok(OrganizationsViewModels);
        }

        [Route("DepartmentUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> OrganizationUpadte([FromBody] OrganizationUpdateViewModel paramViewModel)
        {

            if (paramViewModel.MotherId == 0)
                    paramViewModel.MotherId=null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP003_Department_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", paramViewModel.Id);
                    sqlCommand.Parameters.AddWithValue("DepartmentName", paramViewModel.DepartmentName);
                    sqlCommand.Parameters.AddWithValue("DepartmentCode", paramViewModel.DepartmentCode);
                    sqlCommand.Parameters.AddWithValue("MotherId", paramViewModel.MotherId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                }
            }
            return Ok("با موفقیت انجام شد");
        }

    }
}
