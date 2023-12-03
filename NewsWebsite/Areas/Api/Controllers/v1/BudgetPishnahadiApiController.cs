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
    public class BudgetPishnahadiApiController : Controller
    {
        public readonly IUnitOfWork _uw;
        private readonly IConfiguration _config;
        public BudgetPishnahadiApiController(IUnitOfWork uw, IConfiguration configuration)
        {
            _config = configuration;
            _uw = uw;
        }

        [Route("BudgetProposalIndex")]
        [HttpGet]
        public async Task<ApiResult<List<PishanahadViewModel>>> BudgetProposalIndex(int yearId, int areaId, int budgetProcessId)
        {
            List<PishanahadViewModel> fecth = new List<PishanahadViewModel>();
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                Int64 _totalMosavab = 0; Int64 _totalExpense = 0;
                using (SqlCommand sqlCommand = new SqlCommand("SP004_BudgetProposal", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", yearId);
                    sqlCommand.Parameters.AddWithValue("AreaId", areaId);
                    sqlCommand.Parameters.AddWithValue("BudgetProcessId", budgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {

                        PishanahadViewModel fetchView = new PishanahadViewModel();
                        fetchView.CodingId = int.Parse(dataReader["CodingId"].ToString());
                        fetchView.Code = dataReader["Code"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.LevelNumber = int.Parse(dataReader["LevelNumber"].ToString());
                        fetchView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        fetchView.Edit = StringExtensions.ToNullableBigInt(dataReader["Edit"].ToString());
                        fetchView.CreditAmount = StringExtensions.ToNullableBigInt(dataReader["CreditAmount"].ToString());
                        fetchView.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        fetchView.Crud = (bool)dataReader["Crud"];
                        _totalMosavab += fetchView.Mosavab;
                        _totalExpense += fetchView.Expense;

                        fecth.Add(fetchView);

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
                    }
                }
            }
            if (string.IsNullOrEmpty(readercount)) return Ok("با موفقیت انجام شد");
            else
                return BadRequest(readercount);
        }


          }
}
