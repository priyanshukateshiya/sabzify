using System;
using System.Collections.Generic;

namespace sabzify
{
    [Serializable]
    public class OrderItem
    {
        public string ProductName { get; set; }
        public int Quantity { get; set; }
        public string Unit { get; set; }
        public decimal Price { get; set; }
        public decimal Total => Quantity * Price;
    }

    [Serializable]
    public class Order
    {
        public string OrderId { get; set; }
        public string CustomerName { get; set; }
        public string CustomerEmail { get; set; }
        public string CustomerPhone { get; set; }
        public string OrderDate { get; set; }
        public string Status { get; set; }
        public string PaymentMethod { get; set; }
        public string DeliveryAddress { get; set; }
        public List<OrderItem> Items { get; set; } = new List<OrderItem>();
        public decimal Subtotal { get; set; }
        public decimal DeliveryCharge { get; set; }
        public decimal Discount { get; set; }
        public decimal TotalAmount { get; set; }
    }
}
