using Microsoft.EntityFrameworkCore;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.UsersApi;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.ViewModels.Api.GeneralVm;
using NewsWebsite.ViewModels.Api.Budget.BudgetSeprator;
using NewsWebsite.ViewModels.Api.Report;
using NewsWebsite.ViewModels.Api.Deputy;

namespace NewsWebsite.Data.Repositories
{
    public class Budget_001Rep : IBudget_001Rep
    {
        ProgramBuddbContext _context;
        public readonly IUnitOfWork _uw;
        public readonly IConfiguration _config;

        public Budget_001Rep(ProgramBuddbContext context, IConfiguration config)
        {
            _config = config;
            _context = context;
        }

        //private readonly ProgramBudDbContext context;
        public List<AreaViewModel> AreaFetchForPropozalBudget()
        {
            List<AreaViewModel> areaViews = new List<AreaViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP000_Area_ProposalBudget", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = sqlCommand.ExecuteReader();
                    while (dataReader.Read())
                    {
                        AreaViewModel fetchView = new AreaViewModel();
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.AreaName = dataReader["AreaName"].ToString();
                        areaViews.Add(fetchView);

                        //dataReader.NextResult();
                    }
                }
            }
            return areaViews;
        }

        public async Task<List<YearViewModel>> YearFetchAsync(int kindid)
        {
            List<YearViewModel> yearViews = new List<YearViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP000_Year", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", kindid);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        YearViewModel fetchView = new YearViewModel();
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.YearName = dataReader["YearName"].ToString();
                        yearViews.Add(fetchView);

                        //dataReader.NextResult();
                    }
                }
            }
            return yearViews;
        }

        public async Task<List<BudgetProcessViewModel>> BudgetProcessFetchAsync()
        {
            List<BudgetProcessViewModel> yearViews = new List<BudgetProcessViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP000_BudgetSection", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetProcessViewModel fetchView = new BudgetProcessViewModel();
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.ProcessName = dataReader["ProcessName"].ToString();
                        yearViews.Add(fetchView);

                        //dataReader.NextResult();
                    }
                }
            }
            return yearViews;
        }

        public async Task<string> AreaNameByIdAsync(int id)
        {
            string name = "";
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP000_AreaNameById", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", id);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                        name = dataReader["AreaName"].ToString();
                }
            }
            return name;
        }

        public async Task<UserSignViewModel> GetUserByTocken(string tocken)
        {
            UserSignViewModel user = new UserSignViewModel();
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP000_GetUserInfoByTocken", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("tocken", tocken);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (await dataReader.ReadAsync())
                    {
                        //            user.FirstName = user.FirstName;
                        //user.LastName = userfetch.LastName;
                        //user.SectionId = userfetch.SectionId;
                        //user.SectionName = await AreaNameByIdAsync(userfetch.SectionId);
                        //user.Token = userfetch.Token;
                        //            user.UserName = dataReader["UserName"].ToString(); user.FirstName = dataReader["FirstName"].ToString();
                        //            user.LastName = dataReader["LastName"].ToString();
                        //            user.SectionId = StringExtensions.ToNullableInt(dataReader["SectionId"].ToString());
                        //            user.SectionName = await AreaNameByIdAsync(int.Parse(dataReader["SectionId"].ToString()));
                        //            user.Token = dataReader["Token"].ToString();
                        //            user.UserName = dataReader["UserName"].ToString();
                    }
                }
            }
            return user;
        }
   
        public async Task<List<AreaViewModel>> AreaFetchAsync(int areaform)
        {
            List<AreaViewModel> areaViews = new List<AreaViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP000_Area", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("areaForm", areaform);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        AreaViewModel fetchView = new AreaViewModel();
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.AreaName = dataReader["AreaName"].ToString();
                        fetchView.AreaNameShort = dataReader["AreaNameShort"].ToString();
                        areaViews.Add(fetchView);

                        //dataReader.NextResult();
                    }
                }
            }
            return areaViews;
        }

        public async Task<List<ProctorViewModel>> ProctorList()
        {
           
            List<ProctorViewModel> areaViews = new List<ProctorViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP501_ProctorList_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        ProctorViewModel fetchView = new ProctorViewModel();
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.ProctorName = dataReader["ProctorName"].ToString();
                        areaViews.Add(fetchView);

                        //dataReader.NextResult();
                    }
                }
            }
            return areaViews;
        }

        public double Divivasion(double? expense, double? mosavab)
        {
            if (mosavab == null )  return 0;

            double summry = 0;
            summry = Math.Round((double)(expense / mosavab * 100));
            return summry;
        }

       

     
        public async Task<List<BudgetSepratorViewModel>> GetAllBudgetSeprtaorAsync(int yearId, int areaId, int budgetProcessId)
        {
            List<BudgetSepratorViewModel> fecth = new List<BudgetSepratorViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP002_BudgetSepratorArea", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand.Parameters.AddWithValue("budgetProcessId", budgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetSepratorViewModel fetchView = new BudgetSepratorViewModel();
                        fetchView.Code = dataReader["Code"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.CodingId = int.Parse(dataReader["CodingId"].ToString());
                        fetchView.Edit= long.Parse(dataReader["Edit"].ToString());
                        fetchView.LevelNumber = int.Parse(dataReader["LevelNumber"].ToString());
                        fetchView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        fetchView.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        fetchView.CreditAmount = Int64.Parse(dataReader["CreditAmount"].ToString());
                        fetchView.Crud = bool.Parse(dataReader["Crud"].ToString());
                        fetchView.budgetProcessId = budgetProcessId;

                        if (fetchView.Mosavab != 0)
                        {
                            fetchView.PercentBud = Math.Round(Divivasion(fetchView.Expense, fetchView.Mosavab));
                        }
                        else
                        {
                            fetchView.PercentBud = 0;
                        }
                        fecth.Add(fetchView);
                        //dataReader.NextResult();
                    }
                    //TempData["budgetSeprator"] = fecthViewModel;
                }
            }
            return fecth;
        }

        public async Task<bool> SaveLisenceAsync(int userId, string lisence)
        {
            if (userId == 0)
                return false;

            var user = await _uw._Context.Users.FirstOrDefaultAsync(a => a.Id == userId);
            user.Lisence = lisence;
            return true;
        }

    }

}
