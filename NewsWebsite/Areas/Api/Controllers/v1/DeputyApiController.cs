using Microsoft.AspNetCore.Mvc;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Deputy;
using System.Collections.Generic;
using System.Data;
using System;
using System.Threading.Tasks;
using NewsWebsite.Common.Api;
using NewsWebsite.ViewModels.Fetch;
using System.Data.SqlClient;

namespace NewsWebsite.Areas.Api.Controllers.v1
{

    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class DeputyApiController : Controller
    {
        public readonly IUnitOfWork _uw;
        public DeputyApiController(IUnitOfWork uw)
        {
            _uw = uw;
        }

        [Route("GetAllDeputy")]
        [HttpGet]
        public async Task<IActionResult> FetchDeputys(int yearId,int proctorId,int areaId,int budgetprocessId)
        {
            return Ok(await _uw.DeputyRepository.GetAllDeputiesAsync(yearId,proctorId, areaId, budgetprocessId));
        }

        [Route("ProctorAreaBudget")]
        [HttpGet]
        public async Task<IActionResult> ProctorAreaBudget(int id)
        {
            return Ok(await _uw.DeputyRepository.ProctorAreaAsync(id));
        }

        [Route("ProctorList")]
        [HttpGet]
        public async Task<IActionResult> ProctorList()
        {
            return Ok(await _uw.DeputyRepository.ProctorListAsync());
        }

    }


}
