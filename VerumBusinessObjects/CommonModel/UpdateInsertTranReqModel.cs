﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VerumBusinessObjects
{
    public class UpdateInsertTranReqModel
    {
        public UpdateInsertTranReqModel() { }
        public Guid clientId { get; set; }
        public Guid userId { get; set; }
        public int tranId { get; set; }
    }
}
