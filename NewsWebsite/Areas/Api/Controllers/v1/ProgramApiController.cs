
using Microsoft.AspNetCore.Mvc;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using System.Collections.Generic;
using System.Data;
using System;
using System.Threading.Tasks;
using NewsWebsite.Common.Api;
using System.Data.SqlClient;
using NewsWebsite.Common;
using Microsoft.Extensions.Configuration;
using NewsWebsite.ViewModels.Api.Taraz;
using Microsoft.EntityFrameworkCore.Metadata.Conventions;
using Newtonsoft.Json;
using NewsWebsite.ViewModels.Program;

namespace NewsWebsite.Areas.Api.Controllers.v1
{

    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class ProgramApiController : Controller
    {
        public readonly IUnitOfWork _uw;
        private readonly IConfiguration _config;
        public ProgramApiController(IUnitOfWork uw, IConfiguration configuration)
        {
            _config = configuration;
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
                            fetchViewKol.ProgramName= dataReader["ProgramName"].ToString();
                            fecthkol.Add(fetchViewKol);
                        }
                    }
                }
           
            return Ok(fecthkol);

        }

        [Route("ProgramOperation")]
        [HttpGet]
        public async Task<ApiResult<List<ProgramOperationViewModel>>> ProgramOperation(int ProgramId,int areaId)
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
                        fetchViewKol.ProjectCode = dataReader["ProjectCode"].ToString();
                        fetchViewKol.ProjectName = dataReader["ProjectName"].ToString();
                        fetchViewKol.ProjectScaleName = dataReader["ProjectScaleName"].ToString();
                        fetchViewKol.ProjectScaleId = int.Parse(dataReader["ProjectScaleId"].ToString());
                        fecthkol.Add(fetchViewKol);
                    }
                }
            }

            return Ok(fecthkol);

        }


    }

    
}
