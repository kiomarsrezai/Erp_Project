﻿using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using NewsWebsite.Entities.identity;
using NewsWebsite.Services.Contracts;
using NewsWebsite.ViewModels.UserManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using System.IO;
using NewsWebsite.Common;
using AutoMapper;
using System.Linq.Dynamic.Core;
using NewsWebsite.Data;
using NewsWebsite.Entities;

namespace NewsWebsite.Services.Identity
{
    public class ApplicationUserManager : UserManager<User>, IApplicationUserManager
    {
        private readonly ApplicationIdentityErrorDescriber _errors;
        private readonly ILookupNormalizer _keyNormalizer;
        private readonly ILogger<ApplicationUserManager> _logger;
        private readonly IOptions<IdentityOptions> _options;
        private readonly IPasswordHasher<User> _passwordHasher;
        private readonly IEnumerable<IPasswordValidator<User>> _passwordValidators;
        private readonly IServiceProvider _services;
        private readonly IUserStore<User> _userStore;
        private readonly IEnumerable<IUserValidator<User>> _userValidators;
        private readonly IMapper _mapper;
        private readonly ProgramBuddbContext _context;

        public ApplicationUserManager(
            ApplicationIdentityErrorDescriber errors,
            ILookupNormalizer keyNormalizer,
            ILogger<ApplicationUserManager> logger,
            IOptions<IdentityOptions> options,
            IPasswordHasher<User> passwordHasher,
            IEnumerable<IPasswordValidator<User>> passwordValidators,
            IServiceProvider services,
            IUserStore<User> userStore,
            IEnumerable<IUserValidator<User>> userValidators,
            IMapper mapper)
            : base(userStore, options, passwordHasher, userValidators, passwordValidators, keyNormalizer, errors, services, logger)
        {
            _userStore = userStore;
            _errors = errors;
            _logger = logger;
            _services = services;
            _passwordHasher = passwordHasher;
            _userValidators = userValidators;
            _options = options;
            _keyNormalizer = keyNormalizer;
            _passwordValidators = passwordValidators;
            _mapper = mapper;
        }

        public async Task<List<User>> GetAllUsersAsync()
        {
            return await Users.ToListAsync();
        }

        public async Task<List<UsersViewModel>> GetAllUsersWithRolesAsync()
        {
            return await Users.Select(user => new UsersViewModel
            {
                Id = user.Id,
                Email = user.Email,
                UserName = user.UserName,
                PhoneNumber = user.PhoneNumber,
                FirstName = user.FirstName,
                LastName = user.LastName,
                BirthDate = user.BirthDate,
                IsActive = user.IsActive,
                Image = user.Image,
                RegisterDateTime = user.RegisterDateTime,
                Roles = user.Roles,

            }).ToListAsync();
        }

        public async Task<UsersViewModel> FindUserWithRolesByIdAsync(int UserId)
        {
            return await Users.Where(u => u.Id == UserId).Select(user => new UsersViewModel
            {
                Id = user.Id,
                Email = user.Email,
                UserName = user.UserName,
                PhoneNumber = user.PhoneNumber,
                FirstName = user.FirstName,
                LastName = user.LastName,
                IsActive = user.IsActive,
                Image = user.Image,
                RegisterDateTime = user.RegisterDateTime,
                RoleName = user.Roles.First().Role.Name,
                AccessFailedCount = user.AccessFailedCount,
                EmailConfirmed = user.EmailConfirmed,
                LockoutEnabled = user.LockoutEnabled,
                LockoutEnd = user.LockoutEnd,
                PhoneNumberConfirmed = user.PhoneNumberConfirmed,
                SectionId = user.SectionId,
                TwoFactorEnabled = user.TwoFactorEnabled,
                Gender = user.Gender,
                Lisence=user.Lisence,
                AmlakLisence=user.AmlakLisence,
                Token=user.Token
            }).FirstOrDefaultAsync();
        }

