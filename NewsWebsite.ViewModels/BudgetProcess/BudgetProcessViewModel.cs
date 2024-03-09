using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace NewsWebsite.ViewModels.BudgetProcess
{
    public class BudgetProcessViewModel
    {
        [JsonPropertyName("Id")]
        public int Id { get; set; }

        [Display(Name ="عنوان نوع بودجه"), JsonPropertyName("نوع بودجه")]
        [Required(ErrorMessage ="وارد نمودن {0} الزامی است.")]
        public string ProcessName { get; set; }
        
    }
}
