using System;
using System.Collections.Concurrent;
using System.Collections.Generic;

namespace sabzify
{
    public static class OrderRepository
    {
        private static readonly ConcurrentDictionary<string, Order> Orders =
            new ConcurrentDictionary<string, Order>(StringComparer.OrdinalIgnoreCase);

        static OrderRepository()
        {
            SeedOrders();
        }

        private static void SeedOrders()
        {
            var ord3 = new Order
            {
                OrderId = "ORD003",
                CustomerName = "Pratik Nakum",
                CustomerEmail = "pratik@gmail.com",
                CustomerPhone = "+91 9876543210",
                OrderDate = "Oct 24, 2023",
                Status = "Pending",
                PaymentMethod = "Cash on Delivery (COD)",
                DeliveryAddress = "Near Sanskar Park Society, Rajkot, Gujarat - 360005",
                Subtotal = 1220,
                DeliveryCharge = 40,
                Discount = 20,
                TotalAmount = 1240,
                Items = new List<OrderItem>
                {
                    new OrderItem { ProductName = "Fresh Spinach (Palak)", Quantity = 6, Unit = "GM", Price = 25 },
                    new OrderItem { ProductName = "Farm Fresh Tomatoes", Quantity = 4, Unit = "KG", Price = 35 },
                    new OrderItem { ProductName = "Organic Potato", Quantity = 5, Unit = "KG", Price = 35 },
                    new OrderItem { ProductName = "Fresh Ginger", Quantity = 2, Unit = "KG", Price = 80 },
                    new OrderItem { ProductName = "Green Capsicum", Quantity = 5, Unit = "KG", Price = 65 },
                    new OrderItem { ProductName = "Bottle Gourd (Lauki)", Quantity = 3, Unit = "KG", Price = 30 },
                    new OrderItem { ProductName = "Red Onion", Quantity = 6, Unit = "KG", Price = 30 }
                }
            };
            Orders[ord3.OrderId] = ord3;

            var ord2 = new Order
            {
                OrderId = "ORD002",
                CustomerName = "Pratik Nakum",
                CustomerEmail = "pratik@gmail.com",
                CustomerPhone = "+91 9876543210",
                OrderDate = "Oct 23, 2023",
                Status = "Out for Delivery",
                PaymentMethod = "Cash on Delivery (COD)",
                DeliveryAddress = "Near Sanskar Park Society, Rajkot, Gujarat - 360005",
                Subtotal = 830,
                DeliveryCharge = 30,
                Discount = 10,
                TotalAmount = 850,
                Items = new List<OrderItem>
                {
                    new OrderItem { ProductName = "Farm Fresh Tomatoes", Quantity = 3, Unit = "KG", Price = 35 },
                    new OrderItem { ProductName = "Organic Spinach", Quantity = 4, Unit = "GM", Price = 30 },
                    new OrderItem { ProductName = "Local Potatoes", Quantity = 5, Unit = "KG", Price = 35 },
                    new OrderItem { ProductName = "Red Onion", Quantity = 9, Unit = "KG", Price = 30 },
                    new OrderItem { ProductName = "Fresh Cucumber", Quantity = 4, Unit = "KG", Price = 30 },
                    new OrderItem { ProductName = "Fresh Coriander", Quantity = 2, Unit = "GM", Price = 20 }
                }
            };
            Orders[ord2.OrderId] = ord2;

            var ord1 = new Order
            {
                OrderId = "ORD001",
                CustomerName = "Pratik Nakum",
                CustomerEmail = "pratik@gmail.com",
                CustomerPhone = "+91 9876543210",
                OrderDate = "Oct 20, 2023",
                Status = "Delivered",
                PaymentMethod = "Cash on Delivery (COD)",
                DeliveryAddress = "Near Sanskar Park Society, Rajkot, Gujarat - 360005",
                Subtotal = 2080,
                DeliveryCharge = 50,
                Discount = 30,
                TotalAmount = 2100,
                Items = new List<OrderItem>
                {
                    new OrderItem { ProductName = "Organic Potato", Quantity = 10, Unit = "KG", Price = 35 },
                    new OrderItem { ProductName = "Red Onion", Quantity = 16, Unit = "KG", Price = 30 },
                    new OrderItem { ProductName = "Green Broccoli", Quantity = 4, Unit = "KG", Price = 75 },
                    new OrderItem { ProductName = "Fresh Palak", Quantity = 6, Unit = "GM", Price = 25 },
                    new OrderItem { ProductName = "Farm Fresh Carrot", Quantity = 5, Unit = "KG", Price = 40 },
                    new OrderItem { ProductName = "Bitter Gourd (Karela)", Quantity = 4, Unit = "KG", Price = 45 },
                    new OrderItem { ProductName = "Green Capsicum", Quantity = 4, Unit = "KG", Price = 65 },
                    new OrderItem { ProductName = "Fresh Ginger", Quantity = 2, Unit = "KG", Price = 80 }
                }
            };
            Orders[ord1.OrderId] = ord1;

            var ordRecent = new Order
            {
                OrderId = "OR62051",
                CustomerName = "Pratik Nakum",
                CustomerEmail = "pratik@gmail.com",
                CustomerPhone = "+91 9876543210",
                OrderDate = DateTime.Now.ToString("MMM dd, yyyy", System.Globalization.CultureInfo.InvariantCulture),
                Status = "Confirmed",
                PaymentMethod = "Cash on Delivery (COD)",
                DeliveryAddress = "Rajkot, Gujarat",
                Subtotal = 850,
                DeliveryCharge = 0,
                Discount = 0,
                TotalAmount = 850,
                Items = new List<OrderItem>
                {
                    new OrderItem { ProductName = "Farm Fresh Tomatoes", Quantity = 4, Unit = "KG", Price = 35 },
                    new OrderItem { ProductName = "Organic Spinach", Quantity = 3, Unit = "GM", Price = 30 },
                    new OrderItem { ProductName = "Local Potatoes", Quantity = 4, Unit = "KG", Price = 35 },
                    new OrderItem { ProductName = "Red Onion", Quantity = 12, Unit = "KG", Price = 30 },
                    new OrderItem { ProductName = "Fresh Cucumber", Quantity = 4, Unit = "KG", Price = 30 }
                }
            };
            Orders[ordRecent.OrderId] = ordRecent;
        }

        public static Order GetOrder(string orderId)
        {
            if (string.IsNullOrWhiteSpace(orderId))
            {
                return Orders["ORD003"];
            }

            string cleanId = orderId.Trim().TrimStart('#');
            if (Orders.TryGetValue(cleanId, out Order order))
            {
                return order;
            }

            // Return first order as fallback with adjusted orderId
            var fallback = Orders["ORD003"];
            return fallback;
        }

        // Strict lookup: an id that matches nothing returns null. GetOrder above
        // substitutes ORD003 for anything it cannot find, which meant Bill.aspx
        // rendered a real customer's invoice for any made-up ?orderId=.
        public static Order GetOrderById(string orderId)
        {
            if (string.IsNullOrWhiteSpace(orderId))
            {
                return null;
            }

            Order order;
            return Orders.TryGetValue(orderId.Trim().TrimStart('#'), out order) ? order : null;
        }

        public static List<Order> GetAllOrders()
        {
            return new List<Order>(Orders.Values);
        }
    }
}

