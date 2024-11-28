
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
                .Include(a=>a.Area)
                .Where(c => c.YearId == yearId).Where(c=>c.AreaId==areaId).ToListAsync();

            var edit = 0L;
            var pishnahadi = 0L;

            foreach (var item in items){
                switch (budgetProcessId){
                    case 1:{
                        if (item.Type == "edit")
                            edit = item.ShareProcessId1;
                        if (item.Type == "pishnahadi")
                            pishnahadi = item.ShareProcessId1;
                        break;
                    }
                    case 2:{
                        if (item.Type == "edit")
                            edit = item.ShareProcessId2;
                        if (item.Type == "pishnahadi")
                            pishnahadi = item.ShareProcessId2;
                        break;
                    }
                    case 3:{
                        if (item.Type == "edit")
                            edit = item.ShareProcessId3;
                        if (item.Type == "pishnahadi")
                            pishnahadi = item.ShareProcessId3;
                        break;
                    }
                    case 4:{
                        if (item.Type == "edit")
                            edit = item.ShareProcessId4;
                        if (item.Type == "pishnahadi")
                            pishnahadi = item.ShareProcessId4;
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
