using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Api.BudgetSeprator
{
    public class DeleteSepViewModel
    {
        [Display(Name = "شناسه")]
        public int id { get; set; }

    }
}
