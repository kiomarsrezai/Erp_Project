using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.FileProviders;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Contract;
using NewsWebsite.ViewModels.Api.Public;
using Newtonsoft.Json;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq.Dynamic.Core;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Data;
using NewsWebsite.Data.Models;
using NewsWebsite.Data.Models.AmlakInfo;
using NewsWebsite.Data.Repositories;
using NewsWebsite.ViewModels;
using NewsWebsite.ViewModels.Api.Contract.AmlakInfo;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using System.Linq;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;

namespace NewsWebsite.Areas.Api.Controllers.v1.amlak
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class SupplierApiController : EnhancedController
    {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        protected readonly ProgramBuddbContext _db;

        public SupplierApiController(IUnitOfWork uw, IConfiguration config, IWebHostEnvironment webHostEnvironment,ProgramBuddbContext db)
        {
            _config = config;
            _uw = uw;
            _webHostEnvironment = webHostEnvironment;
            _db=db;

        }

        [Route("List")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakInfoSupplierUpdateVm>>> SuppliersList(string txtSerach){
            await CheckUserAuth(_db);

            List<AmlakInfoSupplierUpdateVm> ContractView = new List<AmlakInfoSupplierUpdateVm>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP011_SuppliersAmlak_List", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("txtSerach", txtSerach);
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            AmlakInfoSupplierUpdateVm data = new AmlakInfoSupplierUpdateVm();
                            data.Id = int.Parse(dataReader["Id"].ToString());
                            data.FirstName = dataReader["FirstName"].ToString();
                            data.LastName = dataReader["LastName"].ToString();
                            data.Mobile = dataReader["Mobile"].ToString();
                            data.CodePost = dataReader["CodePost"].ToString();
                            data.Address = dataReader["Address"].ToString();
                            data.NationalCode = dataReader["NationalCode"].ToString();
                            ContractView.Add(data);
                        }
                    }
                    sqlconnect.Close();
                }
            }
            return Ok(ContractView);
        }

        [Route("Read")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakInfoSupplierUpdateVm>>> SuppliersRead(PublicParamIdViewModel param){
            await CheckUserAuth(_db);

            List<AmlakInfoSupplierUpdateVm> ContractView = new List<AmlakInfoSupplierUpdateVm>();
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP011_SuppliersAmlak_Read", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("Id", param.Id);
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (await dataReader.ReadAsync())
                        {
                            AmlakInfoSupplierUpdateVm data = new AmlakInfoSupplierUpdateVm();
                            data.Id = int.Parse(dataReader["Id"].ToString());
                            data.FirstName = dataReader["FirstName"].ToString();
                            data.LastName = dataReader["LastName"].ToString();
                            data.Mobile = dataReader["Mobile"].ToString();
                            data.CodePost = dataReader["CodePost"].ToString();
                            data.Address = dataReader["Address"].ToString();
                            data.NationalCode = dataReader["NationalCode"].ToString();
                            ContractView.Add(data);
                        }
                    }
                    sqlconnect.Close();
                }
            }
            return Ok(ContractView);
        }

        [Route("Insert")]
        [HttpPost]
        public async Task<ApiResult<AmlakInfoSupplierUpdateVm>> SupplierInsert([FromBody] AmlakInfoSupplierInsertVm param){
            await CheckUserAuth(_db);

            var user = await _db.Suppliers.Where(c => c.NationalCode == param.NationalCode).FirstOrDefaultAsync();
            if (user != null)
                return BadRequest("کاربر با این کد ملی قبلا ثبت شده است.");
            
            AmlakInfoSupplierUpdateVm supp = new AmlakInfoSupplierUpdateVm();
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP012_SuppliersAmlak_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("FirstName", param.FirstName);
                    sqlCommand.Parameters.AddWithValue("LastName", param.LastName);
                    sqlCommand.Parameters.AddWithValue("Mobile", param.Mobile);
                    sqlCommand.Parameters.AddWithValue("CodePost", param.CodePost);
                    sqlCommand.Parameters.AddWithValue("Address", param.Address);
                    sqlCommand.Parameters.AddWithValue("NationalCode", param.NationalCode);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    try{

                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (await dataReader.ReadAsync())
                    {
                        supp.Id = int.Parse(dataReader["id"].ToString());
                        supp.FirstName = dataReader["FirstName"].ToString();
                        supp.LastName = dataReader["LastName"].ToString();
                        supp.Mobile = dataReader["Mobile"].ToString();
                        supp.CodePost = dataReader["CodePost"].ToString();
                        supp.Address = dataReader["Address"].ToString();
                        supp.NationalCode = dataReader["NationalCode"].ToString();
                    }
                    }
                    catch (Exception e){
                        Helpers.dd(e.InnerException);
                    }
                }
            }
            return Ok(supp);
        }

        [Route("Update")]
        [HttpPost]
        public async Task<ApiResult<string>> SupplierUpdate([FromBody] AmlakInfoSupplierUpdateVm param){
            await CheckUserAuth(_db);

            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP011_SuppliersAmlak_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", param.Id);
                    sqlCommand.Parameters.AddWithValue("FirstName", param.FirstName);
                    sqlCommand.Parameters.AddWithValue("LastName", param.LastName);
                    sqlCommand.Parameters.AddWithValue("Mobile", param.Mobile);
                    sqlCommand.Parameters.AddWithValue("CodePost", param.CodePost);
                    sqlCommand.Parameters.AddWithValue("Address", param.Address);
                    sqlCommand.Parameters.AddWithValue("NationalCode", param.NationalCode);

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

        [Route("Delete")]
        [HttpPost]
        public async Task<ApiResult<string>> SupplierDelete([FromBody] PublicParamIdViewModel param){
            await CheckUserAuth(_db);

            //string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP011_SuppliersAmlak_Delete", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", param.Id);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();

                }
            }
            return Ok("با موفقیت انجام شد");
        }

    }
}
