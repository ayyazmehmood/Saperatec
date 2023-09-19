// CAUTION - This file is auto-generated from the data dictionary. Do not change manually!

namespace VerumBusinessObjects
{
	using System;
	using System.Linq;
	using System.Text;
	using System.Collections.Generic;
	using System.Threading.Tasks;
	using System.ComponentModel.DataAnnotations;
	using System.ComponentModel.DataAnnotations.Schema;
	using System.Data.Entity.Spatial;
	public partial interface IAccount
	{
		int Id { get; set; }
		Boolean bound { get; }
		int IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		int idClient { get; set; }
		Client Client { get; set; }
		int idAccountGroup { get; set; }
		AccountGroup AccountGroup { get; set; }
		int idAccountReporting { get; set; }
		Account AccountReporting { get; set; }
		int AccountCode { get; set; }
		short TypeAccount { get; set; }
		string TitleLocalAccount { get; set; }
		string TitleEnglishAccount { get; set; }
		bool FlagPlan { get; set; }
	}


	public partial class Account : IAccount, IBusinessObject<tAccount>
	{
		private VerumDBContext _db = new VerumDBContext();


		private tAccount _data = new tAccount();
		public tAccount data { get => _data; set => _data = value; }


		private Boolean _bound = false;
		public Boolean bound { get => _bound; }


		public Account() { }
		public Account(int id)
		{
			_id = id;
			Load();
		}


		private void Load()
		{
			tAccount o;


			if (_id == 0) _bound = false;
			else
			{
				o = _db.tAccount.Where<tAccount>(b => b.Id == _id).FirstOrDefault();


				if (o == null)
				{
					_data = new tAccount();
					_bound = false;
				}
				else
				{
					_data = o;
					_bound = true;
				}
			}
		}
		public int CommitChanges()
		{
			_db.tAccount.Add(_data);
			return _db.SaveChanges();
		}
		private int _id = 0;
		public int Id
		{
			get => _id;


			set
			{
				_id = value;
				Load();
			}
		}


		public int IdMigrate {
			get => _data.IdMigrate.GetValueOrDefault();
			set { _data.IdMigrate = value; }
		}

		public DateTime DateCreated
		{
			get => _data.DateCreated;
			set { _data.DateCreated = value; }
		}

		public DateTime DateUpdated
		{
			get => _data.DateUpdated.GetValueOrDefault();
			set { _data.DateUpdated = value; }
		}

		public int idClient
		{
			get => _data.idClient;
			set
			{
				_data.idClient = value;
				_Client = null;
			}
		}

		private Client _Client;

		public Client Client
		{
			get
			{
				if (_Client == null)
				{
					_Client = new Client(_data.idClient);
					return _Client;
				}
				else return _Client;
			}
			set { 
				_Client = value;
				idClient = _Client.Id;
			}
		}

		public int idAccountGroup
		{
			get => _data.idAccountGroup.GetValueOrDefault();
			set
			{
				_data.idAccountGroup = value;
				_AccountGroup = null;
			}
		}

		private AccountGroup _AccountGroup;

		public AccountGroup AccountGroup
		{
			get
			{
				if (_AccountGroup == null)
				{
					if (_data.idAccountGroup == null) return null;
					else
					{
						_AccountGroup = new AccountGroup(_data.idAccountGroup.GetValueOrDefault());
						return _AccountGroup;
					}
				}
				else return _AccountGroup;
			}
			set { 
				_AccountGroup = value;
				idAccountGroup = _AccountGroup.Id;
			}
		}

		public int idAccountReporting
		{
			get => _data.idAccountReporting.GetValueOrDefault();
			set
			{
				_data.idAccountReporting = value;
				_AccountReporting = null;
			}
		}

		private Account _AccountReporting;

		public Account AccountReporting
		{
			get
			{
				if (_AccountReporting == null)
				{
					if (_data.idAccountReporting == null) return null;
					else
					{
						_AccountReporting = new Account(_data.idAccountReporting.GetValueOrDefault());
						return _AccountReporting;
					}
				}
				else return _AccountReporting;
			}
			set { 
				_AccountReporting = value;
				idAccountReporting = _AccountReporting.Id;
			}
		}

		public int AccountCode
		{
			get => _data.AccountCode;
			set { _data.AccountCode = value; }
		}

		public short TypeAccount
		{
			get => _data.TypeAccount;
			set { _data.TypeAccount = value; }
		}

		public string TitleLocalAccount
		{
			get => _data.TitleLocalAccount;
			set { _data.TitleLocalAccount = value; }
		}

		public string TitleEnglishAccount
		{
			get => _data.TitleEnglishAccount;
			set { _data.TitleEnglishAccount = value; }
		}

		public bool FlagPlan
		{
			get => _data.FlagPlan;
			set { _data.FlagPlan = value; }
		}

	}


	public partial interface IAccountGroup
	{
		int Id { get; set; }
		Boolean bound { get; }
		int IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		int idClient { get; set; }
		Client Client { get; set; }
		string TitleLocalAccountGroup { get; set; }
		string TitleEnglishAccountGroup { get; set; }
	}


	public partial class AccountGroup : IAccountGroup, IBusinessObject<tAccountGroup>
	{
		private VerumDBContext _db = new VerumDBContext();


		private tAccountGroup _data = new tAccountGroup();
		public tAccountGroup data { get => _data; set => _data = value; }


		private Boolean _bound = false;
		public Boolean bound { get => _bound; }


		public AccountGroup() { }
		public AccountGroup(int id)
		{
			_id = id;
			Load();
		}


		private void Load()
		{
			tAccountGroup o;


			if (_id == 0) _bound = false;
			else
			{
				o = _db.tAccountGroup.Where<tAccountGroup>(b => b.Id == _id).FirstOrDefault();


				if (o == null)
				{
					_data = new tAccountGroup();
					_bound = false;
				}
				else
				{
					_data = o;
					_bound = true;
				}
			}
		}
		public int CommitChanges()
		{
			_db.tAccountGroup.Add(_data);
			return _db.SaveChanges();
		}
		private int _id = 0;
		public int Id
		{
			get => _id;


			set
			{
				_id = value;
				Load();
			}
		}


		public int IdMigrate {
			get => _data.IdMigrate.GetValueOrDefault();
			set { _data.IdMigrate = value; }
		}

		public DateTime DateCreated
		{
			get => _data.DateCreated;
			set { _data.DateCreated = value; }
		}

		public DateTime DateUpdated
		{
			get => _data.DateUpdated.GetValueOrDefault();
			set { _data.DateUpdated = value; }
		}

		public int idClient
		{
			get => _data.idClient;
			set
			{
				_data.idClient = value;
				_Client = null;
			}
		}

		private Client _Client;

		public Client Client
		{
			get
			{
				if (_Client == null)
				{
					_Client = new Client(_data.idClient);
					return _Client;
				}
				else return _Client;
			}
			set { 
				_Client = value;
				idClient = _Client.Id;
			}
		}

		public string TitleLocalAccountGroup
		{
			get => _data.TitleLocalAccountGroup;
			set { _data.TitleLocalAccountGroup = value; }
		}

		public string TitleEnglishAccountGroup
		{
			get => _data.TitleEnglishAccountGroup;
			set { _data.TitleEnglishAccountGroup = value; }
		}

	}


	public partial interface IBookingRun
	{
		int Id { get; set; }
		Boolean bound { get; }
		int IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		int idClient { get; set; }
		Client Client { get; set; }
		string BookingRunCode { get; set; }
		int PeriodYear { get; set; }
		short PeriodMonth { get; set; }
		int SerialNum { get; set; }
		string TitleBookingRun { get; set; }
	}


	public partial class BookingRun : IBookingRun, IBusinessObject<tBookingRun>
	{
		private VerumDBContext _db = new VerumDBContext();


		private tBookingRun _data = new tBookingRun();
		public tBookingRun data { get => _data; set => _data = value; }


		private Boolean _bound = false;
		public Boolean bound { get => _bound; }


		public BookingRun() { }
		public BookingRun(int id)
		{
			_id = id;
			Load();
		}


		private void Load()
		{
			tBookingRun o;


			if (_id == 0) _bound = false;
			else
			{
				o = _db.tBookingRun.Where<tBookingRun>(b => b.Id == _id).FirstOrDefault();


				if (o == null)
				{
					_data = new tBookingRun();
					_bound = false;
				}
				else
				{
					_data = o;
					_bound = true;
				}
			}
		}
		public int CommitChanges()
		{
			_db.tBookingRun.Add(_data);
			return _db.SaveChanges();
		}
		private int _id = 0;
		public int Id
		{
			get => _id;


			set
			{
				_id = value;
				Load();
			}
		}


		public int IdMigrate {
			get => _data.IdMigrate.GetValueOrDefault();
			set { _data.IdMigrate = value; }
		}

		public DateTime DateCreated
		{
			get => _data.DateCreated;
			set { _data.DateCreated = value; }
		}

		public DateTime DateUpdated
		{
			get => _data.DateUpdated.GetValueOrDefault();
			set { _data.DateUpdated = value; }
		}

		public int idClient
		{
			get => _data.idClient;
			set
			{
				_data.idClient = value;
				_Client = null;
			}
		}

		private Client _Client;

		public Client Client
		{
			get
			{
				if (_Client == null)
				{
					_Client = new Client(_data.idClient);
					return _Client;
				}
				else return _Client;
			}
			set { 
				_Client = value;
				idClient = _Client.Id;
			}
		}

		public string BookingRunCode
		{
			get => _data.BookingRunCode;
			set { _data.BookingRunCode = value; }
		}

		public int PeriodYear
		{
			get => _data.PeriodYear;
			set { _data.PeriodYear = value; }
		}

		public short PeriodMonth
		{
			get => _data.PeriodMonth;
			set { _data.PeriodMonth = value; }
		}

		public int SerialNum
		{
			get => _data.SerialNum;
			set { _data.SerialNum = value; }
		}

		public string TitleBookingRun
		{
			get => _data.TitleBookingRun;
			set { _data.TitleBookingRun = value; }
		}

	}


	public partial interface IBookRecord
	{
		int Id { get; set; }
		Boolean bound { get; }
		int IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		int idClient { get; set; }
		Client Client { get; set; }
		bool FlagOutdated { get; set; }
		DateTime DateOutdated { get; set; }
		short TypeBookRecord { get; set; }
		int idAccountDebit { get; set; }
		Account AccountDebit { get; set; }
		int idAccountCredit { get; set; }
		Account AccountCredit { get; set; }
		int idCostCenterBookRecord { get; set; }
		CostCenter CostCenterBookRecord { get; set; }
		int idBookingRun { get; set; }
		BookingRun BookingRun { get; set; }
		int BookingSequenceNum { get; set; }
		int idPlanElementInstance { get; set; }
		PlanElementInstance PlanElementInstance { get; set; }
		string TitleBookRecord { get; set; }
		DateTime BookingDate { get; set; }
		int BusinessYear { get; set; }
		int BookingYear { get; set; }
		short BookingQuarter { get; set; }
		short BookingMonth { get; set; }
		double Amount { get; set; }
		string BookingDocument1 { get; set; }
		string BookingDocument2 { get; set; }
		string ReferenceIDBookRecord { get; set; }
		string BookRecordComment { get; set; }
	}


