﻿using Microsoft.AspNetCore.Identity;
using NewsWebsite.Entities.identity;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.UserManager
{
    public class UserActivationViewModel
    {
        public int UserId { get; set; }
        public int isActive { get; set; }
    }

}