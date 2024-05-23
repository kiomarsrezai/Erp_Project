using NewsWebsite.ViewModels.Api.Contract;
using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Contract
{

    public class Crs
    {
        public string type { get; set; }
        public Properties properties { get; set; }
    }

    public class Feature
    {
        public string type { get; set; }
        public string id { get; set; }
        public Geometry geometry { get; set; }
        public string geometry_name { get; set; }
        public Properties properties { get; set; }
    }

    public class Geometry
    {
        public string type { get; set; }
        public List<List<double>> coordinates { get; set; }
    }

    public class Properties
    {
        public int radif { get; set; }
        public string vaziat { get; set; }
        public double x_utm { get; set; }
        public double y_utm { get; set; }
        public int code { get; set; }
        public string adress { get; set; }
        public string name { get; set; }
        public string sazeh_rang { get; set; }
        public string agreement { get; set; }
        public string size { get; set; }
        public int mantaqe { get; set; }
        public int radif_1 { get; set; }
        public object agreement_ { get; set; }
        public object agreement1 { get; set; }
        public string مبلغ { get; set; }
}

public class ResponseLayerDto
    {
    public string type { get; set; }
    public int totalFeatures { get; set; }
    public List<Feature> features { get; set; }
    public Crs crs { get; set; }
}

public class ResponseLoginSdiDto
    {
        public string api_key { get; set; }
        public string password_change { get; set; }
        public bool success { get; set; }
        public List<string> user_all_permission { get; set; }
        public string user_id { get; set; }
        public string user_name { get; set; }
        public string username { get; set; }
    }

    public class coordinate
    {
        public double latitude { get; set; }
        public double longitude { get; set; }
    }

}
