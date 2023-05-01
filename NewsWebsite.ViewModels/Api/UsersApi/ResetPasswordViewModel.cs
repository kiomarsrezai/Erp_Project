using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Api.UsersApi
{
    public class ResetPasswordViewModel
    {
        [Display(Name = "شماره همراه")]
        public string PhoneNumber { get; set; }

    }
}
