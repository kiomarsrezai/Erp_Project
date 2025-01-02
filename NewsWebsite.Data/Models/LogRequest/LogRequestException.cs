using System;

namespace NewsWebsite.Data.Models.LogRequest {
    public class LogRequestException
    {
        public int Id { get; set; }
        public int LogRequestId { get; set; } // Foreign Key to LogRequest
        public string Location { get; set; } // Location in the code (e.g., file, method)
        public string Exception { get; set; } // Exception message
        public string Code { get; set; } // Stack trace or additional info
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow; // Timestamp of the exception
        public LogRequest LogRequest { get; set; } // Navigation property
    }

}