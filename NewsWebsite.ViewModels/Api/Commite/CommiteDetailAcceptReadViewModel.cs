using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Commite
{
    public class CommiteDetailAcceptReadViewModel
    {
        public int Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Resposibility { get; set; }
        public string DateAccept { get; set; }
        public string DateAcceptShamsi { get; set; }
     
    }

    public class CommiteDetailAcceptReadParamViewModel
    {
        public int CommiteDetailId { get; set; }
    }



}