        public async Task<string> GetFullName(ClaimsPrincipal User)
        {
            var UserInfo = await GetUserAsync(User);
            return UserInfo.FirstName + " " + UserInfo.LastName;
        }

        public User FindByName(string userName)
        {
            return Users.FirstOrDefault(u => u.UserName == userName);
        } 
        
        public int FindSectionIdByName(string userName)
        {
            return Users.FirstOrDefault(u => u.UserName == userName).SectionId;
        }
        public async Task<List<UsersViewModel>> GetPaginateUsersAsync(int offset, int limit,string searchText)
        {
            var users = await Users.Include(u => u.Roles).Include(l => l.Section)
                  .Where(t => t.FirstName.Contains(searchText) || t.LastName.Contains(searchText) || t.Email.Contains(searchText) || t.UserName.Contains(searchText))
                  .Skip(offset).Take(limit)
                  .Select(user => new UsersViewModel
                  {
                      Id = user.Id,
                      Email = user.Email,
                      UserName = user.UserName,
                      PhoneNumber = user.PhoneNumber,
                      FirstName = user.FirstName,
                      LastName = user.LastName,
                      IsActive = user.IsActive,
                      Image = user.Image,
                      SectionId = user.SectionId,
                      SectionName = _context.Sections.FirstOrDefault(a=>a.SectionId== user.SectionId).Name,
                      PersianBirthDate = user.BirthDate.ConvertMiladiToShamsi("yyyy/MM/dd"),
                      PersianRegisterDateTime = user.RegisterDateTime.ConvertMiladiToShamsi("yyyy/MM/dd ساعت HH:mm:ss"),
                      GenderName = user.Gender == GenderType.Male ? "مرد" : "زن",
                      RoleId = user.Roles.Select(r => r.Role.Id).FirstOrDefault(),
                      RoleName = user.Roles.Select(r => r.Role.Name).FirstOrDefault()
                  }).AsNoTracking().ToListAsync();

            foreach (var item in users)
                item.Row = ++offset;

            return users;
        }


        public string CheckAvatarFileName(string fileName)
        {
            string fileExtension = Path.GetExtension(fileName);
            int fileNameCount = Users.Where(f => f.Image == fileName).Count();
            int j = 1;
            while (fileNameCount != 0)
            {
                fileName = fileName.Replace(fileExtension, "") + j + fileExtension;
                fileNameCount = Users.Where(f => f.Image == fileName).Count();
                j++;
            }

            return fileName;
        }

        public Task<User> FindClaimsInUser(int userId)
        {
            return Users.Include(c => c.Claims).FirstOrDefaultAsync(c => c.Id == userId);
        }


        public async Task<IdentityResult> AddOrUpdateClaimsAsync(int userId, string userClaimType, IList<string> selectedUserClaimValues)
        {
            var user = await FindClaimsInUser(userId);
            if (user == null)
            {
                return IdentityResult.Failed(new IdentityError
                {
                    Code = "NotFound",
                    Description = "کاربر مورد نظر یافت نشد.",
                });
            }

            var CurrentUserClaimValues = user.Claims.Where(r => r.ClaimType == userClaimType).Select(r => r.ClaimValue).ToList();
            if (selectedUserClaimValues == null)
                selectedUserClaimValues = new List<string>();

            var newClaimValuesToAdd = selectedUserClaimValues.Except(CurrentUserClaimValues).ToList();
            foreach (var claim in newClaimValuesToAdd)
            {
                user.Claims.Add(new UserClaim
                {
                    UserId = userId,
                    ClaimType = userClaimType,
                    ClaimValue = claim,
                });
            }

            var removedClaimValues = CurrentUserClaimValues.Except(selectedUserClaimValues).ToList();
            foreach (var claim in removedClaimValues)
            {
                var roleClaim = user.Claims.SingleOrDefault(r => r.ClaimValue == claim && r.ClaimType == userClaimType);
                if (roleClaim != null)
                    user.Claims.Remove(roleClaim);
            }

            return await UpdateAsync(user);
        }

