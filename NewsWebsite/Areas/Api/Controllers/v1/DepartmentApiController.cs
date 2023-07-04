using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
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


    }
}
