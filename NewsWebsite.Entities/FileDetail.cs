using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Text;
using static NewsWebsite.Common.FileExtensions;

namespace NewsWebsite.Entities
{
    public class FileDetail
    {
        [Key]
        public int ID { get; set; }
        public string FileName { get; set; }
        public int ProjectId { get; set; }
    }
}
