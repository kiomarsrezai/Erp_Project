using Dapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common.Api;
using NewsWebsite.Data.Contracts;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

namespace NewsWebsite.Data.Repositories
{
    public class SqlDataAccess : ISqlDataAccess
    {
        private readonly IConfiguration _config;

        public SqlDataAccess(IConfiguration configuration)
        {
            _config = configuration;
        }


        public async Task<IEnumerable<T>> LoadData<T, U>(string storedProcedure, U parameters, string connectionId = "SqlErp")
        {
            using IDbConnection connection = new SqlConnection(_config.GetConnectionString(connectionId));

            return await connection.QueryAsync<T>(storedProcedure, parameters, commandType: CommandType.StoredProcedure);

        }

        public async Task SaveData<T>(string storedProcedure, T parameter, string connectionId = "SqlErp")
        {
            using IDbConnection connection = new SqlConnection(_config.GetConnectionString(connectionId));

            await connection.ExecuteAsync(storedProcedure, parameter, commandType: CommandType.StoredProcedure);
        }
    }
}