	public partial class BookRecord : IBookRecord, IBusinessObject<tBookRecord>
	{
		private VerumDBContext _db = new VerumDBContext();


		private tBookRecord _data = new tBookRecord();
		public tBookRecord data { get => _data; set => _data = value; }


		private Boolean _bound = false;
		public Boolean bound { get => _bound; }


		public BookRecord() { }
		public BookRecord(int id)
		{
			_id = id;
			Load();
		}


		private void Load()
		{
			tBookRecord o;


			if (_id == 0) _bound = false;
			else
			{
				o = _db.tBookRecord.Where<tBookRecord>(b => b.Id == _id).FirstOrDefault();


				if (o == null)
				{
					_data = new tBookRecord();
					_bound = false;
				}
				else
				{
					_data = o;
					_bound = true;
				}
			}
		}
		public int CommitChanges()
		{
			_db.tBookRecord.Add(_data);
			return _db.SaveChanges();
		}
		private int _id = 0;
		public int Id
		{
			get => _id;


			set
			{
				_id = value;
				Load();
			}
		}


		public int IdMigrate {
			get => _data.IdMigrate.GetValueOrDefault();
			set { _data.IdMigrate = value; }
		}

		public DateTime DateCreated
		{
			get => _data.DateCreated;
			set { _data.DateCreated = value; }
		}

		public DateTime DateUpdated
		{
			get => _data.DateUpdated.GetValueOrDefault();
			set { _data.DateUpdated = value; }
		}

		public int idClient
		{
			get => _data.idClient;
			set
			{
				_data.idClient = value;
				_Client = null;
			}
		}

		private Client _Client;

		public Client Client
		{
			get
			{
				if (_Client == null)
				{
					_Client = new Client(_data.idClient);
					return _Client;
				}
				else return _Client;
			}
			set { 
				_Client = value;
				idClient = _Client.Id;
			}
		}

		public bool FlagOutdated
		{
			get => _data.FlagOutdated;
			set { _data.FlagOutdated = value; }
		}

		public DateTime DateOutdated
		{
			get => _data.DateOutdated.GetValueOrDefault();
			set { _data.DateOutdated = value; }
		}

		public short TypeBookRecord
		{
			get => _data.TypeBookRecord;
			set { _data.TypeBookRecord = value; }
		}

		public int idAccountDebit
		{
			get => _data.idAccountDebit;
			set
			{
				_data.idAccountDebit = value;
				_AccountDebit = null;
			}
		}

		private Account _AccountDebit;

		public Account AccountDebit
		{
			get
			{
				if (_AccountDebit == null)
				{
					_AccountDebit = new Account(_data.idAccountDebit);
					return _AccountDebit;
				}
				else return _AccountDebit;
			}
			set { 
				_AccountDebit = value;
				idAccountDebit = _AccountDebit.Id;
			}
		}

		public int idAccountCredit
		{
			get => _data.idAccountCredit;
			set
			{
				_data.idAccountCredit = value;
				_AccountCredit = null;
			}
		}

		private Account _AccountCredit;

		public Account AccountCredit
		{
			get
			{
				if (_AccountCredit == null)
				{
					_AccountCredit = new Account(_data.idAccountCredit);
					return _AccountCredit;
				}
				else return _AccountCredit;
			}
			set { 
				_AccountCredit = value;
				idAccountCredit = _AccountCredit.Id;
			}
		}

		public int idCostCenterBookRecord
		{
			get => _data.idCostCenterBookRecord.GetValueOrDefault();
			set
			{
				_data.idCostCenterBookRecord = value;
				_CostCenterBookRecord = null;
			}
		}

		private CostCenter _CostCenterBookRecord;

		public CostCenter CostCenterBookRecord
		{
			get
			{
				if (_CostCenterBookRecord == null)
				{
					if (_data.idCostCenterBookRecord == null) return null;
					else
					{
						_CostCenterBookRecord = new CostCenter(_data.idCostCenterBookRecord.GetValueOrDefault());
						return _CostCenterBookRecord;
					}
				}
				else return _CostCenterBookRecord;
			}
			set { 
				_CostCenterBookRecord = value;
				idCostCenterBookRecord = _CostCenterBookRecord.Id;
			}
		}

		public int idBookingRun
		{
			get => _data.idBookingRun.GetValueOrDefault();
			set
			{
				_data.idBookingRun = value;
				_BookingRun = null;
			}
		}

		private BookingRun _BookingRun;

		public BookingRun BookingRun
		{
			get
			{
				if (_BookingRun == null)
				{
					if (_data.idBookingRun == null) return null;
					else
					{
						_BookingRun = new BookingRun(_data.idBookingRun.GetValueOrDefault());
						return _BookingRun;
					}
				}
				else return _BookingRun;
			}
			set { 
				_BookingRun = value;
				idBookingRun = _BookingRun.Id;
			}
		}

		public int BookingSequenceNum
		{
			get => _data.BookingSequenceNum.GetValueOrDefault();
			set { _data.BookingSequenceNum = value; }
		}

		public int idPlanElementInstance
		{
			get => _data.idPlanElementInstance.GetValueOrDefault();
			set
			{
				_data.idPlanElementInstance = value;
				_PlanElementInstance = null;
			}
		}

		private PlanElementInstance _PlanElementInstance;

		public PlanElementInstance PlanElementInstance
		{
			get
			{
				if (_PlanElementInstance == null)
				{
					if (_data.idPlanElementInstance == null) return null;
					else
					{
						_PlanElementInstance = new PlanElementInstance(_data.idPlanElementInstance.GetValueOrDefault());
						return _PlanElementInstance;
					}
				}
				else return _PlanElementInstance;
			}
			set { 
				_PlanElementInstance = value;
				idPlanElementInstance = _PlanElementInstance.Id;
			}
		}

		public string TitleBookRecord
		{
			get => _data.TitleBookRecord;
			set { _data.TitleBookRecord = value; }
		}

		public DateTime BookingDate
		{
			get => _data.BookingDate;
			set { _data.BookingDate = value; }
		}

		public int BusinessYear
		{
			get => _data.BusinessYear;
			set { _data.BusinessYear = value; }
		}

		public int BookingYear
		{
			get => _data.BookingYear;
			set { _data.BookingYear = value; }
		}

		public short BookingQuarter
		{
			get => _data.BookingQuarter;
			set { _data.BookingQuarter = value; }
		}

		public short BookingMonth
		{
			get => _data.BookingMonth;
			set { _data.BookingMonth = value; }
		}

		public double Amount
		{
			get => _data.Amount;
			set { _data.Amount = value; }
		}

		public string BookingDocument1
		{
			get => _data.BookingDocument1;
			set { _data.BookingDocument1 = value; }
		}

		public string BookingDocument2
		{
			get => _data.BookingDocument2;
			set { _data.BookingDocument2 = value; }
		}

		public string ReferenceIDBookRecord
		{
			get => _data.ReferenceIDBookRecord;
			set { _data.ReferenceIDBookRecord = value; }
		}

		public string BookRecordComment
		{
			get => _data.BookRecordComment;
			set { _data.BookRecordComment = value; }
		}

	}


	public partial interface IBookTransaction
	{
		int Id { get; set; }
		Boolean bound { get; }
		int IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		int idBookingRecord { get; set; }
		BookRecord BookingRecord { get; set; }
		int idAccountTransaction { get; set; }
		Account AccountTransaction { get; set; }
		int idAccountCounter { get; set; }
		Account AccountCounter { get; set; }
		double AmountDebit { get; set; }
		double AmountCredit { get; set; }
		double AmountTotal { get; set; }
	}


	public partial class BookTransaction : IBookTransaction, IBusinessObject<tBookTransaction>
	{
		private VerumDBContext _db = new VerumDBContext();


		private tBookTransaction _data = new tBookTransaction();
		public tBookTransaction data { get => _data; set => _data = value; }


		private Boolean _bound = false;
		public Boolean bound { get => _bound; }


		public BookTransaction() { }
		public BookTransaction(int id)
		{
			_id = id;
			Load();
		}


		private void Load()
		{
			tBookTransaction o;


			if (_id == 0) _bound = false;
			else
			{
				o = _db.tBookTransaction.Where<tBookTransaction>(b => b.Id == _id).FirstOrDefault();


				if (o == null)
				{
					_data = new tBookTransaction();
					_bound = false;
				}
				else
				{
					_data = o;
					_bound = true;
				}
			}
		}
		public int CommitChanges()
		{
			_db.tBookTransaction.Add(_data);
			return _db.SaveChanges();
		}
		private int _id = 0;
		public int Id
		{
			get => _id;


			set
			{
				_id = value;
				Load();
			}
		}


		public int IdMigrate {
			get => _data.IdMigrate.GetValueOrDefault();
			set { _data.IdMigrate = value; }
		}

		public DateTime DateCreated
		{
			get => _data.DateCreated;
			set { _data.DateCreated = value; }
		}

		public DateTime DateUpdated
		{
			get => _data.DateUpdated.GetValueOrDefault();
			set { _data.DateUpdated = value; }
		}

		public int idBookingRecord
		{
			get => _data.idBookingRecord;
			set
			{
				_data.idBookingRecord = value;
				_BookingRecord = null;
			}
		}

		private BookRecord _BookingRecord;

		public BookRecord BookingRecord
		{
			get
			{
				if (_BookingRecord == null)
				{
					_BookingRecord = new BookRecord(_data.idBookingRecord);
					return _BookingRecord;
				}
				else return _BookingRecord;
			}
			set { 
				_BookingRecord = value;
				idBookingRecord = _BookingRecord.Id;
			}
		}

		public int idAccountTransaction
		{
			get => _data.idAccountTransaction;
			set
			{
				_data.idAccountTransaction = value;
				_AccountTransaction = null;
			}
		}

		private Account _AccountTransaction;

		public Account AccountTransaction
		{
			get
			{
				if (_AccountTransaction == null)
				{
					_AccountTransaction = new Account(_data.idAccountTransaction);
					return _AccountTransaction;
				}
				else return _AccountTransaction;
			}
			set { 
				_AccountTransaction = value;
				idAccountTransaction = _AccountTransaction.Id;
			}
		}

		public int idAccountCounter
		{
			get => _data.idAccountCounter;
			set
			{
				_data.idAccountCounter = value;
				_AccountCounter = null;
			}
		}

		private Account _AccountCounter;

		public Account AccountCounter
		{
			get
			{
				if (_AccountCounter == null)
				{
					_AccountCounter = new Account(_data.idAccountCounter);
					return _AccountCounter;
				}
				else return _AccountCounter;
			}
			set { 
				_AccountCounter = value;
				idAccountCounter = _AccountCounter.Id;
			}
		}

		public double AmountDebit
		{
			get => _data.AmountDebit;
			set { _data.AmountDebit = value; }
		}

		public double AmountCredit
		{
			get => _data.AmountCredit;
			set { _data.AmountCredit = value; }
		}

		public double AmountTotal
		{
			get => _data.AmountTotal;
			set { _data.AmountTotal = value; }
		}

	}


	public partial interface IClient
	{
		int Id { get; set; }
		Boolean bound { get; }
		int IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		string TitleClient { get; set; }
		int idCurrencyClient { get; set; }
		Currency CurrencyClient { get; set; }
		bool FlagTemplate { get; set; }
		int StartOfBusinessYear { get; set; }
	}


