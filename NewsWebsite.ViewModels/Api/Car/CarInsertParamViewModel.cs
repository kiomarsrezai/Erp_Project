﻿using System;
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
}