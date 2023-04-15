using Microsoft.AspNetCore.Mvc;
using NewsWebsite.Data.Contracts;
using NewsWebsite.Data.Models;
using NewsWebsite.ViewModels.Fetch;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Threading.Tasks;

namespace NewsWebsite.Data.Repositories
{
    public class VasetRepostory : IVasetRepository
    {
        private readonly ProgramBuddbContext _budgetcontext;
        public VasetRepostory(ProgramBuddbContext context)
        {
            context=_budgetcontext;
        }

        public async Task<List<VasetSazmanhaViewModel>> GetAllAsync(int yearId, int areaId, int budgetProcessId)
        {
            List<VasetSazmanhaViewModel> fecthViewModel = new List<VasetSazmanhaViewModel>();

            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;User Id=sa;Password=Az12345;Initial Catalog=ProgramBudDb;";
            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP9000_Mapping_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand.Parameters.AddWithValue("budgetProcessId", budgetProcessId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        VasetSazmanhaViewModel fetchView = new VasetSazmanhaViewModel();
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.Code = dataReader["Code"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                        fetchView.CodeAcc = dataReader["CodeAcc"].ToString();
                        fetchView.TitleAcc = dataReader["TitleAcc"].ToString();
                        fetchView.PercentBud = int.Parse(dataReader["PercentBud"].ToString());

                        fecthViewModel.Add(fetchView);
                        //dataReader.NextResult();
                    }
                    //TempData["budgetSeprator"] = fecthViewModel;
                }
                sqlconnect.Close();
            }
            return fecthViewModel;
        }

        public async Task<List<SepratorAreaRequestViewModel>> ModalDetailsAsync(int yearId, int areaId, int budgetProcessId, int codingId)
        {
            List<SepratorAreaRequestViewModel> fecthViewModel = new List<SepratorAreaRequestViewModel>();


            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;User Id=sa;Password=Az12345;Initial Catalog=ProgramBudDb;";
            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP001_ShowBudgetSepratorArea_RequestModal", sqlconnect))
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
                        fetchView.Number = dataReader["Number"].ToString();
                        fetchView.Description = dataReader["Description"].ToString();
                        fetchView.Date = dataReader["Date"].ToString();
                        fetchView.EstimateAmount = Int64.Parse(dataReader["EstimateAmount"].ToString());

                        fecthViewModel.Add(fetchView);
                    }

                }
                sqlconnect.Close();
            }

            return fecthViewModel;
        }

        public async Task<bool> InsertCodeAccPostAsync(int id)
        {
            if (id == 0)
                return false;
            else
            {
                string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";

                using (SqlConnection sqlconnect = new SqlConnection(connection))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP9000_Mapping_Insert", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("id", id);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        sqlconnect.Close();
                    }
                }
                return true;
            }

        }
        public async Task<bool> DeleteCodeAccPostAsync(int id)
        {
            if (id == 0)
                return false;
            else
            {
                string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";

                using (SqlConnection sqlconnect = new SqlConnection(connection))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP9000_Mapping_Delete", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("id", id);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        sqlconnect.Close();
                    }
                }
                return true;
            }

        }

    }
}
