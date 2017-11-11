using Newtonsoft.Json.Serialization;
using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Linq;
using WebApplication.Models;

namespace WebApplication.Controllers
{
    public class AjaxController : ApiController, IDisposable
    {
        IContractResolver _resolver;

        public AjaxController()
        {
            var formatter = GlobalConfiguration.Configuration.Formatters.JsonFormatter;
            _resolver = formatter.SerializerSettings.ContractResolver;
            formatter.SerializerSettings.ContractResolver = new CamelCasePropertyNamesContractResolver();
        }

        void IDisposable.Dispose()
        {
            var formatter = GlobalConfiguration.Configuration.Formatters.JsonFormatter;
            formatter.SerializerSettings.ContractResolver = _resolver;
        }

        [HttpGet]
        public HttpResponseMessage States()
        {
            var list = new List<string>();
            list.Add("Balochistan");
            list.Add("Gilgat Baltistan");
            list.Add("KPK");
            list.Add("Punjab");
            list.Add("Sindh");
            return this.Request.CreateResponse(HttpStatusCode.OK, list.ToArray());
        }

        class City
        {
            public int PostalCode { get; set; }
            public string Name { get; set; }
        }

        [HttpGet]
        public HttpResponseMessage Cities(string state)
        {
            var list = new List<City>();
            list.Add(new City() { PostalCode = 1, Name = string.Format("{0} / City 1", state) });
            list.Add(new City() { PostalCode = 2, Name = string.Format("{0} / City 2", state) });
            list.Add(new City() { PostalCode = 3, Name = string.Format("{0} / City 3", state) });

            return this.Request.CreateResponse(HttpStatusCode.OK, new
            {
                cities = list.Select(o => new
                {
                    id = o.PostalCode, city = o.Name
                })
            });
        }



        [HttpPost]
        public HttpResponseMessage Signup(UserModel user)
        {
            if (this.ModelState.IsValid)
            {
                return new HttpResponseMessage(HttpStatusCode.OK);
            }
            else
            {
                return this.Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }
        }
    }
}