        //public User Authenticate(string username, string password)
        //{
        //    if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
        //        return null;

        //    var user = _context.Users.SingleOrDefault(x => x.UserName == username);

        //    // check if username exists
        //    if (user == null)
        //        return null;

        //    // check if password is correct
        //    if (!VerifyPasswordHash(password, user.passStoredHash, user.passStoredSalt))
        //        return null;

        //    // authentication successful
        //    return user;
        //}

        public IEnumerable<User> GetAll()
        {
            return _context.Users;
        }

        public User GetById(int id)
        {
            return _context.Users.Find(id);
        }

        //public User Create(User user, string password)
        //{
        //    // validation
        //    if (string.IsNullOrWhiteSpace(password))
        //        throw new Exception("Password is required");

        //    if (_context.Users.Any(x => x.UserName == user.UserName))
        //        throw new Exception("Username \"" + user.UserName + "\" is already taken");

        //    byte[] passwordHash, passwordSalt;
        //    CreatePasswordHash(password, out passwordHash, out passwordSalt);

        //    user.passStoredHash = passwordHash;
        //    user.passStoredSalt = passwordSalt;

        //    _context.Users.Add(user);
        //    _context.SaveChanges();

        //    return user;
        //}

        //public void Update(User userParam, string password = null)
        //{
        //    var user = _context.Users.Find(userParam.Id);

        //    if (user == null)
        //        throw new Exception("User not found");

        //    // update username if it has changed
        //    if (!string.IsNullOrWhiteSpace(userParam.UserName) && userParam.UserName != user.UserName)
        //    {
        //        // throw error if the new username is already taken
        //        if (_context.Users.Any(x => x.UserName == userParam.UserName))
        //            throw new Exception("Username " + userParam.UserName + " is already taken");

        //        user.UserName = userParam.UserName;
        //    }

        //    // update user properties if provided
        //    if (!string.IsNullOrWhiteSpace(userParam.FirstName))
        //        user.FirstName = userParam.FirstName;

        //    if (!string.IsNullOrWhiteSpace(userParam.LastName))
        //        user.LastName = userParam.LastName;

        //    // update password if provided
        //    if (!string.IsNullOrWhiteSpace(password))
        //    {
        //        byte[] passwordHash, passwordSalt;
        //        CreatePasswordHash(password, out passwordHash, out passwordSalt);

        //        user.passStoredHash = passwordHash;
        //        user.passStoredSalt = passwordSalt;
        //    }

        //    _context.Users.Update(user);
        //    _context.SaveChanges();
        //}

        public void Delete(int id)
        {
            var user = _context.Users.Find(id);
            if (user != null)
            {
                _context.Users.Remove(user);
                _context.SaveChanges();
            }
        }

        // private helper methods

        public void CreatePasswordHash(string password, out byte[] passwordHash, out byte[] passwordSalt)
        {
            if (password == null) throw new ArgumentNullException("password");
            if (string.IsNullOrWhiteSpace(password)) throw new ArgumentException("Value cannot be empty or whitespace only string.", "password");

            using (var hmac = new System.Security.Cryptography.HMACSHA512())
            {
                passwordSalt = hmac.Key;
                passwordHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
            }
        }

        public bool VerifyPasswordHash(string password, byte[] storedHash, byte[] storedSalt)
        {
            if (password == null) throw new ArgumentNullException("password");
            if (string.IsNullOrWhiteSpace(password)) throw new Exception("از قرارداد فضای خالی بین رمز عبور خودداری نمایید");

            using (var hmac = new System.Security.Cryptography.HMACSHA512(storedSalt))
            {
                var computedHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
                for (int i = 0; i < computedHash.Length; i++)
                {
                    if (computedHash[i] != storedHash[i]) return false;
                }
            }

            return true;
        }

    }
}
