using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Data.Contracts;
using NewsWebsite.Data.Models;
using NewsWebsite.Entities.identity;
using NewsWebsite.ViewModels.Api.UsersApi;
using NewsWebsite.ViewModels.Fetch;
using NewsWebsite.ViewModels.GeneralVm;
using NewsWebsite.ViewModels.UserManager;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using static System.Collections.Specialized.BitVector32;

namespace NewsWebsite.Data.Repositories
{
    public class Budget_001Rep : IBudget_001Rep
    {
        ProgramBuddbContext _context = new ProgramBuddbContext();
        public readonly IUnitOfWork _uw;

        public Budget_001Rep(ProgramBuddbContext context)
        {
            _context = context;
        }

        //private readonly ProgramBudDbContext context;
        public List<AreaViewModel> AreaFetchForPropozalBudget()
        {
            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;Trusted_Connection=True;Integrated Security=True;";
            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            List<AreaViewModel> areaViews = new List<AreaViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(connection))
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

        public async Task<List<YearViewModel>> YearFetchAsync()
        {
            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;Trusted_Connection=True;Integrated Security=True;";
            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            List<YearViewModel> yearViews = new List<YearViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP000_Year", sqlconnect))
                {
                    sqlconnect.Open();
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
            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;Trusted_Connection=True;Integrated Security=True;";
            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            List<BudgetProcessViewModel> yearViews = new List<BudgetProcessViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(connection))
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
            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            string name = "";
            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP000_AreaNameById", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("id", id);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    name= dataReader["AreaName"].ToString();
                }
            }
            return name;
        }
        
        public async Task<UserSignViewModel> GetUserByTocken(string tocken)
        {
            string connection = @"Data Source=172.30.30.26;User Id=sa;Password=@Tender124;Initial Catalog=ErpSettingDb;";
            UserSignViewModel user = new UserSignViewModel();
            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP000_GetUserInfoByTocken", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("areaForm", tocken);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (await dataReader.ReadAsync())
                    {
                        user.FirstName = dataReader["FirstName"].ToString();
                        user.LastName = dataReader["LastName"].ToString();
                        user.SectionId = StringExtensions.ToNullableInt(dataReader["SectionId"].ToString());
                        user.SectionName = await AreaNameByIdAsync(int.Parse(dataReader["SectionId"].ToString()));
                        user.token = dataReader["token"].ToString();
                        user.UserName = dataReader["UserName"].ToString();
                    }
                }
            }
            return user;
        }
        public async Task<List<AreaViewModel>> AreaFetchAsync(int areaform)
        {
            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;Trusted_Connection=True;Integrated Security=True;";
            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            List<AreaViewModel> areaViews = new List<AreaViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP000_Area", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("areaForm", areaform);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader =await sqlCommand.ExecuteReaderAsync();
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
            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;Trusted_Connection=True;Integrated Security=True;";
            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            List<ProctorViewModel> areaViews = new List<ProctorViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP501_ProctorList_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader =await sqlCommand.ExecuteReaderAsync();
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

            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;User Id=sa;Password=Az12345;Initial Catalog=ProgramBudDb;";
            using (SqlConnection sqlconnect = new SqlConnection(connection))
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

            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;User Id=sa;Password=Az12345;Initial Catalog=ProgramBudDb;";
            using (SqlConnection sqlconnect = new SqlConnection(connection))
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

            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;User Id=sa;Password=Az12345;Initial Catalog=ProgramBudDb;";
            using (SqlConnection sqlconnect = new SqlConnection(connection))
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

            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;User Id=sa;Password=Az12345;Initial Catalog=ProgramBudDb;";
            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_ShowBudgetSepratorArea", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId",yearId);
                    sqlCommand.Parameters.AddWithValue("areaId",areaId);
                    sqlCommand.Parameters.AddWithValue("budgetProcessId",budgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader =await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetSepratorViewModel fetchView = new BudgetSepratorViewModel();
                        fetchView.Code = dataReader["Code"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.CodingId = int.Parse(dataReader["CodingId"].ToString());
                        //fetchView.CodeVaset = dataReader["CodeVaset"].ToString();
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

        public async Task<bool> SaveLisenceAsync(int userId,string lisence)
        {
            if (userId == 0)
                return false;

            var user = await _uw._Context.Users.FirstOrDefaultAsync(a => a.Id == userId);
            user.Lisence = lisence;
            return true;
        }

    }

}
