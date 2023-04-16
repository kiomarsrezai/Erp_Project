using NewsWebsite.ViewModels.Api.Deputy;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace NewsWebsite.Data.Contracts
{
    public interface IDeputyRepository
    {
        Task<List<DeputyViewModel>> GetAllDeputiesAsync(int yearId, int areaId, int budgetProcessId);
        Task<List<AreaProctorViewModel>> GetProctorAreaAsync(int id);
        
        //مودال اول
        Task<List<AreaProctorViewModel>> ProctorAreaAsync(int Id);
        Task<List<ProctorViewModel>> ProctorListAsync();


    }
}
