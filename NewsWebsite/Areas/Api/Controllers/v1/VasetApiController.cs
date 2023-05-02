using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
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
    public class VasetApiController : Controller
    {
        public readonly IUnitOfWork _uw;
        private readonly IConfiguration _config;
        public VasetApiController(IUnitOfWork uw,IConfiguration configuration)
        {
            _config = configuration;
            _uw = uw;
        }

        [Route("VasetGetAll")]
        [HttpGet]
        public async Task<IActionResult> GetVasets(int yearId, int areaId, int budgetProcessId)
        {
            return Ok(await _uw.VasetRepository.GetAllAsync(yearId, areaId, budgetProcessId));
        }

        [Route("GetModalVaset")]
        [HttpGet]
        public async Task<IActionResult> GetModalVaset(int id, string code, string description, int yearId, int areaId)
        {
            return Ok(await _uw.VasetRepository.ModalDetailsAsync(id, code, description, yearId, areaId));
        }

        [Route("InsertCodeAcc")]
        [HttpGet]
        public async Task<IActionResult> InsertCodeAccAsync(int id)
        {
            if (id == 0)
                return BadRequest("با خطا مواجه شد");
            if (id > 0)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP9000_Mapping_Insert", sqlconnect))
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

        [Route("DeleteCodeAcc")]
        [HttpGet]
        public async Task<ApiResult<string>> DeleteCodeAccAsync(int id)
        {
            if (id == 0)
                return BadRequest("با خطا مواجه شد");
            if (id > 0)
            {
               
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP9000_Mapping_Delete", sqlconnect))
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

        [Route("LinkCodeAcc")]
        [HttpGet]
        public async Task<ApiResult<string>> LinkCodeAcc(int id, int areaId, string codeAcc, string titleAcc)
        {
            if (id == 0)
                return BadRequest("با خطا مواجه شد"); 
            if (id > 0)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP9000_Mapping_Update", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("Id", id);
                        sqlCommand.Parameters.AddWithValue("areaId", areaId);
                        sqlCommand.Parameters.AddWithValue("codeAcc", codeAcc);
                        sqlCommand.Parameters.AddWithValue("titleAcc", titleAcc);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader =await sqlCommand.ExecuteReaderAsync();
                        TempData["notification"] = "ویرایش با موفقیت انجام شد";
                    }
                }

             }
            return Ok("با موفقیت انجام شد");
            
        }

    }


}