	public partial class Client : IClient, IBusinessObject<tClient>
	{
		private VerumDBContext _db = new VerumDBContext();


		private tClient _data = new tClient();
		public tClient data { get => _data; set => _data = value; }


		private Boolean _bound = false;
		public Boolean bound { get => _bound; }


		public Client() { }
		public Client(int id)
		{
			_id = id;
			Load();
		}


		private void Load()
		{
			tClient o;


			if (_id == 0) _bound = false;
			else
			{
				o = _db.tClient.Where<tClient>(b => b.Id == _id).FirstOrDefault();


				if (o == null)
				{
					_data = new tClient();
					_bound = false;
				}
				else
				{
					_data = o;
					_bound = true;
				}
			}
		}
		public int CommitChanges()
		{
			_db.tClient.Add(_data);
			return _db.SaveChanges();
		}
		private int _id = 0;
		public int Id
		{
			get => _id;


			set
			{
				_id = value;
				Load();
			}
		}


		public int IdMigrate {
			get => _data.IdMigrate.GetValueOrDefault();
			set { _data.IdMigrate = value; }
		}

		public DateTime DateCreated
		{
			get => _data.DateCreated;
			set { _data.DateCreated = value; }
		}

		public DateTime DateUpdated
		{
			get => _data.DateUpdated.GetValueOrDefault();
			set { _data.DateUpdated = value; }
		}

		public string TitleClient
		{
			get => _data.TitleClient;
			set { _data.TitleClient = value; }
		}

		public int idCurrencyClient
		{
			get => _data.idCurrencyClient;
			set
			{
				_data.idCurrencyClient = value;
				_CurrencyClient = null;
			}
		}

		private Currency _CurrencyClient;

		public Currency CurrencyClient
		{
			get
			{
				if (_CurrencyClient == null)
				{
					_CurrencyClient = new Currency(_data.idCurrencyClient);
					return _CurrencyClient;
				}
				else return _CurrencyClient;
			}
			set { 
				_CurrencyClient = value;
				idCurrencyClient = _CurrencyClient.Id;
			}
		}

		public bool FlagTemplate
		{
			get => _data.FlagTemplate;
			set { _data.FlagTemplate = value; }
		}

		public int StartOfBusinessYear
		{
			get => _data.StartOfBusinessYear;
			set { _data.StartOfBusinessYear = value; }
		}

	}


	public partial interface ICostCenter
	{
		int Id { get; set; }
		Boolean bound { get; }
		int IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		int idClient { get; set; }
		Client Client { get; set; }
		string CostCenterCode { get; set; }
		string TitleCostCenter { get; set; }
		bool FlagProfitCenter { get; set; }
	}


	public partial class CostCenter : ICostCenter, IBusinessObject<tCostCenter>
	{
		private VerumDBContext _db = new VerumDBContext();


		private tCostCenter _data = new tCostCenter();
		public tCostCenter data { get => _data; set => _data = value; }


		private Boolean _bound = false;
		public Boolean bound { get => _bound; }


		public CostCenter() { }
		public CostCenter(int id)
		{
			_id = id;
			Load();
		}


		private void Load()
		{
			tCostCenter o;


			if (_id == 0) _bound = false;
			else
			{
				o = _db.tCostCenter.Where<tCostCenter>(b => b.Id == _id).FirstOrDefault();


				if (o == null)
				{
					_data = new tCostCenter();
					_bound = false;
				}
				else
				{
					_data = o;
					_bound = true;
				}
			}
		}
		public int CommitChanges()
		{
			_db.tCostCenter.Add(_data);
			return _db.SaveChanges();
		}
		private int _id = 0;
		public int Id
		{
			get => _id;


			set
			{
				_id = value;
				Load();
			}
		}


		public int IdMigrate {
			get => _data.IdMigrate.GetValueOrDefault();
			set { _data.IdMigrate = value; }
		}

		public DateTime DateCreated
		{
			get => _data.DateCreated;
			set { _data.DateCreated = value; }
		}

		public DateTime DateUpdated
		{
			get => _data.DateUpdated.GetValueOrDefault();
			set { _data.DateUpdated = value; }
		}

		public int idClient
		{
			get => _data.idClient;
			set
			{
				_data.idClient = value;
				_Client = null;
			}
		}

		private Client _Client;

		public Client Client
		{
			get
			{
				if (_Client == null)
				{
					_Client = new Client(_data.idClient);
					return _Client;
				}
				else return _Client;
			}
			set { 
				_Client = value;
				idClient = _Client.Id;
			}
		}

		public string CostCenterCode
		{
			get => _data.CostCenterCode;
			set { _data.CostCenterCode = value; }
		}

		public string TitleCostCenter
		{
			get => _data.TitleCostCenter;
			set { _data.TitleCostCenter = value; }
		}

		public bool FlagProfitCenter
		{
			get => _data.FlagProfitCenter;
			set { _data.FlagProfitCenter = value; }
		}

	}


	public partial interface ICurrency
	{
		int Id { get; set; }
		Boolean bound { get; }
		int IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		string CurrencyCode { get; set; }
		string TitleCurrency { get; set; }
	}


	public partial class Currency : ICurrency, IBusinessObject<tCurrency>
	{
		private VerumDBContext _db = new VerumDBContext();


		private tCurrency _data = new tCurrency();
		public tCurrency data { get => _data; set => _data = value; }


		private Boolean _bound = false;
		public Boolean bound { get => _bound; }


		public Currency() { }
		public Currency(int id)
		{
			_id = id;
			Load();
		}


		private void Load()
		{
			tCurrency o;


			if (_id == 0) _bound = false;
			else
			{
				o = _db.tCurrency.Where<tCurrency>(b => b.Id == _id).FirstOrDefault();


				if (o == null)
				{
					_data = new tCurrency();
					_bound = false;
				}
				else
				{
					_data = o;
					_bound = true;
				}
			}
		}
		public int CommitChanges()
		{
			_db.tCurrency.Add(_data);
			return _db.SaveChanges();
		}
		private int _id = 0;
		public int Id
		{
			get => _id;


			set
			{
				_id = value;
				Load();
			}
		}


		public int IdMigrate {
			get => _data.IdMigrate.GetValueOrDefault();
			set { _data.IdMigrate = value; }
		}

		public DateTime DateCreated
		{
			get => _data.DateCreated;
			set { _data.DateCreated = value; }
		}

		public DateTime DateUpdated
		{
			get => _data.DateUpdated.GetValueOrDefault();
			set { _data.DateUpdated = value; }
		}

		public string CurrencyCode
		{
			get => _data.CurrencyCode;
			set { _data.CurrencyCode = value; }
		}

		public string TitleCurrency
		{
			get => _data.TitleCurrency;
			set { _data.TitleCurrency = value; }
		}

	}


	public partial interface IDepreciationRule
	{
		int Id { get; set; }
		Boolean bound { get; }
		int IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		int idClient { get; set; }
		Client Client { get; set; }
		int idAccountDepreciation { get; set; }
		Account AccountDepreciation { get; set; }
		string TitleDepreciationRule { get; set; }
		int NumberOfPeriods { get; set; }
		int PeriodInMonths { get; set; }
		short TypeDepreciationRule { get; set; }
	}


	public partial class DepreciationRule : IDepreciationRule, IBusinessObject<tDepreciationRule>
	{
		private VerumDBContext _db = new VerumDBContext();


		private tDepreciationRule _data = new tDepreciationRule();
		public tDepreciationRule data { get => _data; set => _data = value; }


		private Boolean _bound = false;
		public Boolean bound { get => _bound; }


		public DepreciationRule() { }
		public DepreciationRule(int id)
		{
			_id = id;
			Load();
		}


		private void Load()
		{
			tDepreciationRule o;


			if (_id == 0) _bound = false;
			else
			{
				o = _db.tDepreciationRule.Where<tDepreciationRule>(b => b.Id == _id).FirstOrDefault();


				if (o == null)
				{
					_data = new tDepreciationRule();
					_bound = false;
				}
				else
				{
					_data = o;
					_bound = true;
				}
			}
		}
		public int CommitChanges()
		{
			_db.tDepreciationRule.Add(_data);
			return _db.SaveChanges();
		}
		private int _id = 0;
		public int Id
		{
			get => _id;


			set
			{
				_id = value;
				Load();
			}
		}


		public int IdMigrate {
			get => _data.IdMigrate.GetValueOrDefault();
			set { _data.IdMigrate = value; }
		}

		public DateTime DateCreated
		{
			get => _data.DateCreated;
			set { _data.DateCreated = value; }
		}

		public DateTime DateUpdated
		{
			get => _data.DateUpdated.GetValueOrDefault();
			set { _data.DateUpdated = value; }
		}

		public int idClient
		{
			get => _data.idClient;
			set
			{
				_data.idClient = value;
				_Client = null;
			}
		}

		private Client _Client;

		public Client Client
		{
			get
			{
				if (_Client == null)
				{
					_Client = new Client(_data.idClient);
					return _Client;
				}
				else return _Client;
			}
			set { 
				_Client = value;
				idClient = _Client.Id;
			}
		}

		public int idAccountDepreciation
		{
			get => _data.idAccountDepreciation;
			set
			{
				_data.idAccountDepreciation = value;
				_AccountDepreciation = null;
			}
		}

		private Account _AccountDepreciation;

		public Account AccountDepreciation
		{
			get
			{
				if (_AccountDepreciation == null)
				{
					_AccountDepreciation = new Account(_data.idAccountDepreciation);
					return _AccountDepreciation;
				}
				else return _AccountDepreciation;
			}
			set { 
				_AccountDepreciation = value;
				idAccountDepreciation = _AccountDepreciation.Id;
			}
		}

		public string TitleDepreciationRule
		{
			get => _data.TitleDepreciationRule;
			set { _data.TitleDepreciationRule = value; }
		}

		public int NumberOfPeriods
		{
			get => _data.NumberOfPeriods;
			set { _data.NumberOfPeriods = value; }
		}

		public int PeriodInMonths
		{
			get => _data.PeriodInMonths;
			set { _data.PeriodInMonths = value; }
		}

		public short TypeDepreciationRule
		{
			get => _data.TypeDepreciationRule;
			set { _data.TypeDepreciationRule = value; }
		}

	}


	public partial interface IPlan
	{
		int Id { get; set; }
		Boolean bound { get; }
		int IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		int idClient { get; set; }
		Client Client { get; set; }
		int idPlanBase { get; set; }
		Plan PlanBase { get; set; }
		string TitlePlan { get; set; }
		DateTime DateValidFrom { get; set; }
		DateTime DateValidTo { get; set; }
		bool PlanFlagBaseline { get; set; }
		short TypeStatus { get; set; }
	}


	public partial class Plan : IPlan, IBusinessObject<tPlan>
	{
		private VerumDBContext _db = new VerumDBContext();


		private tPlan _data = new tPlan();
		public tPlan data { get => _data; set => _data = value; }


		private Boolean _bound = false;
		public Boolean bound { get => _bound; }


		public Plan() { }
		public Plan(int id)
		{
			_id = id;
			Load();
		}


