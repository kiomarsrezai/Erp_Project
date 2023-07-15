using NewsWebsite.Data.Models;

namespace NewsWebsite.Areas.Api.Controllers.v1
{
    public class BudgetInlineModalViewModel
    {
        public int Id { get; set; }
        public string ProjectCode { get; set; }
        public string ProjectName { get; set; }
    }

    public class Param16ViewModel
    {
        public int YearId { get; set; }
        public int AreaId { get; set; }
    }


}
