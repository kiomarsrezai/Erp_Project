using AutoMapper;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Data.Contracts;
using NewsWebsite.Data.Models;
using NewsWebsite.Data.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace NewsWebsite.Data.UnitOfWork
{
    public class UnitOfWork : IUnitOfWork
    {
        ProgramBuddbContext _budgetcontext = new ProgramBuddbContext();
        public NewsDBContext _Context { get; }
        private IMapper _mapper;
        private ICategoryRepository _categoryRepository;
        private ITagRepository _tagRepository;
        private IVideoRepository _videoRepository;
        private INewsRepository _newsRepository;
        private INewsletterRepository _newsletterRepository;
        private ICommentRepository _commentRepository;
        private IBudget_001Rep _budget_001Rep;
        private IVasetRepository _vasetRepository;
        private IProjectRepository _projectRepository;
        private IDeputyRepository _deputyRepository;
        private readonly IConfiguration _configuration;

        public UnitOfWork(NewsDBContext context, IMapper mapper, IConfiguration configuration)
        {
            _Context = context;
            _mapper = mapper;
            _configuration = configuration;
        }

        public IBaseRepository<TEntity> BaseRepository<TEntity>() where TEntity : class
        {
            IBaseRepository<TEntity> repository = new BaseRepository<TEntity,NewsDBContext>(_Context);
            return repository;
        }

        public ICategoryRepository CategoryRepository
        {
            get
            {
                if (_categoryRepository == null)
                    _categoryRepository = new CategoryRepository(_Context,_mapper);

                return _categoryRepository;
            }
        }

        public ITagRepository TagRepository
        {
            get
            {
                if (_tagRepository == null)
                    _tagRepository = new TagRepository(_Context);

                return _tagRepository;
            }
        }


        public IVideoRepository VideoRepository
        {
            get
            {
                if (_videoRepository == null)
                    _videoRepository = new VideoRepository(_Context);

                return _videoRepository;
            }
        }

        public INewsRepository NewsRepository
        {
            get
            {
                if (_newsRepository == null)
                    _newsRepository = new NewsRepository(_Context, _mapper,_configuration,this);

                return _newsRepository;
            }
        }

        public INewsletterRepository NewsletterRepository
        {
            get
            {
                if (_newsletterRepository == null)
                    _newsletterRepository = new NewsletterRepository(_Context);

                return _newsletterRepository;
            }
        }

        public ICommentRepository CommentRepository
        {
            get
            {
                if (_commentRepository == null)
                    _commentRepository = new CommentRepository(_Context);

                return _commentRepository;
            }
        }

        public IBudget_001Rep Budget_001Rep
        {
            get
            {
                if (_budget_001Rep == null)
                    _budget_001Rep = new Budget_001Rep(_budgetcontext);

                return _budget_001Rep;
            }
        }

        public IVasetRepository VasetRepository
        {
            get
            {
                if (_vasetRepository == null)
                    _vasetRepository = new VasetRepostory(_budgetcontext);
                return _vasetRepository;
            }
        
        }
        public IProjectRepository ProjectRepository
        {
            get
            {
                if (_projectRepository == null)
                    _projectRepository = new ProjectRepostory(_budgetcontext);
                return _projectRepository;
            }
        
        }
         public IDeputyRepository DeputyRepository
        {
            get
            {
                if (_deputyRepository == null)
                    _deputyRepository = new DeputyRepository(this);
                return _deputyRepository;
            }
        
        }

        public async Task Commit()
        {
            await _Context.SaveChangesAsync();
        }
    }
}
