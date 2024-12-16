using System;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using NewsWebsite.Data.Mapping;
using NewsWebsite.Entities;
using NewsWebsite.Entities.identity;
using NewsWebsite.Data.Models;
using NewsWebsite.Data.Models.AmlakAdmin;
using NewsWebsite.Data.Models.AmlakAgreement;
using NewsWebsite.Data.Models.AmlakArchive;
using NewsWebsite.Data.Models.AmlakInfo;
using NewsWebsite.Data.Models.AmlakPrivate;
using NewsWebsite.ViewModels.Api.Contract.AmlakAgreement;
using NewsWebsite.ViewModels.Api.Contract.AmlakArchive;
using NewsWebsite.ViewModels.Api.Contract.amlakAttachs;
using NewsWebsite.ViewModels.Api.Contract.AmlakInfo;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using NewsWebsite.ViewModels.Api.Contract.AmlakCompliant;
using NewsWebsite.ViewModels.Api.Contract.AmlakLog;
using NewsWebsite.ViewModels.UserManager;

namespace NewsWebsite.Data
{
    public partial class ProgramBuddbContext : IdentityDbContext<User, Role, int, UserClaim, UserRole, IdentityUserLogin<int>, RoleClaim, IdentityUserToken<int>>
    {
        public ProgramBuddbContext(DbContextOptions<ProgramBuddbContext> options) : base(options)
        {
        }

