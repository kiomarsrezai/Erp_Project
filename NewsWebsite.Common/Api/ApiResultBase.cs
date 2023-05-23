using Newtonsoft.Json;
using System.Collections.Generic;

namespace NewsWebsite.Common.Api
{
    public abstract class ApiResultBase
    {
        public abstract bool Isdb { get; set; }
        public bool IsSuccess { get; set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public List<string> Message { get; set; }
        public ApiResultStatusCode StatusCode { get; set; }
    }
}