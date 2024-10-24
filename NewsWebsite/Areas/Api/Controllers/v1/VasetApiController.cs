using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Fetch;
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
        public async Task<ApiResult<List<VasetSazmanhaViewModel>>> GetVasets(int yearId, int areaId, int budgetProcessId)
        {
            List<VasetSazmanhaViewModel> fecthViewModel = new List<VasetSazmanhaViewModel>();

            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;User Id=sa;Password=Az12345;Initial Catalog=ProgramBudDb;";
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP9000_Mapping_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand.Parameters.AddWithValue("budgetProcessId", budgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        VasetSazmanhaViewModel fetchView = new VasetSazmanhaViewModel();
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.Code = dataReader["Code"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        fetchView.CodeAcc = dataReader["CodeAcc"].ToString();
                        fetchView.TitleAcc = dataReader["TitleAcc"].ToString();
                        fetchView.PercentBud = int.Parse(dataReader["PercentBud"].ToString());

                        fecthViewModel.Add(fetchView);
                        //dataReader.NextResult();
                    }
                    //TempData["budgetSeprator"] = fecthViewModel;
                }
            }
            return Ok(fecthViewModel);
        }

        [Route("GetModalVaset")]
        [HttpGet]
        public async Task<ApiResult<List<CodeAccUpdateViewModel>>> GetModalVaset(ModalVasetViewModel model)
        {
            List<CodeAccUpdateViewModel> fecthViewModel = new List<CodeAccUpdateViewModel>();

            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;User Id=sa;Password=Az12345;Initial Catalog=ProgramBudDb;";
            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP9000_Mapping_Modal_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", model.yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", model.areaId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        CodeAccUpdateViewModel codeAcc = new CodeAccUpdateViewModel();
                        codeAcc.Id = model.id;
                        codeAcc.IdKol = dataReader["IdKol"].ToString();
                        codeAcc.IdMoein = dataReader["IdMoien"].ToString();
                        codeAcc.IdTafsily = dataReader["IdTafsily"].ToString() == null ? "" : dataReader["IdTafsily"].ToString();
                        codeAcc.Name = dataReader["Name"].ToString();
                        codeAcc.IdTafsily5 = dataReader["IdTafsily5"].ToString() == null ? "" : dataReader["IdTafsily5"].ToString();
                        codeAcc.IdTafsily6 = dataReader["IdTafsily6"].ToString() == null ? "" : dataReader["IdTafsily6"].ToString();
                        codeAcc.Tafsily6Name = dataReader["Tafsily6Name"].ToString() == null ? "" : dataReader["Tafsily6Name"].ToString();
                        codeAcc.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        codeAcc.MarkazHazine = dataReader["MarkazHazine"].ToString();
                        codeAcc.IdTafsily6 = dataReader["IdTafsily6"].ToString();
                        codeAcc.Tafsily6Name = dataReader["Tafsily6Name"].ToString();
                        codeAcc.AreaId = model.areaId;
                        fecthViewModel.Add(codeAcc);
                    }

                }
                sqlconnect.Close();
            }

            return Ok(fecthViewModel);
        }

        [Route("InsertCodeAcc")]
        [HttpGet]
        public async Task<ApiResult<string>> InsertCodeAccAsync(int id)
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

        [Route("DeleteRow")]
        [HttpGet]
        public async Task<ApiResult<string>> AC_DeleteRow(int id)
        {
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP9000_Mapping_Row_Delete", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("id", id);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    sqlconnect.Close();
                }
            }
       
            return Ok("با موفقیت انجام شد");
        }
        
        [Route("DeleteRows")]
        [HttpGet]
        public async Task<ApiResult<string>> AC_DeleteRows(string ids)
        {
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP9000_Mapping_Rows_Delete", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("ids", ids);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    sqlconnect.Close();
                }
            }
       
            return Ok("با موفقیت انجام شد");
        }


        [Route("LinkCodeAcc")]
        [HttpPost]
        public async Task<ApiResult<string>> LinkCodeAcc([FromBody] LinkCodeAccViewModel model)
        {
            if (model.id == 0)
                return BadRequest("با خطا مواجه شد"); 
            if (model.id > 0)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP9000_Mapping_Update", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("Id", model.id);
                        sqlCommand.Parameters.AddWithValue("areaId", model.areaId);
                        sqlCommand.Parameters.AddWithValue("codeAcc", model.codeAcc);
                        sqlCommand.Parameters.AddWithValue("titleAcc", model.titleAcc);
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