        public virtual DbSet<FileDetail> FileDetails { set; get; }
        public virtual DbSet<Section> Sections { set; get; }
        public virtual DbSet<Category> Categories { set; get; }
        public virtual DbSet<News> News { set; get; }
        public virtual DbSet<Bookmark> Bookmarks { get; set; }
        public virtual DbSet<Comment> Comments { get; set; }
        public virtual DbSet<Like> Likes { get; set; }
        public virtual DbSet<NewsCategory> NewsCategories { get; set; }
        public virtual DbSet<Newsletter> Newsletters { get; set; }
        public virtual DbSet<NewsTag> NewsTags { get; set; }
        public virtual DbSet<Tag> Tags { get; set; }
        public virtual DbSet<Visit> Visits { get; set; }
        public virtual DbSet<Video> Videos { get; set; }
        public virtual DbSet<TblAreas> TblAreas { get; set; }
        public virtual DbSet<TblBudgetAreaShare> TblBudgetAreaShares { set; get; }
        public virtual DbSet<TblBudgetDetailProject> TblBudgetDetailProject { get; set; }
        public virtual DbSet<TblBudgetDetailProjectArea> TblBudgetDetailProjectArea { get; set; }
        public virtual DbSet<TblBudgetDetails> TblBudgetDetails { get; set; }
        public virtual DbSet<TblBudgetProcess> TblBudgetProcess { get; set; }
        public virtual DbSet<TblBudgets> TblBudgets { get; set; }
        public virtual DbSet<TblCodingPbb> TblCodingPbb { get; set; }
        public virtual DbSet<TblCodings> TblCodings { get; set; }
        public virtual DbSet<TblProgramOperationDetails> TblProgramOperationDetails { get; set; }
        public virtual DbSet<TblProgramOperations> TblProgramOperations { get; set; }
        public virtual DbSet<TblPrograms> TblPrograms { get; set; }
        public virtual DbSet<TblProgramDetails> TblProgramDetails { get; set; }
        public virtual DbSet<TblProjects> TblProjects { get; set; }
        public virtual DbSet<TblVasets> TblVasets { get; set; }
        public virtual DbSet<TblYears> TblYears { get; set; }
        // public virtual DbSet<AmlakInfoContract> AmlakInfoContracts { get; set; }
        public virtual DbSet<AmlakPrivateNew> AmlakPrivateNews { get; set; }
        public virtual DbSet<AmlakPrivateGenerating> AmlakPrivateGeneratings { get; set; }
        public virtual DbSet<AmlakPrivateDocHistory> AmlakPrivateDocHistories { get; set; }
        public virtual DbSet<AmlakPrivateTransfer> AmlakPrivateTransfers { get; set; }
        public virtual DbSet<AmlakInfo> AmlakInfos { get; set; }
        public virtual DbSet<AmlakInfoContractCheck> AmlakInfoContractChecks { get; set; }
        public virtual DbSet<AmlakInfoContractNotice> AmlakInfoContractNotices { get; set; }
        public virtual DbSet<AmlakInfoKind> AmlakInfoKinds { get; set; }
        public virtual DbSet<AmlakInfoContract> AmlakInfoContracts { get; set; }
        public virtual DbSet<AmlakInfoContractPrice> AmlakInfoContractPrices { get; set; }
        public virtual DbSet<AmlakInfoContractSupplier> AmlakInfoContractSuppliers { get; set; }
        public virtual DbSet<Supplier> Suppliers { get; set; }
        public virtual DbSet<AmlakParcel> AmlakParcels { get; set; }
        public virtual DbSet<AmlakArchive> AmlakArchives { get; set; }
        public virtual DbSet<AmlakAgreement> AmlakAgreements { get; set; }
        public virtual DbSet<AmlakCompliant> AmlakCompliants { get; set; }
        public virtual DbSet<AmlakLog> AmlakLogs { get; set; }
        public virtual DbSet<AmlakAdmin> AmlakAdmins { get; set; }
        public virtual DbSet<AmlakAttach> AmlakAttachs { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseSqlServer("Server=.;Database=ProgramBuddb;User Id=sa;Password=Az12345;Trusted_Connection=False;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.AddCustomIdentityMappings();
            modelBuilder.AddCustomNewsWebsiteMappings();
            modelBuilder.Entity<Video>().Property(b => b.PublishDateTime).HasDefaultValueSql("CONVERT(DATETIME, CONVERT(VARCHAR(20),GetDate(), 120))");
            modelBuilder.Entity<User>().Property(b => b.RegisterDateTime).HasDefaultValueSql("CONVERT(DATETIME, CONVERT(VARCHAR(20),GetDate(), 120))");
            modelBuilder.Entity<Newsletter>().Property(b => b.RegisterDateTime).HasDefaultValueSql("CONVERT(DATETIME, CONVERT(VARCHAR(20),GetDate(), 120))");
            modelBuilder.Entity<User>().Property(b => b.IsActive).HasDefaultValueSql("1");
            modelBuilder.Entity<Newsletter>().Property(b => b.IsActive).HasDefaultValueSql("1");

            modelBuilder.Entity<TblBudgetDetailProject>(entity =>
            {
                entity.ToTable("tblBudgetDetailProject");

                entity.HasIndex(e => e.TblBudgetDetailId);

                entity.HasOne(d => d.ProgramOperationDetails)
                    .WithMany(p => p.TblBudgetDetailProject)
                    .HasForeignKey(d => d.ProgramOperationDetailsId)
                    .HasConstraintName("FK_tblBudgetDetailProject_TblProgramOperationDetails");

                entity.HasOne(d => d.TblBudgetDetail)
                    .WithMany(p => p.TblBudgetDetailProject)
                    .HasForeignKey(d => d.TblBudgetDetailId);
            });

            modelBuilder.Entity<TblBudgetDetailProjectArea>(entity =>
            {
                entity.ToTable("tblBudgetDetailProjectArea");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.HasOne(d => d.Area)
                    .WithMany(p => p.TblBudgetDetailProjectArea)
                    .HasForeignKey(d => d.AreaId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_tblBudgetDetailProjectArea_TblAreas");

                entity.HasOne(d => d.BudgetDetailProject)
                    .WithMany(p => p.TblBudgetDetailProjectArea)
                    .HasForeignKey(d => d.BudgetDetailProjectId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_tblBudgetDetailProjectArea_tblBudgetDetailProject");
            });

            modelBuilder.Entity<TblBudgetDetails>(entity =>
            {
                entity.HasIndex(e => e.TblBudgetId);

                entity.HasIndex(e => e.TblCodingId);

                entity.Property(e => e.TblCodingId).HasColumnName("tblCodingId");

                entity.HasOne(d => d.TblBudget)
                    .WithMany(p => p.TblBudgetDetails)
                    .HasForeignKey(d => d.TblBudgetId);

                entity.HasOne(d => d.TblCoding)
                    .WithMany(p => p.TblBudgetDetails)
                    .HasForeignKey(d => d.TblCodingId);
            });

            modelBuilder.Entity<TblBudgetProcess>(entity =>
            {
                entity.ToTable("tblBudgetProcess");
            });

            modelBuilder.Entity<TblBudgets>(entity =>
            {
                entity.HasIndex(e => e.TblAreaId);

                entity.HasIndex(e => e.TblYearId);

                entity.HasOne(d => d.TblArea)
                    .WithMany(p => p.TblBudgets)
                    .HasForeignKey(d => d.TblAreaId);

                entity.HasOne(d => d.TblYear)
                    .WithMany(p => p.TblBudgets)
                    .HasForeignKey(d => d.TblYearId);
            });

            modelBuilder.Entity<TblCodingPbb>(entity =>
            {
                entity.ToTable("tblCodingPBB");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Code).HasMaxLength(50);

                entity.Property(e => e.Description).HasMaxLength(500);

                entity.HasOne(d => d.Mother)
                    .WithMany(p => p.InverseMother)
                    .HasForeignKey(d => d.MotherId)
                    .HasConstraintName("FK_tblCodingPBB_tblCodingPBB1");
            });

            modelBuilder.Entity<TblCodings>(entity =>
            {
                entity.HasIndex(e => e.MotherId);

                entity.HasIndex(e => e.TblBudgetProcessId);

                entity.Property(e => e.Code).HasMaxLength(50);

                entity.Property(e => e.CodeAcc).HasMaxLength(50);

                entity.Property(e => e.CodePbb)
                    .HasColumnName("CodePBB")
                    .HasMaxLength(10)
                    .IsFixedLength();

                entity.Property(e => e.CodingPbbid).HasColumnName("CodingPBBId");

                entity.Property(e => e.Description).HasMaxLength(500);

                entity.Property(e => e.LevelNumber).HasColumnName("levelNumber");

                entity.HasOne(d => d.CodingPbb)
                    .WithMany(p => p.TblCodings)
                    .HasForeignKey(d => d.CodingPbbid)
                    .HasConstraintName("FK_TblCodings_tblCodingPBB");

                entity.HasOne(d => d.Mother)
                    .WithMany(p => p.InverseMother)
                    .HasForeignKey(d => d.MotherId);

                entity.HasOne(d => d.TblBudgetProcess)
                    .WithMany(p => p.TblCodings)
                    .HasForeignKey(d => d.TblBudgetProcessId);
            });

            modelBuilder.Entity<TblProgramOperationDetails>(entity =>
            {
                entity.HasIndex(e => e.TblBudgetDetailProjectId);

                entity.HasIndex(e => e.TblProgramOperationId);

                entity.HasIndex(e => e.TblProjectId);

                entity.HasOne(d => d.TblBudgetDetailProjectNavigation)
                    .WithMany(p => p.TblProgramOperationDetails)
                    .HasForeignKey(d => d.TblBudgetDetailProjectId);

                entity.HasOne(d => d.TblProgramOperation)
                    .WithMany(p => p.TblProgramOperationDetails)
                    .HasForeignKey(d => d.TblProgramOperationId);

                entity.HasOne(d => d.TblProject)
                    .WithMany(p => p.TblProgramOperationDetails)
                    .HasForeignKey(d => d.TblProjectId);
            });

            modelBuilder.Entity<TblProgramOperations>(entity =>
            {
                entity.HasIndex(e => e.TblAreaId);

                entity.HasIndex(e => e.TblProgramId);

                entity.HasOne(d => d.TblArea)
                    .WithMany(p => p.TblProgramOperations)
                    .HasForeignKey(d => d.TblAreaId);

                entity.HasOne(d => d.TblProgram)
                    .WithMany(p => p.TblProgramOperations)
                    .HasForeignKey(d => d.TblProgramId);
            });

            modelBuilder.Entity<TblVasets>(entity =>
            {
                entity.HasKey(e => e.VasetId);

                entity.ToTable("Tbl_Vasets");
            });


            modelBuilder.Entity<AmlakPrivateDocHistory>()
                .HasOne(dh => dh.AmlakPrivateNew)
                .WithMany(apn => apn.AmlakPrivateDocHistories)
                .HasForeignKey(dh => dh.AmlakPrivateId);
           
            
            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
