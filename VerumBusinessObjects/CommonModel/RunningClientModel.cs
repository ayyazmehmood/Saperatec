using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VerumBusinessObjects
{
    public  class RunningClientModel
    {
        public Guid GuidId { get; set; }
        public string Title { get; set; }
        public bool IsRunning { get; set; } = false;
        public string BCUrl { get; set; }
        public DateTime? RunDateTime { get; set; }
        public Guid UserId { get; set; }
    }
}
