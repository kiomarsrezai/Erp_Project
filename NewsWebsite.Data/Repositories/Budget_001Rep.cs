using Microsoft.EntityFrameworkCore;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.UsersApi;
using NewsWebsite.ViewModels.Fetch;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.ViewModels.Api.GeneralVm;

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

        public double Divivasion(double expense, double mosavab)
        {
            double summry = 0;
            summry = Math.Round((double)(expense / mosavab * 100));
            return summry;
        }

        public List<DeputyViewModel> GetAllDeputiesAsync(int offset, int limit, string Orderby, string searchText)
        {
            List<DeputyViewModel> fecthViewModel = GetAllDeputies().Where(c => c.ProctorName.Contains(searchText))
                                   .Skip(offset).Take(limit)
                                   .Select(t => new DeputyViewModel
                                   {
                                       Id = t.Id,
                                       ProctorName = t.ProctorName,
                                       PercentTotalStr = t.PercentTotalStr,
                                       PercentTotal = t.PercentTotal,
                                       ExpenseCivil = t.ExpenseCivil,
                                       ExpenseCivilStr = t.ExpenseCivilStr,
                                       ExpenseCurrent = t.ExpenseCurrent,
                                       ExpenseCurrentStr = t.ExpenseCurrentStr,
                                       MosavabCivil = t.MosavabCivil,
                                       MosavabCivilStr = t.MosavabCivilStr,
                                       MosavabCurrentStr = t.MosavabCurrentStr,
                                       PercentCivil = t.PercentCivil,
                                       PercentCivilStr = t.PercentCivilStr,
                                       PercentCurrent = t.PercentCurrent,
                                       PercentCurrentStr = t.PercentCurrentStr
                                   }).ToList();
            foreach (var item in fecthViewModel)
                item.Row = ++offset;

            return fecthViewModel;
        }

        public List<DeputyViewModel> GetAllDeputies()
        {
            List<DeputyViewModel> fecthViewModel = new List<DeputyViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP501_Proctor", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", 32);
                    sqlCommand.Parameters.AddWithValue("ProctorId", 0);
                    sqlCommand.Parameters.AddWithValue("AreaId", 0);
                    sqlCommand.Parameters.AddWithValue("BudgetProcessId", 0);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = sqlCommand.ExecuteReader();
                    while (dataReader.Read())
                    {
                        DeputyViewModel fetchView = new DeputyViewModel();
                        fetchView.ProctorName = dataReader["ProctorName"].ToString();
                        fetchView.MosavabCurrent = long.Parse(dataReader["MosavabCurrent"].ToString());
                        fetchView.MosavabCurrentStr = Common.StringExtensions.En2Fa(Common.StringExtensions.ToNumeric(long.Parse(dataReader["MosavabCurrent"].ToString())));
                        fetchView.MosavabCivil = long.Parse(dataReader["MosavabCivil"].ToString());
                        fetchView.MosavabCivilStr = Common.StringExtensions.En2Fa(Common.StringExtensions.ToNumeric(long.Parse(dataReader["MosavabCivil"].ToString())));
                        fetchView.ExpenseCurrent = long.Parse(dataReader["ExpenseCurrent"].ToString());
                        fetchView.ExpenseCurrentStr = Common.StringExtensions.En2Fa(Common.StringExtensions.ToNumeric(long.Parse(dataReader["ExpenseCurrent"].ToString())));
                        fetchView.ExpenseCivil = long.Parse(dataReader["ExpenseCivil"].ToString());
                        fetchView.ExpenseCivilStr = Common.StringExtensions.En2Fa(Common.StringExtensions.ToNumeric(long.Parse(dataReader["ExpenseCivil"].ToString())));
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.Row = int.Parse(dataReader["Id"].ToString());

                        if (fetchView.MosavabCurrent != 0)
                        {
                            fetchView.PercentCurrent = Divivasion(fetchView.ExpenseCurrent, fetchView.MosavabCurrent);
                            fetchView.PercentCurrentStr = Common.StringExtensions.En2Fa(Divivasion(fetchView.ExpenseCurrent, fetchView.MosavabCurrent).ToString()) + "%";
                        }
                        else
                        {
                            fetchView.MosavabCurrent = 0;
                        }


                        if (fetchView.MosavabCivil != 0)
                        {
                            fetchView.PercentCivil = Divivasion(fetchView.ExpenseCivil, fetchView.MosavabCivil);
                            fetchView.PercentCivilStr = Common.StringExtensions.En2Fa(Divivasion(fetchView.ExpenseCivil, fetchView.MosavabCivil).ToString()) + "%";
                        }
                        else
                        { fetchView.PercentCivil = 0; }


                        if (fetchView.MosavabCurrent + fetchView.MosavabCivil != 0)
                        {
                            fetchView.PercentTotal = Divivasion(fetchView.ExpenseCivil + fetchView.ExpenseCurrent, fetchView.MosavabCivil + fetchView.MosavabCurrent);
                            fetchView.PercentTotalStr = Common.StringExtensions.En2Fa(Divivasion(fetchView.ExpenseCivil + fetchView.ExpenseCurrent, fetchView.MosavabCivil + fetchView.MosavabCurrent).ToString()) + "%";
                        }
                        else
                        {
                            fetchView.PercentTotal = 0;
                        }

                        fecthViewModel.Add(fetchView);
                    }
                }
            }

            return fecthViewModel;
        }

        public List<AreaProctorViewModel> ProctorArea(int Id)
        {

            List<AreaProctorViewModel> fecthViewModel = new List<AreaProctorViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP501_Proctor", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", 32);
                    sqlCommand.Parameters.AddWithValue("ProctorId", Id);
                    sqlCommand.Parameters.AddWithValue("AreaId", 0);
                    sqlCommand.Parameters.AddWithValue("BudgetProcessId", 0);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = sqlCommand.ExecuteReader();
                    while (dataReader.Read())
                    {
                        AreaProctorViewModel fetchView = new AreaProctorViewModel();
                        fetchView.Id = int.Parse(dataReader["AreaId"].ToString());
                        fetchView.AreaName = dataReader["AreaName"].ToString();
                        fetchView.MosavabCurrent = long.Parse(dataReader["MosavabCurrent"].ToString());
                        fetchView.MosavabCurrentStr = Common.StringExtensions.En2Fa(dataReader["MosavabCurrent"].ToString());
                        fetchView.MosavabCivil = long.Parse(dataReader["MosavabCivil"].ToString());
                        fetchView.MosavabCivilStr = Common.StringExtensions.En2Fa(dataReader["MosavabCivil"].ToString());
                        fetchView.ExpenseCurrent = long.Parse(dataReader["ExpenseCurrent"].ToString());
                        fetchView.ExpenseCurrentStr = Common.StringExtensions.En2Fa(dataReader["ExpenseCurrent"].ToString());
                        fetchView.ExpenseCivil = long.Parse(dataReader["ExpenseCivil"].ToString());
                        fetchView.ExpenseCivilStr = Common.StringExtensions.En2Fa(dataReader["ExpenseCivil"].ToString());
                        fetchView.YearId = int.Parse(dataReader["YearId"].ToString());
                        fetchView.ProctorId = int.Parse(dataReader["ProctorId"].ToString());
                        fetchView.AreaId = int.Parse(dataReader["AreaId"].ToString());
                        //fetchView.proctorAreaBudgets = budgetViewModels(int.Parse(dataReader["YearId"].ToString()),int.Parse(dataReader["ProctorId"].ToString()), int.Parse(dataReader["AreaId"].ToString()),2).ToList();

                        if (fetchView.MosavabCurrent != 0)
                        {
                            fetchView.PercentCurrent = Divivasion(fetchView.ExpenseCurrent, fetchView.MosavabCurrent);
                        }
                        else
                        {
                            fetchView.MosavabCurrent = 0;
                        }


                        if (fetchView.MosavabCivil != 0)
                        {
                            fetchView.PercentCivil = Divivasion(fetchView.ExpenseCivil, fetchView.MosavabCivil);
                        }
                        else
                        { fetchView.PercentCivil = 0; }


                        if (fetchView.MosavabCurrent + fetchView.MosavabCivil != 0)
                        {
                            fetchView.PercentTotal = Divivasion(fetchView.ExpenseCivil + fetchView.ExpenseCurrent, fetchView.MosavabCivil + fetchView.MosavabCurrent);
                        }
                        else
                        { fetchView.PercentTotal = 0; }

                        fecthViewModel.Add(fetchView);

                        //dataReader.NextResult();
                    }
                    //TempData["budgetSeprator"] = fecthViewModel;
                }
            }
            return fecthViewModel;
        }

        public List<ProctorAreaBudgetViewModel> budgetViewModels(int yearId, int proctorId, int areaId, int budgetProcessId)
        {
            List<ProctorAreaBudgetViewModel> fecthViewModel = new List<ProctorAreaBudgetViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP501_Proctor", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", yearId);
                    sqlCommand.Parameters.AddWithValue("ProctorId", proctorId);
                    sqlCommand.Parameters.AddWithValue("AreaId", areaId);
                    sqlCommand.Parameters.AddWithValue("BudgetProcessId", budgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = sqlCommand.ExecuteReader();
                    while (dataReader.Read())
                    {
                        ProctorAreaBudgetViewModel fetchView = new ProctorAreaBudgetViewModel();
                        fetchView.AreaId = int.Parse(dataReader["AreaId"].ToString());
                        fetchView.ProctorId = int.Parse(dataReader["ProctorId"].ToString());
                        fetchView.YearId = int.Parse(dataReader["YearId"].ToString());
                        fetchView.Code = dataReader["Code"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.Mosavab = long.Parse(dataReader["Mosavab"].ToString());
                        fetchView.Expense = long.Parse(dataReader["Expense"].ToString());

                        if (fetchView.Percent != 0)
                        {
                            fetchView.Percent = Divivasion(fetchView.Expense, fetchView.Mosavab);
                        }
                        else
                        {
                            fetchView.Percent = 0;
                        }

                        fecthViewModel.Add(fetchView);

                        //dataReader.NextResult();
                    }
                    //TempData["budgetSeprator"] = fecthViewModel;
                }
                return fecthViewModel;
            }
        }

        public async Task<List<BudgetSepratorViewModel>> GetAllBudgetSeprtaorAsync(int yearId, int areaId, int budgetProcessId)
        {
            List<BudgetSepratorViewModel> fecth = new List<BudgetSepratorViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_ShowBudgetSepratorArea", sqlconnect))
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
