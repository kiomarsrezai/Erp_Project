using System;
using System.IO;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace NewsWebsite.Common.PublicMethod
{
    public class GetListApi
    {
        public async Task<string> GetApiList(string apiUrl, string token)
        {
            var myUrl = new Uri(apiUrl);
            var apiRequestCreator = WebRequest.Create(myUrl);
            var httpWebRequest = (HttpWebRequest)apiRequestCreator;

            httpWebRequest.Headers.Add("Authorization", "Bearer " + token);
            httpWebRequest.Accept = "application/json";

            //try
            //{
            var WebResponse = httpWebRequest.GetResponse();
            var responseStream = WebResponse.GetResponseStream();

            if (responseStream == null) return null;

            var StreamReader = new StreamReader(responseStream, Encoding.Default);
            var json = StreamReader.ReadToEnd();

            WebResponse.Close();
            responseStream.Close();

            return json;
            //}
            //catch (Exception)
            //{

            //    throw;
            //}
        }


    }
}