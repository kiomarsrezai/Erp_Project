﻿using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Routing;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data;
using NewsWebsite.Data.Contracts;
using NewsWebsite.Entities;
using NewsWebsite.Services.Api;
using NewsWebsite.ViewModels.Api.Abstract;
using NewsWebsite.ViewModels.Api.GeneralVm;
using NewsWebsite.ViewModels.Api.UploadFile;
using NewsWebsite.ViewModels.Api.UsersApi;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace NewsWebsite.Areas.Api.Controllers.v1
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    public class GeneralApiController : ControllerBase
    {
        ProgramBuddbContext _context;
        public readonly IConfiguration _config;
        public readonly ISqlDataAccess _sqlDataAccess;
        public readonly IUnitOfWork _uw;
        public readonly IWebHostEnvironment _environment;
        private readonly IFileService fileService; 

        public GeneralApiController(ProgramBuddbContext context, IUnitOfWork uw, IConfiguration configuration, IWebHostEnvironment environment, ISqlDataAccess sqlDataAccess)
        {
            _config = configuration;
            _context = context;
            _uw = uw;
            _environment = environment;
            _sqlDataAccess = sqlDataAccess;
        }

        [Route("UploadFile")]
        [HttpPost]
        public async Task<ApiResult<string>> UploadFile(FileUploadModel fileUpload)
        {
            string issuccess = "ناموفق";

            if (await WriteFile(fileUpload.FormFile, fileUpload.ProjectId))
            {
                issuccess = "موفق";
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
            try
            {
                var extension = "." + file.FileName.Split('.')[file.FileName.Split('.').Length - 1];
                fileName = DateTime.Now.Ticks + extension; //Create a new Name for the file due to security reasons.

                var folderName = Path.Combine(@"F:\Resources\Project\",projectId.ToString()+"\\");

                if (!Directory.Exists(folderName))
                {
                    Directory.CreateDirectory(folderName);
                }

                var path = Path.Combine(folderName, fileName);

                using (var stream = new FileStream(path, FileMode.Create))
                {
                    await file.CopyToAsync(stream);

                }
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP0_FileDetail_Insert", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("ProjectId", projectId);
                        sqlCommand.Parameters.AddWithValue("FileName", fileName);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    }
                }
                isSaveSuccess = true;
            }
            catch (Exception e)
            {
                e.Source = "Error";
                isSaveSuccess &= false;
            }

            return isSaveSuccess;
        }

        //[route("areafetch")]
        //[httpget]
        //public async task<apiresult<list<areaviewmodel>>> areafetch(int areaform)
        //{
        //    return ok(await _uw.budget_001rep.areafetchasync(areaform));
        //}

        [Route("AreaFetch")]
        [HttpGet]
        public async Task<ApiResult<List<AreaViewModel>>> AreaFetch(int areaform)
        {
            var data=await _sqlDataAccess.LoadData<AreaViewModel, dynamic>(storedProcedure: "SP000_Area", new { areaform=areaform });
            return Ok(data);
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


        [Route("GetAttachFiles")]
        [HttpGet]
        public async Task<ApiResult<List<GetListAttachFiles>>> GetAttachFiles(int projectId)
        {
            if (projectId== 0) BadRequest();

            List<GetListAttachFiles> yearViews = new List<GetListAttachFiles>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP000_GetListAttachFiles", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("ProjectId", projectId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        GetListAttachFiles fetchView = new GetListAttachFiles();
                        fetchView.ProjectCode = int.Parse(dataReader["ProjectCode"].ToString());
                        fetchView.ProjectId = int.Parse(dataReader["ProjectId"].ToString());
                        fetchView.FileName = dataReader["FileName"].ToString();
                        fetchView.FileDetailId = int.Parse(dataReader["FileDetailId"].ToString());
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


        //[Route("EmployeeRead")]
        //[HttpGet]
        //public async Task<ApiResult<List<EmployeeViewModel>>> AC_EmployeeRead()
        //{
        //    List<EmployeeViewModel> data = new List<EmployeeViewModel>();

        //    using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
        //    {
        //        using (SqlCommand sqlCommand = new SqlCommand("SP000_Employee_Read", sqlconnect))
        //        {
        //            sqlconnect.Open();
        //            sqlCommand.CommandType = CommandType.StoredProcedure;
        //            SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
        //            while (dataReader.Read())
        //            {
        //                EmployeeViewModel row = new EmployeeViewModel();

        //                row.Id = int.Parse(dataReader["Id"].ToString());
        //                row.UserName = dataReader["UserName"].ToString();
        //                row.NormalizedUserName = dataReader["NormalizedUserName"].ToString();
        //                row.Email = dataReader["Email"].ToString();
        //                row.NormalizedEmail = dataReader["NormalizedEmail"].ToString();
        //                row.PhoneNumber = dataReader["PhoneNumber"].ToString();
        //                row.FirstName = dataReader["FirstName"].ToString();
        //                row.LastName = dataReader["LastName"].ToString();
        //                row.Bio = dataReader["Bio"].ToString();
        //                row.BirthDate = dataReader["BirthDate"].ToString();
        //                row.IsActive = StringExtensions.ToNullablebool(dataReader["IsActive"].ToString());
        //                row.Gender =  StringExtensions.ToNullableInt(dataReader["Gender"].ToString());

        //                data.Add(row);
        //            }
        //        }
        //    }
        //    return Ok(data);
        //}
    
    
    
    }
}
