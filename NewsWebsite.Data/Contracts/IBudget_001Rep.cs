using NewsWebsite.ViewModels.Api.Budget.BudgetSeprator;
using NewsWebsite.ViewModels.Api.Deputy;
using NewsWebsite.ViewModels.Api.GeneralVm;
using NewsWebsite.ViewModels.Api.Report;
using NewsWebsite.ViewModels.Api.UsersApi;
using System.Collections.Generic;
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
        double Divivasion(double? expense, double? mosavab);
        Task<List<BudgetSepratorViewModel>> GetAllBudgetSeprtaorAsync(int yearId, int areaId, int budgetProcessId);
        //List<DeputyViewModel> GetAllDeputiesAsync(int offset, int limit, string Orderby, string searchText);
    }
}
