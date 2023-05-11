using NewsWebsite.Common.Api;
using NewsWebsite.Entities.identity;
using NewsWebsite.ViewModels.Api.GeneralVm;
using NewsWebsite.ViewModels.Api.UsersApi;
using NewsWebsite.ViewModels.Fetch;
using NewsWebsite.ViewModels.UserManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace NewsWebsite.Data.Contracts
{
    public interface IBudget_001Rep
    {
        List<AreaViewModel> AreaFetchForPropozalBudget();
        Task<List<AreaViewModel>> AreaFetchAsync(int areaform);
        Task<UserSignViewModel> GetUserByTocken(string tocken);
        Task<string> AreaNameByIdAsync(int id);
        Task<bool> SaveLisenceAsync(int userId, string lisence);
        Task<List<BudgetProcessViewModel>> BudgetProcessFetchAsync();
        Task<List<YearViewModel>> YearFetchAsync(int kindid);
        Task<List<ProctorViewModel>> ProctorList();
        double Divivasion(long? expense, long? mosavab);
        List<DeputyViewModel> GetAllDeputies();
        Task<List<BudgetSepratorViewModel>> GetAllBudgetSeprtaorAsync(int yearId, int areaId, int budgetProcessId);
        List<DeputyViewModel> GetAllDeputiesAsync(int offset, int limit, string Orderby, string searchText);
        List<AreaProctorViewModel> ProctorArea(int Id);
        List<ProctorAreaBudgetViewModel> budgetViewModels(int yearId, int proctorId, int areaId, int budgetProcessId);
    }
}
