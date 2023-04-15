using Microsoft.AspNetCore.Mvc;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace NewsWebsite.Areas.Api.Controllers.v1
{

    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class VasetApiController : Controller
    {
        public readonly IUnitOfWork _uw;
        public VasetApiController(IUnitOfWork uw)
        {
            _uw = uw;
        }

        [Route("VasetGetAll")]
        [HttpGet]
        public async Task<IActionResult> GetVasets(int yearId, int areaId, int budgetProcessId)
        {
            return Ok(await _uw.VasetRepository.GetAllAsync(yearId, areaId, budgetProcessId));
        }

        [Route("GetModalVaset")]
        [HttpGet]
        public async Task<IActionResult> GetModalVaset(int id, string code, string description, int yearId, int areaId)
        {
            return Ok(await _uw.VasetRepository.ModalDetailsAsync(id, code, description, yearId, areaId));
        }

        [Route("InsertCodeAcc")]
        [HttpGet]
        public async Task<IActionResult> InsertCodeAccAsync(int id)
        {
            return Ok(await _uw.VasetRepository.InsertCodeAccPostAsync(id));
        }

        [Route("DeleteCodeAcc")]
        [HttpGet]
        public async Task<IActionResult> DeleteCodeAccAsync(int id)
        {
            return Ok(await _uw.VasetRepository.DeleteCodeAccPostAsync(id));
        }

    }


}
