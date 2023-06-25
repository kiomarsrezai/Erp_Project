using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Car
{
    public class CarInsertParamViewModel
    {
        public string Pelak { get; set; }
        public int KindMotorId { get; set; }
        public int? KindId { get; set; }
        public int? SystemId { get; set; }
        public int? TipeId { get; set; }
        public string ProductYear { get; set; }
        public string Color { get; set; }
    }


    public class CarReadViewModel
    {
        public int Id { get; set; }
        public string Pelak { get; set; }
        public int KindMotorId { get; set; }
        public int? KindId { get; set; }
        public string KindName { get; set; }
        public int? SystemId { get; set; }
        public string SystemName { get; set; }
        public int? TipeId { get; set; }
        public string TipeName { get; set; }
        public string ProductYear { get; set; }
        public string Color { get; set; }
    }
}
