using NewsWebsite.ViewModels.Fetch;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace NewsWebSite.Data.Repository
{
    public interface IBudget_001Rep
    {
        List<AreaViewModelSepertator> AreaFetchForPropozalBudget();
        List<AreaViewModelSepertator> AreaFetch(int areaform);
        List<ProctorViewModel> ProctorList();
        double Divivasion(double expense, double mosavab);
        List<DeputyViewModel> GetAllDeputies();
        List<DeputyViewModel> GetAllDeputiesAsync(int offset, int limit, string Orderby, string searchText);
        List<AreaProctorViewModel> ProctorArea(int Id);
        List<ProctorAreaBudgetViewModel> budgetViewModels(int yearId, int proctorId, int areaId, int budgetProcessId);
    }
}
