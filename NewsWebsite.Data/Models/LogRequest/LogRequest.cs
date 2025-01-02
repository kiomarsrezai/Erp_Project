using System;
using System.Collections.Generic;

namespace NewsWebsite.Data.Models.LogRequest {
    public class LogRequest
    {
        public int Id { get; set; }
        public string Url { get; set; }
        public int Duration { get; set; }
        public string Headers { get; set; } // Consider serializing headers to a string (e.g., JSON format)
        public string Payloads { get; set; } // Serialize the request body as a string if needed
        public string RequestType { get; set; } // GET, POST, etc.
        public int ResponseStatusCode { get; set; }
        public string Response { get; set; } // Serialize response if needed
        public string Ip { get; set; } // IP address of the client
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow; // Timestamp of the request
        
        
        // Navigation properties
        public ICollection<LogRequestQuery> Queries { get; set; } = new List<LogRequestQuery>();
        public ICollection<LogRequestException> Exceptions { get; set; } = new List<LogRequestException>();

    }

}