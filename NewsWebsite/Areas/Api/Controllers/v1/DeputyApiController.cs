using Microsoft.AspNetCore.Mvc;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Deputy;
using System.Collections.Generic;
using System.Data;
using System;
using System.Threading.Tasks;
using NewsWebsite.Common.Api;
using System.Data.SqlClient;
using Microsoft.Extensions.Configuration;

namespace NewsWebsite.Areas.Api.Controllers.v1
{

    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class DeputyApiController : Controller
    {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        public readonly IBudget_001Rep _budgetuw;
        public DeputyApiController(IUnitOfWork uw, IBudget_001Rep budgetuw,IConfiguration configuration)
        {
            _config = configuration;
            _uw = uw;
            _budgetuw = budgetuw;
        }

        

        

    }
}
