
using System.Collections;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Budget.BudgetProject;
using NewsWebsite.ViewModels.Api.Public;
using NewsWebsite.ViewModels.Program;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using NewsWebsite.Data;
using System.Linq;
using Microsoft.EntityFrameworkCore;

namespace NewsWebsite.Areas.Api.Controllers.v1
{

    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class ProgramApiController : Controller
    {
        public readonly IUnitOfWork _uw;
        private readonly IConfiguration _config;
        private readonly ProgramBuddbContext _context;

        public ProgramApiController(IUnitOfWork uw, IConfiguration configuration,ProgramBuddbContext context)
        {
            _config = configuration;
            _context = context;
            _uw = uw;
        }

        [Route("ProgramList")]
        [HttpGet]
        public async Task<ApiResult<List<ProgramViewModel>>> ProgramList()
        {
            List<ProgramViewModel> fecthkol = new List<ProgramViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP005_Program", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        ProgramViewModel fetchViewKol = new ProgramViewModel();
                        fetchViewKol.Id = int.Parse(dataReader["Id"].ToString());
                        fetchViewKol.ProgramName = dataReader["ProgramName"].ToString();
                        fecthkol.Add(fetchViewKol);
                    }
                }
            }

            return Ok(fecthkol);

        }


        [Route("ProgramOperation")]
        [HttpGet]
        public async Task<ApiResult<List<ProgramOperationViewModel>>> ProgramOperation(int ProgramId, int areaId)
        {
            List<ProgramOperationViewModel> fecthkol = new List<ProgramOperationViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP005_ProgramOperation", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("ProgramId", ProgramId);
                    sqlCommand.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        ProgramOperationViewModel fetchViewKol = new ProgramOperationViewModel();
                        fetchViewKol.Id = int.Parse(dataReader["Id"].ToString());
                        fetchViewKol.ProjectId = int.Parse(dataReader["ProjectId"].ToString());
                        fetchViewKol.ProjectCode = dataReader["ProjectCode"].ToString();
                        fetchViewKol.ProjectName = dataReader["ProjectName"].ToString();
                        fetchViewKol.ProjectScaleName = dataReader["ProjectScaleName"].ToString();
                        fetchViewKol.ProjectScaleId = StringExtensions.ToNullableInt(dataReader["ProjectScaleId"].ToString());
                        fecthkol.Add(fetchViewKol);
                    }
                }
            }
            return Ok(fecthkol);
        }


        [Route("ProgramOperationUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> ProgramOperationUpdate([FromBody] ProgramOperationUpdateViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP005_ProgramOperation_Update", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("ProjectId", param.ProjectId);
                        sqlCommand.Parameters.AddWithValue("ScaleId", param.ScaleId);
                        sqlCommand.Parameters.AddWithValue("ProjectName", param.ProjectName);
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


        [Route("ProgramOperationDelete")]
        [HttpPost]
        public async Task<ApiResult<string>> Ac_ProgramOperationDelete([FromBody] DeletePublicParamViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP005_ProgramOperation_Delete", sqlconnect))
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

        
        
        
        [Route("ProgramDetailsList")]
        [HttpGet]
        public async Task<ApiResult<List<ProgramDetailsReadViewModel>>> ProgramDetailsList(int programId){
            
            
            List<ProgramDetailsReadViewModel> fecthkol = new List<ProgramDetailsReadViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_ProgramDetails_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("@programId", programId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    
                    while (dataReader.Read())
                    {
                        ProgramDetailsReadViewModel fetchViewKol = new ProgramDetailsReadViewModel();
                        fetchViewKol.Name1 = dataReader["name1"].ToString();
                        fetchViewKol.Name2 = dataReader["name2"].ToString();
                        fetchViewKol.Name3 = dataReader["name3"].ToString();
                        fetchViewKol.Code = dataReader["Code"].ToString();
                        fetchViewKol.Color = dataReader["Color"].ToString();
                        fecthkol.Add(fetchViewKol);
                    }
                }
            }
            return Ok(fecthkol);
        }

        
        
        [Route("ProgramDetailsListCombo")]
        [HttpGet]
        public async Task<ApiResult<object>> ProgramDetailsListCombo(int programId,int motherId){
            var list = await _context.TblProgramDetails.Where(c => c.ProgramId == programId).Where(c => c.MotherId == motherId).ToListAsync();
            return Ok(list);
        }


        
        [Route("ProgramBudgetRead")]
        [HttpGet]
        public async Task<ApiResult<List<ProgramBudgetReadViewModel>>> ProgramBudgetRead(int YearId, int AreaId,int BudgetProcessId)
        {
            List<ProgramBudgetReadViewModel> fecthkol = new List<ProgramBudgetReadViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_ProgramBudget_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", YearId);
                    sqlCommand.Parameters.AddWithValue("AreaId", AreaId);
                    sqlCommand.Parameters.AddWithValue("BudgetProcessId", BudgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    
                    while (dataReader.Read())
                    {
                        ProgramBudgetReadViewModel fetchViewKol = new ProgramBudgetReadViewModel();
                        fetchViewKol.Id = int.Parse(dataReader["Id"].ToString());
                        fetchViewKol.Code = dataReader["Code"].ToString();
                        fetchViewKol.Description = dataReader["Description"].ToString();
                        fetchViewKol.Mosavab = dataReader["Mosavab"].ToString();
                        fetchViewKol.ProgramDetailsId = dataReader["ProgramDetailsId"].ToString();
                        fetchViewKol.ProgramName = dataReader["ProgramName"].ToString();
                        fetchViewKol.ProgramCode = dataReader["ProgramCode"].ToString();
                        fetchViewKol.ProgramColor = dataReader["ProgramColor"].ToString();
                        fetchViewKol.BDPAId = dataReader["BDPAId"].ToString();
                        fecthkol.Add(fetchViewKol);
                    }
                }
            }
            return Ok(fecthkol);
        }


        
        [Route("ProgramBudgetUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> ProgramBudgetUpdate(int programDetailsId,string ids)
        {
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_ProgramBudget_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("programDetailsId", programDetailsId);
                    sqlCommand.Parameters.AddWithValue("ids", ids);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    sqlconnect.Close();
                }
            }
       
            return Ok("با موفقیت انجام شد");
        }

        
        
    }

}

