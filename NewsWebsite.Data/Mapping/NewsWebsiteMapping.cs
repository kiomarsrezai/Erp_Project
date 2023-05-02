using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.Data.Mapping
{
    public static class NewsWebsiteMapping
    {
        public static void AddCustomNewsWebsiteMappings(this ModelBuilder modelBuilder)
        {
            modelBuilder.ApplyConfiguration(new BookmarkMapping());
            modelBuilder.ApplyConfiguration(new VisitMapping());
            modelBuilder.ApplyConfiguration(new LikeMapping());
            modelBuilder.ApplyConfiguration(new NewsCategoryMapping());
            modelBuilder.ApplyConfiguration(new NewsTagMapping());
        }

    }
}
