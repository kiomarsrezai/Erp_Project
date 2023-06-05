using Microsoft.AspNetCore.Mvc;
using Microsoft.CodeAnalysis;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Budget.BudgetSeprator;
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
    public class BudSepApiController : Controller
    {
        public readonly IUnitOfWork _uw;
        public readonly IConfiguration _configuration;
        public BudSepApiController(IUnitOfWork uw, IConfiguration configuration)
        {
            _configuration = configuration;
            _uw = uw;
        }

        [Route("FetchSeprator")]
        [HttpGet]
        public async Task<IActionResult> FetchSeprators(int yearId, int areaId, int budgetprocessId)
        {
            return Ok(await _uw.Budget_001Rep.GetAllBudgetSeprtaorAsync(yearId, areaId, budgetprocessId));
        }

        
        [Route("DeleteTamin")]
        [HttpPost]
        public virtual async Task<ApiResult> DeleteTamin([FromBody] DeleteSepViewModel deleteSep)
        {
            if (deleteSep.id == 0)
                return BadRequest();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_BudgetSepratorArea_TaminModal_Delete", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("id", deleteSep.id);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    TempData["notification"] = "ویرایش با موفقیت انجام شد";
                }
            }
            return Ok();
        }

        [Route("RefreshSeperator")]
        [HttpGet]
        public async Task<ApiResult> RefreshSeprator(RefreshFormViewModel refreshFormViewModel)
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
                        ViewBag.alertsucces = "بروزرسانی انجام شد";
                    }
                    //view["notification"] = "بروزرسانی با موفقیت انجام شد";
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
                        ViewBag.alertsucces = "بروزرسانی انجام شد";
                    }
                    //view["notification"] = "بروزرسانی با موفقیت انجام شد";
                }
            }
            return Ok();
        }

        [Route("TaminInsert")]
        [HttpPost]
        public async Task<ApiResult> TaminInsert([FromBody] InsertTaminSepViewModel insertTaminSep)
        {
            if (insertTaminSep.codingId == 0) return BadRequest();

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
                    TempData["notification"] = "ویرایش با موفقیت انجام شد";
                }
            }
            return Ok();
        }

        [Route("BudgetSepratorAreaAccModal")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetSepratorAreaAccModalViewModel>>> BudgetSepratorAreaAccModal(int yearId, int areaId, int codingId)
        {
            List<BudgetSepratorAreaAccModalViewModel> fecthViewModel = new List<BudgetSepratorAreaAccModalViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_BudgetSepratorArea_Acc_Modal", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand.Parameters.AddWithValue("codingId", codingId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetSepratorAreaAccModalViewModel fetchView = new BudgetSepratorAreaAccModalViewModel();
                        fetchView.NumberSanad = StringExtensions.ToNullableInt(dataReader["NumberSanad"].ToString());
                        fetchView.DateSanad = dataReader["DateSanad"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.Expense = Int64.Parse(dataReader["Expense"].ToString());

                        fecthViewModel.Add(fetchView);
                    }
                }
            }

            return Ok(fecthViewModel);
        }

        [Route("BudgetSepratorAreaProjectModal")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetSepratorAreaProjectModalViewModel>>> BudgetSepratorAreaProjectModal(int yearId, int areaId, int codingId)
        {
            List<BudgetSepratorAreaProjectModalViewModel> fecthViewModel = new List<BudgetSepratorAreaProjectModalViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_BudgetSepratorArea_Project_Modal", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand.Parameters.AddWithValue("codingId", codingId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetSepratorAreaProjectModalViewModel fetchView = new BudgetSepratorAreaProjectModalViewModel();
                        fetchView.Id = StringExtensions.ToNullableInt(dataReader["Id"].ToString());
                        fetchView.ProjectCode = dataReader["ProjectCode"].ToString();
                        fetchView.ProjectName = dataReader["ProjectName"].ToString();
                        fetchView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());

                        fecthViewModel.Add(fetchView);
                    }
                }
            }

            return Ok(fecthViewModel);
        }

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
        public async Task<ApiResult> BudgetSepratorAreaProjectModal_Update([FromBody] BudgetSepratorAreaProjectModalUpdateViewModel modalUpdateViewModel)
        {
            if (modalUpdateViewModel.BudgetDetailPrjectId == 0) return BadRequest();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_BudgetSepratorArea_Project_Modal_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("BudgetDetailPrjectId", modalUpdateViewModel.BudgetDetailPrjectId);
                    sqlCommand.Parameters.AddWithValue("ProgramOperationDetailId", modalUpdateViewModel.ProgramOperationDetailId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    TempData["notification"] = "ویرایش با موفقیت انجام شد";
                }
            }
            return Ok();
        }

        [Route("BudgetSepratorDepartmantRead")]
        [HttpGet]
        public async Task<ApiResult<List<BudgetSepratorDepartmantRead>>> GetBudgetSepratorDepartmantRead(int yearId, int areaId , int budgetProcessId)
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

        [Route("SepratorAreaDepartmentInsert")]
        [HttpPost]
        public async Task<ApiResult> SepratorAreaDepartmanInsert([FromBody] SepratorAreaDepartmantInsert modalUpdateViewModel)
        {
          //  if (modalUpdateViewModel.departmanId == 0) return BadRequest();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_SepratorAreaDepartmant_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", modalUpdateViewModel.yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", modalUpdateViewModel.areaId);
                    sqlCommand.Parameters.AddWithValue("codingId", modalUpdateViewModel.codingId);
                    sqlCommand.Parameters.AddWithValue("projectId", modalUpdateViewModel.projectId);
                    sqlCommand.Parameters.AddWithValue("departmanId", modalUpdateViewModel.departmanId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    TempData["notification"] = "ویرایش با موفقیت انجام شد";
                }
            }
            return Ok();
        }

        [Route("BudgetSepratorAreaDepartmantUpdate")]
        [HttpPost]
        public async Task<ApiResult> SepratorAreaDepartmentUpdate([FromBody] BudgetSepratorAreaDepartmantUpdate modalUpdateViewModel)
        {
            if (modalUpdateViewModel.Id == 0) return BadRequest();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_SepratorAreaDepartmant_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", modalUpdateViewModel.Id);
                    sqlCommand.Parameters.AddWithValue("MosavabDepartment", modalUpdateViewModel.MosavabDepartment);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    TempData["notification"] = "ویرایش با موفقیت انجام شد";
                }
            }
            return Ok();
        }

        [Route("SepratorAreaDepartmentDelete")]
        [HttpPost]
        public virtual async Task<ApiResult> SepratorAreaCreaditorDelete([FromBody] DeleteSepViewModel deleteSep)
        {
            if (deleteSep.id == 0)
                return BadRequest();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_SepratorAreaDepartment_Delete", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("id", deleteSep.id);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    TempData["notification"] = "ویرایش با موفقیت انجام شد";
                }
            }
            return Ok();
        }

        [Route("SepratorAreaDepartmentModal")]
        [HttpGet]
        public async Task<ApiResult<List<SepratorAreaDepartmentModalViewModel>>> GetSepratorAreaDepartmentModal(int yearId, int areaId, int codingId , int projectId)
        {
            List<SepratorAreaDepartmentModalViewModel> fecthViewModel = new List<SepratorAreaDepartmentModalViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_SepratorAreaDetpartmant_Modal", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand.Parameters.AddWithValue("@codingId", codingId);
                    sqlCommand.Parameters.AddWithValue("@projectId", projectId);
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





    }


}
