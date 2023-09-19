namespace VerumBusinessObjects
{
    using System;
    using System.Data.Entity;
    using System.Linq;
    using VerumBusinessObjects.Framework;
    using System.ComponentModel.DataAnnotations;

    /// <summary>
    /// Specifies currencies and enables the conversion of foreign currency into the client base currency
    /// </summary>    
    public partial class TypeCodeDef : BusinessObject<tTypeCodeDef>, ITypeCodeDef
    {
        public bool SelectViaKey(string code)
        {
            var attr = (StringLengthAttribute)typeof(tTypeCodeDef).GetProperty("TypeID").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();

            if (attr != null)
            {
                var len = attr.MaximumLength;

                if (code.Length > len)
                    code = code.Substring(0, attr.MaximumLength);
            }

            var obj = VerumInstance.Context.tTypeCodeDef.Where(b => b.TypeID == code);

            if (obj.Count() == 0)
            {
                return false;
            }
            else
            {
                Id = obj.FirstOrDefault().Id;
                return true;
            }
        }
    }
}
