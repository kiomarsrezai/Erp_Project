using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.UserManager
{
    public class ResetPassViewModel
    {
        [Display(Name = "شماره همراه")]
        public int userId { get; set; }
        public string Email { get; set; }
        public string NewPassword { get; set; }

    }
}
