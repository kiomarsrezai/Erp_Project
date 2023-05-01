using Microsoft.AspNetCore.Http;
using NewsWebsite.Entities.identity;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace NewsWebsite.ViewModels.UserManager
{
    public class UsersViewModel
    {
        public int? Id { get; set; }

        public int Row { get; set; }

        [Display(Name = "تصویر پروفایل")]
        public string Image { get; set; }

        [JsonIgnore,Display(Name ="تصویر پروفایل")]
        public IFormFile ImageFile { get; set; }


        [Required(ErrorMessage ="وارد نمودن {0} الزامی است.")]
        [Display(Name="نام کاربری")]
        public string UserName { get; set; }
        
        [Display(Name ="ایمیل")]
        public string Email { get; set; }

        [Required(ErrorMessage = "وارد نمودن {0} الزامی است.")]
        [StringLength(100, ErrorMessage = "{0} باید دارای حداقل {2} کاراکتر و حداکثر دارای {1} کاراکتر باشد.", MinimumLength = 6)]
        [DataType(DataType.Password), Display(Name = "کلمه عبور"),JsonIgnore]
        public string Password { get; set; }

        [Display(Name = "شماره موبایل")]
        public string PhoneNumber { get; set; }

        [Display(Name = "نام")]
        [Required(ErrorMessage = "وارد نمودن {0} الزامی است.")]
        public string FirstName { get; set; }

        [Display(Name = "نام خانوادگی")]
        [Required(ErrorMessage = "وارد نمودن {0} الزامی است.")]
        public string LastName { get; set; }

        [Display(Name = "تاریخ تولد"),JsonIgnore()]
        public DateTime? BirthDate { get; set; }

        [Display(Name = "تاریخ تولد")]
        public string PersianBirthDate { get; set; }
        public byte[] passStoredSalt { get; set; }
        public byte[] passStoredHash { get; set; }
        
        [Display(Name = "تاریخ عضویت"),JsonIgnore]
        public DateTime? RegisterDateTime { get; set; }

        [Display(Name = "تاریخ عضویت")]
        public string PersianRegisterDateTime { get; set; }

        [Display(Name = "فعال / غیرفعال")]
        public bool IsActive { get; set; }

        [Display(Name = "جنسیت"),JsonIgnore]
        public GenderType? Gender { get; set; }

        public string GenderName { get; set; }

        public string Lisence { get; set; }

        [JsonIgnore] 
        public string Token { get; set; }

        [Display(Name = "سمت")]
        public string Bio { get; set; }

        [JsonIgnore]
        public ICollection<UserRole> Roles { get; set; }

        [JsonIgnore,Display(Name ="نقش")]
        [Required(ErrorMessage = "انتخاب {0} الزامی است.")]
        public int? RoleId { get; set; }
        
        [JsonIgnore, Display(Name = "منطقه")]
        public int? SectionId { get; set; }

        public string RoleName { get; set; }

        [JsonIgnore]
        public bool PhoneNumberConfirmed { get; set; }

        [JsonIgnore]
        public bool TwoFactorEnabled { get; set; }

        [JsonIgnore]
        public bool LockoutEnabled { get; set; }

        [JsonIgnore]
        public bool EmailConfirmed { get; set; }

        [JsonIgnore]
        public int AccessFailedCount { get; set; }

        [JsonIgnore]
        public DateTimeOffset? LockoutEnd { get; set; }
    }
}
