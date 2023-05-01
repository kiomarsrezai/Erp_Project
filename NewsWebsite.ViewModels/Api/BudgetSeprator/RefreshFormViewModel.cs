using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Api.BudgetSeprator
{
    public class RefreshFormViewModel
    {
        [Display(Name = "شناسه")]
        public int areaId { get; set; }
        public int yearId { get; set; }

    }
}
