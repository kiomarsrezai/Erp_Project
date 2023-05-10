
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

        //[HttpGet]
        //[Route("FetchDetails")]
        //public async Task<ApiResult<List<TarazKolMoeinViewModel>>> FetchDetails(int yearId, int areaId, int codingId)
        //{
        //    List<FetchDataBudgetViewModel> dataset = new List<FetchDataBudgetViewModel>();

        //    using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
        //    {
        //        using (SqlCommand sqlCommand = new SqlCommand("SP001_ShowBudgetDetail", sqlconnect))
        //        {
        //            sqlconnect.Open();
        //            sqlCommand.CommandType = CommandType.StoredProcedure;
        //            sqlCommand.Parameters.AddWithValue("YearId", yearId);
        //            sqlCommand.Parameters.AddWithValue("AreaId", areaId);
        //            sqlCommand.Parameters.AddWithValue("CodingId", codingId);
        //            SqlDataReader dataReader =await sqlCommand.ExecuteReaderAsync();

        //            while (dataReader.Read())
        //            {
        //                FetchDataBudgetViewModel row = new FetchDataBudgetViewModel();

        //                row.AreaId = int.Parse(dataReader["AreaId"].ToString());
        //                row.Code = dataReader["Code"].ToString();
        //                row.Description = dataReader["Description"].ToString();
        //                row.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
        //                row.Expense = Int64.Parse(dataReader["Expense"].ToString());
        //                row.LevelNumber = int.Parse(dataReader["LevelNumber"].ToString());
        //                dataset.Add(row);
        //            }

        //        }

        //    };
        //    return Ok(dataset);
        //}

    }


}
