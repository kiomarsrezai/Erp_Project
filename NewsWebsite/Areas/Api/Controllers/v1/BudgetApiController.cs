using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Budget;
using NewsWebsite.ViewModels.Api.Budget.BudgetCoding;
using NewsWebsite.ViewModels.Api.Budget.BudgetProject;
using NewsWebsite.ViewModels.Budget;
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
    public class BudgetController : Controller
    {
        public readonly IUnitOfWork _uw;
        private readonly IConfiguration _config;
        public BudgetController(IUnitOfWork uw, IConfiguration configuration)
        {
            _config = configuration;
            _uw = uw;
        }

        [Route("FetchIndex")]
        [HttpGet]
        public async Task<ApiResult<List<FetchViewModel>>> FetchIndex(int yearId, int areaId, int budgetProcessId)
        {
            if (yearId == 0) return BadRequest("با خطا مواجه شدید");

            List<FetchViewModel> fecth = new List<FetchViewModel>();
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                Int64 _totalMosavab = 0; Int64 _totalExpense = 0;
                using (SqlCommand sqlCommand = new SqlCommand("SP001_Budget", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", yearId);
                    sqlCommand.Parameters.AddWithValue("AreaId", areaId);
                    sqlCommand.Parameters.AddWithValue("BudgetProcessId", budgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        FetchViewModel fetchView = new FetchViewModel();
                        fetchView.CodingId = int.Parse(dataReader["CodingId"].ToString());
                        fetchView.Code = dataReader["Code"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.LevelNumber = int.Parse(dataReader["LevelNumber"].ToString());
                        fetchView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        fetchView.Edit = Int64.Parse(dataReader["Edit"].ToString());
                        fetchView.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        fetchView.Show = (bool)dataReader["Show"];
                        _totalMosavab += fetchView.Mosavab;
                        _totalExpense += fetchView.Expense;
                        if ((!string.IsNullOrEmpty(dataReader["Mosavab"].ToString()) && Int64.Parse(dataReader["Mosavab"].ToString()) > 0))
                        {
                            fetchView.PercentBud = _uw.Budget_001Rep.Divivasion(StringExtensions.ToNullableBigInt(dataReader["Expense"].ToString()), StringExtensions.ToNullableBigInt(dataReader["Mosavab"].ToString()));
                        }
                        else
                        {
                            fetchView.PercentBud = 0;
                        }

                        fecth.Add(fetchView);
                    }
                }
            }
            return Ok(fecth);
        }

        [Route("GetCodingList")]
        [HttpGet]
        public async Task<ApiResult<List<CodingViewModel>>> GetCodingList(CodingParamViewModel viewModel)
        {
            List<CodingViewModel> fecthViewModel = new List<CodingViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP000_Coding", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("MotherId", viewModel.MotherId);
                    sqlCommand.Parameters.AddWithValue("BudgetProcessId", viewModel.BudgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        CodingViewModel fetchView = new CodingViewModel();
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.MotherId = StringExtensions.ToNullableInt(dataReader["MotherId"].ToString());
                        fetchView.Code = dataReader["Code"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.levelNumber = int.Parse(dataReader["levelNumber"].ToString());
                        fetchView.Crud = bool.Parse(dataReader["Crud"].ToString());
                        fetchView.CodingRevenueKind = int.Parse(dataReader["CodingRevenueKind"].ToString());

                        fecthViewModel.Add(fetchView);
                    }
                }
            }

            return Ok(fecthViewModel);
        }

        [Route("GetBudgetSearchCodingModal")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetSearchCodingViewModel>>> GetBudgetSearchCodingModalList(int budgetProcessId,int motherid,int yearId,int areaId)
        {
            List<BudgetSearchCodingViewModel> fecthViewModel = new List<BudgetSearchCodingViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_BudgetModal1CodingSearch", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("BudgetProcessId", budgetProcessId);
                    sqlCommand.Parameters.AddWithValue("MotherId", motherid);
                    sqlCommand.Parameters.AddWithValue("yearId", yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetSearchCodingViewModel fetchView = new BudgetSearchCodingViewModel();
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.Code = dataReader["Code"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.levelNumber = int.Parse(dataReader["levelNumber"].ToString());
                        fetchView.Crud = bool.Parse(dataReader["Crud"].ToString());
                        fetchView.Show = bool.Parse(dataReader["Show"].ToString());

                        fecthViewModel.Add(fetchView);
                    }
                }
            }

            return Ok(fecthViewModel);
        }

        [Route("CodingInsert")]
        [HttpPost]
        public async Task<ApiResult<string>> InsertCoding(BudgetCodingInsertParamModel budgetCodingInsert)
        {
            if (budgetCodingInsert.MotherId == 0)
                return BadRequest("با خطا مواجه شد");
            if (budgetCodingInsert.MotherId > 0)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP000_Coding_Insert", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("MotherId", budgetCodingInsert.MotherId);
                        sqlCommand.Parameters.AddWithValue("code", budgetCodingInsert.code);
                        sqlCommand.Parameters.AddWithValue("show", budgetCodingInsert.show);
                        sqlCommand.Parameters.AddWithValue("crud", budgetCodingInsert.crud);
                        sqlCommand.Parameters.AddWithValue("description", budgetCodingInsert.description);
                        sqlCommand.Parameters.AddWithValue("levelNumber", budgetCodingInsert.levelNumber);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        sqlconnect.Close();
                    }
                }
            }
            return Ok("با موفقیت انجام شد");
        }

        [Route("CodingDelete")]
        [HttpPost]
        public async Task<ApiResult<string>> CodingDelete(int CodingDeleteid)
        {
            if (CodingDeleteid == 0)
                return BadRequest("با خطا مواجه شد");
            if (CodingDeleteid > 0)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP000_Coding_Delete", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("id", CodingDeleteid);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        sqlconnect.Close();
                    }
                }
            }
            return Ok("با موفقیت انجام شد");
        }

        [Route("CodingUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> CodingUpdate([FromBody] BudgetCodingUpdateParamModel budgetCodingUpdate)
        {
            if (budgetCodingUpdate.id == 0)
                return BadRequest("با خطا مواجه شد");
            if (budgetCodingUpdate.id > 0)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP000_Coding_Update", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("id", budgetCodingUpdate.id);
                        sqlCommand.Parameters.AddWithValue("code", budgetCodingUpdate.code);
                        sqlCommand.Parameters.AddWithValue("show", budgetCodingUpdate.show);
                        sqlCommand.Parameters.AddWithValue("crud", budgetCodingUpdate.crud);
                        sqlCommand.Parameters.AddWithValue("levelNumber", budgetCodingUpdate.levelNumber);
                        sqlCommand.Parameters.AddWithValue("description", budgetCodingUpdate.description);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    }
                }

            }
            return Ok("با موفقیت انجام شد");

        }

        [Route("BudgetModal1Coding")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetModalCodingViewModel>>> BudgetModal1Coding(BudgetModal1CodingParamModel paramModel)
        {
            if (paramModel.CodingId == 0) return BadRequest("با خطا مواجه شدید");

            List<BudgetModalCodingViewModel> fecth = new List<BudgetModalCodingViewModel>();
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_BudgetModal1Coding", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", paramModel.YearId);
                    sqlCommand.Parameters.AddWithValue("AreaId", paramModel.AreaId);
                    sqlCommand.Parameters.AddWithValue("CodingId", paramModel.CodingId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetModalCodingViewModel BudgetView = new BudgetModalCodingViewModel();
                        BudgetView.Id = int.Parse(dataReader["Id"].ToString());
                        BudgetView.Code = dataReader["Code"].ToString();
                        BudgetView.Description = dataReader["Description"].ToString();
                        BudgetView.CodingId= int.Parse(dataReader["CodingId"].ToString());
                        BudgetView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        BudgetView.Edit = Int64.Parse(dataReader["Edit"].ToString());
                        BudgetView.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        //BudgetView.Show = (bool)dataReader["Show"];
                        if (BudgetView.Mosavab != 0)
                        {
                            BudgetView.PercentBud = _uw.Budget_001Rep.Divivasion(BudgetView.Expense, BudgetView.Mosavab);
                        }
                        else
                        {
                            BudgetView.PercentBud = 0;
                        }
                        fecth.Add(BudgetView);
                    }
                }
            }
            return Ok(fecth);
        }

        [Route("BudgetModal2Coding")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetModalProjectViewModel>>> BudgetModal2Coding(BudgetModal1CodingParamModel paramModel)
        {
            if (paramModel.YearId == 0) return BadRequest("با خطا مواجه شدید");

            List<BudgetModalProjectViewModel> fecth = new List<BudgetModalProjectViewModel>();
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_BudgetModal2Project_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("AreaId", paramModel.AreaId);
                    sqlCommand.Parameters.AddWithValue("CodingId", paramModel.CodingId);
                    sqlCommand.Parameters.AddWithValue("YearId", paramModel.YearId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetModalProjectViewModel BudgetView = new BudgetModalProjectViewModel();
                        //BudgetView.LevelNumber = int.Parse(dataReader["LevelNumber"].ToString());
                        BudgetView.ProjectId = int.Parse(dataReader["ProjectId"].ToString());
                        BudgetView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        BudgetView.Edit = Int64.Parse(dataReader["Edit"].ToString());
                        BudgetView.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        BudgetView.ProjectCode = dataReader["ProjectCode"].ToString();
                        BudgetView.ProjectName = dataReader["ProjectName"].ToString();
                        BudgetView.AreaName = dataReader["AreaName"].ToString();
                        //BudgetView.Show = (bool)dataReader["Show"];
                       
                        fecth.Add(BudgetView);
                    }
                }
            }
            return Ok(fecth);
        }

        [Route("BudgetModal3Area")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetAreaModalViewModel>>> BudgetModal3Area(BudgetModal3AreaParamModel paramModel)
        {
            if (paramModel.YearId == 0) return BadRequest("با خطا مواجه شدید");

            List<BudgetAreaModalViewModel> fecth = new List<BudgetAreaModalViewModel>();
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_BudgetModal3Area_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("AreaId", paramModel.AreaId);
                    sqlCommand.Parameters.AddWithValue("CodingId", paramModel.CodingId);
                    sqlCommand.Parameters.AddWithValue("YearId", paramModel.YearId);
                    sqlCommand.Parameters.AddWithValue("ProjectId", paramModel.ProjectId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetAreaModalViewModel BudgetView = new BudgetAreaModalViewModel();
                        BudgetView.Id = int.Parse(dataReader["Id"].ToString());
                        BudgetView.AreaNameShort = dataReader["AreaNameShort"].ToString();
                        //BudgetView.LevelNumber = int.Parse(dataReader["LevelNumber"].ToString());
                        BudgetView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        BudgetView.Edit = Int64.Parse(dataReader["Edit"].ToString());
                        BudgetView.Supply = Int64.Parse(dataReader["Supply"].ToString());
                        BudgetView.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        //BudgetView.Show = (bool)dataReader["Show"];
                        if (BudgetView.Mosavab != 0)
                        {
                            BudgetView.PercentBud = _uw.Budget_001Rep.Divivasion(BudgetView.Expense, BudgetView.Mosavab);
                        }
                        else
                        {
                            BudgetView.PercentBud = 0;
                        }
                        fecth.Add(BudgetView);
                    }
                }
            }
            return Ok(fecth);
        }

        [Route("BudgteCodingInsert")]
        [HttpPost]
        public async Task<ApiResult<string>> BudgteCodingInsert([FromBody] BudgetCodingInsertParamModel budgetCodingInsert)
        {
            if (budgetCodingInsert.MotherId == 0)
                return BadRequest("با خطا مواجه شد");
            if (budgetCodingInsert.MotherId > 0)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP000_Coding_Insert", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("MotherId", budgetCodingInsert.MotherId);
                        sqlCommand.Parameters.AddWithValue("code", budgetCodingInsert.code);
                        sqlCommand.Parameters.AddWithValue("description", budgetCodingInsert.description);
                        sqlCommand.Parameters.AddWithValue("show", budgetCodingInsert.show);
                        sqlCommand.Parameters.AddWithValue("crud", budgetCodingInsert.crud);
                        sqlCommand.Parameters.AddWithValue("levelNumber", budgetCodingInsert.levelNumber);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        sqlconnect.Close();
                    }
                }
            }
            return Ok("با موفقیت انجام شد");
        }

        [Route("BudgteCodingDelete{id}")]
        [HttpPost]
        public async Task<ApiResult<string>> BudgteCodingDelete([FromBody] int id)
        {
            if (id == 0)
                return BadRequest("با خطا مواجه شد");
            if (id > 0)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP000_Coding_Delete", sqlconnect))
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

        [Route("BudgteCodingUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> BudgteCodingUpdate([FromBody] BudgetCodingUpdateParamModel budgetCodingUpdate)
        {
            if (budgetCodingUpdate.id == 0)
                return BadRequest("با خطا مواجه شد");
            if (budgetCodingUpdate.id > 0)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP000_Coding_Update", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("id", budgetCodingUpdate.id);
                        sqlCommand.Parameters.AddWithValue("code", budgetCodingUpdate.code);
                        sqlCommand.Parameters.AddWithValue("description", budgetCodingUpdate.description);
                        sqlCommand.Parameters.AddWithValue("show", budgetCodingUpdate.show);
                        sqlCommand.Parameters.AddWithValue("crud", budgetCodingUpdate.crud);
                        sqlCommand.Parameters.AddWithValue("levelNumber", budgetCodingUpdate.levelNumber);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    }
                }

            }
            return Ok("با موفقیت انجام شد");

        }

        /// <summary>
        /// Modal1Codin
        /// </summary>
        /// <param name="budgetCodingInsert"></param>
        /// <returns></returns>
        /// 
        [Route("BudgteModal1CodingInsert")]
        [HttpPost]
        public async Task<ApiResult<string>> BudgteModal1CodingInsert([FromBody] BudgetModal1CodingInsertParamModel budgetCodingInsert)
        {
            if (budgetCodingInsert.CodingId == 0)
                return BadRequest("با خطا مواجه شد");
            if (budgetCodingInsert.CodingId > 0)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP001_BudgetModal1Coding_Insert", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("CodingId", budgetCodingInsert.CodingId);
                        sqlCommand.Parameters.AddWithValue("areaId", budgetCodingInsert.areaId);
                        sqlCommand.Parameters.AddWithValue("BudgetProcessId", budgetCodingInsert.BudgetProcessId);
                        sqlCommand.Parameters.AddWithValue("yearId", budgetCodingInsert.yearId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        sqlconnect.Close();
                    }
                }
            }
            return Ok("با موفقیت انجام شد");
        }

        [Route("BudgteModal1CodingDelete{id}")]
        [HttpPost]
        public async Task<ApiResult<string>> BudgteModal1CodingDelete([FromBody] int id)
        {
            if (id == 0)
                return BadRequest("با خطا مواجه شد");
            if (id > 0)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP001_BudgetModal1Coding_Delete", sqlconnect))
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

        [Route("BudgteModal1CodingUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> BudgteModal1CodingUpdate([FromBody] BudgetModal1CodingUpdateParamModel budgetCodingUpdate)
        {
            if (budgetCodingUpdate.id == 0)
                return BadRequest("با خطا مواجه شد");
            if (budgetCodingUpdate.id > 0)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP001_BudgetModal1Coding_Update", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("id", budgetCodingUpdate.id);
                        sqlCommand.Parameters.AddWithValue("mosavabPublic", budgetCodingUpdate.mosavabPublic);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    }
                }

            }
            return Ok("با موفقیت انجام شد");

        }

        [Route("BudgteModal2ProjectInsert")]
        [HttpPost]
        public async Task<ApiResult<string>> BudgteModal2ProjectInsert([FromBody] BudgetModal2ProjectInsertParamModel budgetCodingInsert)
        {
            if (budgetCodingInsert.ProgramOperationDetailsId == 0)
                return BadRequest("با خطا مواجه شد");
            if (budgetCodingInsert.ProgramOperationDetailsId > 0)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP001_BudgetModal2Project_Insert", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("BudgetDetailId", budgetCodingInsert.BudgetDetailId);
                        sqlCommand.Parameters.AddWithValue("AreaId", budgetCodingInsert.AreaId);
                        sqlCommand.Parameters.AddWithValue("YearId", budgetCodingInsert.YearId);
                        sqlCommand.Parameters.AddWithValue("ProgramOperationDetailsId", budgetCodingInsert.ProgramOperationDetailsId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        sqlconnect.Close();
                    }
                }
            }
            return Ok("با موفقیت انجام شد");
        }

        [Route("SP001_BudgetModal2ProjectSearch")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetModal2ProjectSearchViewModal>>> BudgetModal2ProjectSearch(BudgetModal2ProjectSearchParamViewModal searchParamViewModal)
        {
            List<BudgetModal2ProjectSearchViewModal> BudgetViews = new List<BudgetModal2ProjectSearchViewModal>();

            if (searchParamViewModal.areaId == 0)
                return BadRequest("با خطا مواجه شد");
            if (searchParamViewModal.areaId > 0)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP001_BudgetModal2ProjectSearch", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("areaId", searchParamViewModal.areaId);
                        sqlCommand.Parameters.AddWithValue("yearId", searchParamViewModal.yearId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        while (dataReader.Read())
                        {
                            BudgetModal2ProjectSearchViewModal BudgetView = new BudgetModal2ProjectSearchViewModal();
                           
                            BudgetView.Id = int.Parse(dataReader["Id"].ToString());
                            BudgetView.ProjectCode = dataReader["ProjectCode"].ToString();
                            BudgetView.ProjectName = dataReader["ProjectName"].ToString();

                            BudgetViews.Add(BudgetView);
                        }
                        sqlconnect.Close();
                    }
                }
            }
            return Ok(BudgetViews);
        }

        [Route("BudgteModal2ProjectUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> BudgteModal2ProjectUpdate([FromBody] BudgetModal2ProjectUpdateParamModel budgetCodingUpdate)
        {
            if (budgetCodingUpdate.yearId == 0)
                return BadRequest("با خطا مواجه شد");
            if (budgetCodingUpdate.yearId > 0)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP001_BudgetModal2Project_Update", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("areaGlobalId", budgetCodingUpdate.areaGlobalId);
                        sqlCommand.Parameters.AddWithValue("codingId", budgetCodingUpdate.codingId);
                        sqlCommand.Parameters.AddWithValue("areaId", budgetCodingUpdate.areaId);
                        sqlCommand.Parameters.AddWithValue("Mosavab", budgetCodingUpdate.Mosavab);
                        sqlCommand.Parameters.AddWithValue("projectId", budgetCodingUpdate.projectId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    }
                }

            }
            return Ok("با موفقیت انجام شد");

        }
    }

  
}
