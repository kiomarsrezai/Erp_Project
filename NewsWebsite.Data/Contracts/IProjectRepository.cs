using Microsoft.AspNetCore.Mvc;
using NewsWebsite.Common.Api;
using NewsWebsite.ViewModels.Fetch;
using NewsWebsite.ViewModels.Project;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace NewsWebsite.Data.Contracts
{
    public interface IProjectRepository
    {
        Task<ProjectViewModel> FindProjectAsync(int id);
        //Task<ApiResult<string>> ProjectInsert(int id, string code, string description, int yearId, int areaId);
    }
}
