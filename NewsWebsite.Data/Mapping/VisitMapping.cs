using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using NewsWebsite.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.Data.Mapping
{
    public class VisitMapping : IEntityTypeConfiguration<Visit>
    {
        public void Configure(EntityTypeBuilder<Visit> builder)
        {
            builder.HasKey(t => new { t.IpAddress, t.NewsId });
            builder
              .HasOne(p => p.News)
              .WithMany(t => t.Visits)
              .HasForeignKey(f => f.NewsId);

            //builder
            //   .HasOne(p => p.IpAddress)
            //   .WithMany(t => t.new)
            //   .HasForeignKey(f => f.UserId).OnDelete(DeleteBehavior.Restrict);
        }
    }

}
