using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.InteropServices;
//using Microsoft.Office.Interop.Access.Dao;

namespace VerumBusinessLogic
{

    [Guid("a2810d6b-23e4-4115-938d-47f40bd15ea5")]
    [ComVisible(true)]
    public interface IPlan
    {
        void Init(int id);
        int Id { get; }
    }

    [Guid("23694080-1ed8-4db7-986d-f7104c10ae07")]
    [ClassInterface(ClassInterfaceType.AutoDispatch)]
    [ComVisible(true)]
    public class Plan : IPlan
    {
        private int PlanId;

        public void Init( int id)
        {
            PlanId = id;
        }

        public int Id
        {
            get
            {
                return (PlanId);
            }
        }
    }
}