		private void Load()
		{
			tPlan o;


			if (_id == 0) _bound = false;
			else
			{
				o = _db.tPlan.Where<tPlan>(b => b.Id == _id).FirstOrDefault();


				if (o == null)
				{
					_data = new tPlan();
					_bound = false;
				}
				else
				{
					_data = o;
					_bound = true;
				}
			}
		}
		public int CommitChanges()
		{
			_db.tPlan.Add(_data);
			return _db.SaveChanges();
		}
		private int _id = 0;
		public int Id
		{
			get => _id;


			set
			{
				_id = value;
				Load();
			}
		}


		public int IdMigrate {
			get => _data.IdMigrate.GetValueOrDefault();
			set { _data.IdMigrate = value; }
		}

		public DateTime DateCreated
		{
			get => _data.DateCreated;
			set { _data.DateCreated = value; }
		}

		public DateTime DateUpdated
		{
			get => _data.DateUpdated.GetValueOrDefault();
			set { _data.DateUpdated = value; }
		}

		public int idClient
		{
			get => _data.idClient;
			set
			{
				_data.idClient = value;
				_Client = null;
			}
		}

		private Client _Client;

		public Client Client
		{
			get
			{
				if (_Client == null)
				{
					_Client = new Client(_data.idClient);
					return _Client;
				}
				else return _Client;
			}
			set { 
				_Client = value;
				idClient = _Client.Id;
			}
		}

		public int idPlanBase
		{
			get => _data.idPlanBase.GetValueOrDefault();
			set
			{
				_data.idPlanBase = value;
				_PlanBase = null;
			}
		}

		private Plan _PlanBase;

		public Plan PlanBase
		{
			get
			{
				if (_PlanBase == null)
				{
					if (_data.idPlanBase == null) return null;
					else
					{
						_PlanBase = new Plan(_data.idPlanBase.GetValueOrDefault());
						return _PlanBase;
					}
				}
				else return _PlanBase;
			}
			set { 
				_PlanBase = value;
				idPlanBase = _PlanBase.Id;
			}
		}

		public string TitlePlan
		{
			get => _data.TitlePlan;
			set { _data.TitlePlan = value; }
		}

		public DateTime DateValidFrom
		{
			get => _data.DateValidFrom;
			set { _data.DateValidFrom = value; }
		}

		public DateTime DateValidTo
		{
			get => _data.DateValidTo;
			set { _data.DateValidTo = value; }
		}

		public bool PlanFlagBaseline
		{
			get => _data.PlanFlagBaseline;
			set { _data.PlanFlagBaseline = value; }
		}

		public short TypeStatus
		{
			get => _data.TypeStatus;
			set { _data.TypeStatus = value; }
		}

	}


	public partial interface IPlanAccountFunction
	{
		int Id { get; set; }
		Boolean bound { get; }
		int IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		int idClient { get; set; }
		Client Client { get; set; }
		int idPlanFunctionDef { get; set; }
		PlanFunctionDef PlanFunctionDef { get; set; }
		int idAccountPlanAccountFunction { get; set; }
		Account AccountPlanAccountFunction { get; set; }
	}


	public partial class PlanAccountFunction : IPlanAccountFunction, IBusinessObject<tPlanAccountFunction>
	{
		private VerumDBContext _db = new VerumDBContext();


		private tPlanAccountFunction _data = new tPlanAccountFunction();
		public tPlanAccountFunction data { get => _data; set => _data = value; }


		private Boolean _bound = false;
		public Boolean bound { get => _bound; }


		public PlanAccountFunction() { }
		public PlanAccountFunction(int id)
		{
			_id = id;
			Load();
		}


		private void Load()
		{
			tPlanAccountFunction o;


			if (_id == 0) _bound = false;
			else
			{
				o = _db.tPlanAccountFunction.Where<tPlanAccountFunction>(b => b.Id == _id).FirstOrDefault();


				if (o == null)
				{
					_data = new tPlanAccountFunction();
					_bound = false;
				}
				else
				{
					_data = o;
					_bound = true;
				}
			}
		}
		public int CommitChanges()
		{
			_db.tPlanAccountFunction.Add(_data);
			return _db.SaveChanges();
		}
		private int _id = 0;
		public int Id
		{
			get => _id;


			set
			{
				_id = value;
				Load();
			}
		}


		public int IdMigrate {
			get => _data.IdMigrate.GetValueOrDefault();
			set { _data.IdMigrate = value; }
		}

		public DateTime DateCreated
		{
			get => _data.DateCreated;
			set { _data.DateCreated = value; }
		}

		public DateTime DateUpdated
		{
			get => _data.DateUpdated.GetValueOrDefault();
			set { _data.DateUpdated = value; }
		}

		public int idClient
		{
			get => _data.idClient;
			set
			{
				_data.idClient = value;
				_Client = null;
			}
		}

		private Client _Client;

		public Client Client
		{
			get
			{
				if (_Client == null)
				{
					_Client = new Client(_data.idClient);
					return _Client;
				}
				else return _Client;
			}
			set { 
				_Client = value;
				idClient = _Client.Id;
			}
		}

		public int idPlanFunctionDef
		{
			get => _data.idPlanFunctionDef;
			set
			{
				_data.idPlanFunctionDef = value;
				_PlanFunctionDef = null;
			}
		}

		private PlanFunctionDef _PlanFunctionDef;

		public PlanFunctionDef PlanFunctionDef
		{
			get
			{
				if (_PlanFunctionDef == null)
				{
					_PlanFunctionDef = new PlanFunctionDef(_data.idPlanFunctionDef);
					return _PlanFunctionDef;
				}
				else return _PlanFunctionDef;
			}
			set { 
				_PlanFunctionDef = value;
				idPlanFunctionDef = _PlanFunctionDef.Id;
			}
		}

		public int idAccountPlanAccountFunction
		{
			get => _data.idAccountPlanAccountFunction;
			set
			{
				_data.idAccountPlanAccountFunction = value;
				_AccountPlanAccountFunction = null;
			}
		}

		private Account _AccountPlanAccountFunction;

		public Account AccountPlanAccountFunction
		{
			get
			{
				if (_AccountPlanAccountFunction == null)
				{
					_AccountPlanAccountFunction = new Account(_data.idAccountPlanAccountFunction);
					return _AccountPlanAccountFunction;
				}
				else return _AccountPlanAccountFunction;
			}
			set { 
				_AccountPlanAccountFunction = value;
				idAccountPlanAccountFunction = _AccountPlanAccountFunction.Id;
			}
		}

	}


	public partial interface IPlanAllocationSchedule
	{
		int Id { get; set; }
		Boolean bound { get; }
		int IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		int idPlan { get; set; }
		Plan Plan { get; set; }
		string TitleAllocationSchedule { get; set; }
		int MonthsBetweenItems { get; set; }
		double PerpetualRate { get; set; }
	}


	public partial class PlanAllocationSchedule : IPlanAllocationSchedule, IBusinessObject<tPlanAllocationSchedule>
	{
		private VerumDBContext _db = new VerumDBContext();


		private tPlanAllocationSchedule _data = new tPlanAllocationSchedule();
		public tPlanAllocationSchedule data { get => _data; set => _data = value; }


		private Boolean _bound = false;
		public Boolean bound { get => _bound; }


		public PlanAllocationSchedule() { }
		public PlanAllocationSchedule(int id)
		{
			_id = id;
			Load();
		}


		private void Load()
		{
			tPlanAllocationSchedule o;


			if (_id == 0) _bound = false;
			else
			{
				o = _db.tPlanAllocationSchedule.Where<tPlanAllocationSchedule>(b => b.Id == _id).FirstOrDefault();


				if (o == null)
				{
					_data = new tPlanAllocationSchedule();
					_bound = false;
				}
				else
				{
					_data = o;
					_bound = true;
				}
			}
		}
		public int CommitChanges()
		{
			_db.tPlanAllocationSchedule.Add(_data);
			return _db.SaveChanges();
		}
		private int _id = 0;
		public int Id
		{
			get => _id;


			set
			{
				_id = value;
				Load();
			}
		}


		public int IdMigrate {
			get => _data.IdMigrate.GetValueOrDefault();
			set { _data.IdMigrate = value; }
		}

		public DateTime DateCreated
		{
			get => _data.DateCreated;
			set { _data.DateCreated = value; }
		}

		public DateTime DateUpdated
		{
			get => _data.DateUpdated.GetValueOrDefault();
			set { _data.DateUpdated = value; }
		}

		public int idPlan
		{
			get => _data.idPlan;
			set
			{
				_data.idPlan = value;
				_Plan = null;
			}
		}

		private Plan _Plan;

		public Plan Plan
		{
			get
			{
				if (_Plan == null)
				{
					_Plan = new Plan(_data.idPlan);
					return _Plan;
				}
				else return _Plan;
			}
			set { 
				_Plan = value;
				idPlan = _Plan.Id;
			}
		}

		public string TitleAllocationSchedule
		{
			get => _data.TitleAllocationSchedule;
			set { _data.TitleAllocationSchedule = value; }
		}

		public int MonthsBetweenItems
		{
			get => _data.MonthsBetweenItems;
			set { _data.MonthsBetweenItems = value; }
		}

		public double PerpetualRate
		{
			get => _data.PerpetualRate;
			set { _data.PerpetualRate = value; }
		}

	}


	public partial interface IPlanItemContract
	{
		int Id { get; set; }
		Boolean bound { get; }
		int IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		int idPlanInstance { get; set; }
		PlanElementInstance PlanInstance { get; set; }
		int idAccountMain { get; set; }
		Account AccountMain { get; set; }
		int idAllocationSchedule { get; set; }
		PlanAllocationSchedule AllocationSchedule { get; set; }
		short TypeRepeat { get; set; }
		int idAccountAdvanceAccrual { get; set; }
		Account AccountAdvanceAccrual { get; set; }
		int AdvanceDelay { get; set; }
		int idAccrualSchedule { get; set; }
		PlanAllocationSchedule AccrualSchedule { get; set; }
		int idDepreciationRule { get; set; }
		DepreciationRule DepreciationRule { get; set; }
		int idDepreciationTrigger { get; set; }
		PlanParameter DepreciationTrigger { get; set; }
		int DepreciationDelay { get; set; }
		int idVATRule { get; set; }
		VATRule VATRule { get; set; }
		int idParInflation { get; set; }
		PlanParameter ParInflation { get; set; }
		int idParPrice1 { get; set; }
		PlanParameter ParPrice1 { get; set; }
		int idParPrice2 { get; set; }
		PlanParameter ParPrice2 { get; set; }
		int idCurrencyContract { get; set; }
		Currency CurrencyContract { get; set; }
		int idParTriggerDate { get; set; }
		PlanParameter ParTriggerDate { get; set; }
		bool ContractFlagBaseline { get; set; }
		bool FlagDateOffset { get; set; }
		int DueDateYear { get; set; }
		int DueDateMonth { get; set; }
		int DueDateDay { get; set; }
		int UntilDateYearContract { get; set; }
		int UntilDateMonthContract { get; set; }
		int UntilDateDayContract { get; set; }
		int PaymentTerm { get; set; }
		int NumberOfUnits { get; set; }
		double Price { get; set; }
		DateTime PriceDate { get; set; }
		double BudgetBase { get; set; }
		double ContingencyRate { get; set; }
		double BudgetContingency { get; set; }
		string Assumptions { get; set; }
		string Revisions { get; set; }
	}


