using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Project
{
    public class CommiteDetailViewModel
    {
       
       
    }


    public class CommiteDetailInsertParamViewModel
    {
        public int Row { get; set; }
        public int CommiteId { get; set; }
        public string Description { get; set; }
        public int ProjectId { get; set; }

    }

    public class CommiteDetailUpdateParamViewModel
    {
        public int Id { get; set; }
        public int Row { get; set; }
        public string Description { get; set; }
        public int ProjectId { get; set; }

    }

    public class CommiteDetailDeleteParamViewModel
    {
        public int Id { get; set; }
    }


    public class CommiteDetailProjectModalViewModel
    {
        public int Id { get; set; }
        public string ProjectCode { get; set; }
        public string ProjectName { get; set; }
    }


    

}
