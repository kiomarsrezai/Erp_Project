using NewsWebsite.ViewModels.Fetch;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace NewsWebsite.Data.Contracts
{
    public interface IVasetRepository
    {
        Task<List<VasetSazmanhaViewModel>> GetAllAsync(int yearId, int areaId, int budgetProcessId);
        Task<List<SepratorAreaRequestViewModel>> ModalDetailsAsync(int yearId, int areaId, int budgetProcessId, int codingId);
        Task<bool> InsertCodeAccPostAsync(int id);
        Task<bool> DeleteCodeAccPostAsync(int id);
    }
}