	public partial class PlanItemContract : IPlanItemContract, IBusinessObject<tPlanItemContract>
	{
		private VerumDBContext _db = new VerumDBContext();


		private tPlanItemContract _data = new tPlanItemContract();
		public tPlanItemContract data { get => _data; set => _data = value; }


		private Boolean _bound = false;
		public Boolean bound { get => _bound; }


		public PlanItemContract() { }
		public PlanItemContract(int id)
		{
			_id = id;
			Load();
		}


		private void Load()
		{
			tPlanItemContract o;


			if (_id == 0) _bound = false;
			else
			{
				o = _db.tPlanItemContract.Where<tPlanItemContract>(b => b.Id == _id).FirstOrDefault();


				if (o == null)
				{
					_data = new tPlanItemContract();
					_bound = false;
				}
				else
				{
					_data = o;
					_bound = true;
				}
			}
		}
		public int CommitChanges()
		{
			_db.tPlanItemContract.Add(_data);
			return _db.SaveChanges();
		}
		private int _id = 0;
		public int Id
		{
			get => _id;


			set
			{
				_id = value;
				Load();
			}
		}


		public int IdMigrate {
			get => _data.IdMigrate.GetValueOrDefault();
			set { _data.IdMigrate = value; }
		}

		public DateTime DateCreated
		{
			get => _data.DateCreated;
			set { _data.DateCreated = value; }
		}

		public DateTime DateUpdated
		{
			get => _data.DateUpdated.GetValueOrDefault();
			set { _data.DateUpdated = value; }
		}

		public int idPlanInstance
		{
			get => _data.idPlanInstance;
			set
			{
				_data.idPlanInstance = value;
				_PlanInstance = null;
			}
		}

		private PlanElementInstance _PlanInstance;

		public PlanElementInstance PlanInstance
		{
			get
			{
				if (_PlanInstance == null)
				{
					_PlanInstance = new PlanElementInstance(_data.idPlanInstance);
					return _PlanInstance;
				}
				else return _PlanInstance;
			}
			set { 
				_PlanInstance = value;
				idPlanInstance = _PlanInstance.Id;
			}
		}

		public int idAccountMain
		{
			get => _data.idAccountMain;
			set
			{
				_data.idAccountMain = value;
				_AccountMain = null;
			}
		}

		private Account _AccountMain;

		public Account AccountMain
		{
			get
			{
				if (_AccountMain == null)
				{
					_AccountMain = new Account(_data.idAccountMain);
					return _AccountMain;
				}
				else return _AccountMain;
			}
			set { 
				_AccountMain = value;
				idAccountMain = _AccountMain.Id;
			}
		}

		public int idAllocationSchedule
		{
			get => _data.idAllocationSchedule.GetValueOrDefault();
			set
			{
				_data.idAllocationSchedule = value;
				_AllocationSchedule = null;
			}
		}

		private PlanAllocationSchedule _AllocationSchedule;

		public PlanAllocationSchedule AllocationSchedule
		{
			get
			{
				if (_AllocationSchedule == null)
				{
					if (_data.idAllocationSchedule == null) return null;
					else
					{
						_AllocationSchedule = new PlanAllocationSchedule(_data.idAllocationSchedule.GetValueOrDefault());
						return _AllocationSchedule;
					}
				}
				else return _AllocationSchedule;
			}
			set { 
				_AllocationSchedule = value;
				idAllocationSchedule = _AllocationSchedule.Id;
			}
		}

		public short TypeRepeat
		{
			get => _data.TypeRepeat;
			set { _data.TypeRepeat = value; }
		}

		public int idAccountAdvanceAccrual
		{
			get => _data.idAccountAdvanceAccrual.GetValueOrDefault();
			set
			{
				_data.idAccountAdvanceAccrual = value;
				_AccountAdvanceAccrual = null;
			}
		}

		private Account _AccountAdvanceAccrual;

		public Account AccountAdvanceAccrual
		{
			get
			{
				if (_AccountAdvanceAccrual == null)
				{
					if (_data.idAccountAdvanceAccrual == null) return null;
					else
					{
						_AccountAdvanceAccrual = new Account(_data.idAccountAdvanceAccrual.GetValueOrDefault());
						return _AccountAdvanceAccrual;
					}
				}
				else return _AccountAdvanceAccrual;
			}
			set { 
				_AccountAdvanceAccrual = value;
				idAccountAdvanceAccrual = _AccountAdvanceAccrual.Id;
			}
		}

		public int AdvanceDelay
		{
			get => _data.AdvanceDelay;
			set { _data.AdvanceDelay = value; }
		}

		public int idAccrualSchedule
		{
			get => _data.idAccrualSchedule.GetValueOrDefault();
			set
			{
				_data.idAccrualSchedule = value;
				_AccrualSchedule = null;
			}
		}

		private PlanAllocationSchedule _AccrualSchedule;

		public PlanAllocationSchedule AccrualSchedule
		{
			get
			{
				if (_AccrualSchedule == null)
				{
					if (_data.idAccrualSchedule == null) return null;
					else
					{
						_AccrualSchedule = new PlanAllocationSchedule(_data.idAccrualSchedule.GetValueOrDefault());
						return _AccrualSchedule;
					}
				}
				else return _AccrualSchedule;
			}
			set { 
				_AccrualSchedule = value;
				idAccrualSchedule = _AccrualSchedule.Id;
			}
		}

		public int idDepreciationRule
		{
			get => _data.idDepreciationRule.GetValueOrDefault();
			set
			{
				_data.idDepreciationRule = value;
				_DepreciationRule = null;
			}
		}

		private DepreciationRule _DepreciationRule;

		public DepreciationRule DepreciationRule
		{
			get
			{
				if (_DepreciationRule == null)
				{
					if (_data.idDepreciationRule == null) return null;
					else
					{
						_DepreciationRule = new DepreciationRule(_data.idDepreciationRule.GetValueOrDefault());
						return _DepreciationRule;
					}
				}
				else return _DepreciationRule;
			}
			set { 
				_DepreciationRule = value;
				idDepreciationRule = _DepreciationRule.Id;
			}
		}

		public int idDepreciationTrigger
		{
			get => _data.idDepreciationTrigger.GetValueOrDefault();
			set
			{
				_data.idDepreciationTrigger = value;
				_DepreciationTrigger = null;
			}
		}

		private PlanParameter _DepreciationTrigger;

		public PlanParameter DepreciationTrigger
		{
			get
			{
				if (_DepreciationTrigger == null)
				{
					if (_data.idDepreciationTrigger == null) return null;
					else
					{
						_DepreciationTrigger = new PlanParameter(_data.idDepreciationTrigger.GetValueOrDefault());
						return _DepreciationTrigger;
					}
				}
				else return _DepreciationTrigger;
			}
			set { 
				_DepreciationTrigger = value;
				idDepreciationTrigger = _DepreciationTrigger.Id;
			}
		}

		public int DepreciationDelay
		{
			get => _data.DepreciationDelay;
			set { _data.DepreciationDelay = value; }
		}

		public int idVATRule
		{
			get => _data.idVATRule.GetValueOrDefault();
			set
			{
				_data.idVATRule = value;
				_VATRule = null;
			}
		}

		private VATRule _VATRule;

		public VATRule VATRule
		{
			get
			{
				if (_VATRule == null)
				{
					if (_data.idVATRule == null) return null;
					else
					{
						_VATRule = new VATRule(_data.idVATRule.GetValueOrDefault());
						return _VATRule;
					}
				}
				else return _VATRule;
			}
			set { 
				_VATRule = value;
				idVATRule = _VATRule.Id;
			}
		}

		public int idParInflation
		{
			get => _data.idParInflation.GetValueOrDefault();
			set
			{
				_data.idParInflation = value;
				_ParInflation = null;
			}
		}

		private PlanParameter _ParInflation;

		public PlanParameter ParInflation
		{
			get
			{
				if (_ParInflation == null)
				{
					if (_data.idParInflation == null) return null;
					else
					{
						_ParInflation = new PlanParameter(_data.idParInflation.GetValueOrDefault());
						return _ParInflation;
					}
				}
				else return _ParInflation;
			}
			set { 
				_ParInflation = value;
				idParInflation = _ParInflation.Id;
			}
		}

		public int idParPrice1
		{
			get => _data.idParPrice1.GetValueOrDefault();
			set
			{
				_data.idParPrice1 = value;
				_ParPrice1 = null;
			}
		}

		private PlanParameter _ParPrice1;

		public PlanParameter ParPrice1
		{
			get
			{
				if (_ParPrice1 == null)
				{
					if (_data.idParPrice1 == null) return null;
					else
					{
						_ParPrice1 = new PlanParameter(_data.idParPrice1.GetValueOrDefault());
						return _ParPrice1;
					}
				}
				else return _ParPrice1;
			}
			set { 
				_ParPrice1 = value;
				idParPrice1 = _ParPrice1.Id;
			}
		}

		public int idParPrice2
		{
			get => _data.idParPrice2.GetValueOrDefault();
			set
			{
				_data.idParPrice2 = value;
				_ParPrice2 = null;
			}
		}

		private PlanParameter _ParPrice2;

		public PlanParameter ParPrice2
		{
			get
			{
				if (_ParPrice2 == null)
				{
					if (_data.idParPrice2 == null) return null;
					else
					{
						_ParPrice2 = new PlanParameter(_data.idParPrice2.GetValueOrDefault());
						return _ParPrice2;
					}
				}
				else return _ParPrice2;
			}
			set { 
				_ParPrice2 = value;
				idParPrice2 = _ParPrice2.Id;
			}
		}

		public int idCurrencyContract
		{
			get => _data.idCurrencyContract;
			set
			{
				_data.idCurrencyContract = value;
				_CurrencyContract = null;
			}
		}

		private Currency _CurrencyContract;

		public Currency CurrencyContract
		{
			get
			{
				if (_CurrencyContract == null)
				{
					_CurrencyContract = new Currency(_data.idCurrencyContract);
					return _CurrencyContract;
				}
				else return _CurrencyContract;
			}
			set { 
				_CurrencyContract = value;
				idCurrencyContract = _CurrencyContract.Id;
			}
		}

		public int idParTriggerDate
		{
			get => _data.idParTriggerDate.GetValueOrDefault();
			set
			{
				_data.idParTriggerDate = value;
				_ParTriggerDate = null;
			}
		}

		private PlanParameter _ParTriggerDate;

		public PlanParameter ParTriggerDate
		{
			get
			{
				if (_ParTriggerDate == null)
				{
					if (_data.idParTriggerDate == null) return null;
					else
					{
						_ParTriggerDate = new PlanParameter(_data.idParTriggerDate.GetValueOrDefault());
						return _ParTriggerDate;
					}
				}
				else return _ParTriggerDate;
			}
			set { 
				_ParTriggerDate = value;
				idParTriggerDate = _ParTriggerDate.Id;
			}
		}

		public bool ContractFlagBaseline
		{
			get => _data.ContractFlagBaseline;
			set { _data.ContractFlagBaseline = value; }
		}

