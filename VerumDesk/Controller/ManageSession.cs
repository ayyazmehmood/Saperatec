using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VerumBusinessObjects.Framework;
using VerumBusinessObjects;
using VerumBusinessObjects.Views;
using VerumDesk.GUI;

namespace VerumDesk.Controller
{
    static internal class ManageSession
    {
        static internal VerumSession Session;
        static internal MainWindow mainWindow;

        static internal BOResult LogonUser( string user, string password, string connectionString)
        {
            Session = new VerumSession();
            return Session.Logon(user, password, connectionString);
        }
    }
}
