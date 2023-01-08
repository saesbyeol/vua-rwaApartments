using rwaLib.Dal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace Admin
{
    public class Global : HttpApplication
    {

        private readonly IRepo _repo;

        public Global()
        {
            _repo = RepoFactory.GetRepo();
        }

        protected void Application_OnStart(object sender, EventArgs e)
        {
            Application["database"] = _repo;
            RouteConfig.RegisterRoutes(RouteTable.Routes);
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }
    }
}