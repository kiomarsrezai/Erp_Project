
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

namespace NewsWebsite.Areas.Api.Controllers.v1
{

    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class TarazApiController : Controller
    {
        public readonly IUnitOfWork _uw;
        private readonly IConfiguration _config;
        public TarazApiController(IUnitOfWork uw, IConfiguration configuration)
        {
            _config = configuration;
            _uw = uw;
        }

        [Route("GetTaraz")]
        [HttpGet]
        public async Task<ApiResult<List<TarazKolMoienViewModel>>> GetTarazKol(int yearId, int areaId, long? MoienId = null, long? TafsilyId = null, int? KindId = null, int? MarkazHazine = null)
        {
            List<TarazKolMoienViewModel> fecthkol = new List<TarazKolMoienViewModel>();

            if (areaId == 0) return BadRequest("با خطا مواجه شدید");

            if (MoienId == null && TafsilyId == null)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP9900_Taraz", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("YearId", yearId);
                        sqlCommand.Parameters.AddWithValue("AreaId", areaId);
                        sqlCommand.Parameters.AddWithValue("MoienId", MoienId);
                        sqlCommand.Parameters.AddWithValue("TafsilyId", TafsilyId);
                        sqlCommand.Parameters.AddWithValue("MarkazHazine", MarkazHazine);
                        sqlCommand.Parameters.AddWithValue("KindId", KindId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (dataReader.Read())
                        {
                            TarazKolMoienViewModel fetchViewKol = new TarazKolMoienViewModel();
                            fetchViewKol.Levels = int.Parse(dataReader["Levels"].ToString());
                            fetchViewKol.MarkazHazine = null;
                            fetchViewKol.MarkazHazineName = null;
                            fetchViewKol.Code = dataReader["Code"].ToString();
                            fetchViewKol.Description = dataReader["Description"].ToString();
                            fetchViewKol.Bedehkar = Int64.Parse(dataReader["Bedehkar"].ToString());
                            fetchViewKol.Bestankar = Int64.Parse(dataReader["Bestankar"].ToString());
                            fetchViewKol.BalanceBedehkar = Int64.Parse(dataReader["BalanceBedehkar"].ToString());
                            fetchViewKol.BalanceBestankar = Int64.Parse(dataReader["BalanceBestankar"].ToString());
                            fetchViewKol.SanadNumber = "";
                            fetchViewKol.SanadDate = "";
                            fecthkol.Add(fetchViewKol);
                        }
                    }
                }
            }
            else
            if (MoienId != null && TafsilyId == null)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP9900_Taraz", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("YearId", yearId);
                        sqlCommand.Parameters.AddWithValue("AreaId", areaId);
                        sqlCommand.Parameters.AddWithValue("MoienId", MoienId);
                        sqlCommand.Parameters.AddWithValue("TafsilyId", TafsilyId);
                        sqlCommand.Parameters.AddWithValue("MarkazHazine", MarkazHazine);
                        sqlCommand.Parameters.AddWithValue("KindId", KindId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (dataReader.Read())
                        {
                            TarazKolMoienViewModel fetchViewtafsily = new TarazKolMoienViewModel();
                            fetchViewtafsily.Levels = int.Parse(dataReader["Levels"].ToString());
                            fetchViewtafsily.MarkazHazine = StringExtensions.ToNullableInt(dataReader["MarkazHazine"].ToString());
                            fetchViewtafsily.MarkazHazineName = dataReader["MarkazHazineName"].ToString();
                            fetchViewtafsily.Code = dataReader["Code"].ToString();
                            fetchViewtafsily.Description = dataReader["Description"].ToString();
                            fetchViewtafsily.Bedehkar = Int64.Parse(dataReader["Bedehkar"].ToString());
                            fetchViewtafsily.Bestankar = Int64.Parse(dataReader["Bestankar"].ToString());
                            fetchViewtafsily.BalanceBedehkar = Int64.Parse(dataReader["BalanceBedehkar"].ToString());
                            fetchViewtafsily.BalanceBestankar = Int64.Parse(dataReader["BalanceBestankar"].ToString());
                            fetchViewtafsily.SanadNumber = "";
                            fetchViewtafsily.SanadDate = "";
                            fecthkol.Add(fetchViewtafsily);
                        }
                    }
                }
            }
            else
            if (MoienId != null && TafsilyId != null)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP9900_Taraz", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("YearId", yearId);
                        sqlCommand.Parameters.AddWithValue("AreaId", areaId);
                        sqlCommand.Parameters.AddWithValue("MoienId", MoienId);
                        sqlCommand.Parameters.AddWithValue("TafsilyId", TafsilyId);
                        sqlCommand.Parameters.AddWithValue("MarkazHazine", MarkazHazine);
                        sqlCommand.Parameters.AddWithValue("KindId", KindId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (dataReader.Read())
                        {
                            TarazKolMoienViewModel fetchViewtafsily = new TarazKolMoienViewModel();
                            fetchViewtafsily.Levels = int.Parse(dataReader["Levels"].ToString());
                            fetchViewtafsily.SanadNumber= dataReader["SanadNumber"].ToString();
                            fetchViewtafsily.SanadDate = dataReader["SanadDate"].ToString();
                            fetchViewtafsily.Description = dataReader["Description"].ToString();
                            fetchViewtafsily.Bedehkar = Int64.Parse(dataReader["Bedehkar"].ToString());
                            fetchViewtafsily.Bestankar = Int64.Parse(dataReader["Bestankar"].ToString());
                            fetchViewtafsily.BalanceBedehkar = 0;
                            fetchViewtafsily.BalanceBestankar = 0;
                            fetchViewtafsily.MarkazHazine = null;
                            fetchViewtafsily.MarkazHazineName = null;
                            fecthkol.Add(fetchViewtafsily);
                        }
                    }
                }
            }

            return Ok(fecthkol);

        }

        [Route("GetTarazHistoryAccount")]
        [HttpGet]
        public async Task<ApiResult<List<HistoryAccountViewModel>>> GetTarazHistoryAccount_AC(Param100 param100)
        {
            List<HistoryAccountViewModel> data = new List<HistoryAccountViewModel>();
   
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP9900_Taraz_HistoryAccount_Read", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("AreaId", param100.AreaId);
                        sqlCommand.Parameters.AddWithValue("IdTafsil", param100.IdTafsil);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (dataReader.Read())
                        {
                        HistoryAccountViewModel row = new HistoryAccountViewModel();
                        row.IdSanad = int.Parse(dataReader["IdSanad"].ToString());
                        row.SanadDate = dataReader["SanadDate"].ToString();
                        row.SanadDateShamsi = DateTimeExtensions.ConvertMiladiToShamsi(StringExtensions.ToNullableDatetime(dataReader["SanadDate"].ToString()), "yyyy/MM/dd");
                        row.IdKol = int.Parse(dataReader["IdKol"].ToString());
                        row.IdMoien = int.Parse(dataReader["IdMoien"].ToString());
                        row.Description = dataReader["Description"].ToString();
                        row.Bedehkar = Int64.Parse(dataReader["Bedehkar"].ToString());
                        row.Bestankar = Int64.Parse(dataReader["Bestankar"].ToString());
                        row.AtfCh = dataReader["AtfCh"].ToString();
                        row.AtfDt = dataReader["AtfDt"].ToString();
                        row.AtfDtShamsi = DateTimeExtensions.ConvertMiladiToShamsi(StringExtensions.ToNullableDatetime(dataReader["AtfDt"].ToString()), "yyyy/MM/dd");
                        data.Add(row);
                        }
                    }
                }
            return Ok(data);
        }


    }


}
