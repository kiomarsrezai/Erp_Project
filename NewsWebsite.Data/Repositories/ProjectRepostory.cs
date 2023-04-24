using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using NewsWebsite.Common.Api;
using NewsWebsite.Data.Contracts;
using NewsWebsite.Data.Models;
using NewsWebsite.ViewModels.Project;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Threading.Tasks;

namespace NewsWebsite.Data.Repositories
{
    public class ProjectRepostory : IProjectRepository
    {
        private readonly ProgramBuddbContext _budgetcontext;
        public ProjectRepostory(ProgramBuddbContext context)
        {
            context=_budgetcontext;
        }

        public async Task<ProjectViewModel> FindProjectAsync(int id)
        {
            ProjectViewModel fetchView = new ProjectViewModel();

            string connection = @"Data Source=amcsosrv63\ProBudDb;User Id=sa;Password=Ki@1972424701;Initial Catalog=ProgramBudDb;";
            //string connection = @"Data Source=.;Initial Catalog=ProgramBudDB;User Id=sa;Password=Az12345;Initial Catalog=ProgramBudDb;";
            using (SqlConnection sqlconnect = new SqlConnection(connection))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP005_Project_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("id", id);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.ProjectCode = dataReader["ProjectCode"].ToString();
                        fetchView.ProjectName = dataReader["ProjectName"].ToString();
                        fetchView.AreaId = int.Parse(dataReader["AreaId"].ToString());
                        fetchView.MotherId= int.Parse(dataReader["MotherId"].ToString());
                    }
                }
                sqlconnect.Close();
            }
            return fetchView;
        }

    }
}
