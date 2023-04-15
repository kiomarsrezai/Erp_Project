using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.GeneralVm
{
    public class YearViewModel
    {
        public int Id { get; set; }

        [Display(Name = "سال")]
        public string YearName { get; set; }
    }
}
