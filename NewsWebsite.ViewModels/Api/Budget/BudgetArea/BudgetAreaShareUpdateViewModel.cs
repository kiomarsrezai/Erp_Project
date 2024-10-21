using System;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace NewsWebsite.ViewModels.Api.Budget.BudgetArea
{
    public class BudgetAreaShareUpdateViewModel
    {
        public int Id { get; set; }

        public long ShareProcessId1 { get; set; }
        public long ShareProcessId2 { get; set; }
        public long ShareProcessId3 { get; set; }
        public long ShareProcessId4 { get; set; }
    }



}
