using NewsWebsite.ViewModels.Fetch;
using NewsWebsite.ViewModels.GeneralVm;
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
        Task<List<YearViewModel>> YearFetchAsync();
        Task<List<ProctorViewModel>> ProctorList();
        double Divivasion(double expense, double mosavab);
        List<DeputyViewModel> GetAllDeputies();
        Task<List<BudgetSepratorViewModel>> GetAllBudgetSeprtaorAsync(int yearId, int areaId, int budgetProcessId);
        List<DeputyViewModel> GetAllDeputiesAsync(int offset, int limit, string Orderby, string searchText);
        List<AreaProctorViewModel> ProctorArea(int Id);
        List<ProctorAreaBudgetViewModel> budgetViewModels(int yearId, int proctorId, int areaId, int budgetProcessId);
    }
}
