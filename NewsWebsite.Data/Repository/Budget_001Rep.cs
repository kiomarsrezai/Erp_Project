using NewsWebsite.Data.Models;
using NewsWebsite.ViewModels.Fetch;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace NewsWebSite.Data.Repository
{
    public class Budget_001Rep : IBudget_001Rep
    {
        ProgramBuddbContext _context = new ProgramBuddbContext();
        public Budget_001Rep(ProgramBuddbContext context)
        {
            _context = context;
        }

        //private readonly ProgramBudDbContext context;
        public List<AreaViewModelSepertator> AreaFetchForPropozalBudget()
        {
            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;Trusted_Connection=True;Integrated Security=True;";
            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            List<AreaViewModelSepertator> areaViews = new List<AreaViewModelSepertator>();

            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP000_Area_ProposalBudget", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = sqlCommand.ExecuteReader();
                    while (dataReader.Read())
                    {
                        AreaViewModelSepertator fetchView = new AreaViewModelSepertator();
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.AreaName = dataReader["AreaName"].ToString();
                        areaViews.Add(fetchView);

                        //dataReader.NextResult();
                    }
                }
            }
            return areaViews;
        }

        public List<AreaViewModelSepertator> AreaFetch(int areaform)
        {
            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;Trusted_Connection=True;Integrated Security=True;";
            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            List<AreaViewModelSepertator> areaViews = new List<AreaViewModelSepertator>();

            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP000_Area", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("areaForm", areaform);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = sqlCommand.ExecuteReader();
                    while (dataReader.Read())
                    {
                        AreaViewModelSepertator fetchView = new AreaViewModelSepertator();
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.AreaName = dataReader["AreaName"].ToString();
                        areaViews.Add(fetchView);

                        //dataReader.NextResult();
                    }
                }
            }
            return areaViews;
        }

        public List<ProctorViewModel> ProctorList()
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
                    SqlDataReader dataReader = sqlCommand.ExecuteReader();
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
            summry = Math.Round((double)((expense / mosavab) * 100));
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
                        fetchView.MosavabCurrent = Int64.Parse(dataReader["MosavabCurrent"].ToString());
                        fetchView.MosavabCurrentStr = NewsWebsite.Common.StringExtensions.En2Fa(NewsWebsite.Common.StringExtensions.ToNumeric(Int64.Parse(dataReader["MosavabCurrent"].ToString())));
                        fetchView.MosavabCivil = Int64.Parse(dataReader["MosavabCivil"].ToString());
                        fetchView.MosavabCivilStr = NewsWebsite.Common.StringExtensions.En2Fa(NewsWebsite.Common.StringExtensions.ToNumeric(Int64.Parse(dataReader["MosavabCivil"].ToString())));
                        fetchView.ExpenseCurrent = Int64.Parse(dataReader["ExpenseCurrent"].ToString());
                        fetchView.ExpenseCurrentStr = NewsWebsite.Common.StringExtensions.En2Fa(NewsWebsite.Common.StringExtensions.ToNumeric(Int64.Parse(dataReader["ExpenseCurrent"].ToString())));
                        fetchView.ExpenseCivil = Int64.Parse(dataReader["ExpenseCivil"].ToString());
                        fetchView.ExpenseCivilStr = NewsWebsite.Common.StringExtensions.En2Fa(NewsWebsite.Common.StringExtensions.ToNumeric(Int64.Parse(dataReader["ExpenseCivil"].ToString())));
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.Row = int.Parse(dataReader["Id"].ToString());

                        if (fetchView.MosavabCurrent != 0)
                        {
                            fetchView.PercentCurrent = Divivasion(fetchView.ExpenseCurrent, fetchView.MosavabCurrent);
                            fetchView.PercentCurrentStr = NewsWebsite.Common.StringExtensions.En2Fa(Divivasion(fetchView.ExpenseCurrent, fetchView.MosavabCurrent).ToString())+"%";
                        }
                        else
                        {
                            fetchView.MosavabCurrent = 0;
                        }


                        if (fetchView.MosavabCivil != 0)
                        {
                            fetchView.PercentCivil = Divivasion(fetchView.ExpenseCivil, fetchView.MosavabCivil);
                            fetchView.PercentCivilStr = NewsWebsite.Common.StringExtensions.En2Fa(Divivasion(fetchView.ExpenseCivil, fetchView.MosavabCivil).ToString())+"%";
                        }
                        else
                        { fetchView.PercentCivil = 0; }


                        if ((fetchView.MosavabCurrent + fetchView.MosavabCivil) != 0)
                        {
                            fetchView.PercentTotal = Divivasion(fetchView.ExpenseCivil + fetchView.ExpenseCurrent, fetchView.MosavabCivil + fetchView.MosavabCurrent);
                            fetchView.PercentTotalStr = NewsWebsite.Common.StringExtensions.En2Fa(Divivasion(fetchView.ExpenseCivil + fetchView.ExpenseCurrent, fetchView.MosavabCivil + fetchView.MosavabCurrent).ToString())+"%";
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
                        fetchView.MosavabCurrent = Int64.Parse(dataReader["MosavabCurrent"].ToString());
                        fetchView.MosavabCurrentStr = NewsWebsite.Common.StringExtensions.En2Fa(dataReader["MosavabCurrent"].ToString());
                        fetchView.MosavabCivil = Int64.Parse(dataReader["MosavabCivil"].ToString());
                        fetchView.MosavabCivilStr = NewsWebsite.Common.StringExtensions.En2Fa(dataReader["MosavabCivil"].ToString());
                        fetchView.ExpenseCurrent = Int64.Parse(dataReader["ExpenseCurrent"].ToString());
                        fetchView.ExpenseCurrentStr = NewsWebsite.Common.StringExtensions.En2Fa(dataReader["ExpenseCurrent"].ToString());
                        fetchView.ExpenseCivil = Int64.Parse(dataReader["ExpenseCivil"].ToString());
                        fetchView.ExpenseCivilStr = NewsWebsite.Common.StringExtensions.En2Fa(dataReader["ExpenseCivil"].ToString());
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


                        if ((fetchView.MosavabCurrent + fetchView.MosavabCivil) != 0)
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

        public List<ProctorAreaBudgetViewModel> budgetViewModels(int yearId,int proctorId,int areaId,int budgetProcessId)
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
                        fetchView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        fetchView.Expense = Int64.Parse(dataReader["Expense"].ToString());

                        if (fetchView.Percent != 0)
                        {
                            fetchView.Percent =Divivasion(fetchView.Expense, fetchView.Mosavab);
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
    }

}
