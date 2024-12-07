
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Budget.BudgetArea;
using System.Collections.Generic;
using System.Threading.Tasks;
using NewsWebsite.Data;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Data.Models;

namespace NewsWebsite.Areas.Api.Controllers.v1
{

    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class BudgetAreaShareApiController : Controller
    {
        public readonly IUnitOfWork _uw;
        private readonly IConfiguration _config;
        protected readonly ProgramBuddbContext _db;
        public BudgetAreaShareApiController(IUnitOfWork uw, IConfiguration configuration,ProgramBuddbContext db)
        {
            _config = configuration;
            _uw = uw;
            _db=db;

        }

        [Route("BudgetAreaShareRead")]
        [HttpGet]
        public async Task<ApiResult<List<TblBudgetAreaShare>>> BudgetProposalRead(int yearId,string type){

            var items = await _db.TblBudgetAreaShares
                .Include(a=>a.Area)
                .Where(c => c.YearId == yearId) .Where(c => c.Type == type).ToListAsync();
            return Ok(items);
        }

        [Route("BudgetAreaShareSingle")]
        [HttpGet]
        public async Task<ApiResult<object>> BudgetProposalRead(int yearId,int areaId,int budgetProcessId ){

            var items = await _db.TblBudgetAreaShares
                .Include(a => a.Area)
                .Where(bas => bas.YearId == yearId)
                .Join(_db.TblAreas,
                    bas => bas.AreaId,
                    a => a.Id,
                    (bas, a) => new { BudgetAreaShare = bas, Area = a })
                .Where(c => 
                    (c.Area.Id == areaId && new[] { 1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29,30,31,32,33,34,35,36,42,43,44,53 }.Contains(areaId)) ||
                    (areaId == 10 && c.Area.StructureId == 1) ||
                    (areaId == 37) ||
                    (areaId == 39 && c.Area.StructureId == 2) ||
                    (areaId == 40 && c.Area.ToGetherBudget == 10) ||
                    (areaId == 41 && c.Area.ToGetherBudget == 84)
                )
                .Select(c => new TblBudgetAreaShare
                {
                    Id = c.BudgetAreaShare.Id,
                    YearId = c.BudgetAreaShare.YearId,
                    AreaId = c.BudgetAreaShare.AreaId,
                    Type = c.BudgetAreaShare.Type ?? string.Empty,
                    ShareProcessId1 = c.BudgetAreaShare.ShareProcessId1??0,
                    ShareProcessId2 = c.BudgetAreaShare.ShareProcessId2??0,
                    ShareProcessId3 = c.BudgetAreaShare.ShareProcessId3??0,
                    ShareProcessId4 = c.BudgetAreaShare.ShareProcessId4??0
                })
                .ToListAsync();

            var edit = 0L;
            var pishnahadi = 0L;

            foreach (var item in items){
                switch (budgetProcessId){
                    case 1:{
                        if (item.Type == "edit")
                            edit += item.ShareProcessId1??0;
                        if (item.Type == "pishnahadi")
                            pishnahadi += item.ShareProcessId1??0;
                        break;
                    }
                    case 2:{
                        if (item.Type == "edit")
                            edit += item.ShareProcessId2??0;
                        if (item.Type == "pishnahadi")
                            pishnahadi += item.ShareProcessId2??0;
                        break;
                    }
                    case 3:{
                        if (item.Type == "edit")
                            edit += item.ShareProcessId3??0;
                        if (item.Type == "pishnahadi")
                            pishnahadi += item.ShareProcessId3??0;
                        break;
                    }
                    case 4:{
                        if (item.Type == "edit")
                            edit += item.ShareProcessId4??0;
                        if (item.Type == "pishnahadi")
                            pishnahadi += item.ShareProcessId4??0;
                        break;
                    }
                }
            }
           
            return Ok(new{edit,pishnahadi});
        }

      
        [Route("BudgetAreaShareInsertNewYear")]
        [HttpGet]
        public async Task<ApiResult<string>> BudgetProposalInsertNewYear(int yearId){
            var types = new string[]{ "pishnahadi", "edit" };
            var areas = await _db.TblAreas.ToListAsync();

            foreach (var type in types){
                foreach (var area in areas){
                    var share = new TblBudgetAreaShare();
                    share.YearId = yearId;
                    share.AreaId = area.Id;
                    share.Type = type;
                    share.ShareProcessId1 = 0;
                    share.ShareProcessId2 = 0;
                    share.ShareProcessId3 = 0;
                    share.ShareProcessId4 = 0;

                    await _db.AddAsync(share);
                    await _db.SaveChangesAsync();
                } 
            } 
            
            return Ok("انجام شد");
        }

      
        [Route("BudgetAreaShareUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> BudgetProposalModalUpdate([FromBody] BudgetAreaShareUpdateViewModel param){

            var item =await  _db.TblBudgetAreaShares.FindAsync(param.Id);

            item.ShareProcessId1 = param.ShareProcessId1;
            item.ShareProcessId2 = param.ShareProcessId2;
            item.ShareProcessId3 = param.ShareProcessId3;
            item.ShareProcessId4 = param.ShareProcessId4;

            await _db.SaveChangesAsync();
            
            return Ok("انجام شد");
        }


    }
}
