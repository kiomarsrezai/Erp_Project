using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NewsWebsite.Common.PublicMethod
{
    public class PackingTypeDeclerationList
    {
        public int ID { get; set; }
        public string Title { get; set; }


        public List<PackingTypeDeclerationList> GetPackingTypeDecleration()
        {
            var model = new List<PackingTypeDeclerationList>
            {
            new PackingTypeDeclerationList {ID = 0, Title = "---واحداندازه گیری---"},
            new PackingTypeDeclerationList {ID = 1, Title = "شل"},
            new PackingTypeDeclerationList {ID = 2, Title = "کارتون"},
            new PackingTypeDeclerationList {ID = 3, Title = "جعبه" },
            new PackingTypeDeclerationList {ID = 4, Title = "عدد"},
            new PackingTypeDeclerationList {ID = 5, Title = "بسته"},
            new PackingTypeDeclerationList {ID = 6, Title = "متر"},
            new PackingTypeDeclerationList {ID = 7, Title = "کیلومتر"},
            new PackingTypeDeclerationList {ID = 8, Title = "کیلوگرم"},
            new PackingTypeDeclerationList {ID = 9, Title = "تن"},
            new PackingTypeDeclerationList {ID = 10, Title = "ست"},
            new PackingTypeDeclerationList {ID = 11, Title = "دستگاه"},
            new PackingTypeDeclerationList {ID = 12, Title = "رول"},
            new PackingTypeDeclerationList {ID = 13, Title = "مترمربع"},
            new PackingTypeDeclerationList {ID = 14, Title = "مترمکعب"},
            new PackingTypeDeclerationList {ID = 15, Title = "بشکه"},
            new PackingTypeDeclerationList {ID = 16, Title = "کیسه"},
            new PackingTypeDeclerationList {ID = 17, Title = "قوطی"},
            new PackingTypeDeclerationList {ID = 18, Title = "ورق"},
            new PackingTypeDeclerationList {ID = 19, Title = "برگ"},
            new PackingTypeDeclerationList {ID = 20, Title = "کلاف"},
            new PackingTypeDeclerationList {ID = 21, Title = "پاکت"},
            new PackingTypeDeclerationList {ID = 22, Title = "قطعه"},
            new PackingTypeDeclerationList {ID = 23, Title = "شاخه"},
            new PackingTypeDeclerationList {ID = 24, Title = "لیتر"},
            new PackingTypeDeclerationList {ID = 25, Title = "قالب"},
            new PackingTypeDeclerationList {ID = 26, Title = "تانکر"},
            };

            return model;
        }
    }
}
