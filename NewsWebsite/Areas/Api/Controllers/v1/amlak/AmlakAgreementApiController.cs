using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.FileProviders;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Contract;
using NewsWebsite.ViewModels.Api.Public;
using Newtonsoft.Json;
using RestSharp;
using System;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Data;
using NewsWebsite.ViewModels;
using System.Linq;
using NewsWebsite.Data.Models.AmlakAgreement;
using NewsWebsite.ViewModels.Api.Contract.AmlakAgreement;
using NewsWebsite.ViewModels.Api.Contract.AmlakLog;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;

namespace NewsWebsite.Areas.Api.Controllers.v1.amlak {
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class AmlakAgreementApiController : EnhancedController {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        protected readonly ProgramBuddbContext _db;

        public AmlakAgreementApiController(IUnitOfWork uw, IConfiguration config, IWebHostEnvironment webHostEnvironment, ProgramBuddbContext db){
            _config = config;
            _uw = uw;
            _webHostEnvironment = webHostEnvironment;
            _db = db;
        }


        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------


        [Route("List")]
        [HttpGet]
        public async Task<ApiResult<object>> AmlakAgreementList(AmlakAgreementReadInputVm param){
            await CheckUserAuth(_db);

            var builder = _db.AmlakAgreements
                .ContractParty(param.ContractParty)
                .DateFrom(param.DateFrom)
                .DateTo(param.DateTo)
                .MainPlateNumber(param.MainPlateNumber)
                .SubPlateNumber(param.SubPlateNumber)
                .Type(param.Type)
                .Search(param.Search);

            var pageCount = (int)Math.Ceiling((await builder.IsSubmitted(1).CountAsync())/Convert.ToDouble(param.PageRows));
            
            
            if (param.Export == 1){
                param.Page = 1;
                param.PageRows = 100000;
            }
            if (param.ForMap == 0){
                builder = builder
                    .IsSubmitted(1)
                    .OrderBy(param.Sort,param.SortType)
                    .Page2(param.Page, param.PageRows);
            }
            var items = await builder.ToListAsync();
            
             
            if (param.Export == 1){
                var fileUrl = ExportExcel(items);
                return Ok(new {fileUrl});
            }
            
            var finalItems = MyMapper.MapTo<AmlakAgreement, AmlakAgreementListVm>(items);
        
            return Ok(new{items=finalItems,pageCount});
        }
        
        
          
        private static object ExportExcel(List<AmlakAgreement> items){
            var finalItems = new List<List<object>>();

            foreach (var item in items){
                var row = new List<object>();
                row.Add(item.Id);
                row.Add(item.SdiId);
                row.Add(item.IsSubmitted);
                row.Add(item.Title);
                row.Add(item.DateFa);
                row.Add(item.ContractParty);
                row.Add(item.MainPlateNumber);
                row.Add(item.SubPlateNumber);
                row.Add(item.Type);
                row.Add(item.AmountMunicipality);
                row.Add(item.AmountContractParty);
                row.Add(item.DateFromFa);
                row.Add(item.DateToFa);
                row.Add(item.Description);
                row.Add(item.Coordinates);
                row.Add(item.Address);
                row.Add(item.CreatedAtFa);
                row.Add(item.UpdatedAtFa);
                finalItems.Add(row);
            }

            return Helpers.ExportExcelFile(finalItems, "amlak_agreement");
        }


        
        [Route("Read")]
        [HttpGet]
        public async Task<ApiResult<AmlakAgreementReadVm>> AmlakAgreementRead(PublicParamIdViewModel param){
            await CheckUserAuth(_db);

            var item = await _db.AmlakAgreements.Id(param.Id)
                .FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("پیدا نشد");
            
            var finalItem = MyMapper.MapTo<AmlakAgreement, AmlakAgreementReadVm>(item);
        
            return Ok(finalItem);
        }
        
        
        
        [Route("Update")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakAgreementUpdate([FromBody] AmlakAgreementUpdateVm param){
            await CheckUserAuth(_db);

            var item = await _db.AmlakAgreements.Id(param.Id).FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("پیدا نشد");

            item.Title = param.Title;
            item.Date = DateTime.Parse(param.Date);
            item.ContractParty = param.ContractParty;
            item.MainPlateNumber= param.MainPlateNumber;
            item.SubPlateNumber= param.SubPlateNumber;
            item.Type= param.Type;
            item.AmountMunicipality = param.AmountMunicipality;
            item.AmountContractParty = param.AmountContractParty;
            item.DateFrom = !string.IsNullOrEmpty(param.DateFrom) ? DateTime.Parse(param.DateFrom) : (DateTime?)null;
            item.DateTo = !string.IsNullOrEmpty(param.DateTo) ? DateTime.Parse(param.DateTo) : (DateTime?)null;
            item.Description = param.Description;
            item.Address = param.Description;
            item.IsSubmitted = 1;
            item.UpdatedAt = Helpers.GetServerDateTimeType();
            await _db.SaveChangesAsync();
        
            await SaveLogAsync(_db, item.Id, TargetTypes.Agreement, "توافق ویرایش شد.");

            return Ok("با موفقیت انجام شد");
        }
    }
}