		public bool FlagDateOffset
		{
			get => _data.FlagDateOffset;
			set { _data.FlagDateOffset = value; }
		}

		public int DueDateYear
		{
			get => _data.DueDateYear;
			set { _data.DueDateYear = value; }
		}

		public int DueDateMonth
		{
			get => _data.DueDateMonth;
			set { _data.DueDateMonth = value; }
		}

		public int DueDateDay
		{
			get => _data.DueDateDay;
			set { _data.DueDateDay = value; }
		}

		public int UntilDateYearContract
		{
			get => _data.UntilDateYearContract;
			set { _data.UntilDateYearContract = value; }
		}

		public int UntilDateMonthContract
		{
			get => _data.UntilDateMonthContract;
			set { _data.UntilDateMonthContract = value; }
		}

		public int UntilDateDayContract
		{
			get => _data.UntilDateDayContract.GetValueOrDefault();
			set { _data.UntilDateDayContract = value; }
		}

		public int PaymentTerm
		{
			get => _data.PaymentTerm;
			set { _data.PaymentTerm = value; }
		}

		public int NumberOfUnits
		{
			get => _data.NumberOfUnits;
			set { _data.NumberOfUnits = value; }
		}

		public double Price
		{
			get => _data.Price;
			set { _data.Price = value; }
		}

		public DateTime PriceDate
		{
			get => _data.PriceDate.GetValueOrDefault();
			set { _data.PriceDate = value; }
		}

		public double BudgetBase
		{
			get => _data.BudgetBase;
			set { _data.BudgetBase = value; }
		}

		public double ContingencyRate
		{
			get => _data.ContingencyRate;
			set { _data.ContingencyRate = value; }
		}

		public double BudgetContingency
		{
			get => _data.BudgetContingency;
			set { _data.BudgetContingency = value; }
		}

		public string Assumptions
		{
			get => _data.Assumptions;
			set { _data.Assumptions = value; }
		}

		public string Revisions
		{
			get => _data.Revisions;
			set { _data.Revisions = value; }
		}

	}


	public partial interface IPlanElement
	{
		int Id { get; set; }
		Boolean bound { get; }
		int IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		int idClient { get; set; }
		Client Client { get; set; }
		int idCostCenterPlanElement { get; set; }
		CostCenter CostCenterPlanElement { get; set; }
		short TypePlanElement { get; set; }
		int idPlanGroup { get; set; }
		PlanGroup PlanGroup { get; set; }
		string TitlePlanElement { get; set; }
		string ReferenceIDPlanElement { get; set; }
		bool ElementFlagBaseline { get; set; }
		string PlanElementDescription { get; set; }
	}


	public partial class PlanElement : IPlanElement, IBusinessObject<tPlanElement>
	{
		private VerumDBContext _db = new VerumDBContext();


		private tPlanElement _data = new tPlanElement();
		public tPlanElement data { get => _data; set => _data = value; }


		private Boolean _bound = false;
		public Boolean bound { get => _bound; }


		public PlanElement() { }
		public PlanElement(int id)
		{
			_id = id;
			Load();
		}


		private void Load()
		{
			tPlanElement o;


			if (_id == 0) _bound = false;
			else
			{
				o = _db.tPlanElement.Where<tPlanElement>(b => b.Id == _id).FirstOrDefault();


				if (o == null)
				{
					_data = new tPlanElement();
					_bound = false;
				}
				else
				{
					_data = o;
					_bound = true;
				}
			}
		}
		public int CommitChanges()
		{
			_db.tPlanElement.Add(_data);
			return _db.SaveChanges();
		}
		private int _id = 0;
		public int Id
		{
			get => _id;


			set
			{
				_id = value;
				Load();
			}
		}


		public int IdMigrate {
			get => _data.IdMigrate.GetValueOrDefault();
			set { _data.IdMigrate = value; }
		}

		public DateTime DateCreated
		{
			get => _data.DateCreated;
			set { _data.DateCreated = value; }
		}

		public DateTime DateUpdated
		{
			get => _data.DateUpdated.GetValueOrDefault();
			set { _data.DateUpdated = value; }
		}

		public int idClient
		{
			get => _data.idClient;
			set
			{
				_data.idClient = value;
				_Client = null;
			}
		}

		private Client _Client;

		public Client Client
		{
			get
			{
				if (_Client == null)
				{
					_Client = new Client(_data.idClient);
					return _Client;
				}
				else return _Client;
			}
			set { 
				_Client = value;
				idClient = _Client.Id;
			}
		}

		public int idCostCenterPlanElement
		{
			get => _data.idCostCenterPlanElement;
			set
			{
				_data.idCostCenterPlanElement = value;
				_CostCenterPlanElement = null;
			}
		}

		private CostCenter _CostCenterPlanElement;

		public CostCenter CostCenterPlanElement
		{
			get
			{
				if (_CostCenterPlanElement == null)
				{
					_CostCenterPlanElement = new CostCenter(_data.idCostCenterPlanElement);
					return _CostCenterPlanElement;
				}
				else return _CostCenterPlanElement;
			}
			set { 
				_CostCenterPlanElement = value;
				idCostCenterPlanElement = _CostCenterPlanElement.Id;
			}
		}

		public short TypePlanElement
		{
			get => _data.TypePlanElement;
			set { _data.TypePlanElement = value; }
		}

		public int idPlanGroup
		{
			get => _data.idPlanGroup;
			set
			{
				_data.idPlanGroup = value;
				_PlanGroup = null;
			}
		}

		private PlanGroup _PlanGroup;

		public PlanGroup PlanGroup
		{
			get
			{
				if (_PlanGroup == null)
				{
					_PlanGroup = new PlanGroup(_data.idPlanGroup);
					return _PlanGroup;
				}
				else return _PlanGroup;
			}
			set { 
				_PlanGroup = value;
				idPlanGroup = _PlanGroup.Id;
			}
		}

		public string TitlePlanElement
		{
			get => _data.TitlePlanElement;
			set { _data.TitlePlanElement = value; }
		}

		public string ReferenceIDPlanElement
		{
			get => _data.ReferenceIDPlanElement;
			set { _data.ReferenceIDPlanElement = value; }
		}

		public bool ElementFlagBaseline
		{
			get => _data.ElementFlagBaseline;
			set { _data.ElementFlagBaseline = value; }
		}

		public string PlanElementDescription
		{
			get => _data.PlanElementDescription;
			set { _data.PlanElementDescription = value; }
		}

	}


	public partial interface IPlanElementInstance
	{
		int Id { get; set; }
		Boolean bound { get; }
		int IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		int idPlanElement { get; set; }
		PlanElement PlanElement { get; set; }
		int idPlan { get; set; }
		Plan Plan { get; set; }
		int idPlanItem { get; set; }
	}


	public partial class PlanElementInstance : IPlanElementInstance, IBusinessObject<tPlanElementInstance>
	{
		private VerumDBContext _db = new VerumDBContext();


		private tPlanElementInstance _data = new tPlanElementInstance();
		public tPlanElementInstance data { get => _data; set => _data = value; }


		private Boolean _bound = false;
		public Boolean bound { get => _bound; }


		public PlanElementInstance() { }
		public PlanElementInstance(int id)
		{
			_id = id;
			Load();
		}


		private void Load()
		{
			tPlanElementInstance o;


			if (_id == 0) _bound = false;
			else
			{
				o = _db.tPlanElementInstance.Where<tPlanElementInstance>(b => b.Id == _id).FirstOrDefault();


				if (o == null)
				{
					_data = new tPlanElementInstance();
					_bound = false;
				}
				else
				{
					_data = o;
					_bound = true;
				}
			}
		}
		public int CommitChanges()
		{
			_db.tPlanElementInstance.Add(_data);
			return _db.SaveChanges();
		}
		private int _id = 0;
		public int Id
		{
			get => _id;


			set
			{
				_id = value;
				Load();
			}
		}


		public int IdMigrate {
			get => _data.IdMigrate.GetValueOrDefault();
			set { _data.IdMigrate = value; }
		}

		public DateTime DateCreated
		{
			get => _data.DateCreated;
			set { _data.DateCreated = value; }
		}

		public DateTime DateUpdated
		{
			get => _data.DateUpdated.GetValueOrDefault();
			set { _data.DateUpdated = value; }
		}

		public int idPlanElement
		{
			get => _data.idPlanElement;
			set
			{
				_data.idPlanElement = value;
				_PlanElement = null;
			}
		}

		private PlanElement _PlanElement;

		public PlanElement PlanElement
		{
			get
			{
				if (_PlanElement == null)
				{
					_PlanElement = new PlanElement(_data.idPlanElement);
					return _PlanElement;
				}
				else return _PlanElement;
			}
			set { 
				_PlanElement = value;
				idPlanElement = _PlanElement.Id;
			}
		}

		public int idPlan
		{
			get => _data.idPlan;
			set
			{
				_data.idPlan = value;
				_Plan = null;
			}
		}

		private Plan _Plan;

		public Plan Plan
		{
			get
			{
				if (_Plan == null)
				{
					_Plan = new Plan(_data.idPlan);
					return _Plan;
				}
				else return _Plan;
			}
			set { 
				_Plan = value;
				idPlan = _Plan.Id;
			}
		}

		public int idPlanItem
		{
			get => _data.idPlanItem.GetValueOrDefault();
			set { _data.idPlanItem = value; }
		}

	}


	public partial interface IPlanExchangeRate
	{
		int Id { get; set; }
		Boolean bound { get; }
		int IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		int idPlan { get; set; }
		Plan Plan { get; set; }
		string TitlePlanXRate { get; set; }
		int idCurrencyExchangeRate { get; set; }
		Currency CurrencyExchangeRate { get; set; }
		double RatePerClientCurrency { get; set; }
	}


	public partial class PlanExchangeRate : IPlanExchangeRate, IBusinessObject<tPlanExchangeRate>
	{
		private VerumDBContext _db = new VerumDBContext();


		private tPlanExchangeRate _data = new tPlanExchangeRate();
		public tPlanExchangeRate data { get => _data; set => _data = value; }


		private Boolean _bound = false;
		public Boolean bound { get => _bound; }


		public PlanExchangeRate() { }
		public PlanExchangeRate(int id)
		{
			_id = id;
			Load();
		}


		private void Load()
		{
			tPlanExchangeRate o;


			if (_id == 0) _bound = false;
			else
			{
				o = _db.tPlanExchangeRate.Where<tPlanExchangeRate>(b => b.Id == _id).FirstOrDefault();


				if (o == null)
				{
					_data = new tPlanExchangeRate();
					_bound = false;
				}
				else
				{
					_data = o;
					_bound = true;
				}
			}
		}
		public int CommitChanges()
		{
			_db.tPlanExchangeRate.Add(_data);
			return _db.SaveChanges();
		}
		private int _id = 0;
		public int Id
		{
			get => _id;


			set
			{
				_id = value;
				Load();
			}
		}


		public int IdMigrate {
			get => _data.IdMigrate.GetValueOrDefault();
			set { _data.IdMigrate = value; }
		}

		public DateTime DateCreated
		{
			get => _data.DateCreated;
			set { _data.DateCreated = value; }
		}

		public DateTime DateUpdated
		{
			get => _data.DateUpdated.GetValueOrDefault();
			set { _data.DateUpdated = value; }
		}

