using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.CodeAnalysis.CSharp.Syntax;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Budget;
using NewsWebsite.ViewModels.Api.Budget.BudgetArea;
using NewsWebsite.ViewModels.Api.Budget.BudgetCoding;
using NewsWebsite.ViewModels.Api.Budget.BudgetConnect;
using NewsWebsite.ViewModels.Api.Budget.BudgetProject;
using NewsWebsite.ViewModels.Api.Budget.BudgetSeprator;
using NewsWebsite.ViewModels.Api.Projects;
using NewsWebsite.ViewModels.Api.Request;
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
    public class BudgetApiController : Controller
    {
        public readonly IUnitOfWork _uw;
        private readonly IConfiguration _config;
        public BudgetApiController(IUnitOfWork uw, IConfiguration configuration)
        {
            _config = configuration;
            _uw = uw;
        }

        [Route("FetchIndex")]
        [HttpGet]
        public async Task<ApiResult<List<FetchViewModel>>> FetchIndex(int yearId, int areaId, int budgetProcessId)
        {
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
                        fetchView.Edit = StringExtensions.ToNullableBigInt(dataReader["Edit"].ToString());
                        fetchView.CreditAmount = StringExtensions.ToNullableBigInt(dataReader["CreditAmount"].ToString());
                        fetchView.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        fetchView.Show = (bool)dataReader["Show"];
                        fetchView.Crud = (bool)dataReader["Crud"];
                        fetchView.MotherId = StringExtensions.ToNullableInt(dataReader["MotherId"].ToString());
                        _totalMosavab += fetchView.Mosavab;
                        _totalExpense += fetchView.Expense;
                        if ((!string.IsNullOrEmpty(dataReader["Edit"].ToString()) && Int64.Parse(dataReader["Edit"].ToString()) > 0))
                        {
                            fetchView.PercentBud = _uw.Budget_001Rep.Division(StringExtensions.ToNullableBigInt(dataReader["Expense"].ToString()), StringExtensions.ToNullableBigInt(dataReader["Edit"].ToString()));
                        }
                        else
                        {
                            fetchView.PercentBud = 0;
                        }

                        fecth.Add(fetchView);

                    }
                }
                return Ok(fecth);

            }
        }

        [Route("BudgetConnectRead")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetConnect_ReadViewModel>>> BudgetConnectRead(BudgetConnect_ReadParamViewModel viewModel)
        {
            List<BudgetConnect_ReadViewModel> fecthViewModel = new List<BudgetConnect_ReadViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_BudgetConnect_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", viewModel.YearId);
                    sqlCommand.Parameters.AddWithValue("AreaId", viewModel.AreaId);
                    sqlCommand.Parameters.AddWithValue("BudgetProcessId", viewModel.BudgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetConnect_ReadViewModel row = new BudgetConnect_ReadViewModel();
                        row.Id = int.Parse(dataReader["Id"].ToString());

                        row.Code = dataReader["Code"].ToString();
                        row.Description = dataReader["Description"].ToString();
                        row.ProctorId = StringExtensions.ToNullableInt(dataReader["ProctorId"].ToString());
                        row.ProctorName = dataReader["ProctorName"].ToString();

                        row.ExecuteId = StringExtensions.ToNullableInt(dataReader["ExecuteId"].ToString());
                        row.ExecuteName = dataReader["ExecuteName"].ToString();

                        row.BudgetDetailId = int.Parse(dataReader["BudgetDetailId"].ToString());
                        row.Show = StringExtensions.ToNullablebool(dataReader["Show"].ToString());
                        row.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        row.CodingNatureId = StringExtensions.ToNullableInt(dataReader["CodingNatureId"].ToString());
                        row.CodingNatureName = dataReader["CodingNatureName"].ToString();

                        fecthViewModel.Add(row);
                    }
                }
            }
            return Ok(fecthViewModel);

        }

        [Route("CodingNatureCom")]
        [HttpGet]
        public async Task<ApiResult<List<CodingNatureCom>>> CodingNatureCom()
        {
            List<CodingNatureCom> fecthViewModel = new List<CodingNatureCom>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_CodingNature_Com", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        CodingNatureCom fetchView = new CodingNatureCom();
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.CodingNatureName = dataReader["CodingNatureName"].ToString();

                        fecthViewModel.Add(fetchView);
                    }
                }
            }
            return Ok(fecthViewModel);

        }

        //خروجی با MessageDB
        [Route("BudgetConnectUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> BudgetConnectUpdate([FromBody] BudgetConnectUpdateParamViewModel param)
        {
            string readercount = null;

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_BudgetConnect_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("id", param.id);
                    sqlCommand.Parameters.AddWithValue("ProctorId", param.ProctorId);
                    sqlCommand.Parameters.AddWithValue("CodingNatureId", param.CodingNatureId);
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

        [Route("GetBudgetSearchCodingModal")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetSearchCodingViewModel>>> GetBudgetSearchCodingModalList(int budgetProcessId, int motherid, int yearId, int areaId)
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
                        fetchView.CodingKindId = int.Parse(dataReader["CodingKindId"].ToString());

                        fecthViewModel.Add(fetchView);
                    }
                }
            }

            return Ok(fecthViewModel);
        }

        [Route("CodingInsert")]
        [HttpPost]
        public async Task<ApiResult<string>> InsertCoding(BudgetCodingInsertParamModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP000_Coding_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("MotherId", param.MotherId);
                    sqlCommand.Parameters.AddWithValue("code", param.code);
                    sqlCommand.Parameters.AddWithValue("show", param.show);
                    sqlCommand.Parameters.AddWithValue("crud", param.crud);
                    sqlCommand.Parameters.AddWithValue("description", param.description);
                    sqlCommand.Parameters.AddWithValue("levelNumber", param.levelNumber);
                    sqlCommand.Parameters.AddWithValue("BudgetProcessId", param.BudgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        if (dataReader["Message_DB"].ToString() != null) readercount = dataReader["Message_DB"].ToString();
                    }
                }
            }
            if (string.IsNullOrEmpty(readercount))
                return Ok("با موفقیت انجام شد");
            else
                return BadRequest(readercount);
        }

        [Route("CodingDelete")]
        [HttpPost]
        public async Task<ApiResult<string>> CodingDelete([FromBody] RequestBudgetDeleteViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP000_Coding_Delete", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("id", param.Id);
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

        [Route("CodingUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> CodingUpdate([FromBody] BudgetCodingUpdateParamModel budgetCodingUpdate)
        {
            string readercount = null;
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

        [Route("BudgetCodingMainModal")]
        [HttpGet]
        public async Task<ApiResult<List<CodingMainModalViewModel>>> BudgetCodingMainModal(int yearId, int areaId, int budgetProcessId)
        {
            List<CodingMainModalViewModel> fecthViewModel = new List<CodingMainModalViewModel>();
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("Sp001_BudgetCodingMainModal", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand.Parameters.AddWithValue("budgetProcessId", budgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        CodingMainModalViewModel fetchView = new CodingMainModalViewModel();
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.Code = dataReader["Code"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.levelNumber = int.Parse(dataReader["levelNumber"].ToString());
                        fecthViewModel.Add(fetchView);
                    }
                }
            }

            return Ok(fecthViewModel);
        }

        [Route("BudgetModal1Coding")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetModalCodingViewModel>>> BudgetModal1Coding(BudgetModal1CodingParamModel paramModel)
        {
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
                        BudgetView.CodingId = int.Parse(dataReader["CodingId"].ToString());
                        BudgetView.Description = dataReader["Description"].ToString();
                        BudgetView.Code = dataReader["Code"].ToString();
                        BudgetView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        BudgetView.EditPublic = Int64.Parse(dataReader["EditPublic"].ToString());
                        BudgetView.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        BudgetView.AreaName = dataReader["AreaName"].ToString();
                        //BudgetView.Show = (bool)dataReader["Show"];
                        if (BudgetView.Mosavab != 0)
                        {
                            BudgetView.PercentBud = _uw.Budget_001Rep.Division(BudgetView.Expense, BudgetView.Mosavab);
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

        [Route("BudgteModal1CodingInsert")]
        [HttpPost]
        public async Task<ApiResult<string>> BudgteModal1CodingInsert([FromBody] BudgetModal1CodingInsertParamModel budgetCodingInsert)
        {
            string readercount = null;
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

        
        [Route("BudgteModal1CodingUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> BudgteModal1CodingUpdate([FromBody] BudgetModal1CodingUpdateParamModel Param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_BudgetModal1Coding_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("id", Param.id);
                    sqlCommand.Parameters.AddWithValue("mosavabPublic", Param.mosavabPublic);
                    sqlCommand.Parameters.AddWithValue("CodeOld", Param.CodeOld);
                    sqlCommand.Parameters.AddWithValue("CodeNew", Param.CodeNew);
                    sqlCommand.Parameters.AddWithValue("Description", Param.Description);
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

        [Route("BudgteModal1CodingDelete")]
        [HttpPost]
        public async Task<ApiResult<string>> BudgteModal1CodingDelete([FromBody] RequestBudgetDeleteViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_BudgetModal1Coding_Delete", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("id", param.Id);
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

        [Route("BudgetModal2CodingRead")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetModalProjectViewModel>>> BudgetModal2CodingRead(BudgetModal1CodingParamModel paramModel)
        {

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
                        BudgetView.Id = int.Parse(dataReader["Id"].ToString());
                        BudgetView.ProjectId = int.Parse(dataReader["ProjectId"].ToString());
                        BudgetView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        BudgetView.EditProject = Int64.Parse(dataReader["EditProject"].ToString());
                        BudgetView.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        BudgetView.ProjectCode = dataReader["ProjectCode"].ToString();
                        BudgetView.ProjectName = dataReader["ProjectName"].ToString();
                        BudgetView.AreaName = dataReader["AreaName"].ToString();
                        BudgetView.AreaId = int.Parse(dataReader["AreaId"].ToString());
                        //BudgetView.Show = (bool)dataReader["Show"];

                        fecth.Add(BudgetView);
                    }
                }
            }
            return Ok(fecth);
        }

        [Route("BudgetModal2ProjectSearch")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetModal2ProjectSearchViewModal>>> BudgetModal2ProjectSearch(BudgetModal2ProjectSearchParamViewModal searchParamViewModal)
        {
            List<BudgetModal2ProjectSearchViewModal> BudgetViews = new List<BudgetModal2ProjectSearchViewModal>();
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
                }
            }
            return Ok(BudgetViews);
        }

        [Route("BudgteModal2ProjectInsert")]
        [HttpPost]
        public async Task<ApiResult<string>> BudgteModal2ProjectInsert([FromBody] BudgetModal2ProjectInsertParamModel budgetCodingInsert)
        {
            string readercount = null;
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

        [Route("BudgteModal2ProjectUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> BudgteModal2ProjectUpdate([FromBody] BudgetModal2ProjectUpdateParamModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_BudgetModal2Project_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", param.Id);
                    sqlCommand.Parameters.AddWithValue("Mosavab", param.Mosavab);
                    sqlCommand.Parameters.AddWithValue("EditProject", param.EditProject);
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

        [Route("BudgteModal2ProjectDelete")]
        [HttpPost]
        public async Task<ApiResult<string>> BudgteModal2ProjectDelete([FromBody] RequestBudgetDeleteViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_BudgetModal2Project_Delete", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("id", param.Id);
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

        [Route("BudgteCodingInsert")]
        [HttpPost]
        public async Task<ApiResult<string>> BudgteCodingInsert([FromBody] BudgetCodingInsertParamModel budgetCodingInsert)
        {
            string readercount = null;
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

        [Route("BudgteCodingDelete")]
        [HttpPost]
        public async Task<ApiResult<string>> BudgteCodingDelete([FromBody] RequestBudgetDeleteViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP000_Coding_Delete", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("id", param.Id);
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

        [Route("BudgteCodingUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> BudgteCodingUpdate([FromBody] BudgetCodingUpdateParamModel budgetCodingUpdate)
        {
            string readercount = null;
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

        [Route("BudgetModal3AreaRead")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetAreaModalViewModel>>> BudgetModal3AreaRead(BudgetModal3AreaParamModel paramModel)
        {
            List<BudgetAreaModalViewModel> fecth = new List<BudgetAreaModalViewModel>();
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_BudgetModal3Area_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("areaPublicId", paramModel.areaPublicId);
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
                        BudgetView.AreaName = dataReader["AreaName"].ToString();
                        //BudgetView.LevelNumber = int.Parse(dataReader["LevelNumber"].ToString());
                        BudgetView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        BudgetView.EditArea = Int64.Parse(dataReader["EditArea"].ToString());
                        BudgetView.Supply = Int64.Parse(dataReader["Supply"].ToString());
                        BudgetView.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        //BudgetView.Show = (bool)dataReader["Show"];
                        if (BudgetView.Mosavab != 0)
                        {
                            BudgetView.PercentBud = _uw.Budget_001Rep.Division(BudgetView.Expense, BudgetView.Mosavab);
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

        [Route("BudgetModal3AreaUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> BudgetModal3AreaUpdate([FromBody] BudgetModal3AreaUpdateParam param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_BudgetModal3Area_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", param.Id);
                    sqlCommand.Parameters.AddWithValue("Mosavab", param.mosavab);
                    sqlCommand.Parameters.AddWithValue("EditArea", param.EditArea);
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

        [Route("BudgetModal3AreaInsert")]
        [HttpPost]
        public async Task<ApiResult<string>> BudgetModal3AreaInsert([FromBody] BudgetModal3ParamAreaInsert areaInsert)
        {
            string readercount = null;
            List<BudgetAreaModalViewModel> fecth = new List<BudgetAreaModalViewModel>();
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_BudgetModal3Area_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("areaId", areaInsert.areaId);
                    sqlCommand.Parameters.AddWithValue("projectId", areaInsert.projectId);
                    sqlCommand.Parameters.AddWithValue("codingId", areaInsert.codingId);
                    sqlCommand.Parameters.AddWithValue("yearId", areaInsert.yearId);
                    sqlCommand.Parameters.AddWithValue("areaPublicId", areaInsert.areaPublicId);
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

        [Route("BudgetModal3AreaDelete")]
        [HttpPost]
        public async Task<ApiResult<string>> BudgteModal3AreaDelete([FromBody] RequestBudgetDeleteViewModel param)
        {

            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("[SP001_BudgetModal3Area_Delete]", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("id", param.Id);
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

        [Route("BudgetCodingInfoModalRead")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetCodingInfoModalReadViewModal>>> Ac_BudgetCodingInfoModalRead(ParamViewModal param)
        {

            List<BudgetCodingInfoModalReadViewModal> fecth = new List<BudgetCodingInfoModalReadViewModal>();
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_BudgetCodingInfoModal_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", param.YearId);
                    sqlCommand.Parameters.AddWithValue("CodingId", param.CodingId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetCodingInfoModalReadViewModal data = new BudgetCodingInfoModalReadViewModal();
                        data.AreaName = dataReader["AreaName"].ToString();
                        data.Mosavab = StringExtensions.ToNullableBigInt(dataReader["Mosavab"].ToString());
                        data.EditArea = StringExtensions.ToNullableBigInt(dataReader["EditArea"].ToString());
                        data.Expense = StringExtensions.ToNullableBigInt(dataReader["Expense"].ToString());
                        data.CreditAmount = StringExtensions.ToNullableBigInt(dataReader["CreditAmount"].ToString());
                        data.StructureId = int.Parse(dataReader["StructureId"].ToString());
                        fecth.Add(data);
                    }
                }
            }
            return Ok(fecth);
        }


        [Route("BudgetInlineInsert")]
        [HttpPost]
        public async Task<ApiResult<string>> AC_BudgetInlineInsert([FromBody] param15ViewModel param)
        {
            //string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_Budget_Inline_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Code", param.Code);
                    sqlCommand.Parameters.AddWithValue("Description", param.Description);
                    sqlCommand.Parameters.AddWithValue("CodingId", param.CodingId);
                    sqlCommand.Parameters.AddWithValue("YearId", param.YearId);
                    sqlCommand.Parameters.AddWithValue("AreaId", param.AreaId);
                    sqlCommand.Parameters.AddWithValue("Mosavab", param.Mosavab);
                    sqlCommand.Parameters.AddWithValue("ProgramOperationDetailsId", param.ProgramOperationDetailsId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    //while (dataReader.Read())
                    //{
                    //    if (dataReader["Message_DB"].ToString() != null) readercount = dataReader["Message_DB"].ToString();
                    //}
                }
            }
            return Ok("با موفقیت انجام شد");
           
        }


        [Route("BudgetInlineInsertModal")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetInlineModalViewModel>>> BudgetSepratorAreaProjectModal2(Param16ViewModel param)
        {
            List<BudgetInlineModalViewModel> data = new List<BudgetInlineModalViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_Budget_Inline_Modal", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", param.YearId);
                    sqlCommand.Parameters.AddWithValue("areaId", param.AreaId);
                    //sqlCommand.Parameters.AddWithValue("codingId", codingId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetInlineModalViewModel row = new BudgetInlineModalViewModel();
                        row.Id = int.Parse(dataReader["Id"].ToString());
                        row.ProjectCode = dataReader["ProjectCode"].ToString();
                        row.ProjectName = dataReader["ProjectName"].ToString();
                        data.Add(row);
                    }
                }
            }

            return Ok(data);
        }


    }
}
