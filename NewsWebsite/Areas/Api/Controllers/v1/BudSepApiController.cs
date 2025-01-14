﻿using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Budget.BudgetCoding;
using NewsWebsite.ViewModels.Api.Budget.BudgetSeprator;
using NewsWebsite.ViewModels.Api.Public;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using NewsWebsite.Data;
using NewsWebsite.ViewModels.Api.Contract.AmlakLog;

namespace NewsWebsite.Areas.Api.Controllers.v1
{

    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class BudSepApiController : EnhancedBudgetController
    {
        public readonly IUnitOfWork _uw;
        public readonly IConfiguration _configuration;
        private readonly ProgramBuddbContext _db;
        public readonly ISqlDataAccess _sqlDataAccess;
        public BudSepApiController(IUnitOfWork uw, IConfiguration configuration,ProgramBuddbContext db)
        {
            _configuration = configuration;
            _db = db;
            _uw = uw;
        }

        [Route("FetchSeprator")]
        [HttpGet]
        public async Task<IActionResult> FetchSeprators(int yearId, int areaId, int budgetprocessId)
        {
            List<BudgetSepratorViewModel> fecth = new List<BudgetSepratorViewModel>();
            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_BudgetSepratorArea", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand.Parameters.AddWithValue("budgetProcessId", budgetprocessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetSepratorViewModel fetchView = new BudgetSepratorViewModel();
                        fetchView.Code = dataReader["Code"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.CodingId = int.Parse(dataReader["CodingId"].ToString());
                        fetchView.Edit = long.Parse(dataReader["Edit"].ToString());
                        fetchView.LevelNumber = int.Parse(dataReader["LevelNumber"].ToString());
                        fetchView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        fetchView.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        fetchView.CreditAmount = Int64.Parse(dataReader["CreditAmount"].ToString());
                        fetchView.Crud = bool.Parse(dataReader["Crud"].ToString());
                        fetchView.budgetProcessId = budgetprocessId;

                        if (fetchView.Mosavab != 0)
                        {
                            fetchView.PercentBud = Math.Round(_uw.Budget_001Rep.Division(fetchView.Expense, fetchView.Mosavab));
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


        [Route("DeleteTamin")]
        [HttpPost]
        public virtual async Task<ApiResult<string>> DeleteTamin([FromBody] DeleteSepViewModel deleteSep)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_BudgetSepratorArea_TaminModal_Delete", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("id", deleteSep.id);
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

        [Route("RefreshSeperator")]
        [HttpGet]
        public async Task<ApiResult<string>> RefreshSeprator(RefreshFormViewModel refreshFormViewModel)
        {
            if (refreshFormViewModel.yearId == 32)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP9900_Akh_TO_Olden_Then_Budget_1401_Main", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("areaId", refreshFormViewModel.areaId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        await sqlCommand.ExecuteReaderAsync();
                        // ViewBag.alertsucces = "بروزرسانی انجام شد";
                    }
                    sqlconnect.Close();
                }
            }
            else
            if (refreshFormViewModel.yearId == 33)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP9900_Akh_TO_Olden_Then_Budget_1402_Main", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("areaId", refreshFormViewModel.areaId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.ExecuteReader();
                        // ViewBag.alertsucces = "بروزرسانی انجام شد";
                    }
                    sqlconnect.Close();
                }
            }
            else
            if (refreshFormViewModel.yearId == 34)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP9900_Akh_TO_Olden_Then_Budget_1403_Main", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("areaId", refreshFormViewModel.areaId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.ExecuteReader();
                        // ViewBag.alertsucces = "بروزرسانی انجام شد";
                    }
                    sqlconnect.Close();
                }
                
                using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP9999_Convert_Tamin_To_ERP_1403", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.ExecuteReader();
                        // ViewBag.alertsucces = "بروزرسانی انجام شد";
                    }
                    sqlconnect.Close();
                }
            }
            
            return Ok("با موفقیت انجام شد");
        }

        [Route("TaminInsert")]
        [HttpPost]
        public async Task<ApiResult<string>> TaminInsert([FromBody] InsertTaminSepViewModel insertTaminSep)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_BudgetSepratorArea_TaminModal_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", insertTaminSep.yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", insertTaminSep.areaId);
                    sqlCommand.Parameters.AddWithValue("budgetProcessId", insertTaminSep.budgetProcessId);
                    sqlCommand.Parameters.AddWithValue("RequestRefStr", insertTaminSep.RequestRefStr);
                    sqlCommand.Parameters.AddWithValue("RequestDate", insertTaminSep.RequestDate);
                    sqlCommand.Parameters.AddWithValue("RequestPrice", insertTaminSep.RequestPrice);
                    sqlCommand.Parameters.AddWithValue("ReqDesc", insertTaminSep.ReqDesc);
                    sqlCommand.Parameters.AddWithValue("codingId", insertTaminSep.codingId);
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

        [HttpGet]
        [Route("Details")]
        public async Task<ApiResult<List<SepratorAreaRequestViewModel>>> Details(int yearId, int areaId, int budgetProcessId, int codingId)
        {
            List<SepratorAreaRequestViewModel> fecthViewModel = new List<SepratorAreaRequestViewModel>();
            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_BudgetSepratorArea_TaminModal", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand.Parameters.AddWithValue("budgetProcessId", budgetProcessId);
                    sqlCommand.Parameters.AddWithValue("codingId", codingId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        SepratorAreaRequestViewModel fetchView = new SepratorAreaRequestViewModel();
                        fetchView.id = StringExtensions.ToNullableInt(dataReader["id"].ToString());
                        fetchView.Number = dataReader["Number"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.Date = dataReader["Date"].ToString();
                        fetchView.EstimateAmount = Int64.Parse(dataReader["EstimateAmount"].ToString());

                        fecthViewModel.Add(fetchView);
                    }
                }
            }
            return Ok(fecthViewModel);
        }

        [HttpGet]
        [Route("Taminetebarat")]
        public async Task<ApiResult<List<BudgetSepTaminModal2ViewModel>>> Taminetebarat(int yearId, int areaId, int budgetProcessId)
        {
            List<BudgetSepTaminModal2ViewModel> fecthViewModel = new List<BudgetSepTaminModal2ViewModel>();
            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_BudgetSepratorArea_TaminModal_2", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand.Parameters.AddWithValue("budgetProcessId", budgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetSepTaminModal2ViewModel fetchView = new BudgetSepTaminModal2ViewModel();
                        fetchView.BodgetId = dataReader["BodgetId"].ToString();
                        fetchView.BodgetDesc = dataReader["BodgetDesc"].ToString();
                        fetchView.ReqDesc = dataReader["ReqDesc"].ToString();
                        fetchView.RequestDate = dataReader["RequestDate"].ToString();
                        fetchView.RequestRefStr = dataReader["RequestRefStr"].ToString();
                        fetchView.RequestPrice = Int64.Parse(dataReader["RequestPrice"].ToString());

                        fecthViewModel.Add(fetchView);
                    }
                }
            }
            return Ok(fecthViewModel);
        }

        [Route("BudgetSepratorAreaAccModal")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetSepratorAreaAccModalViewModel>>> BudgetSepratorAreaAccModal(Param10ViewModel param)
        {
            List<BudgetSepratorAreaAccModalViewModel> fecthViewModel = new List<BudgetSepratorAreaAccModalViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_BudgetSepratorArea_Acc_Modal", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", param.yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", param.areaId);
                    sqlCommand.Parameters.AddWithValue("codingId", param.codingId);
                    sqlCommand.Parameters.AddWithValue("KindId", param.KindId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetSepratorAreaAccModalViewModel fetchView = new BudgetSepratorAreaAccModalViewModel();
                        fetchView.NumberSanad = dataReader["NumberSanad"].ToString();
                        fetchView.DateSanad = dataReader["DateSanad"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        fetchView.programOperationDetailsId = dataReader["programOperationDetailsId"].ToString();

                        fecthViewModel.Add(fetchView);
                    }
                }
            }

            return Ok(fecthViewModel);
        }

        [Route("BudgetSepratorAreaProjectModal")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetSepratorAreaProjectModalViewModel>>> BudgetSepratorAreaProjectModal(int yearId, int areaId, int codingId, int BudgetProcessId)
        {
            List<BudgetSepratorAreaProjectModalViewModel> dataModel = new List<BudgetSepratorAreaProjectModalViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_BudgetSepratorArea_Project_Modal", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand.Parameters.AddWithValue("BudgetProcessId", BudgetProcessId);
                    sqlCommand.Parameters.AddWithValue("codingId", codingId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetSepratorAreaProjectModalViewModel row = new BudgetSepratorAreaProjectModalViewModel();
                        row.Id = int.Parse(dataReader["Id"].ToString());
                        row.ProjectId = int.Parse(dataReader["ProjectId"].ToString());
                        row.ProjectCode = dataReader["ProjectCode"].ToString();
                        row.ProjectName = dataReader["ProjectName"].ToString();
                        row.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        row.Expense = Int64.Parse(dataReader["Expense"].ToString());

                        dataModel.Add(row);
                    }
                }
            }
            return Ok(dataModel);
        }

        // [Route("CodingUpdate")]
        // [HttpPost]
        // public async Task<ApiResult<string>> BudgetSepratorAreaProjectModal_Update([FromBody] CodingUpdateParamViewModel param)
        // {
        //     string readercount = null;
        //     using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
        //     {
        //         using (SqlCommand sqlCommand = new SqlCommand("SP002_Coding_Update", sqlconnect))
        //         {
        //             sqlconnect.Open();
        //             sqlCommand.Parameters.AddWithValue("CodingId", param.CodingId);
        //             sqlCommand.Parameters.AddWithValue("Code", param.Code);
        //             sqlCommand.Parameters.AddWithValue("Description", param.Description);
        //             sqlCommand.Parameters.AddWithValue("Scope", param.Scope);
        //             sqlCommand.Parameters.AddWithValue("Stability", param.Stability);
        //             sqlCommand.Parameters.AddWithValue("PublicConsumptionPercent", param.PublicConsumptionPercent);
        //             sqlCommand.Parameters.AddWithValue("PrivateConsumptionPercent", param.PrivateConsumptionPercent);
        //             sqlCommand.CommandType = CommandType.StoredProcedure;
        //             SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
        //             while (dataReader.Read())
        //             {
        //                 if (dataReader["Message_DB"].ToString() != null) readercount = dataReader["Message_DB"].ToString();
        //             }
        //         }
        //     }
        //     if (string.IsNullOrEmpty(readercount)) return Ok("با موفقیت انجام شد");
        //     else
        //         return BadRequest(readercount);
        // }

        [Route("BudgetSepratorAreaProjectModal2")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetSepratorAreaProjectModal2ViewModel>>> BudgetSepratorAreaProjectModal2(int yearId, int areaId)
        {
            List<BudgetSepratorAreaProjectModal2ViewModel> fecthViewModel = new List<BudgetSepratorAreaProjectModal2ViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_BudgetSepratorArea_Project_Modal_2", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", areaId);
                    //sqlCommand.Parameters.AddWithValue("codingId", codingId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetSepratorAreaProjectModal2ViewModel fetchView = new BudgetSepratorAreaProjectModal2ViewModel();
                        fetchView.Id = StringExtensions.ToNullableInt(dataReader["Id"].ToString());
                        fetchView.ProjectCode = dataReader["ProjectCode"].ToString();
                        fetchView.ProjectName = dataReader["ProjectName"].ToString();
                        fetchView.AreaNameShort = dataReader["AreaNameShort"].ToString();

                        fecthViewModel.Add(fetchView);
                    }
                }
            }

            return Ok(fecthViewModel);
        }

        [Route("BudgetSepratorAreaProjectModal_Update")]
        [HttpPost]
        public async Task<ApiResult<string>> BudgetSepratorAreaProjectModal_Update([FromBody] BudgetSepratorAreaProjectModalUpdateViewModel modalUpdateViewModel)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_BudgetSepratorArea_Project_Modal_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("BudgetDetailPrjectId", modalUpdateViewModel.BudgetDetailPrjectId);
                    sqlCommand.Parameters.AddWithValue("ProgramOperationDetailId", modalUpdateViewModel.ProgramOperationDetailId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        if (dataReader["Message_DB"].ToString() != null) readercount = dataReader["Message_DB"].ToString();
                    }
                    dataReader.Close();
                }
                
                if (string.IsNullOrEmpty(readercount)){
                    var obj = await getCodingBaseBDP(sqlconnect, modalUpdateViewModel.BudgetDetailPrjectId);
                    await SaveLogAsync(_db, 0, TargetTypesBudgetLog.Coding, "ویرایش پروژه ردیف بودجه برای سال "+ obj.YearId, obj.Code);
                    
                    return Ok("با موفقیت انجام شد");
                }
                else
                    return BadRequest(readercount);
            }

        }

        [Route("BudgetSepratorDepartmantRead")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetSepratorDepartmantRead>>> GetBudgetSepratorDepartmantRead(int yearId, int areaId, int budgetProcessId)
        {
            List<BudgetSepratorDepartmantRead> fecthViewModel = new List<BudgetSepratorDepartmantRead>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_SepratorAreaDepartment_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand.Parameters.AddWithValue("budgetProcessId", budgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetSepratorDepartmantRead fetchView = new BudgetSepratorDepartmantRead();
                        fetchView.CodingId = int.Parse(dataReader["CodingId"].ToString());
                        fetchView.ProjectId = int.Parse(dataReader["ProjectId"].ToString());
                        fetchView.Code = dataReader["Code"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.Project = dataReader["Project"].ToString();
                        fetchView.LevelNumber = int.Parse(dataReader["LevelNumber"].ToString());
                        fetchView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        fetchView.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        fetchView.Crud = (bool)dataReader["Crud"];

                        fecthViewModel.Add(fetchView);
                    }
                }
            }

            return Ok(fecthViewModel);
        }

        [Route("BudgetSeperatorDepartmentCom")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetSepratorCreaditorCom>>> GetBudgetSepratorCreaditorCom()
        {
            List<BudgetSepratorCreaditorCom> fecthViewModel = new List<BudgetSepratorCreaditorCom>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_Creaditor_Com", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetSepratorCreaditorCom fetchView = new BudgetSepratorCreaditorCom();
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.creaditorName = dataReader["creaditorName"].ToString();



                        fecthViewModel.Add(fetchView);
                    }
                }
            }

            return Ok(fecthViewModel);
        }

          //=============================================================================================================

        [Route("SepratorAreaDepartmentInsert")]
        [HttpPost]
        public async Task<ApiResult<string>> AC_SepratorAreaDepartmentInsert([FromBody] SepratorAreaDepartmantInsert param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_SepratorAreaDepartmant_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", param.yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", param.areaId);
                    sqlCommand.Parameters.AddWithValue("codingId", param.codingId);
                    sqlCommand.Parameters.AddWithValue("projectId", param.projectId);
                    sqlCommand.Parameters.AddWithValue("departmanId", param.departmanId);
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

          //==========================================================================================================================



        [Route("BudgetSepratorAreaDepartmantUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> SepratorAreaDepartmentUpdate([FromBody] BudgetSepratorAreaDepartmantUpdate modalUpdateViewModel)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_SepratorAreaDepartmant_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", modalUpdateViewModel.Id);
                    sqlCommand.Parameters.AddWithValue("MosavabDepartment", modalUpdateViewModel.MosavabDepartment);
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


        [Route("SepratorAreaDepartmentModal")]
        [HttpGet]
        public async Task<ApiResult<List<SepratorAreaDepartmentModalViewModel>>> GetSepratorAreaDepartmentModal(int yearId, int areaId, int codingId, int projectId)
        {
            List<SepratorAreaDepartmentModalViewModel> fecthViewModel = new List<SepratorAreaDepartmentModalViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_SepratorAreaDetpartmant_Modal", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand.Parameters.AddWithValue("codingId", codingId);
                    sqlCommand.Parameters.AddWithValue("projectId", projectId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        SepratorAreaDepartmentModalViewModel fetchView = new SepratorAreaDepartmentModalViewModel();
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.DepartmentName = dataReader["DepartmentName"].ToString();
                        fetchView.MosavabDepartment = Int64.Parse(dataReader["MosavabDepartment"].ToString());

                        fecthViewModel.Add(fetchView);
                    }
                }
            }

            return Ok(fecthViewModel);
        }


        [Route("SepratorAreaDepartmentDelete")]
        [HttpPost]
        public virtual async Task<ApiResult<string>> SepratorAreaCreaditorDelete([FromBody] PublicParamIdViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_SepratorAreaDepartment_Delete", sqlconnect))
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


        // [Route("CodingManualUpdate")]
        // [HttpPost]
        // public async Task<ApiResult<string>> AC_CodingManualUpdate([FromBody] CodingManualUpdate param)
        // {
        //     string readercount = null;
        //     using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
        //     {
        //         using (SqlCommand sqlCommand = new SqlCommand("SP002_EditCodingManual", sqlconnect))
        //         {
        //             sqlconnect.Open();
        //             sqlCommand.Parameters.AddWithValue("YearId", param.YearId);
        //             sqlCommand.Parameters.AddWithValue("AreaId", param.AreaId);
        //             sqlCommand.Parameters.AddWithValue("BudgetProcessId", param.BudgetProcessId);
        //             sqlCommand.Parameters.AddWithValue("CodingId", param.CodingId);
        //             sqlCommand.Parameters.AddWithValue("Code", param.Code);
        //             sqlCommand.Parameters.AddWithValue("Description", param.Description);
        //             sqlCommand.CommandType = CommandType.StoredProcedure;
        //             SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
        //             while (dataReader.Read())
        //             {
        //                 if (dataReader["Message_DB"].ToString() != null) readercount = dataReader["Message_DB"].ToString();
        //             }
        //         }
        //     }
        //     if (string.IsNullOrEmpty(readercount)) return Ok("با موفقیت انجام شد");
        //     else
        //         return BadRequest(readercount);
        // }


        [Route("MosavabManualModal")]
        [HttpGet]
        public async Task<ApiResult<List<MosavabModalViewModel>>> AC_MosavabManualModal(ReadPublicParamViewModel param)
        {
            List<MosavabModalViewModel> fecthViewModel = new List<MosavabModalViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_MosavabManualModal", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", param.yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", param.areaId);
                    sqlCommand.Parameters.AddWithValue("budgetProcessId", param.budgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        MosavabModalViewModel data = new MosavabModalViewModel();
                        data.Code = dataReader["Code"].ToString();
                        data.Description = dataReader["Description"].ToString();
                        data.BudgetDetailId = int.Parse(dataReader["BudgetDetailId"].ToString());
                        data.MosavabPublic = Int64.Parse(dataReader["MosavabPublic"].ToString());
                        data.BudgetDetailProjectId = int.Parse(dataReader["BudgetDetailProjectId"].ToString());
                        data.MosavabProject = Int64.Parse(dataReader["MosavabProject"].ToString());
                        data.BudgetDetailProjectAreaId = int.Parse(dataReader["BudgetDetailProjectAreaId"].ToString());
                        data.MosavabArea = Int64.Parse(dataReader["MosavabArea"].ToString());
                        fecthViewModel.Add(data);
                    }
                }
            }

            return Ok(fecthViewModel);
        }
        //
        //
        // [Route("MosavabManualUpdate")]
        // [HttpPost]
        // public async Task<ApiResult<string>> AC_MosavabManualUpdate([FromBody] MosavabManualUpdateViewModel param)
        // {
        //     string readercount = null;
        //     using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
        //     {
        //         using (SqlCommand sqlCommand = new SqlCommand("SP002_EditMosavabManual", sqlconnect))
        //         {
        //             sqlconnect.Open();
        //             sqlCommand.Parameters.AddWithValue("Mosavab", param.Mosavab);
        //             sqlCommand.Parameters.AddWithValue("BudgetDetailId", param.BudgetDetailId);
        //             sqlCommand.Parameters.AddWithValue("BudgetDetailProjectId", param.BudgetDetailProjectId);
        //             sqlCommand.Parameters.AddWithValue("BudgetDetailProjectAreaId", param.BudgetDetailProjectAreaId);
        //             sqlCommand.CommandType = CommandType.StoredProcedure;
        //             SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
        //             while (dataReader.Read())
        //             {
        //                 if (dataReader["Message_DB"].ToString() != null) readercount = dataReader["Message_DB"].ToString();
        //             }
        //         }
        //     }
        //     if (string.IsNullOrEmpty(readercount)) return Ok("با موفقیت انجام شد");
        //     else
        //         return BadRequest(readercount);
        // }


        [Route("BudgetSepratorAbstractAreaModal")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetSepratorAbstractAreaModalViewModel>>> AC_BudgetSepratorAbstractAreaModal(Param3 param)
        {
            List<BudgetSepratorAbstractAreaModalViewModel> DataModel = new List<BudgetSepratorAbstractAreaModalViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_AbstractArea", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", param.YearId);
                    sqlCommand.Parameters.AddWithValue("AreaId", param.AreaId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetSepratorAbstractAreaModalViewModel row = new BudgetSepratorAbstractAreaModalViewModel();
                        row.side = int.Parse(dataReader["side"].ToString());
                        row.Description = dataReader["Description"].ToString();
                        row.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        row.Edit = Int64.Parse(dataReader["Edit"].ToString());
                        row.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        DataModel.Add(row);
                    }
                }
            }
            return Ok(DataModel);
        }


        [Route("BudgetPerformanceAccept")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetPerformanceAcceptViewModel>>> AC_BudgetPerformanceAccept(Param14 param)
        {
            List<BudgetPerformanceAcceptViewModel> datamodel = new List<BudgetPerformanceAcceptViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_BudgetPerformanceAccept_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", param.YearId);
                    sqlCommand.Parameters.AddWithValue("MonthId", param.MonthId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetPerformanceAcceptViewModel row = new BudgetPerformanceAcceptViewModel();
                        row.Id = int.Parse(dataReader["Id"].ToString());
                        row.UserId = int.Parse(dataReader["UserId"].ToString());
                        row.AreaName = dataReader["AreaName"].ToString();
                        row.FirstName = dataReader["FirstName"].ToString();
                        row.LastName = dataReader["LastName"].ToString();
                        row.Responsibility = dataReader["Responsibility"].ToString();
                        row.Date = dataReader["Date"].ToString();
                        row.DateShamsi = DateTimeExtensions.ConvertMiladiToShamsi(StringExtensions.ToNullableDatetime(dataReader["Date"].ToString()), "yyyy/MM/dd");
                        datamodel.Add(row);
                    }
                }
            }
            return Ok(datamodel);
        }


        [Route("BudgetPerformanceAcceptUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> AC_BudgetPerformanceAcceptUpdate([FromBody] PublicParamIdViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_BudgetPerformanceAccept_Update", sqlconnect))
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



        [Route("AbstractPerformanceMonthly")]
        [HttpGet]
        public async Task<ApiResult<List<AbstractPerformanceMonthlyViewModel>>> AC_AbstractPerformanceMonthly(Param15 param)
        {
            List<AbstractPerformanceMonthlyViewModel> datamodel = new List<AbstractPerformanceMonthlyViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_Abstract_PerformanceMonthly", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", param.YearId);
                    sqlCommand.Parameters.AddWithValue("AreaId", param.AreaId);
                    sqlCommand.Parameters.AddWithValue("budgetProcessId", param.budgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        AbstractPerformanceMonthlyViewModel row = new AbstractPerformanceMonthlyViewModel();
                        row.Id = int.Parse(dataReader["Id"].ToString());
                        row.Code = dataReader["Code"].ToString();
                        row.Description = dataReader["Description"].ToString();
                        row.Month = StringExtensions.ToNullableInt(dataReader["Month"].ToString());
                        row.Mosavab = StringExtensions.ToNullableBigInt(dataReader["Mosavab"].ToString());
                        row.Expense = StringExtensions.ToNullableBigInt(dataReader["Expense"].ToString());
                        datamodel.Add(row);
                    }
                }
            }
            return Ok(datamodel);
        }

    }
}
