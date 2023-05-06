using System.ComponentModel.DataAnnotations;

namespace NewsWebsite.ViewModels.Api.GeneralVm
{
    public class BudgetProcessViewModel
    {
        public int Id { get; set; }

        [Display(Name = "نوع بودجه")]
        public string ProcessName { get; set; }
    }
}
