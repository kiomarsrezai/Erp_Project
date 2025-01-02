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
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Data;
using NewsWebsite.Data.Models.AmlakAdmin;
using NewsWebsite.Data.Models.AmlakTicket;
using NewsWebsite.ViewModels;
using NewsWebsite.ViewModels.Api.Contract.AmlakAdmin;
using NewsWebsite.ViewModels.Api.Contract.AmlakLog;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;

namespace NewsWebsite.Areas.Api.Controllers.v1.amlak {
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class AmlakTicketApiController : EnhancedController {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        protected readonly ProgramBuddbContext _db;

        public AmlakTicketApiController(IUnitOfWork uw, IConfiguration config, IWebHostEnvironment webHostEnvironment, ProgramBuddbContext db){
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
        public async Task<ApiResult<object>> AmlakTicketList(AmlakTicketReadInputVm param){
            await CheckUserAuth(_db);

            var builder = _db.AmlakTickets;
            var items = await builder
                // .Include(a=>a.Admin).Include(a=>a.LastAdmin)
                .OrderBy(param.Sort,param.SortType).Page2(param.Page,param.PageRows).ToListAsync();
            var finalItems = MyMapper.MapTo<AmlakTicket, AmlakTicketListVm>(items);
            
            var pageCount = (int)Math.Ceiling((await builder.CountAsync())/Convert.ToDouble(param.PageRows));

            return Ok(new{items=finalItems,pageCount});
        }

        [Route("Read")]
        [HttpGet]
        public async Task<ApiResult<AmlakTicketReadVm>> AmlakTicketRead(PublicParamIdViewModel param){
            await CheckUserAuth(_db);

            var item = await _db.AmlakTickets.Id(param.Id).FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("پیدا نشد");
            
            var messages = await _db.AmlakTicketMessages.TicketId(param.Id).ToListAsync();
            
            var allTicketAdmins = await _db.AmlakTicketAdmins.TicketId(param.Id).ToListAsync();
            var adminIds = allTicketAdmins.Select(x => x.AdminId).ToList();

            var AmlakAdmins = await _db.AmlakAdmins.Where(x => adminIds.Contains(x.Id)).ToListAsync();
            
            var finalItem = MyMapper.MapTo<AmlakTicket, AmlakTicketReadVm>(item);
            var finalMessages = MyMapper.MapTo<AmlakTicketMessage, AmlakTicketMessageVm>(messages);
            var finalAdmins = MyMapper.MapTo<AmlakAdmin, AmlakAdminTicket>(AmlakAdmins);
            finalItem.Messages = finalMessages;
            finalItem.Speakers = finalAdmins;
            
            return Ok(finalItem);
        }


        [Route("Store")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakTicketStore( AmlakTicketStoreVm param){
            var user = await CheckUserAuth(_db);

            var item = new AmlakTicket();
            item.Title = param.Title;
            item.AdminId = user.Id;
            item.LastAdminId = param.ToAdminId;
            item.Title = param.Title;
            item.Links = param.Links;
            item.Status = 1;
            item.CreatedAt = Helpers.GetServerDateTimeType();
            item.UpdatedAt = Helpers.GetServerDateTimeType();
            _db.Add(item);
            await _db.SaveChangesAsync();
            
            
             var itemMessage = new AmlakTicketMessage();
            itemMessage.TicketId = item.Id;
            itemMessage.FromId = user.Id;
            itemMessage.ToId= param.ToAdminId;
            itemMessage.Message =param.Message;
            itemMessage.CreatedAt = Helpers.GetServerDateTimeType();
            _db.Add(itemMessage);

            var ticketAdmin1 = new AmlakTicketAdmin();
            ticketAdmin1.TicketId = item.Id;
            ticketAdmin1.AdminId = user.Id;
            ticketAdmin1.Type = 1;
            _db.Add(itemMessage);
            
            var ticketAdmin2 = new AmlakTicketAdmin();
            ticketAdmin2.TicketId = item.Id;
            ticketAdmin2.AdminId = param.ToAdminId;
            ticketAdmin2.Type = 2;
            _db.Add(itemMessage);
            
            foreach (var adminId in param.CCAdminIds)
            {
                var ticketAdmin = new AmlakTicketAdmin();
                ticketAdmin.TicketId = item.Id;
                ticketAdmin.AdminId = adminId;
                ticketAdmin.Type = 3;
                _db.Add(itemMessage);
            }
            await _db.SaveChangesAsync();

            // await SaveLogAsync(_db, item.Id, TargetTypes.Parcel, "پارسل اضافه شد"); //todo : 

            return Ok(item.Id.ToString());
        }

        
        
        [Route("Status")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakTicketUpdateStatus( AmlakTicketUpdateStatusVm param){

            await CheckUserAuth(_db);

            var item = await _db.AmlakTickets.Id(param.Id).FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("پیدا نشد");

            item.Status = param.Status;
            await _db.SaveChangesAsync();

            // await SaveLogAsync(_db, item.Id, TargetTypes.Parcel, "وضعیت پارسل  به "+param.Status+" ویرایش شد"); // todo:

            return Ok("با موفقیت انجام شد");
        }
        
        
    }
}