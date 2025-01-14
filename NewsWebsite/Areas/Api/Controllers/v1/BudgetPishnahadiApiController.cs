﻿
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
using NewsWebsite.ViewModels.Api.Budget.BudgetProposal;
using NewsWebsite.ViewModels.Api.Budget.BudgetSeprator;
using NewsWebsite.ViewModels.Api.Projects;
using NewsWebsite.ViewModels.Api.Request;
using NewsWebsite.ViewModels.Fetch;
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
    public class BudgetPishnahadiApiController : EnhancedBudgetController
    {
        public readonly IUnitOfWork _uw;
        private readonly IConfiguration _config;
        private readonly ProgramBuddbContext _db;

        public BudgetPishnahadiApiController(IUnitOfWork uw, IConfiguration configuration,ProgramBuddbContext db)
        {
            _config = configuration;
            _uw = uw;
            _db = db;
        }

        [Route("BudgetProposalRead")]
        [HttpGet]
        public async Task<ApiResult<List<PishanahadViewModel>>> BudgetProposaRead(int yearId, int areaId, int budgetProcessId)
        {
            List<PishanahadViewModel> data = new List<PishanahadViewModel>();
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP004_BudgetProposal_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", yearId);
                    sqlCommand.Parameters.AddWithValue("AreaId", areaId);
                    sqlCommand.Parameters.AddWithValue("BudgetProcessId", budgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        PishanahadViewModel row = new PishanahadViewModel();
                        row.CodingId = int.Parse(dataReader["CodingId"].ToString());
                        row.Code = dataReader["Code"].ToString();
                        row.Description = dataReader["Description"].ToString();
                        row.LevelNumber = int.Parse(dataReader["LevelNumber"].ToString());
                        row.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        row.Edit = StringExtensions.ToNullableBigInt(dataReader["Edit"].ToString());
                        row.CreditAmount = StringExtensions.ToNullableBigInt(dataReader["CreditAmount"].ToString());
                        row.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        row.PishnahadiCash = Int64.Parse(dataReader["PishnahadiCash"].ToString());
                        row.PishnahadiNonCash = Int64.Parse(dataReader["PishnahadiNonCash"].ToString());
                        row.Pishnahadi = Int64.Parse(dataReader["Pishnahadi"].ToString());
                        row.ConfirmStatus = int.Parse(dataReader["ConfirmStatus"].ToString());
                        row.IsNewYear = int.Parse(dataReader["isNewYear"].ToString());
                        row.DelegateTo = int.Parse(dataReader["DelegateTo"].ToString());
                        row.DelegateToName = dataReader["DelegateToName"].ToString();
                        row.DelegateAmount = Int64.Parse(dataReader["DelegateAmount"].ToString());
                        row.DelegatePercentage = int.Parse(dataReader["DelegatePercentage"].ToString());
                        row.ExecutionId = int.Parse(dataReader["ExecutionId"].ToString());
                        row.ProctorId = int.Parse(dataReader["ProctorId"].ToString());
                        row.Last3Month = Int64.Parse(dataReader["Last3Month"].ToString());
                        row.Last9Month = Int64.Parse(dataReader["Last9Month"].ToString());
                        row.Crud = (bool)dataReader["Crud"];
                        if (row.Mosavab != 0)
                        {
                            row.Percent = _uw.Budget_001Rep.Growth(row.Pishnahadi, row.Mosavab);
                        }
                        else
                        {
                            row.Percent = 0;
                        }
                        data.Add(row);
                    }
                }
                return Ok(data);
            }
        }

        [Route("BudgetProposalBalanceTextBoxRead")]
        [HttpGet]
        public async Task<ApiResult<BalanceViewModel>> BudgetProposalBalanceTextBoxRead(int yearId, int areaId, int budgetProcessId)
        {
            BalanceViewModel fecth = new BalanceViewModel();
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP004_BudgetProposal_BalanceTextbox_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", yearId);
                    sqlCommand.Parameters.AddWithValue("AreaId", areaId);
                    sqlCommand.Parameters.AddWithValue("BudgetProcessId", budgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                         fecth.Balance = Int64.Parse(dataReader["Balance"].ToString());
              
                    }
                }
                return Ok(fecth);
            }
        }

        [Route("BudgetProposalInlineInsert")]
        [HttpPost]
        public async Task<ApiResult<string>> BudgetProposalInlineInsert([FromBody] BudgetPrposalInsertModalViewModel updateParamViewModel)
        {
            string readercount = null;
            string newCode = null;

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP004_BudgetProposal_Inline_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("areaId", updateParamViewModel.areaId);
                    sqlCommand.Parameters.AddWithValue("codingId", updateParamViewModel.codingId);
                    sqlCommand.Parameters.AddWithValue("budgetProcessId", updateParamViewModel.budgetProcessId);
                    sqlCommand.Parameters.AddWithValue("yearId", updateParamViewModel.yearId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        if (dataReader["Message_DB"].ToString() != null) readercount = dataReader["Message_DB"].ToString();
                        if (dataReader["NewCode"].ToString() != null) newCode = dataReader["NewCode"].ToString();
                    }
                }
            }

            if (string.IsNullOrEmpty(readercount)){
                await SaveLogAsync(_db, 0, TargetTypesBudgetLog.Coding, "افزودن ردیف بودجه  برای منطقه"+updateParamViewModel.areaId+" وسال "+updateParamViewModel.yearId, newCode);

                return Ok("با موفقیت انجام شد");
            }
            else
                return BadRequest(readercount);
        }
      
        //ثبت بودجه سال جدید پیشنهادی
        [Route("BudgetProposalModalUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> BudgetProposalModalUpdate([FromBody] BudgetProposalUpdateViewModel param)
        {
            string readercount = null;

            if (param.Pishnahadi  < (param.DelegateAmount ?? 0)){
                return BadRequest("مبلغ نیابت نمی تواند بیشتر از مبلغ پیشنهادی باشد");
            }
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP004_BudgetProposal_Inline_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", param.yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", param.areaId);
                    sqlCommand.Parameters.AddWithValue("proctorId", param.ProctorId);
                    sqlCommand.Parameters.AddWithValue("executionId", param.ExecutionId);
                    sqlCommand.Parameters.AddWithValue("budgetProcessId", param.budgetProcessId);
                    sqlCommand.Parameters.AddWithValue("codingId", param.codingId);
                    sqlCommand.Parameters.AddWithValue("PishnahadiCash", param.PishnahadiCash);
                    sqlCommand.Parameters.AddWithValue("PishnahadiNonCash", param.PishnahadiNonCash);
                    sqlCommand.Parameters.AddWithValue("Pishnahadi", param.Pishnahadi);
                    // sqlCommand.Parameters.AddWithValue("Description", param.Description);
                    sqlCommand.Parameters.AddWithValue("DelegateTo", param.DelegateTo??0);
                    sqlCommand.Parameters.AddWithValue("DelegateAmount", param.DelegateAmount??0);
                    sqlCommand.Parameters.AddWithValue("DelegatePercentage", param.DelegatePercentage??0);
                    sqlCommand.Parameters.AddWithValue("Last3Month", param.Last3Month??0);
                    sqlCommand.Parameters.AddWithValue("Last9Month", param.Last9Month??0);
           
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        if (dataReader["Message_DB"].ToString() != null) readercount = dataReader["Message_DB"].ToString();
                    }
                }
            }

            if (string.IsNullOrEmpty(readercount)){
                await SaveLogAsync(_db, 0, TargetTypesBudgetLog.Coding, "ویرایش بودجه پیشنهادی منطقه"+param.areaId+" وسال "+param.yearId
                                                                        +"Pishnahadi : " + param.Pishnahadi
                                                                        +"PishnahadiCash : " + param.PishnahadiCash
                                                                        +"PishnahadiNonCash : " + param.PishnahadiNonCash
                                                                        +"DelegateTo : " + (param.DelegateTo ?? 0)
                                                                        +"DelegateAmount : " + (param.DelegateAmount??0)
                                                                        +"DelegatePercentage : " + (param.DelegatePercentage??0)
                                                                        +"Last3Month : " + (param.Last3Month??0)
                                                                        +"Last9Month : " + (param.Last9Month??0)
                    , param.codingId);

                return Ok("با موفقیت انجام شد");
            }
            else
                return BadRequest(readercount);
        }

        //ثبت بودجه اصلاحیه پیشنهادی

        [Route("BudgetProposalEditInlineUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> BudgetProposalEditInlineUpdate([FromBody] BudgetProposalEditUpdateViewModel param)
        {
            string readercount = null;

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP004_BudgetProposalEdit_Inline_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", param.yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", param.areaId);
                    sqlCommand.Parameters.AddWithValue("proctorId", param.ProctorId);
                    sqlCommand.Parameters.AddWithValue("executionId", param.ExecutionId);
                    sqlCommand.Parameters.AddWithValue("budgetProcessId", param.budgetProcessId);
                    sqlCommand.Parameters.AddWithValue("codingId", param.codingId);
                    sqlCommand.Parameters.AddWithValue("BudgetNext", param.BudgetNext);
                    sqlCommand.Parameters.AddWithValue("Description", param.Description);

                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        if (dataReader["Message_DB"].ToString() != null) readercount = dataReader["Message_DB"].ToString();
                    }
                }
            }

            if (string.IsNullOrEmpty(readercount)){
                await SaveLogAsync(_db, 0, TargetTypesBudgetLog.Coding, "ویرایش اصلاح پیشنهادی به "+param.BudgetNext + " برای منطقه " + param.areaId+" و سال "+param.yearId, param.codingId);

                return Ok("با موفقیت انجام شد");
            }
            else
                return BadRequest(readercount);
        }

        [Route("BudgetProposalInlineDelete")]
        [HttpPost]
        public async Task<ApiResult<string>> BudgetProposalInlineDelete([FromBody] BudgetProposalInlineDeleteViewModel paramDelete)
        {
            string readercount = null;

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP004_BudgetProposal_Inline_Delete", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", paramDelete.yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", paramDelete.areaId);
                    sqlCommand.Parameters.AddWithValue("budgetProcessId", paramDelete.budgetProcessId);
                    sqlCommand.Parameters.AddWithValue("codingId", paramDelete.codingId);

                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        if (dataReader["Message_DB"].ToString() != null) readercount = dataReader["Message_DB"].ToString();
                    }
                }
            }

            if (string.IsNullOrEmpty(readercount)){
                await SaveLogAsync(_db, 0, TargetTypesBudgetLog.Coding, "حذف کدینگ منطقه"+paramDelete.areaId+" وسال "+paramDelete.yearId, paramDelete.codingId);
                return Ok("با موفقیت انجام شد");
            }
            else
                return BadRequest(readercount);
        }


        [Route("BudgetProposalModalRead")]
        [HttpGet]
        public async Task<ApiResult<List<PishanahadModalViewModel>>> AC_BudgetProposalModalRead(int yearId, int areaId, int budgetProcessId , int codingId)
        {
            List<PishanahadModalViewModel> data = new List<PishanahadModalViewModel>();
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP004_BudgetProposal_Modal_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", yearId);
                    sqlCommand.Parameters.AddWithValue("AreaId", areaId);
                    sqlCommand.Parameters.AddWithValue("BudgetProcessId", budgetProcessId);
                    sqlCommand.Parameters.AddWithValue("codingId", codingId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        PishanahadModalViewModel row = new PishanahadModalViewModel();
                        row.CodingId = int.Parse(dataReader["CodingId"].ToString());
                        row.AreaId = int.Parse(dataReader["AreaId"].ToString());
                        row.AreaName = dataReader["AreaName"].ToString();
                        // row.ProctorId = dataReader["ProctorId"].ToString();
                        // row.ExecutionId = dataReader["ExecutionId"].ToString();
                        row.Code = dataReader["Code"].ToString();
                        row.Description = dataReader["Description"].ToString();
                        row.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        row.Edit = Int64.Parse(dataReader["Edit"].ToString());
                        row.Supply = Int64.Parse(dataReader["Supply"].ToString());
                        row.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        row.BudgetNext = Int64.Parse(dataReader["BudgetNext"].ToString());
                    
                        data.Add(row);
                    }
                }
                return Ok(data);
            }
        }


        [Route("ChartRadef")]
        [HttpGet]
        public async Task<ApiResult<List<object>>> ChartRadef(int codingId )
        {
            List<object> data = new List<object>();
            List<int> YearName = new List<int>();
            List<Int64> Mosavab = new List<Int64>();
            List<Int64> Edit = new List<Int64>();
            List<Int64> Expense = new List<Int64>();
            List<double> PercentMosavab = new List<double>();
            List<double> PercentEdit = new List<double>();

            using (SqlConnection sqlconnect1 = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand1 = new SqlCommand("SP004_BudgetProposal_Chart_Read", sqlconnect1))
                    {
                        sqlconnect1.Open();
                        sqlCommand1.CommandType = CommandType.StoredProcedure;
                        sqlCommand1.Parameters.AddWithValue("codingId", codingId);
                        SqlDataReader dataReader = await sqlCommand1.ExecuteReaderAsync();

                        while (dataReader.Read())
                        {
                           YearName.Add(int.Parse(dataReader["YearName"].ToString()));
                           Mosavab.Add(Int64.Parse(dataReader["Mosavab"].ToString()));
                           Edit.Add(Int64.Parse(dataReader["Edit"].ToString()));
                           Expense.Add(Int64.Parse(dataReader["Expense"].ToString()));
                            if (Int64.Parse(dataReader["Mosavab"].ToString()) > 0)
                            {
                            PercentMosavab.Add(_uw.Budget_001Rep.Division(long.Parse(dataReader["Expense"].ToString()), long.Parse(dataReader["Mosavab"].ToString())));
                            }
                            else
                            {
                            PercentMosavab.Add(0);
                            }
                            if (Int64.Parse(dataReader["Edit"].ToString()) > 0)
                            {
                            PercentEdit.Add(_uw.Budget_001Rep.Division(long.Parse(dataReader["Expense"].ToString()), long.Parse(dataReader["Edit"].ToString())));
                            }
                            else
                            {
                            PercentEdit.Add(0);
                            }
                        }

                        data.Add(YearName);
                        data.Add(Mosavab);
                        data.Add(Edit);
                        data.Add(Expense);
                        data.Add(PercentMosavab);
                        data.Add(PercentEdit);
                    }
                }

            return data;

        }



    }
}
