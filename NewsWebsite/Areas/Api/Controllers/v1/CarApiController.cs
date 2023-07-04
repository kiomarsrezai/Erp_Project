using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Car;
using NewsWebsite.ViewModels.Api.Contract;
using NewsWebsite.ViewModels.Api.Public;
using NewsWebsite.ViewModels.Commite;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace NewsWebsite.Areas.Api.Controllers.v1
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class CarApiController : Controller
    {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        public CarApiController(IUnitOfWork uw, IConfiguration config)
        {
            _config = config;
            _uw = uw;
        }
        [Route("CarKindCom")]
        [HttpGet]
        public async Task<ApiResult<List<KindViewModel>>> AC_CarKindCom()
        {
            List<KindViewModel> dataViews = new List<KindViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP050_Kind_Com", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (await dataReader.ReadAsync())
                    {
                        KindViewModel data = new KindViewModel();
                        data.Id = int.Parse(dataReader["Id"].ToString());
                        data.KindName = dataReader["KindName"].ToString();
                        dataViews.Add(data);
                    }
                }
            }
            return Ok(dataViews);
        }


        [Route("CarSystemCom")]
        [HttpGet]
        public async Task<ApiResult<List<SystemViewModel>>> AC_CarSystemCom()
        {
            List<SystemViewModel> dataViews = new List<SystemViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP050_Syetem_Com", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (await dataReader.ReadAsync())
                    {
                        SystemViewModel data = new SystemViewModel();
                        data.Id = int.Parse(dataReader["Id"].ToString());
                        data.SystemName = dataReader["SystemName"].ToString();
                        dataViews.Add(data);
                    }
                }
            }
            return Ok(dataViews);
        }


        [Route("TipeCom")]
        [HttpGet]
        public async Task<ApiResult<List<TipeViewModel>>> AC_TipeCom()
        {
            List<TipeViewModel> dataViews = new List<TipeViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP050_Tipe_Com", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (await dataReader.ReadAsync())
                    {
                        TipeViewModel data = new TipeViewModel();
                        data.Id = int.Parse(dataReader["Id"].ToString());
                        data.TipeName = dataReader["TipeName"].ToString();
                        dataViews.Add(data);
                    }
                }
            }
            return Ok(dataViews);
        }


        [Route("CarRead")]
        [HttpGet]
        public async Task<ApiResult<List<CarReadViewModel>>> AC_CarRead(PublicParamIdViewModel param)
        {
            List<CarReadViewModel> dataViews = new List<CarReadViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP050_Car_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", param.Id);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (await dataReader.ReadAsync())
                    {
                        CarReadViewModel data = new CarReadViewModel();
                        data.Id = int.Parse(dataReader["Id"].ToString());
                        data.Pelak = dataReader["Pelak"].ToString();
                        data.KindMotorId =int.Parse(dataReader["KindMotorId"].ToString());
                        data.KindId = StringExtensions.ToNullableInt(dataReader["KindId"].ToString());
                        data.KindName = dataReader["KindName"].ToString();
                        data.SystemId = StringExtensions.ToNullableInt(dataReader["SystemId"].ToString());
                        data.SystemName = dataReader["SystemName"].ToString();
                        data.TipeId = StringExtensions.ToNullableInt(dataReader["TipeId"].ToString());
                        data.TipeName = dataReader["TipeName"].ToString();
                        data.ProductYear = dataReader["ProductYear"].ToString();
                        data.Color = dataReader["Color"].ToString();
                        dataViews.Add(data);
                    }
                        }
            }
            return Ok(dataViews);
        }


        [Route("CarInsert")]
        [HttpPost]
        public async Task<ApiResult<CarReadViewModel>> AC_CarInsert([FromBody] CarInsertParamViewModel param)
        {
            CarReadViewModel data = new CarReadViewModel();
           // string readercount = null;

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP050_Car_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Pelak", param.Pelak);
                    sqlCommand.Parameters.AddWithValue("KindMotorId", param.KindMotorId);
                    sqlCommand.Parameters.AddWithValue("KindId", param.KindId);
                    sqlCommand.Parameters.AddWithValue("SystemId", param.SystemId);
                    sqlCommand.Parameters.AddWithValue("TipeId", param.TipeId);
                    sqlCommand.Parameters.AddWithValue("ProductYear", param.ProductYear);
                    sqlCommand.Parameters.AddWithValue("Color", param.Color);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        data.Id = int.Parse(dataReader["Id"].ToString());
                        data.Pelak = dataReader["Pelak"].ToString();
                        data.KindMotorId = int.Parse(dataReader["KindMotorId"].ToString());
                        data.KindId = StringExtensions.ToNullableInt(dataReader["KindId"].ToString());
                        data.KindName = dataReader["KindName"].ToString();
                        data.SystemId = StringExtensions.ToNullableInt(dataReader["SystemId"].ToString());
                        data.SystemName = dataReader["SystemName"].ToString();
                        data.TipeId = StringExtensions.ToNullableInt(dataReader["TipeId"].ToString());
                        data.TipeName = dataReader["TipeName"].ToString();
                        data.ProductYear = dataReader["ProductYear"].ToString();
                        data.Color = dataReader["Color"].ToString();

                        //if (dataReader["Message_DB"].ToString() != null) readercount = dataReader["Message_DB"].ToString();
                    }
                }
            }
            //if (string.IsNullOrEmpty(readercount)) return Ok("با موفقیت انجام شد");
            //else
            return Ok(data);
        }

        [Route("CarUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> AC_CarUpdate([FromBody] CarUpdateParamViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP050_Car_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", param.Id);
                    sqlCommand.Parameters.AddWithValue("Pelak", param.Pelak);
                    sqlCommand.Parameters.AddWithValue("KindMotorId", param.KindMotorId);
                    sqlCommand.Parameters.AddWithValue("KindId", param.KindId);
                    sqlCommand.Parameters.AddWithValue("SystemId", param.SystemId);
                    sqlCommand.Parameters.AddWithValue("TipeId", param.TipeId);
                    sqlCommand.Parameters.AddWithValue("ProductYear", param.ProductYear);
                    sqlCommand.Parameters.AddWithValue("Color", param.Color);
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


        [Route("CarDelete")]
        [HttpPost]
        public async Task<ApiResult<string>> AC_CarDelete([FromBody] PublicParamIdViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP050_Car_Delete", sqlconnect))
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

        [Route("CarSearch")]
        [HttpGet]
        public async Task<ApiResult<List<CarSearchViewModel>>> AC_CarSearch()
        {
            List<CarSearchViewModel> dataViews = new List<CarSearchViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP050_Car_Search", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (await dataReader.ReadAsync())
                    {
                        CarSearchViewModel data = new CarSearchViewModel();
                        data.Id = int.Parse(dataReader["Id"].ToString());
                        data.Pelak = dataReader["Pelak"].ToString();
                        data.KindMotorId = int.Parse(dataReader["KindMotorId"].ToString());
                        data.KindId = StringExtensions.ToNullableInt(dataReader["KindId"].ToString());
                        data.KindName = dataReader["KindName"].ToString();
                        data.SystemId = StringExtensions.ToNullableInt(dataReader["SystemId"].ToString());
                        data.SystemName = dataReader["SystemName"].ToString();
                        data.TipeId = StringExtensions.ToNullableInt(dataReader["TipeId"].ToString());
                        data.TipeName = dataReader["TipeName"].ToString();
                        data.ProductYear = dataReader["ProductYear"].ToString();
                        data.Color = dataReader["Color"].ToString();
                        dataViews.Add(data);
                    }
                }
            }

            return Ok(dataViews);
        }




    }
}
