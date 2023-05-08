namespace NewsWebsite.ViewModels.Api.Taraz
{
    public class TarazKolMoienViewModel
    {
        public string SanadNumber { get; set; }
        public string SanadDate { get; set; }
        public string Code { get; set; }
        public int Levels { get; set; }
        public string Description { get; set; }
        public long Bedehkar { get; set; }
        public long Bestankar { get; set; }
        public long? BalanceBedehkar { get; set; }
        public long? BalanceBestankar { get; set; }
        public int? MarkazHazine { get; set; }
        public string MarkazHazineName { get; set; }
    }
}
