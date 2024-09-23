using System;
using System.Net;

namespace NewsWebsite.Common {
    public class ErrMessageException : Exception {
        public HttpStatusCode StatusCode{ get; }

        public ErrMessageException(string message, HttpStatusCode statusCode) : base(message){
            StatusCode = statusCode;
        }
    }
}