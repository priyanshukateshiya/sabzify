using System;

namespace sabzify
{
    [Serializable]
    public class Product
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Category { get; set; }
        public decimal Price { get; set; }
        public decimal? OldPrice { get; set; }
        public string Unit { get; set; }
        public int StockQuantity { get; set; }
        public string ImageUrl { get; set; }
        public bool IsOrganic { get; set; }
        public bool IsSale { get; set; }
        public int DiscountPercent { get; set; }
        public string Status { get; set; }
        public int Popularity { get; set; }
        public string Description { get; set; }

        public string Badge
        {
            get
            {
                if (IsSale && DiscountPercent > 0) return "-" + DiscountPercent + "%";
                if (IsOrganic) return "Organic";
                return null;
            }
        }
    }
}
