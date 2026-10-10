using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;

namespace sabzify
{
    public static class ProductRepository
    {
        private static readonly ConcurrentDictionary<int, Product> Products =
            new ConcurrentDictionary<int, Product>();

        // Id source for AddProduct. Seeded at the end of SeedProducts() so a
        // generated id can never collide with - and overwrite - a seeded product.
        private static int _lastId;

        static ProductRepository()
        {
            SeedProducts();
        }

        private static void SeedProducts()
        {
            var list = new List<Product>
            {
                new Product
                {
                    Id = 1,
                    Name = "Local Tomato",
                    Category = "Vegetables",
                    Price = 35,
                    OldPrice = 42,
                    Unit = "KG",
                    StockQuantity = 80,
                    ImageUrl = "Content/Images/tomato.png",
                    IsOrganic = false,
                    IsSale = true,
                    DiscountPercent = 15,
                    Status = "Active",
                    Popularity = 98,
                    Description = "Locally sourced, farm-fresh red tomatoes from Rajkot farms. Ideal for curries, salads, and everyday cooking."
                },
                new Product
                {
                    Id = 2,
                    Name = "Farm Fresh Carrot",
                    Category = "Root Vegetables",
                    Price = 40,
                    OldPrice = 45,
                    Unit = "KG",
                    StockQuantity = 120,
                    ImageUrl = "Content/Images/carrot.png",
                    IsOrganic = false,
                    IsSale = true,
                    DiscountPercent = 10,
                    Status = "Active",
                    Popularity = 92,
                    Description = "Crunchy and sweet farm-fresh carrots harvested from local farms in Saurashtra."
                },
                new Product
                {
                    Id = 3,
                    Name = "Organic Potato",
                    Category = "Root Vegetables",
                    Price = 35,
                    OldPrice = null,
                    Unit = "KG",
                    StockQuantity = 150,
                    ImageUrl = "Content/Images/potato.jpg",
                    IsOrganic = true,
                    IsSale = false,
                    DiscountPercent = 0,
                    Status = "Active",
                    Popularity = 95,
                    Description = "Naturally grown, pesticide-free organic potatoes with authentic earthy flavor."
                },
                new Product
                {
                    Id = 4,
                    Name = "Fresh Palak",
                    Category = "Leafy Greens",
                    Price = 25,
                    OldPrice = 30,
                    Unit = "GM",
                    StockQuantity = 65,
                    ImageUrl = "Content/Images/palak.jpg",
                    IsOrganic = false,
                    IsSale = true,
                    DiscountPercent = 15,
                    Status = "Active",
                    Popularity = 88,
                    Description = "Freshly harvested green spinach bunches, rich in iron, minerals, and dietary fiber."
                },
                new Product
                {
                    Id = 5,
                    Name = "Cabbage",
                    Category = "Leafy Greens",
                    Price = 55,
                    OldPrice = null,
                    Unit = "KG",
                    StockQuantity = 45,
                    ImageUrl = "Content/Images/cabbage.png",
                    IsOrganic = false,
                    IsSale = false,
                    DiscountPercent = 0,
                    Status = "Active",
                    Popularity = 82,
                    Description = "Crisp and tightly packed fresh green cabbage, perfect for salads, stir fries, and sabzi."
                },
                new Product
                {
                    Id = 6,
                    Name = "Red Onion",
                    Category = "Root Vegetables",
                    Price = 30,
                    OldPrice = null,
                    Unit = "KG",
                    StockQuantity = 200,
                    ImageUrl = "Content/Images/onion.png",
                    IsOrganic = false,
                    IsSale = false,
                    DiscountPercent = 0,
                    Status = "Active",
                    Popularity = 99,
                    Description = "Flavorful, pungent red onions sourced from Bhavnagar and Rajkot farmers."
                },
                new Product
                {
                    Id = 7,
                    Name = "Green Capsicum",
                    Category = "Vegetables",
                    Price = 65,
                    OldPrice = 75,
                    Unit = "KG",
                    StockQuantity = 50,
                    ImageUrl = "Content/Images/capsicum.png",
                    IsOrganic = false,
                    IsSale = true,
                    DiscountPercent = 15,
                    Status = "Active",
                    Popularity = 86,
                    Description = "Fresh, shiny green bell peppers with a crisp crunch and mild sweet taste."
                },
                new Product
                {
                    Id = 8,
                    Name = "Bottle Gourd (Lauki)",
                    Category = "Marrows",
                    Price = 30,
                    OldPrice = 35,
                    Unit = "KG",
                    StockQuantity = 40,
                    ImageUrl = "Content/Images/lauki.jpg",
                    IsOrganic = false,
                    IsSale = false,
                    DiscountPercent = 0,
                    Status = "Active",
                    Popularity = 84,
                    Description = "Tender and light bottle gourd, excellent for soups, healthy juicing, and light curries."
                },
                new Product
                {
                    Id = 9,
                    Name = "Bitter Gourd (Karela)",
                    Category = "Marrows",
                    Price = 45,
                    OldPrice = 50,
                    Unit = "KG",
                    StockQuantity = 35,
                    ImageUrl = "Content/Images/karela.jpg",
                    IsOrganic = true,
                    IsSale = true,
                    DiscountPercent = 10,
                    Status = "Active",
                    Popularity = 78,
                    Description = "Farm-fresh bitter gourd, known for rich antioxidants and natural blood purifying benefits."
                },
                new Product
                {
                    Id = 10,
                    Name = "Fresh Cucumber",
                    Category = "Marrows",
                    Price = 30,
                    OldPrice = null,
                    Unit = "KG",
                    StockQuantity = 90,
                    ImageUrl = "Content/Images/cucumber.jpg",
                    IsOrganic = false,
                    IsSale = false,
                    DiscountPercent = 0,
                    Status = "Active",
                    Popularity = 90,
                    Description = "Crisp and hydrating garden cucumbers, freshly picked for refreshing salads."
                },
                new Product
                {
                    Id = 11,
                    Name = "Organic Beetroot",
                    Category = "Root Vegetables",
                    Price = 45,
                    OldPrice = 50,
                    Unit = "KG",
                    StockQuantity = 60,
                    ImageUrl = "Content/Images/beetroot.jpg",
                    IsOrganic = true,
                    IsSale = true,
                    DiscountPercent = 10,
                    Status = "Active",
                    Popularity = 85,
                    Description = "Deep crimson, nutrient-packed organic beetroots rich in nitrates and vitamins."
                },
                new Product
                {
                    Id = 12,
                    Name = "Fresh Coriander",
                    Category = "Leafy Greens",
                    Price = 20,
                    OldPrice = null,
                    Unit = "GM",
                    StockQuantity = 70,
                    ImageUrl = "Content/Images/coriander.jpg",
                    IsOrganic = true,
                    IsSale = false,
                    DiscountPercent = 0,
                    Status = "Active",
                    Popularity = 94,
                    Description = "Aromatic farm-fresh coriander bunches to garnish and elevate every traditional dish."
                },
                new Product
                {
                    Id = 13,
                    Name = "Fresh Ginger",
                    Category = "Root Vegetables",
                    Price = 80,
                    OldPrice = 90,
                    Unit = "KG",
                    StockQuantity = 40,
                    ImageUrl = "Content/Images/ginger.jpg",
                    IsOrganic = true,
                    IsSale = true,
                    DiscountPercent = 10,
                    Status = "Active",
                    Popularity = 89,
                    Description = "Fiery and fragrant fresh ginger root with great medicinal and culinary benefits."
                },
                new Product
                {
                    Id = 14,
                    Name = "Green Chilli",
                    Category = "Vegetables",
                    Price = 50,
                    OldPrice = null,
                    Unit = "KG",
                    StockQuantity = 55,
                    ImageUrl = "Content/Images/chilli.jpg",
                    IsOrganic = false,
                    IsSale = false,
                    DiscountPercent = 0,
                    Status = "Active",
                    Popularity = 91,
                    Description = "Spicy and crisp fresh green chillies picked at optimum pungency."
                },
                new Product
                {
                    Id = 15,
                    Name = "Purple Brinjal",
                    Category = "Vegetables",
                    Price = 40,
                    OldPrice = 45,
                    Unit = "KG",
                    StockQuantity = 60,
                    ImageUrl = "Content/Images/brinjal.jpg",
                    IsOrganic = false,
                    IsSale = false,
                    DiscountPercent = 0,
                    Status = "Active",
                    Popularity = 80,
                    Description = "Glossy deep-purple round brinjals, perfect for traditional Gujarati Ringan no Olo."
                },
                new Product
                {
                    Id = 16,
                    Name = "Green Broccoli",
                    Category = "Vegetables",
                    Price = 75,
                    OldPrice = 85,
                    Unit = "KG",
                    StockQuantity = 30,
                    ImageUrl = "Content/Images/broccoli.jpg",
                    IsOrganic = true,
                    IsSale = true,
                    DiscountPercent = 12,
                    Status = "Active",
                    Popularity = 83,
                    Description = "Exotic, fresh green broccoli florets grown without harmful synthetic pesticides."
                },
                new Product
                {
                    Id = 17,
                    Name = "Organic Spinach",
                    Category = "Leafy Greens",
                    Price = 30,
                    OldPrice = null,
                    Unit = "GM",
                    StockQuantity = 50,
                    ImageUrl = "Content/Images/palak.jpg",
                    IsOrganic = true,
                    IsSale = false,
                    DiscountPercent = 0,
                    Status = "Active",
                    Popularity = 87,
                    Description = "Certified organic spinach grown sustainably by local farmers."
                },
                new Product
                {
                    Id = 18,
                    Name = "Ridge Gourd (Turai)",
                    Category = "Marrows",
                    Price = 40,
                    OldPrice = 48,
                    Unit = "KG",
                    StockQuantity = 35,
                    ImageUrl = "Content/Images/lauki.jpg",
                    IsOrganic = false,
                    IsSale = true,
                    DiscountPercent = 16,
                    Status = "Active",
                    Popularity = 77,
                    Description = "Fresh ridge gourd rich in dietary fiber and essential minerals."
                },
                new Product
                {
                    Id = 19,
                    Name = "Sweet Potato",
                    Category = "Root Vegetables",
                    Price = 50,
                    OldPrice = null,
                    Unit = "KG",
                    StockQuantity = 45,
                    ImageUrl = "Content/Images/potato.jpg",
                    IsOrganic = false,
                    IsSale = false,
                    DiscountPercent = 0,
                    Status = "Active",
                    Popularity = 79,
                    Description = "Naturally sweet, starchy root vegetable perfect for roasting or boiling."
                },
                new Product
                {
                    Id = 20,
                    Name = "Fresh Methi (Fenugreek)",
                    Category = "Leafy Greens",
                    Price = 25,
                    OldPrice = null,
                    Unit = "GM",
                    StockQuantity = 60,
                    ImageUrl = "Content/Images/coriander.jpg",
                    IsOrganic = true,
                    IsSale = false,
                    DiscountPercent = 0,
                    Status = "Active",
                    Popularity = 86,
                    Description = "Fragrant fresh fenugreek greens, essential for healthy parathas and theplas."
                },
                new Product
                {
                    Id = 21,
                    Name = "Snake Gourd",
                    Category = "Marrows",
                    Price = 35,
                    OldPrice = null,
                    Unit = "KG",
                    StockQuantity = 25,
                    ImageUrl = "Content/Images/lauki.jpg",
                    IsOrganic = false,
                    IsSale = false,
                    DiscountPercent = 0,
                    Status = "Active",
                    Popularity = 72,
                    Description = "Delicate and mild green snake gourd with high moisture content."
                },
                new Product
                {
                    Id = 22,
                    Name = "White Radish (Mooli)",
                    Category = "Root Vegetables",
                    Price = 30,
                    OldPrice = null,
                    Unit = "KG",
                    StockQuantity = 70,
                    ImageUrl = "Content/Images/carrot.png",
                    IsOrganic = true,
                    IsSale = false,
                    DiscountPercent = 0,
                    Status = "Active",
                    Popularity = 81,
                    Description = "Crisp and sharp white daikon radish, fresh from the morning harvest."
                },
                new Product
                {
                    Id = 23,
                    Name = "Fresh Mint Leaves",
                    Category = "Leafy Greens",
                    Price = 15,
                    OldPrice = null,
                    Unit = "GM",
                    StockQuantity = 80,
                    ImageUrl = "Content/Images/coriander.jpg",
                    IsOrganic = false,
                    IsSale = false,
                    DiscountPercent = 0,
                    Status = "Active",
                    Popularity = 93,
                    Description = "Cooling, intensely aromatic mint leaves for refreshing chutneys and drinks."
                },
                new Product
                {
                    Id = 24,
                    Name = "Green Zucchini",
                    Category = "Marrows",
                    Price = 60,
                    OldPrice = 70,
                    Unit = "KG",
                    StockQuantity = 30,
                    ImageUrl = "Content/Images/cucumber.jpg",
                    IsOrganic = true,
                    IsSale = true,
                    DiscountPercent = 14,
                    Status = "Active",
                    Popularity = 79,
                    Description = "Tender young green zucchini with smooth skin and firm texture."
                },
                new Product
                {
                    Id = 25,
                    Name = "Fresh Garlic (Lasun)",
                    Category = "Root Vegetables",
                    Price = 120,
                    OldPrice = null,
                    Unit = "KG",
                    StockQuantity = 50,
                    ImageUrl = "Content/Images/onion.png",
                    IsOrganic = false,
                    IsSale = false,
                    DiscountPercent = 0,
                    Status = "Active",
                    Popularity = 96,
                    Description = "Pungent, high-grade Saurashtra garlic bulbs with full aroma and flavor."
                },
                new Product
                {
                    Id = 26,
                    Name = "Ash Gourd (Petha)",
                    Category = "Marrows",
                    Price = 40,
                    OldPrice = null,
                    Unit = "KG",
                    StockQuantity = 20,
                    ImageUrl = "Content/Images/lauki.jpg",
                    IsOrganic = false,
                    IsSale = false,
                    DiscountPercent = 0,
                    Status = "Active",
                    Popularity = 75,
                    Description = "Rejuvenating, cool ash gourd praised in traditional Ayurvedic cooking."
                },
                new Product
                {
                    Id = 27,
                    Name = "Spring Onion",
                    Category = "Leafy Greens",
                    Price = 30,
                    OldPrice = null,
                    Unit = "GM",
                    StockQuantity = 45,
                    ImageUrl = "Content/Images/onion.png",
                    IsOrganic = false,
                    IsSale = false,
                    DiscountPercent = 0,
                    Status = "Active",
                    Popularity = 84,
                    Description = "Crisp green stems with mild, sweet bulbs, ideal for Indo-Chinese recipes."
                },
                new Product
                {
                    Id = 28,
                    Name = "Baby Potato",
                    Category = "Root Vegetables",
                    Price = 40,
                    OldPrice = null,
                    Unit = "KG",
                    StockQuantity = 80,
                    ImageUrl = "Content/Images/potato.jpg",
                    IsOrganic = true,
                    IsSale = false,
                    DiscountPercent = 0,
                    Status = "Active",
                    Popularity = 85,
                    Description = "Small, tender baby potatoes ideal for Dum Aloo."
                },
                new Product
                {
                    Id = 29,
                    Name = "Ivy Gourd (Tindora)",
                    Category = "Marrows",
                    Price = 50,
                    OldPrice = null,
                    Unit = "KG",
                    StockQuantity = 35,
                    ImageUrl = "Content/Images/cucumber.jpg",
                    IsOrganic = false,
                    IsSale = false,
                    DiscountPercent = 0,
                    Status = "Active",
                    Popularity = 80,
                    Description = "Fresh, crunchy green tindora perfect for everyday dry sabzi."
                },
                new Product
                {
                    Id = 30,
                    Name = "Curry Leaves",
                    Category = "Leafy Greens",
                    Price = 10,
                    OldPrice = null,
                    Unit = "GM",
                    StockQuantity = 90,
                    ImageUrl = "Content/Images/coriander.jpg",
                    IsOrganic = true,
                    IsSale = false,
                    DiscountPercent = 0,
                    Status = "Active",
                    Popularity = 95,
                    Description = "Fresh aromatic curry leaves picked directly from local farms."
                },
                new Product
                {
                    Id = 31,
                    Name = "Red Bell Pepper",
                    Category = "Vegetables",
                    Price = 80,
                    OldPrice = 95,
                    Unit = "KG",
                    StockQuantity = 25,
                    ImageUrl = "Content/Images/capsicum.png",
                    IsOrganic = true,
                    IsSale = true,
                    DiscountPercent = 15,
                    Status = "Active",
                    Popularity = 82,
                    Description = "Sweet, juicy red capsicum loaded with vitamin C."
                },
                new Product
                {
                    Id = 32,
                    Name = "Cherry Tomatoes",
                    Category = "Vegetables",
                    Price = 60,
                    OldPrice = 70,
                    Unit = "KG",
                    StockQuantity = 40,
                    ImageUrl = "Content/Images/tomato.png",
                    IsOrganic = true,
                    IsSale = true,
                    DiscountPercent = 14,
                    Status = "Active",
                    Popularity = 88,
                    Description = "Bite-sized, sweet and tangy hydroponic cherry tomatoes."
                },
                new Product
                {
                    Id = 33,
                    Name = "Organic Palak",
                    Category = "Leafy Greens",
                    Price = 30,
                    OldPrice = 35,
                    Unit = "GM",
                    StockQuantity = 50,
                    ImageUrl = "Content/Images/palak.jpg",
                    IsOrganic = true,
                    IsSale = true,
                    DiscountPercent = 14,
                    Status = "Active",
                    Popularity = 86,
                    Description = "Certified organic palak grown without synthetic pesticides."
                },
                new Product
                {
                    Id = 34,
                    Name = "Sweet Potato",
                    Category = "Root Vegetables",
                    Price = 45,
                    OldPrice = 50,
                    Unit = "KG",
                    StockQuantity = 70,
                    ImageUrl = "Content/Images/potato.jpg",
                    IsOrganic = true,
                    IsSale = false,
                    DiscountPercent = 0,
                    Status = "Active",
                    Popularity = 84,
                    Description = "Naturally sweet and fibrous root vegetables rich in beta carotene."
                },
                new Product
                {
                    Id = 35,
                    Name = "Ridge Gourd (Turai)",
                    Category = "Marrows",
                    Price = 35,
                    OldPrice = null,
                    Unit = "KG",
                    StockQuantity = 60,
                    ImageUrl = "Content/Images/lauki.jpg",
                    IsOrganic = false,
                    IsSale = false,
                    DiscountPercent = 0,
                    Status = "Active",
                    Popularity = 82,
                    Description = "Tender ridged gourds perfect for authentic Gujarati dishes."
                },
                new Product
                {
                    Id = 36,
                    Name = "Desi Karela",
                    Category = "Marrows",
                    Price = 38,
                    OldPrice = 45,
                    Unit = "KG",
                    StockQuantity = 45,
                    ImageUrl = "Content/Images/karela.jpg",
                    IsOrganic = true,
                    IsSale = true,
                    DiscountPercent = 15,
                    Status = "Active",
                    Popularity = 83,
                    Description = "Small, intensely flavored organic desi karela."
                },
                new Product
                {
                    Id = 37,
                    Name = "Baby Corn",
                    Category = "Vegetables",
                    Price = 50,
                    OldPrice = 60,
                    Unit = "GM",
                    StockQuantity = 35,
                    ImageUrl = "Content/Images/corn.jpg",
                    IsOrganic = false,
                    IsSale = true,
                    DiscountPercent = 16,
                    Status = "Active",
                    Popularity = 79,
                    Description = "Crisp, sweet baby corns ideal for stir fries and soups."
                },
                new Product
                {
                    Id = 38,
                    Name = "Fresh Mushroom",
                    Category = "Vegetables",
                    Price = 60,
                    OldPrice = null,
                    Unit = "GM",
                    StockQuantity = 30,
                    ImageUrl = "Content/Images/capsicum.png",
                    IsOrganic = true,
                    IsSale = false,
                    DiscountPercent = 0,
                    Status = "Active",
                    Popularity = 81,
                    Description = "Farm fresh white button mushrooms packed with earthy flavor."
                },
                new Product
                {
                    Id = 39,
                    Name = "Colocasia (Arbi)",
                    Category = "Root Vegetables",
                    Price = 40,
                    OldPrice = null,
                    Unit = "KG",
                    StockQuantity = 55,
                    ImageUrl = "Content/Images/potato.jpg",
                    IsOrganic = false,
                    IsSale = false,
                    DiscountPercent = 0,
                    Status = "Active",
                    Popularity = 78,
                    Description = "Starchy and wholesome arbi roots harvested fresh from Saurashtra."
                },
                new Product
                {
                    Id = 40,
                    Name = "Elephant Yam (Suran)",
                    Category = "Root Vegetables",
                    Price = 45,
                    OldPrice = 50,
                    Unit = "KG",
                    StockQuantity = 40,
                    ImageUrl = "Content/Images/potato.jpg",
                    IsOrganic = false,
                    IsSale = true,
                    DiscountPercent = 10,
                    Status = "Active",
                    Popularity = 77,
                    Description = "Nutritious Jimikand / Suran yam roots cut fresh for cooking."
                },
                new Product
                {
                    Id = 41,
                    Name = "Snake Gourd (Padwal)",
                    Category = "Marrows",
                    Price = 42,
                    OldPrice = null,
                    Unit = "KG",
                    StockQuantity = 35,
                    ImageUrl = "Content/Images/lauki.jpg",
                    IsOrganic = false,
                    IsSale = false,
                    DiscountPercent = 0,
                    Status = "Active",
                    Popularity = 75,
                    Description = "Long and crisp snake gourd filled with cooling hydration."
                },
                new Product
                {
                    Id = 42,
                    Name = "Red Cabbage",
                    Category = "Leafy Greens",
                    Price = 65,
                    OldPrice = 75,
                    Unit = "KG",
                    StockQuantity = 25,
                    ImageUrl = "Content/Images/cabbage.png",
                    IsOrganic = true,
                    IsSale = true,
                    DiscountPercent = 13,
                    Status = "Active",
                    Popularity = 80,
                    Description = "Vibrant organic red cabbage packed with antioxidants."
                },
                new Product
                {
                    Id = 43,
                    Name = "Bok Choy",
                    Category = "Leafy Greens",
                    Price = 55,
                    OldPrice = null,
                    Unit = "GM",
                    StockQuantity = 20,
                    ImageUrl = "Content/Images/palak.jpg",
                    IsOrganic = true,
                    IsSale = false,
                    DiscountPercent = 0,
                    Status = "Active",
                    Popularity = 76,
                    Description = "Crisp, hydroponically grown organic Chinese cabbage greens."
                },
                new Product
                {
                    Id = 44,
                    Name = "Spring Onions",
                    Category = "Leafy Greens",
                    Price = 25,
                    OldPrice = 30,
                    Unit = "GM",
                    StockQuantity = 60,
                    ImageUrl = "Content/Images/coriander.jpg",
                    IsOrganic = false,
                    IsSale = true,
                    DiscountPercent = 16,
                    Status = "Active",
                    Popularity = 85,
                    Description = "Crisp green stalks and mild scallion bulbs."
                },
                new Product
                {
                    Id = 45,
                    Name = "Green Peas (Matar)",
                    Category = "Vegetables",
                    Price = 50,
                    OldPrice = 60,
                    Unit = "KG",
                    StockQuantity = 75,
                    ImageUrl = "Content/Images/capsicum.png",
                    IsOrganic = true,
                    IsSale = true,
                    DiscountPercent = 16,
                    Status = "Active",
                    Popularity = 94,
                    Description = "Sweet, tender and freshly podded green peas."
                },
                new Product
                {
                    Id = 46,
                    Name = "Drumsticks (Saragvo)",
                    Category = "Vegetables",
                    Price = 35,
                    OldPrice = null,
                    Unit = "GM",
                    StockQuantity = 50,
                    ImageUrl = "Content/Images/cucumber.jpg",
                    IsOrganic = false,
                    IsSale = false,
                    DiscountPercent = 0,
                    Status = "Active",
                    Popularity = 87,
                    Description = "Fresh nutrient-dense moringa pods perfect for sambar and dal."
                },
                new Product
                {
                    Id = 47,
                    Name = "Raw Green Banana",
                    Category = "Vegetables",
                    Price = 30,
                    OldPrice = 35,
                    Unit = "KG",
                    StockQuantity = 45,
                    ImageUrl = "Content/Images/cucumber.jpg",
                    IsOrganic = false,
                    IsSale = true,
                    DiscountPercent = 14,
                    Status = "Active",
                    Popularity = 82,
                    Description = "Starchy raw cooking bananas popular in Jain cuisine."
                },
                new Product
                {
                    Id = 48,
                    Name = "Fresh Pudina (Mint)",
                    Category = "Leafy Greens",
                    Price = 15,
                    OldPrice = null,
                    Unit = "GM",
                    StockQuantity = 80,
                    ImageUrl = "Content/Images/coriander.jpg",
                    IsOrganic = true,
                    IsSale = false,
                    DiscountPercent = 0,
                    Status = "Active",
                    Popularity = 90,
                    Description = "Aromatic, refreshing garden-fresh organic spearmint leaves."
                }
            };

            foreach (var p in list)
            {
                Products[p.Id] = p;
            }

            // Start the counter above every seeded id.
            _lastId = Products.Keys.DefaultIfEmpty(0).Max();
        }

        public static List<Product> GetAllProducts()
        {
            return Products.Values.OrderBy(p => p.Id).ToList();
        }

        public static Product GetById(int id)
        {
            return GetProductById(id);
        }

        public static List<Product> GetActiveProducts()
        {
            return Products.Values
                .Where(p => string.Equals(p.Status, "Active", StringComparison.OrdinalIgnoreCase))
                .OrderBy(p => p.Id)
                .ToList();
        }

        public static Product GetProductById(int id)
        {
            Products.TryGetValue(id, out Product product);
            return product;
        }

        public static void UpdateProduct(Product product)
        {
            if (product != null)
            {
                Products[product.Id] = product;
            }
        }

        public static void AddProduct(Product product)
        {
            if (product != null)
            {
                if (product.Id <= 0)
                {
                    product.Id = System.Threading.Interlocked.Increment(ref _lastId);
                }
                Products[product.Id] = product;
            }
        }
    }
}

