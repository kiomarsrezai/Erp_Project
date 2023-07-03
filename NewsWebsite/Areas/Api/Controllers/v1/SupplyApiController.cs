using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Budget;
using NewsWebsite.ViewModels.Api.Supply;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace NewsWebsite.Areas.Api.Controllers.v1
{

    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class SupplyApiController : Controller
    {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        public readonly IBudget_001Rep _budgetuw;
        public SupplyApiController(IUnitOfWork uw, IBudget_001Rep budgetuw, IConfiguration configuration)
        {
            _config = configuration;
            _uw = uw;
            _budgetuw = budgetuw;
        }

        [Route("SuppliersRead")]
        [HttpGet]
        public async Task<ApiResult<List<SupplyViewModel>>> AC_SuppliersRead(int SuppliersCoKindId)
        {
            List<SupplyViewModel> fecthViewModel = new List<SupplyViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP011_Suppliers_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("SuppliersCoKindId", SuppliersCoKindId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        SupplyViewModel fetchView = new SupplyViewModel();
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.SuppliersName = dataReader["SuppliersName"].ToString();
                        fetchView.Bank = dataReader["Bank"].ToString();
                        fetchView.Branch = dataReader["Branch"].ToString();
                        fetchView.NumberBank = dataReader["NumberBank"].ToString();
                        fecthViewModel.Add(fetchView);
                    }
                }
            }
            return Ok(fecthViewModel);
        }
        
        [Route("SuppliersCo_ComList")]
        [HttpGet]
        public async Task<ApiResult<List<SuppliersCoViewModel>>> GetSuppliersCo_ComList()
        {
            List<SuppliersCoViewModel> fecthViewModel = new List<SuppliersCoViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP011_SuppliersCo_Com", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        SuppliersCoViewModel fetchView = new SuppliersCoViewModel();
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.CompanyKindName = dataReader["CompanyKindName"].ToString();

                        fecthViewModel.Add(fetchView);
                    }
                }
            }
            return Ok(fecthViewModel);
        }


   
    }
}
