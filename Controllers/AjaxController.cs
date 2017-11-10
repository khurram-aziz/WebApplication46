using Newtonsoft.Json.Serialization;
using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
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

        [HttpPost]
        public HttpResponseMessage Signup(UserModel user)
        {
            if (this.ModelState.IsValid)
            {
                return new HttpResponseMessage(HttpStatusCode.OK);
            }
            else
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }
        }
    }
}
