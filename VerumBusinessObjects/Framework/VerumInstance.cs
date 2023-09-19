using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics.PerformanceData;
using System.Linq;
using System.Linq.Expressions;
using System.Runtime.InteropServices.ComTypes;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;
using System.Data.Common;
using System.Data.Entity.Validation;


namespace VerumBusinessObjects.Framework
{
    [ComVisible(false)]
    static public class VerumInstance
    {
        // PUBLIC PROPERTIES (COM INTEROP)

        /// <summary>
        /// Type of current user (NoUser, Standard or Admin)
        /// </summary>
        public static TypeUserEnum TypeCurrentUser
        {
            get
            {
                if (_Session == null) return TypeUserEnum.NoUser;
                else return (TypeUserEnum)_Session.SessionUserParent.TypeUser;
            }
        }

        public static User User
        {
            get
            {
                if (_Session == null) return null;
                else
                    return _Session.SessionUserParent;
            }
        }

        /// <summary>
        /// Return client id of current user session
        /// </summary>
        public static Guid IdClient
        {
            get
            {
                if (_Session == null) return Guid.Empty;
                else return _Session.idClient;
            }
        }

        /// <summary>
        /// Return client business object for current session
        /// </summary>
        public static Client Client
        {
            get
            {
                if (_Session == null) return null;
                else return _Session.SessionClientParent;
            }
        }

        /// <summary>
        /// Return session id of current user session
        /// </summary>
        public static Guid IdSession
        {
            get
            {
                if (_Session == null) return Guid.Empty;
                else return _Session.Id;
            }
        }

        /// <summary>
        /// Provides access to a static database context which can be shared across a transaction involving several business objects
        /// </summary>
        static internal VerumDBContext Context
        {
            get
            {
                if (_db == null) throw new Exception(Properties.Errors.VerumNoSessionAvailable);
                return _db;
            }
        }
        static private VerumDBContext _db;
        static private string ConnectionString;

        static internal bool TraceLogging
        {
            get => _logging;
            set
            {
                _logging = value;

                if (_logging) Context.Database.Log = Console.Write;
                else Context.Database.Log = null;
            }
        }
        static private bool _logging = false;

        /// <summary>
        /// Initiates the start of a new transaction. Multiple transactions can be nested. Only when the most outer transaction is ended (TransactionEnd) 
        /// will any data changes commit to data source.
        /// </summary>
        /// <returns></returns>
        static public int TransactionStart()
        {
            _txCounter += 1;

            //if (_tx == null) _tx = Context.Database.BeginTransaction();

            return _txCounter;
        }

        /// <summary>
        /// Ends a transaction. If the transaction is the most outer transaction, data will be committed to database. Changes are saved asynchronously.
        /// Transaction functionality is currently overridden!!
        /// </summary>
        /// <returns></returns>
        static public int TransactionEnd()
        {
            _txCounter -= 1;

            if (_txCounter <= 0)
            {
                _txCounter = 0;
                if (_tx != null) _tx.Commit();
                SaveChanges();
                _tx = null;
            }

            SaveChanges();   // override

            return _txCounter;
        }

        static public void TransactionRollback()
        {
            _txCounter = 0;
            if (_tx != null) _tx.Rollback();
            _tx = null;
        }
        static private int _txCounter = 0;
        static private DbContextTransaction _tx;

        static public void SaveChanges( bool forceCommit = false)
        {
            if (forceCommit || _txCounter <= 0)
            {
                try
                {
                    _db.SaveChanges();
                }
                catch (DbEntityValidationException ex)
                {
                    foreach (var entityValidationErrors in ex.EntityValidationErrors)
                    {
                        foreach (var validationError in entityValidationErrors.ValidationErrors)
                        {
                            //System.Windows.Forms.MessageBox.Show("Property: " + validationError.PropertyName + " Error: " + validationError.ErrorMessage, "Error");
                        }
                    }
                }
            }
        }


        /// <summary>
        /// Returns current user session business object - with COM Interop
        /// </summary>
        static public Session CurrentSession 
        { 
            get => _Session; 
        }
        static private Session _Session;

        /// <summary>
        /// Connect to existing valid session. Checks session key and whether age of session exceeds maximum
        /// </summary>
        /// <param name="idSession">Valid session key</param>
        /// <returns>Session business object</returns>
        static public Session ConnectSession( Guid idSession)
        {
            // close existing session if exists and open DB connection
            if (_Session != null) CloseSession();
            _db = new VerumDBContext(ConnectionString);

            // Retrieve session from db
            var query = _db.tSession.Where(b => b.Id == idSession);

            // Error if session key does not exist
            if (query.Count() < 1) throw new Exception(Properties.Errors.VerumInvalidSessionKey);
            _Session = new Session();
            _Session.data = query.FirstOrDefault();

            // Error if session is older than may property value
            TimeSpan sessionage = DateTime.UtcNow - _Session.DateUpdated;
            if (sessionage.Hours > int.Parse(Properties.Resources.VerumMaximumSessionTime))
            {
                _Session = null;
                _db = null;
                throw new Exception(Properties.Errors.VerumExpiredSessionKey);
            }

            return _Session;
        }

        internal static Guid NewSession(Guid IdUser, Guid IdClientDefault, string connectionString)
        {
            ConnectionString = connectionString;
            _db = new VerumDBContext(connectionString);
            _db.Database.CommandTimeout = 240;

            _Session = new Session();
            _Session.New();
            _Session.idClient = IdClientDefault;
            _Session.idUser = IdUser;
            _Session.CommitChanges();

            return _Session.Id;
        }

        internal static void CloseSession()
        {
            TransactionRollback();

            if (_db != null)
            {
                _db.tSession.RemoveRange(_db.tSession.Where(b => (b.Id == IdSession)));
                _db.SaveChanges();
                _Session = null;
                _db = null;
            }
        }

        //internal static Guid NewSession(Guid IdClientDefault, string connectionString, Guid userId)
        //{
        //    ConnectionString = connectionString;
        //    _db = new VerumDBContext(connectionString);
        //    _db.Database.CommandTimeout = 240;
        //    _Session = new Session();
        //    _Session.New();
        //    _Session.idClient = IdClientDefault;
        //    _Session.idUser = userId;
        //    _Session.CommitChanges();
        //    return _Session.Id;
        //}

        internal static void SetConnection(string connectionString)
        {
            ConnectionString = connectionString;
            _db = new VerumDBContext(connectionString);
            _db.Database.CommandTimeout = 240;
        }

    }
}
