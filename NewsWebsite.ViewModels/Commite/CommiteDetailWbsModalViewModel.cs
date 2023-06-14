using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Commite
{
    public class CommiteDetailWbsReadViewModel
    {
        public int Id { get; set; }
        public string FirstName { get; set; }
        public string Description { get; set; }
        public string LastName { get; set; }
        public string Responsibility { get; set; }
        
        public string DateStart { get; set; }

        public string DateEnd { get; set; }
        public string DateStartShamsi { get; set; }
        public string DatteEndShamsi { get; set; }
    }


    public class CommiteDetailWbsReadParamViewModel
    {
        public int CommiteDetailId { get; set; }
    }




}
