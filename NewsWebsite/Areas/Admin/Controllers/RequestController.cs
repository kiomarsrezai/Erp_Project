using Microsoft.AspNetCore.Mvc;

namespace NewsWebsite.Areas.Admin.Controllers
{
    public class RequestController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

    }
}
