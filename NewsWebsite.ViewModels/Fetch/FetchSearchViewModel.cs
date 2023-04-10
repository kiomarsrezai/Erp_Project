using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace NewsWebsite.ViewModels.Fetch
{
    public class FetchSearchViewModel
    {
        public int YearId { get; set; }

        public int AreaId { get; set; }

        public int BudgetProcessId { get; set; }

    }
}
