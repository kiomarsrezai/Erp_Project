using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.Data.Models;
using System.Threading.Tasks;

namespace NewsWebsite.Areas.Api.Controllers.v1
{
   
    
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class GeneralApiController : ControllerBase
    {
        ProgramBuddbContext _context = new ProgramBuddbContext();
        public readonly IUnitOfWork _uw;

        public GeneralApiController(ProgramBuddbContext context, IUnitOfWork uw)
        {
            _context = context;
            _uw = uw;
        }

        [Route("AreaFetch")]
        [HttpGet]
        public async Task<IActionResult> AreaFetch(int areaform)
        {
            return Ok(await _uw.Budget_001Rep.AreaFetchAsync(areaform));
        }

        [Route("YearFetch")]
        [HttpGet]
        public async Task<IActionResult> YearFetch()
        {
            return Ok(await _uw.Budget_001Rep.YearFetchAsync());
        }

        [Route("BudgetProcessFetch")]
        [HttpGet]
        public async Task<IActionResult> BudgetProcess()
        {
            return Ok(await _uw.Budget_001Rep.BudgetProcessFetchAsync());
        }

    }
}
