using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data;
using NewsWebsite.Data.Contracts;
using NewsWebsite.Services.Api;
using NewsWebsite.ViewModels.Api.Abstract;
using NewsWebsite.ViewModels.Api.GeneralVm;
using NewsWebsite.ViewModels.Api.UploadFile;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Threading.Tasks;

namespace NewsWebsite.Areas.Api.Controllers.v1
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class GeneralApiController : ControllerBase
    {
        ProgramBuddbContext _context;
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;

        public GeneralApiController(ProgramBuddbContext context, IUnitOfWork uw, IConfiguration configuration)
        {
            _config = configuration;
            _context = context;
            _uw = uw;
        }

        [Route("UploadFile")]
        [HttpPost]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(string), StatusCodes.Status400BadRequest)]
        public async Task<ApiResult<string>> UploadFile(FileUploadModel fileUpload)
        {
            string issuccess="ناموفق";

            if (await WriteFile(fileUpload.FormFile,fileUpload.ProjectId))
            {
               issuccess ="موفق";
            }
            else
            {
                return BadRequest(new { message = "فایل نامعتبر می باشد" });
            }

            return Ok(issuccess);
        }
        private bool CheckIfExcelFile(IFormFile file)
        {
            var extension = FileExtensions.GetContentType(file.FileName);
            return (extension == "Mkv" || extension == "Mp4" || extension == "Png" || extension == "JpG" || extension == "Gif"); // Change the extension based on your need
        }

        private async Task<bool> WriteFile(IFormFile file, int projectId)
        {
            bool isSaveSuccess = false;
            string fileName;
            //try
            //{
                var extension = "." + file.FileName.Split('.')[file.FileName.Split('.').Length - 1];
                fileName = DateTime.Now.Ticks + extension; //Create a new Name for the file due to security reasons.

                var pathBuilt = Path.Combine(Directory.GetCurrentDirectory(), "Resources\\Project\\", projectId.ToString(), "\\");

                if (!Directory.Exists(pathBuilt))
                {
                    Directory.CreateDirectory(pathBuilt);
                }

                var path = Path.Combine(Directory.GetCurrentDirectory(), "Resources\\Project\\", projectId.ToString(), "\\", fileName);

                using (var stream = new FileStream(path, FileMode.Create))
                {
                    await file.CopyToAsync(stream);

                }

                isSaveSuccess = true;
            //}
            //catch (Exception e)
            //{
            //    //log error
            //}

            return isSaveSuccess;
        }

        [Route("AreaFetch")]
        [HttpGet]
        public async Task<IActionResult> AreaFetch(int areaform)
        {

            return Ok(await _uw.Budget_001Rep.AreaFetchAsync(areaform));
        }

        [Route("GetAbstractList")]
        [HttpGet]
        public async Task<ApiResult<List<AbstractViewModel>>> AbstractList(int yearId, int KindId, int StructureId)
        {
            List<AbstractViewModel> abslist = new List<AbstractViewModel>();

            using (SqlConnection sqlConnection = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand cmd = new SqlCommand("SP500_Abstract", sqlConnection))
                {
                    sqlConnection.Open();
                    cmd.Parameters.AddWithValue("yearId", yearId);
                    cmd.Parameters.AddWithValue("KindId", KindId);
                    cmd.Parameters.AddWithValue("StructureId", StructureId);
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await cmd.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        AbstractViewModel fetchView = new AbstractViewModel();
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.AreaName = dataReader["AreaName"].ToString();
                        fetchView.MosavabCurrent = long.Parse(dataReader["MosavabCurrent"].ToString());
                        fetchView.MosavabCivil = long.Parse(dataReader["MosavabCivil"].ToString());
                        fetchView.MosavabRevenue = long.Parse(dataReader["MosavabRevenue"].ToString());
                        fetchView.MosavabDar_Khazane = long.Parse(dataReader["MosavabDar_Khazane"].ToString());
                        fetchView.MosavabFinancial = long.Parse(dataReader["MosavabFinancial"].ToString());
                        fetchView.MosavabPayMotomarkez = long.Parse(dataReader["MosavabPayMotomarkez"].ToString());
                        fetchView.MosavabSanavati = long.Parse(dataReader["MosavabSanavati"].ToString());
                        fetchView.balanceMosavab = long.Parse(dataReader["balanceMosavab"].ToString());
                        fetchView.Resoures = long.Parse(dataReader["Resoures"].ToString());
                        abslist.Add(fetchView);

                        //dataReader.NextResult();
                    }
                }
            }

            return Ok(abslist);
        }

        [Route("YearFetch")]
        [HttpGet]
        public async Task<ApiResult<List<YearViewModel>>> YearFetch(YearParamViewModel yearParam)
        {
            if (yearParam.KindId == 0)
                BadRequest();

            List<YearViewModel> yearViews = new List<YearViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP000_Year", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("KindId", yearParam.KindId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        YearViewModel fetchView = new YearViewModel();
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.YearName = dataReader["YearName"].ToString();
                        yearViews.Add(fetchView);

                        //dataReader.NextResult();
                    }
                }
            }
            return Ok(yearViews);
        }

        [Route("BudgetProcessFetch")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetProcessViewModel>>> BudgetProcess()
        {
            return Ok(await _uw.Budget_001Rep.BudgetProcessFetchAsync());
        }



    }
}
