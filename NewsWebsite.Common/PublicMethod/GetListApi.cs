using Microsoft.AspNetCore.Identity;
using System;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Net.Mime;
using System.Text;
using System.Threading.Tasks;


namespace NewsWebsite.Common.PublicMethod
{
    public class GetListApi
    {
        public async Task<string> GetApiList(string apiUrl)
        {
            var myUrl = new Uri(apiUrl);
            var apiRequestCreator = WebRequest.Create(myUrl);
            var httpWebRequest = (HttpWebRequest)apiRequestCreator;

            //httpWebRequest.Headers.Add("Authorization", "Bearer " + token);
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

        public class logintosdi
        {
            public string username { get; set; }
            public string password { get; set; }
            public string appId { get; set; }

        }

        public async Task<string> GetLoginApiSdiWithParam(string apiUrl, logintosdi request)
        {
            using (HttpClient client = new HttpClient())
            {
                var jsonBody = Newtonsoft.Json.JsonConvert.SerializeObject(request);
                var requestGet = new HttpRequestMessage
                {
                    Method = HttpMethod.Get,
                    RequestUri = new Uri(apiUrl),
                    Content = new StringContent(jsonBody, Encoding.UTF8, mediaType: MediaTypeNames.Application.Json)
                };
                
                //requestGet.Headers.Add("Authorization", "Bearer " + token);

                var response = await client.SendAsync(requestGet).ConfigureAwait(false);
                var responseString = await response.Content.ReadAsStringAsync().ConfigureAwait(false);
                return responseString.ToString();
            }
        }

    }
}