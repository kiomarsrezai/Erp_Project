using System;

namespace NewsWebsite.Data.Models.LogRequest {
    public class LogRequestQuery
    {
        public int Id { get; set; }
        public int LogRequestId { get; set; } // Foreign Key to LogRequest
        public string Query { get; set; } // SQL query or LINQ query string
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow; // Timestamp of the query
        public LogRequest LogRequest { get; set; } // Navigation property
    }

}