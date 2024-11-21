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
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq.Dynamic.Core;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Data;
using NewsWebsite.Data.Models;
using NewsWebsite.Data.Models.AmlakInfo;
using NewsWebsite.Data.Repositories;
using NewsWebsite.ViewModels;
using NewsWebsite.ViewModels.Api.Contract.AmlakInfo;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using System.Linq;
using NewsWebsite.Data.Models.AmlakArchive;
using NewsWebsite.Data.Models.AmlakPrivate;
using SharpKml.Dom;
using SharpKml.Engine;
using System.IO;
using System.IO.Compression;
using SharpKml.Base;

namespace NewsWebsite.Areas.Api.Controllers.v1.amlak
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class AmlakAppApiController : EnhancedController
    {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        protected readonly ProgramBuddbContext _db;

        public AmlakAppApiController(IUnitOfWork uw, IConfiguration config, IWebHostEnvironment webHostEnvironment,ProgramBuddbContext db)
        {
            _config = config;
            _uw = uw;
            _webHostEnvironment = webHostEnvironment;
            _db=db;

        }


        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------

        
        [Route("Dashboard")]
        [HttpGet]
        public async Task<ApiResult<object>> ContractList(){
            await CheckUserAuth(_db);

            var amlakPrivatesCount = await _db.AmlakPrivateNews.CountAsync();
            var amlakPrivatesSanadTakBargCount = await _db.AmlakPrivateNews.DocumentType(1).CountAsync();
            var amlakPrivatesSanadDaftarcheCount = await _db.AmlakPrivateNews.DocumentType(3).CountAsync();
            var amlakPrivatesTypeSakhtemanCount = await _db.AmlakPrivateNews.PropertyType(1).CountAsync();
            var amlakPrivatesTypeZaminCount = await _db.AmlakPrivateNews.PropertyType(2).CountAsync();
            var amlakPrivatesTypeKhaneCount = await _db.AmlakPrivateNews.PropertyType(3).CountAsync();
            
            
            
            var parcelsCount = await _db.AmlakParcels.CountAsync();
            var parcelsPendingCount = await _db.AmlakParcels.Status("1").CountAsync();
            var parcelsAcceptedCount = await _db.AmlakParcels.Status("2").CountAsync();
            var parcelsRejectedCount = await _db.AmlakParcels.Status("3").CountAsync();
            var parcelsRemovedCount = await _db.AmlakParcels.Status("4").CountAsync();
            
            var archivesNotSubmittedCount = await _db.AmlakArchives.IsSubmitted(0).CountAsync();
            var archivesSubmittedCount = await _db.AmlakArchives.IsSubmitted(1).CountAsync();
            
            var amlakInfosNonRentableAllCount = await _db.AmlakInfos.Rentable(0).CountAsync();
            var amlakInfosNonRentableParkCount = await _db.AmlakInfos.Rentable(0).AmlakInfoKindId(5).CountAsync();
            var amlakInfosNonRentableGozarCount = await _db.AmlakInfos.Rentable(0).AmlakInfoKindId(6).CountAsync();
            var amlakInfosNonRentableOtherCount = amlakInfosNonRentableAllCount-amlakInfosNonRentableParkCount-amlakInfosNonRentableGozarCount;
            var amlakInfosRentableAllCount = await _db.AmlakInfos.Rentable(1).CountAsync();
            var amlakInfosRentableWithContractCount = await _db.AmlakInfos.Rentable(1).Where(ai => ai.Contracts.Any()).CountAsync();
            var amlakInfosRentableWithoutContractCount = await _db.AmlakInfos.Rentable(1).Where(ai => !ai.Contracts.Any()).CountAsync();
            var amlakInfosRentableWithActiveContractCount =await _db.AmlakInfos.Rentable(1).Where(ai => ai.Contracts.Any(c => c.DateEnd == null || c.DateEnd > DateTime.Now)).CountAsync();
            var amlakInfosRentableWithoutActiveContractCount =  await _db.AmlakInfos.Where(ai => !ai.Contracts.Any(c => c.DateEnd == null || c.DateEnd > DateTime.Now)).CountAsync();
            
            var contractAmlakInfosAllCount = await _db.AmlakInfoContracts.CountAsync();
            var contractAmlakInfosActiveCount = await _db.AmlakInfoContracts.IsActive(1).CountAsync();
            var contractAmlakInfos2MonthActiveCount = await _db.AmlakInfoContracts.LessThanNMonth(2).CountAsync();
            
            
            return Ok(new {amlakPrivatesCount,amlakPrivatesSanadTakBargCount,amlakPrivatesSanadDaftarcheCount,amlakPrivatesTypeSakhtemanCount,amlakPrivatesTypeZaminCount,amlakPrivatesTypeKhaneCount,parcelsCount,parcelsPendingCount,parcelsAcceptedCount,parcelsRejectedCount,parcelsRemovedCount,archivesNotSubmittedCount,archivesSubmittedCount,amlakInfosNonRentableAllCount,amlakInfosNonRentableParkCount,amlakInfosNonRentableGozarCount,amlakInfosNonRentableOtherCount,amlakInfosRentableAllCount,amlakInfosRentableWithContractCount,amlakInfosRentableWithoutContractCount,amlakInfosRentableWithActiveContractCount,amlakInfosRentableWithoutActiveContractCount,contractAmlakInfosAllCount,contractAmlakInfosActiveCount,contractAmlakInfos2MonthActiveCount});
        }
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------

        
        [Route("Areas")]
        [HttpGet]
        public async Task<ApiResult<object>> DistrictsList(){
            await CheckUserAuth(_db);

            var areas = await _db.TblAreas.Where(a => a.Id <= 9 || a.Id == 52).ToListAsync();
            foreach (var area in areas){
                if (area.Id == 9){
                    area.AreaName = "شهرداری مرکز";
                }
            }
            return Ok(new {areas});
        }

        [Route("Owners")]
        [HttpGet]
        public async Task<ApiResult<object>> OwnersList(){
            await CheckUserAuth(_db);

            var owners = await _db.TblAreas.Where(a => a.Id <= 9 || a.StructureId == 2 || a.Id == 52).ToListAsync();
            foreach (var owner in owners){
                if (owner.Id == 9){
                    owner.AreaName = "شهرداری مرکز";
                }
            }
            return Ok(new {owners});
        }

        

        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------

        [Route("GeneralSearch")]
        [HttpGet]
        public async Task<ApiResult<object>> GeneralSearch(string text){
            await CheckUserAuth(_db);

            var amlakInfos = await _db.AmlakInfos.Where(a=> EF.Functions.Like(a.EstateInfoName, $"%{text}%") || 
                                                            EF.Functions.Like(a.EstateInfoAddress, $"%{text}%")
                                                        ).ToListAsync();
            var amlakPrivates = await _db.AmlakPrivateNews.Where(a=> EF.Functions.Like(a.Title, $"%{text}%") || 
                                                        EF.Functions.Like(a.TypeUsing, $"%{text}%")
                                                        ).ToListAsync();
            
              var amlakArchives = await _db.AmlakArchives.Where(a=> EF.Functions.Like(a.Address, $"%{text}%") || 
                                                                    EF.Functions.Like(a.Description, $"%{text}%")
                                                        ).ToListAsync();
            
            
            return Ok(new {amlakInfos,amlakPrivates,amlakArchives});
        }
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------

        [Route("Test11")]
        [HttpGet]
        public async Task<ApiResult<object>> Test11(int ContractId){
            await CheckUserAuth(_db);

            var builder = _db.AmlakArchives;

            var i = await builder.AreaId(ContractId).ToListAsync();
            var pageCount = await builder.CountAsync();

            return Ok( new{i,pageCount});
        }
        
        
        
        
        [Route("KMZ")]
        [HttpGet]
        public void CreateKmzFile(){


            var priv=_db.AmlakPrivateNews.FirstOrDefault();
            var coordinates = JsonConvert.DeserializeObject<List<List<double>>>(priv.Coordinates.ToString());


// Create a KML document
            var kml = new Kml();
            var document = new Document();
            kml.Feature = document;
            //----------------------------------------------

            
// Define the coordinates for the polygon
            var outerBoundary = new LinearRing();
            var coordinateCollection = new CoordinateCollection();

            var str = "";
            foreach (var coordinate in coordinates){
                str+=coordinate[1] +","+ coordinate[0]+"   /    ";
                // coordinateCollection.Add(new Vector(coordinate[0], coordinate[1]));
            }
            outerBoundary.Coordinates = coordinateCollection;

            Helpers.dd(str);
            
            // var outerBoundary = new LinearRing();
            // outerBoundary.Coordinates = new CoordinateCollection
            // {
            //     new Vector(37.422, -122.084),
            //     new Vector(37.422, -122.082),
            //     new Vector(37.420, -122.082),
            //     new Vector(37.420, -122.084),
            //     new Vector(37.422, -122.084) // Closing the polygon
            // };

// Create the polygon
            var polygon = new Polygon
            {
                OuterBoundary = new OuterBoundary { LinearRing = outerBoundary }
            };

// Create a placemark for the polygon
            var placemark = new Placemark
            {
                Name = "Sample Polygon",
                Geometry = polygon
            };

            
// Add the placemark to the document
            document.AddFeature(placemark);

            
            //----------------------------------------------
// Add a placemark
            var placemark2 = new Placemark
            {
                Name = "Sample Placemark",
                Geometry = new Point { Coordinate = new Vector(37.422, -122.084) }
            };
            document.AddFeature(placemark2);
            //----------------------------------------------

// Save the KML to a KMZ file
            using (var memoryStream = new MemoryStream())
            {
                KmlFile kmlFile = KmlFile.Create(kml, false);
                kmlFile.Save(memoryStream);

                using (var fileStream = new FileStream("output.kmz", FileMode.Create))
                using (var archive = new ZipArchive(fileStream, ZipArchiveMode.Create, true))
                {
                    var entry = archive.CreateEntry("doc.kml");
                    using (var entryStream = entry.Open())
                    {
                        memoryStream.Seek(0, SeekOrigin.Begin);
                        memoryStream.CopyTo(entryStream);
                    }
                }
            }
        }
    }
}
