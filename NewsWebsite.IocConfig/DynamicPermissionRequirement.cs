﻿using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc.Controllers;
using Microsoft.AspNetCore.Mvc.Filters;
using NewsWebsite.Services.Contracts;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace NewsWebsite.IocConfig
{
    public class DynamicPermissionRequirement : IAuthorizationRequirement
    {
    }

    public class DynamicPermissionsAuthorizationHandler : AuthorizationHandler<DynamicPermissionRequirement>
    {
        private readonly ISecurityTrimmingService _securityTrimmingService;

        public DynamicPermissionsAuthorizationHandler(ISecurityTrimmingService securityTrimmingService)
        {
            _securityTrimmingService = securityTrimmingService;
        }

        protected override Task HandleRequirementAsync(
             AuthorizationHandlerContext context,
             DynamicPermissionRequirement requirement)
        {
            var mvcContext = context.Resource as Endpoint;
            if (mvcContext == null)
            {
                return Task.CompletedTask;
            }

            var actionDescriptor = mvcContext.Metadata.OfType<ControllerActionDescriptor>().SingleOrDefault();

            actionDescriptor.RouteValues.TryGetValue("area", out var areaName);
            var area = string.IsNullOrWhiteSpace(areaName) ? string.Empty : areaName;

            actionDescriptor.RouteValues.TryGetValue("controller", out var controllerName);
            var controller = string.IsNullOrWhiteSpace(controllerName) ? string.Empty : controllerName;

            actionDescriptor.RouteValues.TryGetValue("action", out var actionName);
            var action = string.IsNullOrWhiteSpace(actionName) ? string.Empty : actionName;

            if (_securityTrimmingService.CanCurrentUserAccess(area, controller, action))
            {
                context.Succeed(requirement);
            }

            return Task.CompletedTask;
        }
    }
}