		public int idPlan
		{
			get => _data.idPlan;
			set
			{
				_data.idPlan = value;
				_Plan = null;
			}
		}

		private Plan _Plan;

		public Plan Plan
		{
			get
			{
				if (_Plan == null)
				{
					_Plan = new Plan(_data.idPlan);
					return _Plan;
				}
				else return _Plan;
			}
			set { 
				_Plan = value;
				idPlan = _Plan.Id;
			}
		}

		public string TitlePlanXRate
		{
			get => _data.TitlePlanXRate;
			set { _data.TitlePlanXRate = value; }
		}

		public int idCurrencyExchangeRate
		{
			get => _data.idCurrencyExchangeRate;
			set
			{
				_data.idCurrencyExchangeRate = value;
				_CurrencyExchangeRate = null;
			}
		}

		private Currency _CurrencyExchangeRate;

		public Currency CurrencyExchangeRate
		{
			get
			{
				if (_CurrencyExchangeRate == null)
				{
					_CurrencyExchangeRate = new Currency(_data.idCurrencyExchangeRate);
					return _CurrencyExchangeRate;
				}
				else return _CurrencyExchangeRate;
			}
			set { 
				_CurrencyExchangeRate = value;
				idCurrencyExchangeRate = _CurrencyExchangeRate.Id;
			}
		}

		public double RatePerClientCurrency
		{
			get => _data.RatePerClientCurrency;
			set { _data.RatePerClientCurrency = value; }
		}

	}


	public partial interface IPlanFunctionDef
	{
		int Id { get; set; }
		Boolean bound { get; }
		int IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		string TitleFunctionDef { get; set; }
	}


	public partial class PlanFunctionDef : IPlanFunctionDef, IBusinessObject<tPlanFunctionDef>
	{
		private VerumDBContext _db = new VerumDBContext();


		private tPlanFunctionDef _data = new tPlanFunctionDef();
		public tPlanFunctionDef data { get => _data; set => _data = value; }


		private Boolean _bound = false;
		public Boolean bound { get => _bound; }


		public PlanFunctionDef() { }
		public PlanFunctionDef(int id)
		{
			_id = id;
			Load();
		}


		private void Load()
		{
			tPlanFunctionDef o;


			if (_id == 0) _bound = false;
			else
			{
				o = _db.tPlanFunctionDef.Where<tPlanFunctionDef>(b => b.Id == _id).FirstOrDefault();


				if (o == null)
				{
					_data = new tPlanFunctionDef();
					_bound = false;
				}
				else
				{
					_data = o;
					_bound = true;
				}
			}
		}
		public int CommitChanges()
		{
			_db.tPlanFunctionDef.Add(_data);
			return _db.SaveChanges();
		}
		private int _id = 0;
		public int Id
		{
			get => _id;


			set
			{
				_id = value;
				Load();
			}
		}


		public int IdMigrate {
			get => _data.IdMigrate.GetValueOrDefault();
			set { _data.IdMigrate = value; }
		}

		public DateTime DateCreated
		{
			get => _data.DateCreated;
			set { _data.DateCreated = value; }
		}

		public DateTime DateUpdated
		{
			get => _data.DateUpdated.GetValueOrDefault();
			set { _data.DateUpdated = value; }
		}

		public string TitleFunctionDef
		{
			get => _data.TitleFunctionDef;
			set { _data.TitleFunctionDef = value; }
		}

	}


	public partial interface IPlanGroup
	{
		int Id { get; set; }
		Boolean bound { get; }
		int IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		int idClient { get; set; }
		Client Client { get; set; }
		string TitlePlanGroup { get; set; }
	}


	public partial class PlanGroup : IPlanGroup, IBusinessObject<tPlanGroup>
	{
		private VerumDBContext _db = new VerumDBContext();


		private tPlanGroup _data = new tPlanGroup();
		public tPlanGroup data { get => _data; set => _data = value; }


		private Boolean _bound = false;
		public Boolean bound { get => _bound; }


		public PlanGroup() { }
		public PlanGroup(int id)
		{
			_id = id;
			Load();
		}


		private void Load()
		{
			tPlanGroup o;


			if (_id == 0) _bound = false;
			else
			{
				o = _db.tPlanGroup.Where<tPlanGroup>(b => b.Id == _id).FirstOrDefault();


				if (o == null)
				{
					_data = new tPlanGroup();
					_bound = false;
				}
				else
				{
					_data = o;
					_bound = true;
				}
			}
		}
		public int CommitChanges()
		{
			_db.tPlanGroup.Add(_data);
			return _db.SaveChanges();
		}
		private int _id = 0;
		public int Id
		{
			get => _id;


			set
			{
				_id = value;
				Load();
			}
		}


		public int IdMigrate {
			get => _data.IdMigrate.GetValueOrDefault();
			set { _data.IdMigrate = value; }
		}

		public DateTime DateCreated
		{
			get => _data.DateCreated;
			set { _data.DateCreated = value; }
		}

		public DateTime DateUpdated
		{
			get => _data.DateUpdated.GetValueOrDefault();
			set { _data.DateUpdated = value; }
		}

		public int idClient
		{
			get => _data.idClient;
			set
			{
				_data.idClient = value;
				_Client = null;
			}
		}

		private Client _Client;

		public Client Client
		{
			get
			{
				if (_Client == null)
				{
					_Client = new Client(_data.idClient);
					return _Client;
				}
				else return _Client;
			}
			set { 
				_Client = value;
				idClient = _Client.Id;
			}
		}

		public string TitlePlanGroup
		{
			get => _data.TitlePlanGroup;
			set { _data.TitlePlanGroup = value; }
		}

	}


	public partial interface IPlanParameter
	{
		int Id { get; set; }
		Boolean bound { get; }
		int IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		int idPlan { get; set; }
		Plan Plan { get; set; }
		short TypePlanParameter { get; set; }
		string TitlePlanParameter { get; set; }
		double ValueNum { get; set; }
		DateTime ValueDate { get; set; }
		string ValueText { get; set; }
		string UnitParameter { get; set; }
		string PlanParameterComment { get; set; }
	}


	public partial class PlanParameter : IPlanParameter, IBusinessObject<tPlanParameter>
	{
		private VerumDBContext _db = new VerumDBContext();


		private tPlanParameter _data = new tPlanParameter();
		public tPlanParameter data { get => _data; set => _data = value; }


		private Boolean _bound = false;
		public Boolean bound { get => _bound; }


		public PlanParameter() { }
		public PlanParameter(int id)
		{
			_id = id;
			Load();
		}


		private void Load()
		{
			tPlanParameter o;


			if (_id == 0) _bound = false;
			else
			{
				o = _db.tPlanParameter.Where<tPlanParameter>(b => b.Id == _id).FirstOrDefault();


				if (o == null)
				{
					_data = new tPlanParameter();
					_bound = false;
				}
				else
				{
					_data = o;
					_bound = true;
				}
			}
		}
		public int CommitChanges()
		{
			_db.tPlanParameter.Add(_data);
			return _db.SaveChanges();
		}
		private int _id = 0;
		public int Id
		{
			get => _id;


			set
			{
				_id = value;
				Load();
			}
		}


		public int IdMigrate {
			get => _data.IdMigrate.GetValueOrDefault();
			set { _data.IdMigrate = value; }
		}

		public DateTime DateCreated
		{
			get => _data.DateCreated;
			set { _data.DateCreated = value; }
		}

		public DateTime DateUpdated
		{
			get => _data.DateUpdated.GetValueOrDefault();
			set { _data.DateUpdated = value; }
		}

		public int idPlan
		{
			get => _data.idPlan;
			set
			{
				_data.idPlan = value;
				_Plan = null;
			}
		}

		private Plan _Plan;

		public Plan Plan
		{
			get
			{
				if (_Plan == null)
				{
					_Plan = new Plan(_data.idPlan);
					return _Plan;
				}
				else return _Plan;
			}
			set { 
				_Plan = value;
				idPlan = _Plan.Id;
			}
		}

		public short TypePlanParameter
		{
			get => _data.TypePlanParameter;
			set { _data.TypePlanParameter = value; }
		}

		public string TitlePlanParameter
		{
			get => _data.TitlePlanParameter;
			set { _data.TitlePlanParameter = value; }
		}

		public double ValueNum
		{
			get => _data.ValueNum;
			set { _data.ValueNum = value; }
		}

		public DateTime ValueDate
		{
			get => _data.ValueDate.GetValueOrDefault();
			set { _data.ValueDate = value; }
		}

		public string ValueText
		{
			get => _data.ValueText;
			set { _data.ValueText = value; }
		}

		public string UnitParameter
		{
			get => _data.UnitParameter;
			set { _data.UnitParameter = value; }
		}

		public string PlanParameterComment
		{
			get => _data.PlanParameterComment;
			set { _data.PlanParameterComment = value; }
		}

	}


	public partial interface IPlanTransaction
	{
		int Id { get; set; }
		Boolean bound { get; }
		int IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		int idPlan { get; set; }
		Plan Plan { get; set; }
		int idBookTransaction { get; set; }
		BookTransaction BookTransaction { get; set; }
	}


	public partial class PlanTransaction : IPlanTransaction, IBusinessObject<tPlanTransaction>
	{
		private VerumDBContext _db = new VerumDBContext();


		private tPlanTransaction _data = new tPlanTransaction();
		public tPlanTransaction data { get => _data; set => _data = value; }


		private Boolean _bound = false;
		public Boolean bound { get => _bound; }


		public PlanTransaction() { }
		public PlanTransaction(int id)
		{
			_id = id;
			Load();
		}


		private void Load()
		{
			tPlanTransaction o;


			if (_id == 0) _bound = false;
			else
			{
				o = _db.tPlanTransaction.Where<tPlanTransaction>(b => b.Id == _id).FirstOrDefault();


				if (o == null)
				{
					_data = new tPlanTransaction();
					_bound = false;
				}
				else
				{
					_data = o;
					_bound = true;
				}
			}
		}
		public int CommitChanges()
		{
			_db.tPlanTransaction.Add(_data);
			return _db.SaveChanges();
		}
		private int _id = 0;
		public int Id
		{
			get => _id;


			set
			{
				_id = value;
				Load();
			}
		}


		public int IdMigrate {
			get => _data.IdMigrate.GetValueOrDefault();
			set { _data.IdMigrate = value; }
		}

		public DateTime DateCreated
		{
			get => _data.DateCreated;
			set { _data.DateCreated = value; }
		}

		public DateTime DateUpdated
		{
			get => _data.DateUpdated.GetValueOrDefault();
			set { _data.DateUpdated = value; }
		}

		public int idPlan
		{
			get => _data.idPlan;
			set
			{
				_data.idPlan = value;
				_Plan = null;
			}
		}

		private Plan _Plan;

		public Plan Plan
		{
			get
			{
				if (_Plan == null)
				{
					_Plan = new Plan(_data.idPlan);
					return _Plan;
				}
				else return _Plan;
			}
			set { 
				_Plan = value;
				idPlan = _Plan.Id;
			}
		}

		public int idBookTransaction
		{
			get => _data.idBookTransaction;
			set
			{
				_data.idBookTransaction = value;
				_BookTransaction = null;
			}
		}

