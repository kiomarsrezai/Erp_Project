using NewsWebsite.Entities.identity;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace NewsWebsite.Entities
{
    public partial class Section
    {
        [Key]
        public int SectionId { get; set; }
        public string Name { get; set; }
        public string Manager { get; set; }
        public string Address { get; set; }
        public string Phone { get; set; }
        public virtual ICollection<User> Users { get; set; }
    }
}
