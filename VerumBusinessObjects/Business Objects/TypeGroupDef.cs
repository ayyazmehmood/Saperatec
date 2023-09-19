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
    public partial class TypeGroupDef : BusinessObject<tTypeGroupDef>, ITypeGroupDef
    {
        public bool SelectViaKey(string code)
        {
            var attr = (StringLengthAttribute)typeof(tTypeGroupDef).GetProperty("TypeGroupID").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();

            if (attr != null)
            {
                var len = attr.MaximumLength;

                if (code.Length > len)
                    code = code.Substring(0, attr.MaximumLength);
            }

            var obj = VerumInstance.Context.tTypeGroupDef.Where(b => b.TypeGroupID == code);

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
