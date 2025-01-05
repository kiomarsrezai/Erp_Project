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
using NewsWebsite.ViewModels.Api.Contract.amlakAttachs;
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
            var user = await CheckUserAuth(_db);

            var builder = _db.AmlakTickets.Title(param.Title);
            
            switch (param.Type){
                case "sent":
                    builder = builder.Where(a => a.AdminId == user.Id);
                    break;
                case "todo":
                    builder = builder.Where(a => a.LastAdminId == user.Id);
                    break;
                case "cc":
                    var allTicketAdmins1 = await _db.AmlakTicketAdmins.AdminId(user.Id).Where(a=>a.Type==3).ToListAsync();
                    var allTicketIds1 = allTicketAdmins1.Select(x => x.TicketId).ToList();
                    
                    builder = builder.Where(x => allTicketIds1.Contains(x.Id));
                    break;
                case "all":
                    var allTicketAdmins2 = await _db.AmlakTicketAdmins.AdminId(user.Id).ToListAsync();
                    var allTicketIds2 = allTicketAdmins2.Select(x => x.TicketId).ToList();
                    
                    builder = builder.Where(x => allTicketIds2.Contains(x.Id));
                    
                    break;
                
                default:
                    return BadRequest("نوع نامعتبر!");
            }
            
            var items =await builder.Include(a => a.Admin).Include(a => a.LastAdmin)
                .OrderBy(param.Sort, param.SortType).Page2(param.Page, param.PageRows).ToListAsync();
            
            var finalItems = MyMapper.MapTo<AmlakTicket, AmlakTicketListVm>(items);
            
            var pageCount = (int)Math.Ceiling((await builder.CountAsync())/Convert.ToDouble(param.PageRows));
            return Ok(new{items=finalItems,pageCount});
        }

        [Route("Read")]
        [HttpGet]
        public async Task<ApiResult<object>> AmlakTicketRead(PublicParamUUIDViewModel param){
            await CheckUserAuth(_db);

            var item = await _db.AmlakTickets.UUID(param.UUID).FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("پیدا نشد");
            
            var messages = await _db.AmlakTicketMessages.TicketId(item.Id).ToListAsync();
            
            var allTicketAdmins = await _db.AmlakTicketAdmins.TicketId(item.Id).ToListAsync();
            var adminIds = allTicketAdmins.Select(x => x.AdminId).ToList();

            var AmlakAdmins = await _db.AmlakAdmins.Where(x => adminIds.Contains(x.Id)).ToListAsync();
            
            var finalItem = MyMapper.MapTo<AmlakTicket, AmlakTicketReadVm>(item);
            var finalMessages = MyMapper.MapTo<AmlakTicketMessage, AmlakTicketMessageVm>(messages);
            var finalAdmins = MyMapper.MapTo<AmlakAdmin, AmlakAdminTicket>(AmlakAdmins);

            foreach (var message in finalMessages){
                message.attachments = await _db.AmlakAttachs.TargetType("ticketMessage").TargetId(message.Id).ToListAsync();
            }
            
            
            finalItem.Messages = finalMessages;
            finalItem.Speakers = finalAdmins;
            
            return Ok(finalItem);
        }


        [Route("Store")]
        [HttpPost]
        [Consumes("multipart/form-data")]
        public async Task<ApiResult<string>> AmlakTicketStore( AmlakTicketStoreVm param){
            var user = await CheckUserAuth(_db);

            var item = new AmlakTicket();
            item.UUID = Guid.NewGuid().ToString();
            item.Title = param.Title;
            item.AdminId = user.Id;
            item.LastAdminId = param.ToAdminId;
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
            _db.Add(ticketAdmin1);
            
            var ticketAdmin2 = new AmlakTicketAdmin();
            ticketAdmin2.TicketId = item.Id;
            ticketAdmin2.AdminId = param.ToAdminId;
            ticketAdmin2.Type = 2;
            _db.Add(ticketAdmin2);
            
            if(param.CCAdminIds!=null && param.CCAdminIds.Any())
                foreach (var adminId in param.CCAdminIds)
                {
                    var ticketAdmin = new AmlakTicketAdmin();
                    ticketAdmin.TicketId = item.Id;
                    ticketAdmin.AdminId = adminId;
                    ticketAdmin.Type = 3;
                    _db.Add(ticketAdmin);
                }
            await _db.SaveChangesAsync();


            if (param.Attachments != null){
                var attachC = new AmlakAttachApiController(_uw, _config, _webHostEnvironment, _db);
                foreach (var attach in param.Attachments){
                    await attachC.DoUpload(new AmlakAttachUploadVm{
                        FileTitle = "",
                        FormFile = attach,
                        TargetId = itemMessage.Id,
                        TargetType = "ticketMessage",
                        Type = "Attach"
                    });
                }
            }
            // await SaveLogAsync(_db, item.Id, TargetTypes.Parcel, "پارسل اضافه شد"); //todo : 

            return Ok(item.UUID);
        }

        

        [Route("StoreMessage")]
        [HttpPost]
        public async Task<ApiResult<object>> AmlakTicketMessageStore( AmlakTicketMessageStoreVm param){
            var user = await CheckUserAuth(_db);

            var item = _db.AmlakTickets.UUID(param.UUID).FirstOrError("پیدا نشد");

            item.LastAdminId = param.ToAdminId;
            
             var itemMessage = new AmlakTicketMessage();
            itemMessage.TicketId = item.Id;
            itemMessage.FromId = user.Id;
            itemMessage.ToId= param.ToAdminId;
            itemMessage.Message =param.Message;
            itemMessage.CreatedAt = Helpers.GetServerDateTimeType();
            _db.Add(itemMessage);


            var oldAdminTicket = await _db.AmlakTicketAdmins.TicketId(item.Id).AdminId(param.ToAdminId).FirstOrDefaultAsync();
            if (oldAdminTicket == null){
                var ticketAdmin = new AmlakTicketAdmin();
                ticketAdmin.TicketId = item.Id;
                ticketAdmin.AdminId = param.ToAdminId;
                ticketAdmin.Type = 1;
                _db.Add(ticketAdmin);
            }
            
            await _db.SaveChangesAsync();

            if (param.Attachments != null){
                var attachC = new AmlakAttachApiController(_uw, _config, _webHostEnvironment, _db);
                foreach (var attach in param.Attachments){
                    await attachC.DoUpload(new AmlakAttachUploadVm{
                        FileTitle = "",
                        FormFile = attach,
                        TargetId = itemMessage.Id,
                        TargetType = "ticketMessage",
                        Type = "Attach"
                    });
                }
            }
            
            var ticketCountTodo = await _db.AmlakTickets.Where(a => a.LastAdminId == user.Id).CountAsync();


            return Ok(new{
                TicketCountTodo=ticketCountTodo
            });
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