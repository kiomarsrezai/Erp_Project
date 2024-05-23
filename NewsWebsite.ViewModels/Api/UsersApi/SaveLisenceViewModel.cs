using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Api.UsersApi
{
    public class SaveLisenceViewModel
    {
        public int Id { get; set; }
        public string Lisence { get; set; }

    }

    public class SaveAmlakLisenceViewModel
    {
        public int Id { get; set; }
        public string AmlakLisence { get; set; }

    }
}
