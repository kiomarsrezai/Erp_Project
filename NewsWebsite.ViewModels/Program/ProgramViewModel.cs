using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace NewsWebsite.ViewModels.Program
{
    public class ProgramViewModel
    {
        public int Id { get; set; }

        public string ProgramName { get; set; }
    }
}
