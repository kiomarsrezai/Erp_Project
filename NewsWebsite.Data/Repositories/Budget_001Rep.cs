using Microsoft.EntityFrameworkCore;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.UsersApi;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.ViewModels.Api.GeneralVm;
using NewsWebsite.ViewModels.Api.Budget.BudgetSeprator;
using NewsWebsite.ViewModels.Api.Report;
using NewsWebsite.ViewModels.Api.Deputy;
using Newtonsoft.Json;
using System.Net.Http;
using System.Text;
using NewsWebsite.ViewModels.Api.Contract;
using Microsoft.AspNetCore.Mvc;
using System.Net.Http.Headers;
using RestSharp;
using System.Xml.Linq;
using Newtonsoft.Json.Linq;
using System.Text.Json.Nodes;

namespace NewsWebsite.Data.Repositories
{
    public class Budget_001Rep : IBudget_001Rep
    {
        ProgramBuddbContext _context;
        public readonly IUnitOfWork _uw;
        public readonly IConfiguration _config;

        public Budget_001Rep(ProgramBuddbContext context, IConfiguration config)
        {
            _config = config;
            _context = context;
        }

        //private readonly ProgramBudDbContext context;
        public List<AreaViewModel> AreaFetchForPropozalBudget()
        {
            List<AreaViewModel> areaViews = new List<AreaViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP000_Area_ProposalBudget", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = sqlCommand.ExecuteReader();
                    while (dataReader.Read())
                    {
                        AreaViewModel fetchView = new AreaViewModel();
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.AreaName = dataReader["AreaName"].ToString();
                        areaViews.Add(fetchView);

                        //dataReader.NextResult();
                    }
                }
            }
            return areaViews;
        }

        public async Task<List<YearViewModel>> YearFetchAsync(int kindid)
        {
            List<YearViewModel> yearViews = new List<YearViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP000_Year", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("YearId", kindid);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        YearViewModel fetchView = new YearViewModel();
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.YearName = dataReader["YearName"].ToString();
                        yearViews.Add(fetchView);

                        //dataReader.NextResult();
                    }
                }
            }
            return yearViews;
        }

        public async Task<List<BudgetProcessViewModel>> BudgetProcessFetchAsync()
        {
            List<BudgetProcessViewModel> yearViews = new List<BudgetProcessViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP000_BudgetSection", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        BudgetProcessViewModel fetchView = new BudgetProcessViewModel();
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.ProcessName = dataReader["ProcessName"].ToString();
                        yearViews.Add(fetchView);

                        //dataReader.NextResult();
                    }
                }
            }
            return yearViews;
        }

        public async Task<Root> UpdateErpFromSdi()
        {

            Root AmlakPrivateFromSdiDto = new Root();

            //your Hosted Base URL
            string loginurl = "https://sdi.ahvaz.ir/geoapi/user/login/";
            // GET: login

            var clientlogin = new RestClient(loginurl);
            var requestlogin = new RestRequest();
            requestlogin.AddHeader("Accept", "application/json, text/plain, */*");
            requestlogin.AddHeader("Content-Type", "application/json");
            requestlogin.AddParameter("username", "ERP_Fava", ParameterType.RequestBody);
            requestlogin.AddParameter("password", "123456", ParameterType.RequestBody);
            requestlogin.AddParameter("appId", "mobilegis", ParameterType.RequestBody);

            RestResponse responselogin =await clientlogin.ExecuteAsync(requestlogin);

            string authkey = JObject.Parse(responselogin.Content)["app_key"].ToString();

            string requetlayerurl = "https://sdi.ahvaz.ir/geoapi/user/login/";
            // GET: kiosk layer

            var clientlayer = new RestClient(requetlayerurl);
            var requestlayer = new RestRequest();
            requestlayer.AddHeader("Accept", "application/json, text/plain, */*");
            requestlayer.AddHeader("Content-Type", "application/json");
            requestlayer.AddParameter("service", "WMS", ParameterType.QueryString);
            requestlayer.AddParameter("version", "123456", ParameterType.QueryString);
            requestlayer.AddParameter("request", "GetMap", ParameterType.QueryString);
            requestlayer.AddParameter("layers", "ahvaz_kiosk14000719_8798", ParameterType.QueryString);
            requestlayer.AddParameter("styles", "", ParameterType.QueryString);
            requestlayer.AddParameter("bbox", "266946.15830115,3459691.01376209,290403.347700002,3475056.7358", ParameterType.QueryString);
            requestlayer.AddParameter("width", "565", ParameterType.QueryString);
            requestlayer.AddParameter("srs", "EPSG:32639", ParameterType.QueryString);
            requestlayer.AddParameter("format", "application/json", ParameterType.QueryString);
            requestlayer.AddParameter("authkey", authkey, ParameterType.QueryString);
            requestlayer.AddParameter("INFO_FORMAT", "application/json", ParameterType.QueryString);

            RestResponse responseRequestLayer = await clientlayer.ExecuteAsync(requestlayer);
            var TempData = JsonConvert.DeserializeObject<Root>(responseRequestLayer.Content);

            return TempData;

        }
    public async Task<string> AreaNameByIdAsync(int id)
    {
        string name = "";
        using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
        {
            using (SqlCommand sqlCommand = new SqlCommand("SP000_AreaNameById", sqlconnect))
            {
                sqlconnect.Open();
                sqlCommand.Parameters.AddWithValue("Id", id);
                sqlCommand.CommandType = CommandType.StoredProcedure;
                SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                while (dataReader.Read())
                    name = dataReader["AreaName"].ToString();
            }
        }
        return name;
    }

    public async Task<UserSignViewModel> GetUserByTocken(string tocken)
    {
        UserSignViewModel user = new UserSignViewModel();
        using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
        {
            using (SqlCommand sqlCommand = new SqlCommand("SP000_GetUserInfoByTocken", sqlconnect))
            {
                sqlconnect.Open();
                sqlCommand.Parameters.AddWithValue("tocken", tocken);
                sqlCommand.CommandType = CommandType.StoredProcedure;
                SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                while (await dataReader.ReadAsync())
                {
                    //            user.FirstName = user.FirstName;
                    //user.LastName = userfetch.LastName;
                    //user.SectionId = userfetch.SectionId;
                    //user.SectionName = await AreaNameByIdAsync(userfetch.SectionId);
                    //user.Token = userfetch.Token;
                    //            user.UserName = dataReader["UserName"].ToString(); user.FirstName = dataReader["FirstName"].ToString();
                    //            user.LastName = dataReader["LastName"].ToString();
                    //            user.SectionId = StringExtensions.ToNullableInt(dataReader["SectionId"].ToString());
                    //            user.SectionName = await AreaNameByIdAsync(int.Parse(dataReader["SectionId"].ToString()));
                    //            user.Token = dataReader["Token"].ToString();
                    //            user.UserName = dataReader["UserName"].ToString();
                }
            }
        }
        return user;
    }

    public async Task<List<AreaViewModel>> AreaFetchAsync(int areaform)
    {
        List<AreaViewModel> areaViews = new List<AreaViewModel>();

        using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
        {
            using (SqlCommand sqlCommand = new SqlCommand("SP000_Area", sqlconnect))
            {
                sqlconnect.Open();
                sqlCommand.Parameters.AddWithValue("areaForm", areaform);
                sqlCommand.CommandType = CommandType.StoredProcedure;
                SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                while (dataReader.Read())
                {
                    AreaViewModel fetchView = new AreaViewModel();
                    fetchView.Id = int.Parse(dataReader["Id"].ToString());
                    fetchView.AreaName = dataReader["AreaName"].ToString();
                    fetchView.AreaNameShort = dataReader["AreaNameShort"].ToString();
                    areaViews.Add(fetchView);

                    //dataReader.NextResult();
                }
            }
        }
        return areaViews;
    }

    public async Task<List<ProctorViewModel>> ProctorList()
    {

        List<ProctorViewModel> areaViews = new List<ProctorViewModel>();

        using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
        {
            using (SqlCommand sqlCommand = new SqlCommand("SP501_ProctorList_Read", sqlconnect))
            {
                sqlconnect.Open();
                sqlCommand.CommandType = CommandType.StoredProcedure;
                SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                while (dataReader.Read())
                {
                    ProctorViewModel fetchView = new ProctorViewModel();
                    fetchView.Id = int.Parse(dataReader["Id"].ToString());
                    fetchView.ProctorName = dataReader["ProctorName"].ToString();
                    areaViews.Add(fetchView);

                    //dataReader.NextResult();
                }
            }
        }
        return areaViews;
    }

    public double Division(double? expense, double? mosavab)
    {
        if (mosavab == null) return 0;

        double summry = 0;
        summry = Math.Round((double)(expense / mosavab * 100));
        return summry;
    }

    public double Growth(double? SecondNumber, double? FirstNumber)
    {
        if (FirstNumber == null) return 0;

        double summry = 0;
        summry = Math.Round((double)(SecondNumber / FirstNumber * 100) - 100);
        return summry;
    }



    public async Task<List<BudgetSepratorViewModel>> GetAllBudgetSeprtaorAsync(int yearId, int areaId, int budgetProcessId)
    {
        List<BudgetSepratorViewModel> fecth = new List<BudgetSepratorViewModel>();

        using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
        {
            using (SqlCommand sqlCommand = new SqlCommand("SP002_BudgetSepratorArea", sqlconnect))
            {
                sqlconnect.Open();
                sqlCommand.Parameters.AddWithValue("yearId", yearId);
                sqlCommand.Parameters.AddWithValue("areaId", areaId);
                sqlCommand.Parameters.AddWithValue("budgetProcessId", budgetProcessId);
                sqlCommand.CommandType = CommandType.StoredProcedure;
                SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                while (dataReader.Read())
                {
                    BudgetSepratorViewModel fetchView = new BudgetSepratorViewModel();
                    fetchView.Code = dataReader["Code"].ToString();
                    fetchView.Description = dataReader["Description"].ToString();
                    fetchView.CodingId = int.Parse(dataReader["CodingId"].ToString());
                    fetchView.Edit = long.Parse(dataReader["Edit"].ToString());
                    fetchView.LevelNumber = int.Parse(dataReader["LevelNumber"].ToString());
                    fetchView.Mosavab = Int64.Parse(dataReader["Mosavab"].ToString());
                    fetchView.Expense = Int64.Parse(dataReader["Expense"].ToString());
                    fetchView.CreditAmount = Int64.Parse(dataReader["CreditAmount"].ToString());
                    fetchView.Crud = bool.Parse(dataReader["Crud"].ToString());
                    fetchView.budgetProcessId = budgetProcessId;

                    if (fetchView.Mosavab != 0)
                    {
                        fetchView.PercentBud = Math.Round(Division(fetchView.Expense, fetchView.Mosavab));
                    }
                    else
                    {
                        fetchView.PercentBud = 0;
                    }
                    fecth.Add(fetchView);
                    //dataReader.NextResult();
                }
                //TempData["budgetSeprator"] = fecthViewModel;
            }
        }
        return fecth;
    }

    public async Task<bool> SaveLisenceAsync(int userId, string lisence)
    {
        if (userId == 0)
            return false;

        var user = await _uw._Context.Users.FirstOrDefaultAsync(a => a.Id == userId);
        user.Lisence = lisence;
        return true;
    }

}

}
