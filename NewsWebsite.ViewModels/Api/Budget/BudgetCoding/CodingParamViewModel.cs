using System.ComponentModel.DataAnnotations;

namespace NewsWebsite.ViewModels.Api.Budget.BudgetCoding
{
    public class CodingParamViewModel
    {
        public int? MotherId { get; set; }

        public int BudgetProcessId { get; set; }
    }
}
