using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.Data.Contracts;
using NewsWebsite.Data.Models;
using NewsWebsite.ViewModels.Api.Deputy;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Threading.Tasks;

namespace NewsWebsite.Data.Repositories
{
    public class DeputyRepository : IDeputyRepository
    {
        private readonly IUnitOfWork _uw;
        private readonly IConfiguration _config;
        public DeputyRepository(IUnitOfWork uw,IConfiguration configuration)
        {
            _config = configuration;
            this._uw = uw;
            _uw.CheckArgumentIsNull(nameof(_uw));

        }

        public async Task<List<DeputyViewModel>> GetAllDeputiesAsync(int yearId,int proctorId, int areaId, int budgetProcessId)
        {
            List<DeputyViewModel> fecthViewModel = new List<DeputyViewModel>();
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
                    SqlDataReader dataReader =await sqlCommand.ExecuteReaderAsync();
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
                            fetchView.PercentCurrent = _uw.Budget_001Rep.Divivasion(fetchView.ExpenseCurrent, fetchView.MosavabCurrent);
                            fetchView.PercentCurrentStr = Common.StringExtensions.En2Fa(_uw.Budget_001Rep.Divivasion(fetchView.ExpenseCurrent, fetchView.MosavabCurrent).ToString()) + "%";
                        }
                        else
                        {
                            fetchView.MosavabCurrent = 0;
                        }


                        if (fetchView.MosavabCivil != 0)
                        {
                            fetchView.PercentCivil = _uw.Budget_001Rep.Divivasion(fetchView.ExpenseCivil, fetchView.MosavabCivil);
                            fetchView.PercentCivilStr = Common.StringExtensions.En2Fa(_uw.Budget_001Rep.Divivasion(fetchView.ExpenseCivil, fetchView.MosavabCivil).ToString()) + "%";
                        }
                        else
                        { fetchView.PercentCivil = 0; }


                        if (fetchView.MosavabCurrent + fetchView.MosavabCivil != 0)
                        {
                            fetchView.PercentTotal = _uw.Budget_001Rep.Divivasion(fetchView.ExpenseCivil + fetchView.ExpenseCurrent, fetchView.MosavabCivil + fetchView.MosavabCurrent);
                            fetchView.PercentTotalStr = Common.StringExtensions.En2Fa(_uw.Budget_001Rep.Divivasion(fetchView.ExpenseCivil + fetchView.ExpenseCurrent, fetchView.MosavabCivil + fetchView.MosavabCurrent).ToString()) + "%";
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


        public async Task<List<AreaProctorViewModel>> GetProctorAreaAsync(int id)
        {
            List<AreaProctorViewModel> fecthViewModel = new List<AreaProctorViewModel>();

            fecthViewModel =await _uw.DeputyRepository.ProctorAreaAsync(id);

            return fecthViewModel;
        }

        public async Task<List<AreaProctorViewModel>> ProctorAreaAsync(int Id)
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
                    SqlDataReader dataReader =await sqlCommand.ExecuteReaderAsync();
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
                            fetchView.PercentCurrent = _uw.Budget_001Rep.Divivasion(fetchView.ExpenseCurrent, fetchView.MosavabCurrent);
                        }
                        else
                        {
                            fetchView.MosavabCurrent = 0;
                        }


                        if (fetchView.MosavabCivil != 0)
                        {
                            fetchView.PercentCivil = _uw.Budget_001Rep.Divivasion(fetchView.ExpenseCivil, fetchView.MosavabCivil);
                        }
                        else
                        { fetchView.PercentCivil = 0; }


                        if (fetchView.MosavabCurrent + fetchView.MosavabCivil != 0)
                        {
                            fetchView.PercentTotal = _uw.Budget_001Rep.Divivasion(fetchView.ExpenseCivil + fetchView.ExpenseCurrent, fetchView.MosavabCivil + fetchView.MosavabCurrent);
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
    
        public async Task<List<ProctorViewModel>> ProctorListAsync()
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

    }
}
