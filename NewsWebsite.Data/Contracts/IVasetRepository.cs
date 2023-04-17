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
        Task<List<CodeAccUpdateViewModel>> ModalDetailsAsync(int id, string code, string description, int yearId, int areaId);
    }
}
