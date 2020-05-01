using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ECart.BL
{
    public class CartItem
    {
        public int Quantity { get; set; }

        public Product Product { get; set; }
    }
}