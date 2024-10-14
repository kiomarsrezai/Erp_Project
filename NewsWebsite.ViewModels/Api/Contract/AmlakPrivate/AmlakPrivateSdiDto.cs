using System;
using System.Collections.Generic;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakPrivate {
    public class SdiDto {
        public string Type{ get; set; }
        public int TotalFeatures{ get; set; }
        public List<Feature> Features{ get; set; }
        public Crs Crs{ get; set; }
    }

    public class Feature {
        public string Type{ get; set; }
        public string Id{ get; set; }
        public Geometry? Geometry{ get; set; }
        public string GeometryName{ get; set; }
        public Properties Properties{ get; set; }
    }

    public class Geometry {
        public string Type{ get; set; }
        public List<List<List<double>>> Coordinates{ get; set; }
    }

    public class Properties {
        public int Fid1{ get; set; }
        public string Pelaksabti{ get; set; }
        public string Mantaqe{ get; set; }
        public string GisCode{ get; set; }
        public string CreatedUser{ get; set; }
        public DateTime CreatedDate{ get; set; }
        public string LastEditedUser{ get; set; }
        public DateTime LastEditedDate{ get; set; }
        public string Name{ get; set; }
        public string Address{ get; set; }
    }

    public class Crs {
        public string Type{ get; set; }
        public CrsProperties Properties{ get; set; }
    }

    public class CrsProperties {
        public string Name{ get; set; }
    }
}