using NewsWebsite.Common.Api;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace NewsWebsite.Data.Contracts
{
    public interface ISqlDataAccess
    {
        Task<IEnumerable<T>> LoadData<T, U>(string storedProcedure, U parameters, string connectionId = "SqlErp");
        Task<T> LoadDataById<T, U>(string storedProcedure, U parameters, string connectionId = "SqlErp");
        Task SaveData<T>(string storedProcedure, T parameter, string connectionId = "SqlErp");
    }
}