//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ECart
{
    using System;
    using System.Collections.Generic;
    
    public partial class Brand
    {
        public Brand()
        {
            this.CategoryBrands = new HashSet<CategoryBrand>();
            this.Products = new HashSet<Product>();
        }
    
        public int Id { get; set; }
        public string Name { get; set; }
    
        public virtual ICollection<CategoryBrand> CategoryBrands { get; set; }
        public virtual ICollection<Product> Products { get; set; }
    }
}
