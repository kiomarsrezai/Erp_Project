using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace NewsWebsite.Data.Contracts
{
    public interface IUnitOfWork
    {
        IBaseRepository<TEntity> BaseRepository<TEntity>() where TEntity : class;
        ICategoryRepository CategoryRepository { get; }
        ITagRepository TagRepository { get; }
        IVideoRepository VideoRepository { get; }
        INewsRepository NewsRepository { get; }
        INewsletterRepository NewsletterRepository { get; }
        ICommentRepository CommentRepository { get; }
        IBudget_001Rep Budget_001Rep { get; }
        IDeputyRepository DeputyRepository{ get; }
        IVasetRepository VasetRepository { get; }
        NewsDBContext _Context { get; }
        Task Commit();
    }
}