		private BookTransaction _BookTransaction;

		public BookTransaction BookTransaction
		{
			get
			{
				if (_BookTransaction == null)
				{
					_BookTransaction = new BookTransaction(_data.idBookTransaction);
					return _BookTransaction;
				}
				else return _BookTransaction;
			}
			set { 
				_BookTransaction = value;
				idBookTransaction = _BookTransaction.Id;
			}
		}

	}


	public partial interface IReferenceCodes
	{
		int Id { get; set; }
		Boolean bound { get; }
		int IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		int idClient { get; set; }
		Client Client { get; set; }
		int idReferenceGroup { get; set; }
		ReferenceGroup ReferenceGroup { get; set; }
		string ReferenceCode { get; set; }
		string TitleReferenceCode { get; set; }
		string ReferenceCodeComment { get; set; }
	}


	public partial class ReferenceCodes : IReferenceCodes, IBusinessObject<tReferenceCodes>
	{
		private VerumDBContext _db = new VerumDBContext();


		private tReferenceCodes _data = new tReferenceCodes();
		public tReferenceCodes data { get => _data; set => _data = value; }


		private Boolean _bound = false;
		public Boolean bound { get => _bound; }


		public ReferenceCodes() { }
		public ReferenceCodes(int id)
		{
			_id = id;
			Load();
		}


		private void Load()
		{
			tReferenceCodes o;


			if (_id == 0) _bound = false;
			else
			{
				o = _db.tReferenceCodes.Where<tReferenceCodes>(b => b.Id == _id).FirstOrDefault();


				if (o == null)
				{
					_data = new tReferenceCodes();
					_bound = false;
				}
				else
				{
					_data = o;
					_bound = true;
				}
			}
		}
		public int CommitChanges()
		{
			_db.tReferenceCodes.Add(_data);
			return _db.SaveChanges();
		}
		private int _id = 0;
		public int Id
		{
			get => _id;


			set
			{
				_id = value;
				Load();
			}
		}


		public int IdMigrate {
			get => _data.IdMigrate.GetValueOrDefault();
			set { _data.IdMigrate = value; }
		}

		public DateTime DateCreated
		{
			get => _data.DateCreated;
			set { _data.DateCreated = value; }
		}

		public DateTime DateUpdated
		{
			get => _data.DateUpdated.GetValueOrDefault();
			set { _data.DateUpdated = value; }
		}

		public int idClient
		{
			get => _data.idClient;
			set
			{
				_data.idClient = value;
				_Client = null;
			}
		}

		private Client _Client;

		public Client Client
		{
			get
			{
				if (_Client == null)
				{
					_Client = new Client(_data.idClient);
					return _Client;
				}
				else return _Client;
			}
			set { 
				_Client = value;
				idClient = _Client.Id;
			}
		}

		public int idReferenceGroup
		{
			get => _data.idReferenceGroup;
			set
			{
				_data.idReferenceGroup = value;
				_ReferenceGroup = null;
			}
		}

		private ReferenceGroup _ReferenceGroup;

		public ReferenceGroup ReferenceGroup
		{
			get
			{
				if (_ReferenceGroup == null)
				{
					_ReferenceGroup = new ReferenceGroup(_data.idReferenceGroup);
					return _ReferenceGroup;
				}
				else return _ReferenceGroup;
			}
			set { 
				_ReferenceGroup = value;
				idReferenceGroup = _ReferenceGroup.Id;
			}
		}

		public string ReferenceCode
		{
			get => _data.ReferenceCode;
			set { _data.ReferenceCode = value; }
		}

		public string TitleReferenceCode
		{
			get => _data.TitleReferenceCode;
			set { _data.TitleReferenceCode = value; }
		}

		public string ReferenceCodeComment
		{
			get => _data.ReferenceCodeComment;
			set { _data.ReferenceCodeComment = value; }
		}

	}


	public partial interface IReferenceGroup
	{
		int Id { get; set; }
		Boolean bound { get; }
		int IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		int idClient { get; set; }
		Client Client { get; set; }
		string TypeReferenceGroup { get; set; }
		string TitleReferenceGroup { get; set; }
		string BaseCode { get; set; }
		int NextNum { get; set; }
		bool FlagAutoGen { get; set; }
		short AutoDigits { get; set; }
	}


	public partial class ReferenceGroup : IReferenceGroup, IBusinessObject<tReferenceGroup>
	{
		private VerumDBContext _db = new VerumDBContext();


		private tReferenceGroup _data = new tReferenceGroup();
		public tReferenceGroup data { get => _data; set => _data = value; }


		private Boolean _bound = false;
		public Boolean bound { get => _bound; }


		public ReferenceGroup() { }
		public ReferenceGroup(int id)
		{
			_id = id;
			Load();
		}


		private void Load()
		{
			tReferenceGroup o;


			if (_id == 0) _bound = false;
			else
			{
				o = _db.tReferenceGroup.Where<tReferenceGroup>(b => b.Id == _id).FirstOrDefault();


				if (o == null)
				{
					_data = new tReferenceGroup();
					_bound = false;
				}
				else
				{
					_data = o;
					_bound = true;
				}
			}
		}
		public int CommitChanges()
		{
			_db.tReferenceGroup.Add(_data);
			return _db.SaveChanges();
		}
		private int _id = 0;
		public int Id
		{
			get => _id;


			set
			{
				_id = value;
				Load();
			}
		}


		public int IdMigrate {
			get => _data.IdMigrate.GetValueOrDefault();
			set { _data.IdMigrate = value; }
		}

		public DateTime DateCreated
		{
			get => _data.DateCreated;
			set { _data.DateCreated = value; }
		}

		public DateTime DateUpdated
		{
			get => _data.DateUpdated.GetValueOrDefault();
			set { _data.DateUpdated = value; }
		}

		public int idClient
		{
			get => _data.idClient;
			set
			{
				_data.idClient = value;
				_Client = null;
			}
		}

		private Client _Client;

		public Client Client
		{
			get
			{
				if (_Client == null)
				{
					_Client = new Client(_data.idClient);
					return _Client;
				}
				else return _Client;
			}
			set { 
				_Client = value;
				idClient = _Client.Id;
			}
		}

		public string TypeReferenceGroup
		{
			get => _data.TypeReferenceGroup;
			set { _data.TypeReferenceGroup = value; }
		}

		public string TitleReferenceGroup
		{
			get => _data.TitleReferenceGroup;
			set { _data.TitleReferenceGroup = value; }
		}

		public string BaseCode
		{
			get => _data.BaseCode;
			set { _data.BaseCode = value; }
		}

		public int NextNum
		{
			get => _data.NextNum;
			set { _data.NextNum = value; }
		}

		public bool FlagAutoGen
		{
			get => _data.FlagAutoGen;
			set { _data.FlagAutoGen = value; }
		}

		public short AutoDigits
		{
			get => _data.AutoDigits;
			set { _data.AutoDigits = value; }
		}

	}


	public partial interface IVATRule
	{
		int Id { get; set; }
		Boolean bound { get; }
		int IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		int idClient { get; set; }
		Client Client { get; set; }
		int idAccountVATInput { get; set; }
		Account AccountVATInput { get; set; }
		int idAccountVATOutput { get; set; }
		Account AccountVATOutput { get; set; }
		string VATRuleCode { get; set; }
		string TitleVATRule { get; set; }
		double RateCurrent { get; set; }
		DateTime DateRateChange { get; set; }
		double RateFuture { get; set; }
		bool FlagReverseCharge { get; set; }
	}


	public partial class VATRule : IVATRule, IBusinessObject<tVATRule>
	{
		private VerumDBContext _db = new VerumDBContext();


		private tVATRule _data = new tVATRule();
		public tVATRule data { get => _data; set => _data = value; }


		private Boolean _bound = false;
		public Boolean bound { get => _bound; }


		public VATRule() { }
		public VATRule(int id)
		{
			_id = id;
			Load();
		}


		private void Load()
		{
			tVATRule o;


			if (_id == 0) _bound = false;
			else
			{
				o = _db.tVATRule.Where<tVATRule>(b => b.Id == _id).FirstOrDefault();


				if (o == null)
				{
					_data = new tVATRule();
					_bound = false;
				}
				else
				{
					_data = o;
					_bound = true;
				}
			}
		}
		public int CommitChanges()
		{
			_db.tVATRule.Add(_data);
			return _db.SaveChanges();
		}
		private int _id = 0;
		public int Id
		{
			get => _id;


			set
			{
				_id = value;
				Load();
			}
		}


		public int IdMigrate {
			get => _data.IdMigrate.GetValueOrDefault();
			set { _data.IdMigrate = value; }
		}

		public DateTime DateCreated
		{
			get => _data.DateCreated;
			set { _data.DateCreated = value; }
		}

		public DateTime DateUpdated
		{
			get => _data.DateUpdated.GetValueOrDefault();
			set { _data.DateUpdated = value; }
		}

		public int idClient
		{
			get => _data.idClient;
			set
			{
				_data.idClient = value;
				_Client = null;
			}
		}

		private Client _Client;

		public Client Client
		{
			get
			{
				if (_Client == null)
				{
					_Client = new Client(_data.idClient);
					return _Client;
				}
				else return _Client;
			}
			set { 
				_Client = value;
				idClient = _Client.Id;
			}
		}

		public int idAccountVATInput
		{
			get => _data.idAccountVATInput;
			set
			{
				_data.idAccountVATInput = value;
				_AccountVATInput = null;
			}
		}

		private Account _AccountVATInput;

		public Account AccountVATInput
		{
			get
			{
				if (_AccountVATInput == null)
				{
					_AccountVATInput = new Account(_data.idAccountVATInput);
					return _AccountVATInput;
				}
				else return _AccountVATInput;
			}
			set { 
				_AccountVATInput = value;
				idAccountVATInput = _AccountVATInput.Id;
			}
		}

		public int idAccountVATOutput
		{
			get => _data.idAccountVATOutput;
			set
			{
				_data.idAccountVATOutput = value;
				_AccountVATOutput = null;
			}
		}

		private Account _AccountVATOutput;

		public Account AccountVATOutput
		{
			get
			{
				if (_AccountVATOutput == null)
				{
					_AccountVATOutput = new Account(_data.idAccountVATOutput);
					return _AccountVATOutput;
				}
				else return _AccountVATOutput;
			}
			set { 
				_AccountVATOutput = value;
				idAccountVATOutput = _AccountVATOutput.Id;
			}
		}

		public string VATRuleCode
		{
			get => _data.VATRuleCode;
			set { _data.VATRuleCode = value; }
		}

		public string TitleVATRule
		{
			get => _data.TitleVATRule;
			set { _data.TitleVATRule = value; }
		}

		public double RateCurrent
		{
			get => _data.RateCurrent;
			set { _data.RateCurrent = value; }
		}

		public DateTime DateRateChange
		{
			get => _data.DateRateChange.GetValueOrDefault();
			set { _data.DateRateChange = value; }
		}

		public double RateFuture
		{
			get => _data.RateFuture;
			set { _data.RateFuture = value; }
		}

		public bool FlagReverseCharge
		{
			get => _data.FlagReverseCharge;
			set { _data.FlagReverseCharge = value; }
		}

	}


}
