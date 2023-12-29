using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using NewsWebsite.Common.Api;
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

        public async Task<List<CodeAccUpdateViewModel>> ModalDetailsAsync(int id, string code, string description, int yearId, int areaId)
        {
            List<CodeAccUpdateViewModel> fecthViewModel = new List<CodeAccUpdateViewModel>();

            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;User Id=sa;Password=Az12345;Initial Catalog=ProgramBudDb;";
            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP9000_Mapping_Modal_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("yearId", yearId);
                    sqlCommand.Parameters.AddWithValue("areaId", areaId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader =await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        CodeAccUpdateViewModel codeAcc = new CodeAccUpdateViewModel();
                        codeAcc.Id = id;
                        codeAcc.IdKol = dataReader["IdKol"].ToString();
                        codeAcc.IdMoein = dataReader["IdMoien"].ToString();
                        codeAcc.IdTafsily = dataReader["IdTafsily"].ToString() == null ? "" : dataReader["IdTafsily"].ToString();
                        codeAcc.Name = dataReader["Name"].ToString();
                        codeAcc.IdTafsily5 = dataReader["IdTafsily5"].ToString() == null ? "" : dataReader["IdTafsily5"].ToString();
                        codeAcc.Expense = Int64.Parse(dataReader["Expense"].ToString());
                        codeAcc.MarkazHazine = dataReader["MarkazHazine"].ToString();
                        codeAcc.IdTafsily6 = dataReader["IdTafsily6"].ToString();
                        codeAcc.Tafsily6Name = dataReader["Tafsily6Name"].ToString();
                        codeAcc.AreaId = areaId;
                        fecthViewModel.Add(codeAcc);
                    }

                }
                sqlconnect.Close();
            }

            return fecthViewModel;
        }

      
    }
}
