﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.GeneralVm
{
    public class AreaViewModel
    {
        public int Id { get; set; }

        [Display(Name = "منطقه")]
        public string AreaName { get; set; }
    }
}