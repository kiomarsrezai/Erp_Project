using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace NewsWebsite.Data.Models
{
    public partial class ProgramBuddbContext : DbContext
    {
        public ProgramBuddbContext()
        {
        }

        public ProgramBuddbContext(DbContextOptions<ProgramBuddbContext> options)
            : base(options)
        {
        }

        public virtual DbSet<TblAreas> TblAreas { get; set; }
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
        public virtual DbSet<TblProjects> TblProjects { get; set; }
        public virtual DbSet<TblVasets> TblVasets { get; set; }
        public virtual DbSet<TblYears> TblYears { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseSqlServer("Server=.;Database=ProgramBuddb;User Id=sa;Password=Az12345;Trusted_Connection=False;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
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

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
