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
	using VerumBusinessObjects.Framework;
	using System.Runtime.InteropServices;
    using VerumBusinessObjects.Views;

	public partial interface ICurrency
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		string CurrencyCode { get; set; }
		string TitleCurrency { get; set; }
	}


	public partial class Currency : BusinessObject<tCurrency>, ICurrency
	{
		public Currency() : base() {}
		public Currency(Guid id) : base(id) {}
		public string CurrencyCode
		{
			get => _data.CurrencyCode;
			set
			{
				if (_data.CurrencyCode == value) return;
				bool valid = true;
				_CurrencyCodeValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("CurrencyCode").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.CurrencyCode = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _CurrencyCodeValid( string value, ref bool valid);

		public string TitleCurrency
		{
			get => _data.TitleCurrency;
			set
			{
				if (_data.TitleCurrency == value) return;
				bool valid = true;
				_TitleCurrencyValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TitleCurrency").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TitleCurrency = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TitleCurrencyValid( string value, ref bool valid);

	}


	public partial interface IClient
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		string TitleClient { get; set; }
		Guid idCurrencyClient { get; set; }
		Currency CurrencyClientParent { get; set; }
		bool FlagTemplate { get; set; }
		int StartOfBusinessYear { get; set; }
		[ComVisible(false)]
		int? DATEVClientNumber { get; set; }
		[ComVisible(false)]
		Guid? idReferenceGroupDefault { get; set; }
		ReferenceGroup ReferenceGroupParent { get; set; }
		[ComVisible(false)]
		DateTime? BCLastUpdate { get; set; }
		[ComVisible(false)]
		string BusinessCenterUrl { get; set; }
		int BCLastBookingCodeNo { get; set; }
	}


	public partial class Client : BusinessObject<tClient>, IClient
	{
		public Client() : base() {}
		public Client(Guid id) : base(id) {}
		public string TitleClient
		{
			get => _data.TitleClient;
			set
			{
				if (_data.TitleClient == value) return;
				bool valid = true;
				_TitleClientValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TitleClient").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TitleClient = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TitleClientValid( string value, ref bool valid);

		public Guid idCurrencyClient
		{
			get => _data.idCurrencyClient;
			set
			{
				if (_data.idCurrencyClient == value) return;
				bool valid = true;
				_idCurrencyClientValid(value, ref valid);

				if (valid)
				{
					_data.idCurrencyClient = value;
					_CurrencyClient = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idCurrencyClientValid( Guid value, ref bool valid);

		private Currency _CurrencyClient;

		public Currency CurrencyClientParent
		{
			get
			{
				if (_CurrencyClient == null || _CurrencyClient.data == null )
				{
						_CurrencyClient = new Currency();
						_CurrencyClient.Id =_data.idCurrencyClient;
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
			set
			{
				if (_data.FlagTemplate == value) return;
				bool valid = true;
				_FlagTemplateValid(value, ref valid);

				if (valid)
				{
					_data.FlagTemplate = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _FlagTemplateValid( bool value, ref bool valid);

		public int StartOfBusinessYear
		{
			get => _data.StartOfBusinessYear;
			set
			{
				if (_data.StartOfBusinessYear == value) return;
				bool valid = true;
				_StartOfBusinessYearValid(value, ref valid);

				if (valid)
				{
					_data.StartOfBusinessYear = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _StartOfBusinessYearValid( int value, ref bool valid);

		public int? DATEVClientNumber
		{
			get => _data.DATEVClientNumber.GetValueOrDefault();
			set
			{
				if (_data.DATEVClientNumber == value) return;
				bool valid = true;
				_DATEVClientNumberValid(value, ref valid);

				if (valid)
				{
					_data.DATEVClientNumber = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _DATEVClientNumberValid( int? value, ref bool valid);

		public Guid? idReferenceGroupDefault
		{
			get => _data.idReferenceGroupDefault.GetValueOrDefault();
			set
			{
				if (_data.idReferenceGroupDefault == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idReferenceGroupDefaultValid(value, ref valid);

				if (valid)
				{
					_data.idReferenceGroupDefault = value;
					_ReferenceGroup = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idReferenceGroupDefaultValid( Guid? value, ref bool valid);

		private ReferenceGroup _ReferenceGroup;

		public ReferenceGroup ReferenceGroupParent
		{
			get
			{
				if (_ReferenceGroup == null || _ReferenceGroup.data == null )
				{
					if (_data.idReferenceGroupDefault == null) return null;
					else
					{
						_ReferenceGroup = new ReferenceGroup();
						_ReferenceGroup.Id =_data.idReferenceGroupDefault.GetValueOrDefault();
						return _ReferenceGroup;
					}
				}
				else return _ReferenceGroup;
			}
			set { 
				_ReferenceGroup = value;
				idReferenceGroupDefault = _ReferenceGroup.Id;
			}
		}

		public DateTime? BCLastUpdate
		{
			get => _data.BCLastUpdate.GetValueOrDefault();
			set
			{
				if (_data.BCLastUpdate == value) return;
				bool valid = true;
				_BCLastUpdateValid(value, ref valid);

				if (valid)
				{
					_data.BCLastUpdate = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _BCLastUpdateValid( DateTime? value, ref bool valid);

		public string BusinessCenterUrl
		{
			get => _data.BusinessCenterUrl;
			set
			{
				if (_data.BusinessCenterUrl == value) return;
				bool valid = true;
				_BusinessCenterUrlValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("BusinessCenterUrl").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.BusinessCenterUrl = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _BusinessCenterUrlValid( string value, ref bool valid);

		public int BCLastBookingCodeNo
		{
			get => _data.BCLastBookingCodeNo;
			set
			{
				if (_data.BCLastBookingCodeNo == value) return;
				bool valid = true;
				_BCLastBookingCodeNoValid(value, ref valid);

				if (valid)
				{
					_data.BCLastBookingCodeNo = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _BCLastBookingCodeNoValid( int value, ref bool valid);

	}


	public partial interface ITypeGroupDef
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		string TypeGroupID { get; set; }
	}


	public partial class TypeGroupDef : BusinessObject<tTypeGroupDef>, ITypeGroupDef
	{
		public TypeGroupDef() : base() {}
		public TypeGroupDef(Guid id) : base(id) {}
		public string TypeGroupID
		{
			get => _data.TypeGroupID;
			set
			{
				if (_data.TypeGroupID == value) return;
				bool valid = true;
				_TypeGroupIDValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TypeGroupID").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TypeGroupID = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TypeGroupIDValid( string value, ref bool valid);

	}


	public partial interface ITypeCodeDef
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idTypeGroupDef { get; set; }
		TypeGroupDef TypeGroupDefParent { get; set; }
		string TypeID { get; set; }
		short TypeCode { get; set; }
	}


	public partial class TypeCodeDef : BusinessObject<tTypeCodeDef>, ITypeCodeDef
	{
		public TypeCodeDef() : base() {}
		public TypeCodeDef(Guid id) : base(id) {}
		public Guid idTypeGroupDef
		{
			get => _data.idTypeGroupDef;
			set
			{
				if (_data.idTypeGroupDef == value) return;
				bool valid = true;
				_idTypeGroupDefValid(value, ref valid);

				if (valid)
				{
					_data.idTypeGroupDef = value;
					_TypeGroupDef = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idTypeGroupDefValid( Guid value, ref bool valid);

		private TypeGroupDef _TypeGroupDef;

		public TypeGroupDef TypeGroupDefParent
		{
			get
			{
				if (_TypeGroupDef == null || _TypeGroupDef.data == null )
				{
						_TypeGroupDef = new TypeGroupDef();
						_TypeGroupDef.Id =_data.idTypeGroupDef;
					return _TypeGroupDef;
				}
				else return _TypeGroupDef;
			}
			set { 
				_TypeGroupDef = value;
				idTypeGroupDef = _TypeGroupDef.Id;
			}
		}

		public string TypeID
		{
			get => _data.TypeID;
			set
			{
				if (_data.TypeID == value) return;
				bool valid = true;
				_TypeIDValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TypeID").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TypeID = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TypeIDValid( string value, ref bool valid);

		public short TypeCode
		{
			get => _data.TypeCode;
			set
			{
				if (_data.TypeCode == value) return;
				bool valid = true;
				_TypeCodeValid(value, ref valid);

				if (valid)
				{
					_data.TypeCode = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TypeCodeValid( short value, ref bool valid);

	}


	public partial interface IUser
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		string UserName { get; set; }
		string UserLogin { get; set; }
		string UserPasswordHash { get; set; }
		Guid idClientDefault { get; set; }
		Client ClientDefaultParent { get; set; }
		short TypeUser { get; set; }
		[ComVisible(false)]
		string DATEVImportFolder { get; set; }
		[ComVisible(false)]
		string DataImportFolder { get; set; }
	}


	public partial class User : BusinessObject<tUser>, IUser
	{
		public User() : base() {}
		public User(Guid id) : base(id) {}
		public string UserName
		{
			get => _data.UserName;
			set
			{
				if (_data.UserName == value) return;
				bool valid = true;
				_UserNameValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("UserName").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.UserName = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _UserNameValid( string value, ref bool valid);

		public string UserLogin
		{
			get => _data.UserLogin;
			set
			{
				if (_data.UserLogin == value) return;
				bool valid = true;
				_UserLoginValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("UserLogin").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.UserLogin = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _UserLoginValid( string value, ref bool valid);

		public string UserPasswordHash
		{
			get => _data.UserPasswordHash;
			set
			{
				if (_data.UserPasswordHash == value) return;
				bool valid = true;
				_UserPasswordHashValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("UserPasswordHash").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.UserPasswordHash = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _UserPasswordHashValid( string value, ref bool valid);

		public Guid idClientDefault
		{
			get => _data.idClientDefault;
			set
			{
				if (_data.idClientDefault == value) return;
				bool valid = true;
				_idClientDefaultValid(value, ref valid);

				if (valid)
				{
					_data.idClientDefault = value;
					_ClientDefault = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idClientDefaultValid( Guid value, ref bool valid);

		private Client _ClientDefault;

		public Client ClientDefaultParent
		{
			get
			{
				if (_ClientDefault == null || _ClientDefault.data == null )
				{
						_ClientDefault = new Client();
						_ClientDefault.Id =_data.idClientDefault;
					return _ClientDefault;
				}
				else return _ClientDefault;
			}
			set { 
				_ClientDefault = value;
				idClientDefault = _ClientDefault.Id;
			}
		}

		public short TypeUser
		{
			get => _data.TypeUser;
			set
			{
				if (_data.TypeUser == value) return;
				bool valid = true;
				_TypeUserValid(value, ref valid);

				if (valid)
				{
					_data.TypeUser = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TypeUserValid( short value, ref bool valid);

		public string DATEVImportFolder
		{
			get => _data.DATEVImportFolder;
			set
			{
				if (_data.DATEVImportFolder == value) return;
				bool valid = true;
				_DATEVImportFolderValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("DATEVImportFolder").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.DATEVImportFolder = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _DATEVImportFolderValid( string value, ref bool valid);

		public string DataImportFolder
		{
			get => _data.DataImportFolder;
			set
			{
				if (_data.DataImportFolder == value) return;
				bool valid = true;
				_DataImportFolderValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("DataImportFolder").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.DataImportFolder = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _DataImportFolderValid( string value, ref bool valid);

	}


	public partial interface ISession
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idUser { get; set; }
		User SessionUserParent { get; set; }
		Guid idClient { get; set; }
		Client SessionClientParent { get; set; }
	}


	public partial class Session : BusinessObject<tSession>, ISession
	{
		public Session() : base() {}
		public Session(Guid id) : base(id) {}
		public Guid idUser
		{
			get => _data.idUser;
			set
			{
				if (_data.idUser == value) return;
				bool valid = true;
				_idUserValid(value, ref valid);

				if (valid)
				{
					_data.idUser = value;
					_SessionUser = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idUserValid( Guid value, ref bool valid);

		private User _SessionUser;

		public User SessionUserParent
		{
			get
			{
				if (_SessionUser == null || _SessionUser.data == null )
				{
						_SessionUser = new User();
						_SessionUser.Id =_data.idUser;
					return _SessionUser;
				}
				else return _SessionUser;
			}
			set { 
				_SessionUser = value;
				idUser = _SessionUser.Id;
			}
		}

		public Guid idClient
		{
			get => _data.idClient;
			set
			{
				if (_data.idClient == value) return;
				bool valid = true;
				_idClientValid(value, ref valid);

				if (valid)
				{
					_data.idClient = value;
					_SessionClient = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idClientValid( Guid value, ref bool valid);

		private Client _SessionClient;

		public Client SessionClientParent
		{
			get
			{
				if (_SessionClient == null || _SessionClient.data == null )
				{
						_SessionClient = new Client();
						_SessionClient.Id =_data.idClient;
					return _SessionClient;
				}
				else return _SessionClient;
			}
			set { 
				_SessionClient = value;
				idClient = _SessionClient.Id;
			}
		}

	}


	public partial interface IJobReport
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idClient { get; set; }
		Client ClientParent { get; set; }
		[ComVisible(false)]
		Guid? idUser { get; set; }
		User UserParent { get; set; }
		short TypeJob { get; set; }
		DateTime DateJobStart { get; set; }
		[ComVisible(false)]
		DateTime? DateJobEnd { get; set; }
		short TypeJobSuccess { get; set; }
	}


	public partial class JobReport : BusinessObject<tJobReport>, IJobReport
	{
		public JobReport() : base() {}
		public JobReport(Guid id) : base(id) {}
		public Guid idClient
		{
			get => _data.idClient;
			set
			{
				if (_data.idClient == value) return;
				bool valid = true;
				_idClientValid(value, ref valid);

				if (valid)
				{
					_data.idClient = value;
					_Client = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idClientValid( Guid value, ref bool valid);

		private Client _Client;

		public Client ClientParent
		{
			get
			{
				if (_Client == null || _Client.data == null )
				{
						_Client = new Client();
						_Client.Id =_data.idClient;
					return _Client;
				}
				else return _Client;
			}
			set { 
				_Client = value;
				idClient = _Client.Id;
			}
		}

		public Guid? idUser
		{
			get => _data.idUser.GetValueOrDefault();
			set
			{
				if (_data.idUser == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idUserValid(value, ref valid);

				if (valid)
				{
					_data.idUser = value;
					_User = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idUserValid( Guid? value, ref bool valid);

		private User _User;

		public User UserParent
		{
			get
			{
				if (_User == null || _User.data == null )
				{
					if (_data.idUser == null) return null;
					else
					{
						_User = new User();
						_User.Id =_data.idUser.GetValueOrDefault();
						return _User;
					}
				}
				else return _User;
			}
			set { 
				_User = value;
				idUser = _User.Id;
			}
		}

		public short TypeJob
		{
			get => _data.TypeJob;
			set
			{
				if (_data.TypeJob == value) return;
				bool valid = true;
				_TypeJobValid(value, ref valid);

				if (valid)
				{
					_data.TypeJob = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TypeJobValid( short value, ref bool valid);

		public DateTime DateJobStart
		{
			get => _data.DateJobStart;
			set
			{
				if (_data.DateJobStart == value) return;
				bool valid = true;
				_DateJobStartValid(value, ref valid);

				if (valid)
				{
					_data.DateJobStart = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _DateJobStartValid( DateTime value, ref bool valid);

		public DateTime? DateJobEnd
		{
			get => _data.DateJobEnd.GetValueOrDefault();
			set
			{
				if (_data.DateJobEnd == value) return;
				bool valid = true;
				_DateJobEndValid(value, ref valid);

				if (valid)
				{
					_data.DateJobEnd = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _DateJobEndValid( DateTime? value, ref bool valid);

		public short TypeJobSuccess
		{
			get => _data.TypeJobSuccess;
			set
			{
				if (_data.TypeJobSuccess == value) return;
				bool valid = true;
				_TypeJobSuccessValid(value, ref valid);

				if (valid)
				{
					_data.TypeJobSuccess = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TypeJobSuccessValid( short value, ref bool valid);

	}


	public partial interface IJobReportItem
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idJobReport { get; set; }
		JobReport JobReportParent { get; set; }
		DateTime Timestamp { get; set; }
		short TypeJobSuccess { get; set; }
		int ResultCode { get; set; }
		[ComVisible(false)]
		string ObjectTitle { get; set; }
		[ComVisible(false)]
		string ContextInfo { get; set; }
		[ComVisible(false)]
		string Message { get; set; }
	}


	public partial class JobReportItem : BusinessObject<tJobReportItem>, IJobReportItem
	{
		public JobReportItem() : base() {}
		public JobReportItem(Guid id) : base(id) {}
		public Guid idJobReport
		{
			get => _data.idJobReport;
			set
			{
				if (_data.idJobReport == value) return;
				bool valid = true;
				_idJobReportValid(value, ref valid);

				if (valid)
				{
					_data.idJobReport = value;
					_JobReport = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idJobReportValid( Guid value, ref bool valid);

		private JobReport _JobReport;

		public JobReport JobReportParent
		{
			get
			{
				if (_JobReport == null || _JobReport.data == null )
				{
						_JobReport = new JobReport();
						_JobReport.Id =_data.idJobReport;
					return _JobReport;
				}
				else return _JobReport;
			}
			set { 
				_JobReport = value;
				idJobReport = _JobReport.Id;
			}
		}

		public DateTime Timestamp
		{
			get => _data.Timestamp;
			set
			{
				if (_data.Timestamp == value) return;
				bool valid = true;
				_TimestampValid(value, ref valid);

				if (valid)
				{
					_data.Timestamp = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TimestampValid( DateTime value, ref bool valid);

		public short TypeJobSuccess
		{
			get => _data.TypeJobSuccess;
			set
			{
				if (_data.TypeJobSuccess == value) return;
				bool valid = true;
				_TypeJobSuccessValid(value, ref valid);

				if (valid)
				{
					_data.TypeJobSuccess = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TypeJobSuccessValid( short value, ref bool valid);

		public int ResultCode
		{
			get => _data.ResultCode;
			set
			{
				if (_data.ResultCode == value) return;
				bool valid = true;
				_ResultCodeValid(value, ref valid);

				if (valid)
				{
					_data.ResultCode = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _ResultCodeValid( int value, ref bool valid);

		public string ObjectTitle
		{
			get => _data.ObjectTitle;
			set
			{
				if (_data.ObjectTitle == value) return;
				bool valid = true;
				_ObjectTitleValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("ObjectTitle").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.ObjectTitle = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _ObjectTitleValid( string value, ref bool valid);

		public string ContextInfo
		{
			get => _data.ContextInfo;
			set
			{
				if (_data.ContextInfo == value) return;
				bool valid = true;
				_ContextInfoValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("ContextInfo").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.ContextInfo = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _ContextInfoValid( string value, ref bool valid);

		public string Message
		{
			get => _data.Message;
			set
			{
				if (_data.Message == value) return;
				bool valid = true;
				_MessageValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("Message").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.Message = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _MessageValid( string value, ref bool valid);

	}


	public partial interface IAccountSection
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idClient { get; set; }
		Client ClientParent { get; set; }
		string TitleLocalSection { get; set; }
		[ComVisible(false)]
		string TitleEnglishSection { get; set; }
		short TypeAccount { get; set; }
		int SectionOrder { get; set; }
	}


	public partial class AccountSection : BusinessObject<tAccountSection>, IAccountSection
	{
		public AccountSection() : base() {}
		public AccountSection(Guid id) : base(id) {}
		public Guid idClient
		{
			get => _data.idClient;
			set
			{
				if (_data.idClient == value) return;
				bool valid = true;
				_idClientValid(value, ref valid);

				if (valid)
				{
					_data.idClient = value;
					_Client = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idClientValid( Guid value, ref bool valid);

		private Client _Client;

		public Client ClientParent
		{
			get
			{
				if (_Client == null || _Client.data == null )
				{
						_Client = new Client();
						_Client.Id =_data.idClient;
					return _Client;
				}
				else return _Client;
			}
			set { 
				_Client = value;
				idClient = _Client.Id;
			}
		}

		public string TitleLocalSection
		{
			get => _data.TitleLocalSection;
			set
			{
				if (_data.TitleLocalSection == value) return;
				bool valid = true;
				_TitleLocalSectionValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TitleLocalSection").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TitleLocalSection = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TitleLocalSectionValid( string value, ref bool valid);

		public string TitleEnglishSection
		{
			get => _data.TitleEnglishSection;
			set
			{
				if (_data.TitleEnglishSection == value) return;
				bool valid = true;
				_TitleEnglishSectionValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TitleEnglishSection").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TitleEnglishSection = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TitleEnglishSectionValid( string value, ref bool valid);

		public short TypeAccount
		{
			get => _data.TypeAccount;
			set
			{
				if (_data.TypeAccount == value) return;
				bool valid = true;
				_TypeAccountValid(value, ref valid);

				if (valid)
				{
					_data.TypeAccount = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TypeAccountValid( short value, ref bool valid);

		public int SectionOrder
		{
			get => _data.SectionOrder;
			set
			{
				if (_data.SectionOrder == value) return;
				bool valid = true;
				_SectionOrderValid(value, ref valid);

				if (valid)
				{
					_data.SectionOrder = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _SectionOrderValid( int value, ref bool valid);

	}


	public partial interface IAccountMainGroup
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idClient { get; set; }
		Guid idAccountSection { get; set; }
		AccountSection AccountSectionParent { get; set; }
		string TitleLocalMainGroup { get; set; }
		[ComVisible(false)]
		string TitleEnglishMainGroup { get; set; }
		int MainGroupOrder { get; set; }
	}


	public partial class AccountMainGroup : BusinessObject<tAccountMainGroup>, IAccountMainGroup
	{
		public AccountMainGroup() : base() {}
		public AccountMainGroup(Guid id) : base(id) {}
		public Guid idClient
		{
			get => _data.idClient;
			set
			{
				if (_data.idClient == value) return;
				bool valid = true;
				_idClientValid(value, ref valid);

				if (valid)
				{
					_data.idClient = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idClientValid( Guid value, ref bool valid);

		public Guid idAccountSection
		{
			get => _data.idAccountSection;
			set
			{
				if (_data.idAccountSection == value) return;
				bool valid = true;
				_idAccountSectionValid(value, ref valid);

				if (valid)
				{
					_data.idAccountSection = value;
					_AccountSection = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idAccountSectionValid( Guid value, ref bool valid);

		private AccountSection _AccountSection;

		public AccountSection AccountSectionParent
		{
			get
			{
				if (_AccountSection == null || _AccountSection.data == null )
				{
						_AccountSection = new AccountSection();
						_AccountSection.Id =_data.idAccountSection;
					return _AccountSection;
				}
				else return _AccountSection;
			}
			set { 
				_AccountSection = value;
				idAccountSection = _AccountSection.Id;
			}
		}

		public string TitleLocalMainGroup
		{
			get => _data.TitleLocalMainGroup;
			set
			{
				if (_data.TitleLocalMainGroup == value) return;
				bool valid = true;
				_TitleLocalMainGroupValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TitleLocalMainGroup").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TitleLocalMainGroup = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TitleLocalMainGroupValid( string value, ref bool valid);

		public string TitleEnglishMainGroup
		{
			get => _data.TitleEnglishMainGroup;
			set
			{
				if (_data.TitleEnglishMainGroup == value) return;
				bool valid = true;
				_TitleEnglishMainGroupValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TitleEnglishMainGroup").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TitleEnglishMainGroup = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TitleEnglishMainGroupValid( string value, ref bool valid);

		public int MainGroupOrder
		{
			get => _data.MainGroupOrder;
			set
			{
				if (_data.MainGroupOrder == value) return;
				bool valid = true;
				_MainGroupOrderValid(value, ref valid);

				if (valid)
				{
					_data.MainGroupOrder = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _MainGroupOrderValid( int value, ref bool valid);

	}


	public partial interface IAccountGroup
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idClient { get; set; }
		[ComVisible(false)]
		Guid? idAccountMainGroup { get; set; }
		AccountMainGroup AccountMainGroupParent { get; set; }
		string TitleLocalAccountGroup { get; set; }
		[ComVisible(false)]
		string TitleEnglishAccountGroup { get; set; }
		int AccountGroupOrder { get; set; }
		int AccountCodeFrom { get; set; }
		int AccountCodeTo { get; set; }
		[ComVisible(false)]
		Guid? idAccountReportingDefault { get; set; }
		short TypeAccountDefault { get; set; }
	}


	public partial class AccountGroup : BusinessObject<tAccountGroup>, IAccountGroup
	{
		public AccountGroup() : base() {}
		public AccountGroup(Guid id) : base(id) {}
		public Guid idClient
		{
			get => _data.idClient;
			set
			{
				if (_data.idClient == value) return;
				bool valid = true;
				_idClientValid(value, ref valid);

				if (valid)
				{
					_data.idClient = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idClientValid( Guid value, ref bool valid);

		public Guid? idAccountMainGroup
		{
			get => _data.idAccountMainGroup.GetValueOrDefault();
			set
			{
				if (_data.idAccountMainGroup == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idAccountMainGroupValid(value, ref valid);

				if (valid)
				{
					_data.idAccountMainGroup = value;
					_AccountMainGroup = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idAccountMainGroupValid( Guid? value, ref bool valid);

		private AccountMainGroup _AccountMainGroup;

		public AccountMainGroup AccountMainGroupParent
		{
			get
			{
				if (_AccountMainGroup == null || _AccountMainGroup.data == null )
				{
					if (_data.idAccountMainGroup == null) return null;
					else
					{
						_AccountMainGroup = new AccountMainGroup();
						_AccountMainGroup.Id =_data.idAccountMainGroup.GetValueOrDefault();
						return _AccountMainGroup;
					}
				}
				else return _AccountMainGroup;
			}
			set { 
				_AccountMainGroup = value;
				idAccountMainGroup = _AccountMainGroup.Id;
			}
		}

		public string TitleLocalAccountGroup
		{
			get => _data.TitleLocalAccountGroup;
			set
			{
				if (_data.TitleLocalAccountGroup == value) return;
				bool valid = true;
				_TitleLocalAccountGroupValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TitleLocalAccountGroup").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TitleLocalAccountGroup = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TitleLocalAccountGroupValid( string value, ref bool valid);

		public string TitleEnglishAccountGroup
		{
			get => _data.TitleEnglishAccountGroup;
			set
			{
				if (_data.TitleEnglishAccountGroup == value) return;
				bool valid = true;
				_TitleEnglishAccountGroupValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TitleEnglishAccountGroup").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TitleEnglishAccountGroup = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TitleEnglishAccountGroupValid( string value, ref bool valid);

		public int AccountGroupOrder
		{
			get => _data.AccountGroupOrder;
			set
			{
				if (_data.AccountGroupOrder == value) return;
				bool valid = true;
				_AccountGroupOrderValid(value, ref valid);

				if (valid)
				{
					_data.AccountGroupOrder = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _AccountGroupOrderValid( int value, ref bool valid);

		public int AccountCodeFrom
		{
			get => _data.AccountCodeFrom;
			set
			{
				if (_data.AccountCodeFrom == value) return;
				bool valid = true;
				_AccountCodeFromValid(value, ref valid);

				if (valid)
				{
					_data.AccountCodeFrom = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _AccountCodeFromValid( int value, ref bool valid);

		public int AccountCodeTo
		{
			get => _data.AccountCodeTo;
			set
			{
				if (_data.AccountCodeTo == value) return;
				bool valid = true;
				_AccountCodeToValid(value, ref valid);

				if (valid)
				{
					_data.AccountCodeTo = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _AccountCodeToValid( int value, ref bool valid);

		public Guid? idAccountReportingDefault
		{
			get => _data.idAccountReportingDefault.GetValueOrDefault();
			set
			{
				if (_data.idAccountReportingDefault == value) return;
				bool valid = true;
				_idAccountReportingDefaultValid(value, ref valid);

				if (valid)
				{
					_data.idAccountReportingDefault = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idAccountReportingDefaultValid( Guid? value, ref bool valid);

		public short TypeAccountDefault
		{
			get => _data.TypeAccountDefault;
			set
			{
				if (_data.TypeAccountDefault == value) return;
				bool valid = true;
				_TypeAccountDefaultValid(value, ref valid);

				if (valid)
				{
					_data.TypeAccountDefault = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TypeAccountDefaultValid( short value, ref bool valid);

	}


	public partial interface IAccount
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idClient { get; set; }
		[ComVisible(false)]
		Guid? idAccountGroup { get; set; }
		AccountGroup AccountGroupParent { get; set; }
		[ComVisible(false)]
		Guid? idAccountReporting { get; set; }
		Account AccountReportingParent { get; set; }
		int AccountCode { get; set; }
		short TypeAccount { get; set; }
		string TitleLocalAccount { get; set; }
		[ComVisible(false)]
		string TitleEnglishAccount { get; set; }
		bool FlagPlan { get; set; }
		[ComVisible(false)]
		Guid? idAccountSection { get; set; }
		AccountSection AccountSectionParent { get; set; }
		[ComVisible(false)]
		Guid? idAccountMainGroup { get; set; }
		AccountMainGroup AccountMainGroupParent { get; set; }
	}


	public partial class Account : BusinessObject<tAccount>, IAccount
	{
		public Account() : base() {}
		public Account(Guid id) : base(id) {}
		public Guid idClient
		{
			get => _data.idClient;
			set
			{
				if (_data.idClient == value) return;
				bool valid = true;
				_idClientValid(value, ref valid);

				if (valid)
				{
					_data.idClient = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idClientValid( Guid value, ref bool valid);

		public Guid? idAccountGroup
		{
			get => _data.idAccountGroup.GetValueOrDefault();
			set
			{
				if (_data.idAccountGroup == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idAccountGroupValid(value, ref valid);

				if (valid)
				{
					_data.idAccountGroup = value;
					_AccountGroup = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idAccountGroupValid( Guid? value, ref bool valid);

		private AccountGroup _AccountGroup;

		public AccountGroup AccountGroupParent
		{
			get
			{
				if (_AccountGroup == null || _AccountGroup.data == null )
				{
					if (_data.idAccountGroup == null) return null;
					else
					{
						_AccountGroup = new AccountGroup();
						_AccountGroup.Id =_data.idAccountGroup.GetValueOrDefault();
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

		public Guid? idAccountReporting
		{
			get => _data.idAccountReporting.GetValueOrDefault();
			set
			{
				if (_data.idAccountReporting == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idAccountReportingValid(value, ref valid);

				if (valid)
				{
					_data.idAccountReporting = value;
					_AccountReporting = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idAccountReportingValid( Guid? value, ref bool valid);

		private Account _AccountReporting;

		public Account AccountReportingParent
		{
			get
			{
				if (_AccountReporting == null || _AccountReporting.data == null )
				{
					if (_data.idAccountReporting == null) return null;
					else
					{
						_AccountReporting = new Account();
						_AccountReporting.Id =_data.idAccountReporting.GetValueOrDefault();
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
			set
			{
				if (_data.AccountCode == value) return;
				bool valid = true;
				_AccountCodeValid(value, ref valid);

				if (valid)
				{
					_data.AccountCode = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _AccountCodeValid( int value, ref bool valid);

		public short TypeAccount
		{
			get => _data.TypeAccount;
			set
			{
				if (_data.TypeAccount == value) return;
				bool valid = true;
				_TypeAccountValid(value, ref valid);

				if (valid)
				{
					_data.TypeAccount = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TypeAccountValid( short value, ref bool valid);

		public string TitleLocalAccount
		{
			get => _data.TitleLocalAccount;
			set
			{
				if (_data.TitleLocalAccount == value) return;
				bool valid = true;
				_TitleLocalAccountValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TitleLocalAccount").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TitleLocalAccount = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TitleLocalAccountValid( string value, ref bool valid);

		public string TitleEnglishAccount
		{
			get => _data.TitleEnglishAccount;
			set
			{
				if (_data.TitleEnglishAccount == value) return;
				bool valid = true;
				_TitleEnglishAccountValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TitleEnglishAccount").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TitleEnglishAccount = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TitleEnglishAccountValid( string value, ref bool valid);

		public bool FlagPlan
		{
			get => _data.FlagPlan;
			set
			{
				if (_data.FlagPlan == value) return;
				bool valid = true;
				_FlagPlanValid(value, ref valid);

				if (valid)
				{
					_data.FlagPlan = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _FlagPlanValid( bool value, ref bool valid);

		public Guid? idAccountSection
		{
			get => _data.idAccountSection.GetValueOrDefault();
			set
			{
				if (_data.idAccountSection == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idAccountSectionValid(value, ref valid);

				if (valid)
				{
					_data.idAccountSection = value;
					_AccountSection = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idAccountSectionValid( Guid? value, ref bool valid);

		private AccountSection _AccountSection;

		public AccountSection AccountSectionParent
		{
			get
			{
				if (_AccountSection == null || _AccountSection.data == null )
				{
					if (_data.idAccountSection == null) return null;
					else
					{
						_AccountSection = new AccountSection();
						_AccountSection.Id =_data.idAccountSection.GetValueOrDefault();
						return _AccountSection;
					}
				}
				else return _AccountSection;
			}
			set { 
				_AccountSection = value;
				idAccountSection = _AccountSection.Id;
			}
		}

		public Guid? idAccountMainGroup
		{
			get => _data.idAccountMainGroup.GetValueOrDefault();
			set
			{
				if (_data.idAccountMainGroup == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idAccountMainGroupValid(value, ref valid);

				if (valid)
				{
					_data.idAccountMainGroup = value;
					_AccountMainGroup = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idAccountMainGroupValid( Guid? value, ref bool valid);

		private AccountMainGroup _AccountMainGroup;

		public AccountMainGroup AccountMainGroupParent
		{
			get
			{
				if (_AccountMainGroup == null || _AccountMainGroup.data == null )
				{
					if (_data.idAccountMainGroup == null) return null;
					else
					{
						_AccountMainGroup = new AccountMainGroup();
						_AccountMainGroup.Id =_data.idAccountMainGroup.GetValueOrDefault();
						return _AccountMainGroup;
					}
				}
				else return _AccountMainGroup;
			}
			set { 
				_AccountMainGroup = value;
				idAccountMainGroup = _AccountMainGroup.Id;
			}
		}

	}


	public partial interface IPlanAccountFunction
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idClient { get; set; }
		Client ClientParent { get; set; }
		int TypeAccountFunction { get; set; }
		Guid idAccountPlanAccountFunction { get; set; }
		Account AccountPlanAccountFunctionParent { get; set; }
	}


	public partial class PlanAccountFunction : BusinessObject<tPlanAccountFunction>, IPlanAccountFunction
	{
		public PlanAccountFunction() : base() {}
		public PlanAccountFunction(Guid id) : base(id) {}
		public Guid idClient
		{
			get => _data.idClient;
			set
			{
				if (_data.idClient == value) return;
				bool valid = true;
				_idClientValid(value, ref valid);

				if (valid)
				{
					_data.idClient = value;
					_Client = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idClientValid( Guid value, ref bool valid);

		private Client _Client;

		public Client ClientParent
		{
			get
			{
				if (_Client == null || _Client.data == null )
				{
						_Client = new Client();
						_Client.Id =_data.idClient;
					return _Client;
				}
				else return _Client;
			}
			set { 
				_Client = value;
				idClient = _Client.Id;
			}
		}

		public int TypeAccountFunction
		{
			get => _data.TypeAccountFunction;
			set
			{
				if (_data.TypeAccountFunction == value) return;
				bool valid = true;
				_TypeAccountFunctionValid(value, ref valid);

				if (valid)
				{
					_data.TypeAccountFunction = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TypeAccountFunctionValid( int value, ref bool valid);

		public Guid idAccountPlanAccountFunction
		{
			get => _data.idAccountPlanAccountFunction;
			set
			{
				if (_data.idAccountPlanAccountFunction == value) return;
				bool valid = true;
				_idAccountPlanAccountFunctionValid(value, ref valid);

				if (valid)
				{
					_data.idAccountPlanAccountFunction = value;
					_AccountPlanAccountFunction = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idAccountPlanAccountFunctionValid( Guid value, ref bool valid);

		private Account _AccountPlanAccountFunction;

		public Account AccountPlanAccountFunctionParent
		{
			get
			{
				if (_AccountPlanAccountFunction == null || _AccountPlanAccountFunction.data == null )
				{
						_AccountPlanAccountFunction = new Account();
						_AccountPlanAccountFunction.Id =_data.idAccountPlanAccountFunction;
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


	public partial interface ICostCenter
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idClient { get; set; }
		Client ClientParent { get; set; }
		string CostCenterCode { get; set; }
		string TitleCostCenter { get; set; }
		[ComVisible(false)]
		string TitleEnglishCostCenter { get; set; }
		bool FlagProfitCenter { get; set; }
		[ComVisible(false)]
		string DescriptionCostCenter { get; set; }
        Guid? idBudgetResponsible { get; set; }
        Guid? idExecutiveApprover { get; set; }


    }


    public partial class CostCenter : BusinessObject<tCostCenter>, ICostCenter
	{
		public CostCenter() : base() {}
		public CostCenter(Guid id) : base(id) {}
		public Guid idClient
		{
			get => _data.idClient;
			set
			{
				if (_data.idClient == value) return;
				bool valid = true;
				_idClientValid(value, ref valid);

				if (valid)
				{
					_data.idClient = value;
					_Client = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idClientValid( Guid value, ref bool valid);
        public Guid? idBudgetResponsible
        {
            get => _data.idBudgetResponsible;
            set
            {
                if (_data.idClient == value) return;
                bool valid = true;
                _idBudgetResponsibleValid((Guid)value, ref valid);

                if (valid)
                {
                    _data.idBudgetResponsible = value;
                    _Client = null;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }

        partial void _idBudgetResponsibleValid(Guid value, ref bool valid);
        public Guid? idExecutiveApprover
        {
            get => _data.idExecutiveApprover;
            set
            {
                if (_data.idClient == value) return;
                bool valid = true;
                _idExecutiveApproverValid((Guid)value, ref valid);

                if (valid)
                {
                    _data.idExecutiveApprover = value;
                    _Client = null;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }

        partial void _idExecutiveApproverValid(Guid value, ref bool valid);

        private Client _Client;

		public Client ClientParent
		{
			get
			{
				if (_Client == null || _Client.data == null )
				{
						_Client = new Client();
						_Client.Id =_data.idClient;
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
			set
			{
				if (_data.CostCenterCode == value) return;
				bool valid = true;
				_CostCenterCodeValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("CostCenterCode").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.CostCenterCode = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _CostCenterCodeValid( string value, ref bool valid);

		public string TitleCostCenter
		{
			get => _data.TitleCostCenter;
			set
			{
				if (_data.TitleCostCenter == value) return;
				bool valid = true;
				_TitleCostCenterValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TitleCostCenter").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TitleCostCenter = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TitleCostCenterValid( string value, ref bool valid);

		public string TitleEnglishCostCenter
		{
			get => _data.TitleEnglishCostCenter;
			set
			{
				if (_data.TitleEnglishCostCenter == value) return;
				bool valid = true;
				_TitleEnglishCostCenterValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TitleEnglishCostCenter").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TitleEnglishCostCenter = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TitleEnglishCostCenterValid( string value, ref bool valid);

		public bool FlagProfitCenter
		{
			get => _data.FlagProfitCenter;
			set
			{
				if (_data.FlagProfitCenter == value) return;
				bool valid = true;
				_FlagProfitCenterValid(value, ref valid);

				if (valid)
				{
					_data.FlagProfitCenter = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _FlagProfitCenterValid( bool value, ref bool valid);

		public string DescriptionCostCenter
		{
			get => _data.DescriptionCostCenter;
			set
			{
				if (_data.DescriptionCostCenter == value) return;
				bool valid = true;
				_DescriptionCostCenterValid(value, ref valid);

				if (valid)
				{
					_data.DescriptionCostCenter = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _DescriptionCostCenterValid( string value, ref bool valid);

	}


	public partial interface IDepreciationRule
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idClient { get; set; }
		Client ClientParent { get; set; }
		Guid idAccountActivation { get; set; }
		Account AccountActivationParent { get; set; }
		[ComVisible(false)]
		Guid? idAccountDepreciation { get; set; }
		Account AccountDepreciationParent { get; set; }
		string TitleDepreciationRule { get; set; }
		int NumberOfPeriods { get; set; }
		int PeriodInMonths { get; set; }
		short TypeDepreciationRule { get; set; }
	}


	public partial class DepreciationRule : BusinessObject<tDepreciationRule>, IDepreciationRule
	{
		public DepreciationRule() : base() {}
		public DepreciationRule(Guid id) : base(id) {}
		public Guid idClient
		{
			get => _data.idClient;
			set
			{
				if (_data.idClient == value) return;
				bool valid = true;
				_idClientValid(value, ref valid);

				if (valid)
				{
					_data.idClient = value;
					_Client = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idClientValid( Guid value, ref bool valid);

		private Client _Client;

		public Client ClientParent
		{
			get
			{
				if (_Client == null || _Client.data == null )
				{
						_Client = new Client();
						_Client.Id =_data.idClient;
					return _Client;
				}
				else return _Client;
			}
			set { 
				_Client = value;
				idClient = _Client.Id;
			}
		}

		public Guid idAccountActivation
		{
			get => _data.idAccountActivation;
			set
			{
				if (_data.idAccountActivation == value) return;
				bool valid = true;
				_idAccountActivationValid(value, ref valid);

				if (valid)
				{
					_data.idAccountActivation = value;
					_AccountActivation = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idAccountActivationValid( Guid value, ref bool valid);

		private Account _AccountActivation;

		public Account AccountActivationParent
		{
			get
			{
				if (_AccountActivation == null || _AccountActivation.data == null )
				{
						_AccountActivation = new Account();
						_AccountActivation.Id =_data.idAccountActivation;
					return _AccountActivation;
				}
				else return _AccountActivation;
			}
			set { 
				_AccountActivation = value;
				idAccountActivation = _AccountActivation.Id;
			}
		}

		public Guid? idAccountDepreciation
		{
			get => _data.idAccountDepreciation.GetValueOrDefault();
			set
			{
				if (_data.idAccountDepreciation == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idAccountDepreciationValid(value, ref valid);

				if (valid)
				{
					_data.idAccountDepreciation = value;
					_AccountDepreciation = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idAccountDepreciationValid( Guid? value, ref bool valid);

		private Account _AccountDepreciation;

		public Account AccountDepreciationParent
		{
			get
			{
				if (_AccountDepreciation == null || _AccountDepreciation.data == null )
				{
					if (_data.idAccountDepreciation == null) return null;
					else
					{
						_AccountDepreciation = new Account();
						_AccountDepreciation.Id =_data.idAccountDepreciation.GetValueOrDefault();
						return _AccountDepreciation;
					}
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
			set
			{
				if (_data.TitleDepreciationRule == value) return;
				bool valid = true;
				_TitleDepreciationRuleValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TitleDepreciationRule").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TitleDepreciationRule = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TitleDepreciationRuleValid( string value, ref bool valid);

		public int NumberOfPeriods
		{
			get => _data.NumberOfPeriods;
			set
			{
				if (_data.NumberOfPeriods == value) return;
				bool valid = true;
				_NumberOfPeriodsValid(value, ref valid);

				if (valid)
				{
					_data.NumberOfPeriods = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _NumberOfPeriodsValid( int value, ref bool valid);

		public int PeriodInMonths
		{
			get => _data.PeriodInMonths;
			set
			{
				if (_data.PeriodInMonths == value) return;
				bool valid = true;
				_PeriodInMonthsValid(value, ref valid);

				if (valid)
				{
					_data.PeriodInMonths = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _PeriodInMonthsValid( int value, ref bool valid);

		public short TypeDepreciationRule
		{
			get => _data.TypeDepreciationRule;
			set
			{
				if (_data.TypeDepreciationRule == value) return;
				bool valid = true;
				_TypeDepreciationRuleValid(value, ref valid);

				if (valid)
				{
					_data.TypeDepreciationRule = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TypeDepreciationRuleValid( short value, ref bool valid);

	}


	public partial interface IVATRule
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idClient { get; set; }
		Client ClientParent { get; set; }
		Guid idAccountVATInput { get; set; }
		Account AccountVATInputParent { get; set; }
		Guid idAccountVATOutput { get; set; }
		Account AccountVATOutputParent { get; set; }
		[ComVisible(false)]
		Guid? idAccountVATBalance { get; set; }
		Account AccountVATBalanceParent { get; set; }
		[ComVisible(false)]
		string VATRuleCode { get; set; }
		string TitleVATRule { get; set; }
		double RateCurrent { get; set; }
		int SettlementTerm { get; set; }
		[ComVisible(false)]
		DateTime? DateRateChange { get; set; }
		[ComVisible(false)]
		double? RateFuture { get; set; }
		bool FlagReverseCharge { get; set; }
	}


	public partial class VATRule : BusinessObject<tVATRule>, IVATRule
	{
		public VATRule() : base() {}
		public VATRule(Guid id) : base(id) {}
		public Guid idClient
		{
			get => _data.idClient;
			set
			{
				if (_data.idClient == value) return;
				bool valid = true;
				_idClientValid(value, ref valid);

				if (valid)
				{
					_data.idClient = value;
					_Client = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idClientValid( Guid value, ref bool valid);

		private Client _Client;

		public Client ClientParent
		{
			get
			{
				if (_Client == null || _Client.data == null )
				{
						_Client = new Client();
						_Client.Id =_data.idClient;
					return _Client;
				}
				else return _Client;
			}
			set { 
				_Client = value;
				idClient = _Client.Id;
			}
		}

		public Guid idAccountVATInput
		{
			get => _data.idAccountVATInput;
			set
			{
				if (_data.idAccountVATInput == value) return;
				bool valid = true;
				_idAccountVATInputValid(value, ref valid);

				if (valid)
				{
					_data.idAccountVATInput = value;
					_AccountVATInput = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idAccountVATInputValid( Guid value, ref bool valid);

		private Account _AccountVATInput;

		public Account AccountVATInputParent
		{
			get
			{
				if (_AccountVATInput == null || _AccountVATInput.data == null )
				{
						_AccountVATInput = new Account();
						_AccountVATInput.Id =_data.idAccountVATInput;
					return _AccountVATInput;
				}
				else return _AccountVATInput;
			}
			set { 
				_AccountVATInput = value;
				idAccountVATInput = _AccountVATInput.Id;
			}
		}

		public Guid idAccountVATOutput
		{
			get => _data.idAccountVATOutput;
			set
			{
				if (_data.idAccountVATOutput == value) return;
				bool valid = true;
				_idAccountVATOutputValid(value, ref valid);

				if (valid)
				{
					_data.idAccountVATOutput = value;
					_AccountVATOutput = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idAccountVATOutputValid( Guid value, ref bool valid);

		private Account _AccountVATOutput;

		public Account AccountVATOutputParent
		{
			get
			{
				if (_AccountVATOutput == null || _AccountVATOutput.data == null )
				{
						_AccountVATOutput = new Account();
						_AccountVATOutput.Id =_data.idAccountVATOutput;
					return _AccountVATOutput;
				}
				else return _AccountVATOutput;
			}
			set { 
				_AccountVATOutput = value;
				idAccountVATOutput = _AccountVATOutput.Id;
			}
		}

		public Guid? idAccountVATBalance
		{
			get => _data.idAccountVATBalance.GetValueOrDefault();
			set
			{
				if (_data.idAccountVATBalance == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idAccountVATBalanceValid(value, ref valid);

				if (valid)
				{
					_data.idAccountVATBalance = value;
					_AccountVATBalance = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idAccountVATBalanceValid( Guid? value, ref bool valid);

		private Account _AccountVATBalance;

		public Account AccountVATBalanceParent
		{
			get
			{
				if (_AccountVATBalance == null || _AccountVATBalance.data == null )
				{
					if (_data.idAccountVATBalance == null) return null;
					else
					{
						_AccountVATBalance = new Account();
						_AccountVATBalance.Id =_data.idAccountVATBalance.GetValueOrDefault();
						return _AccountVATBalance;
					}
				}
				else return _AccountVATBalance;
			}
			set { 
				_AccountVATBalance = value;
				idAccountVATBalance = _AccountVATBalance.Id;
			}
		}

		public string VATRuleCode
		{
			get => _data.VATRuleCode;
			set
			{
				if (_data.VATRuleCode == value) return;
				bool valid = true;
				_VATRuleCodeValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("VATRuleCode").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.VATRuleCode = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _VATRuleCodeValid( string value, ref bool valid);

		public string TitleVATRule
		{
			get => _data.TitleVATRule;
			set
			{
				if (_data.TitleVATRule == value) return;
				bool valid = true;
				_TitleVATRuleValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TitleVATRule").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TitleVATRule = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TitleVATRuleValid( string value, ref bool valid);

		public double RateCurrent
		{
			get => _data.RateCurrent;
			set
			{
				if (_data.RateCurrent == value) return;
				bool valid = true;
				_RateCurrentValid(value, ref valid);

				if (valid)
				{
					_data.RateCurrent = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _RateCurrentValid( double value, ref bool valid);

		public int SettlementTerm
		{
			get => _data.SettlementTerm;
			set
			{
				if (_data.SettlementTerm == value) return;
				bool valid = true;
				_SettlementTermValid(value, ref valid);

				if (valid)
				{
					_data.SettlementTerm = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _SettlementTermValid( int value, ref bool valid);

		public DateTime? DateRateChange
		{
			get => _data.DateRateChange.GetValueOrDefault();
			set
			{
				if (_data.DateRateChange == value) return;
				bool valid = true;
				_DateRateChangeValid(value, ref valid);

				if (valid)
				{
					_data.DateRateChange = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _DateRateChangeValid( DateTime? value, ref bool valid);

		public double? RateFuture
		{
			get => _data.RateFuture.GetValueOrDefault();
			set
			{
				if (_data.RateFuture == value) return;
				bool valid = true;
				_RateFutureValid(value, ref valid);

				if (valid)
				{
					_data.RateFuture = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _RateFutureValid( double? value, ref bool valid);

		public bool FlagReverseCharge
		{
			get => _data.FlagReverseCharge;
			set
			{
				if (_data.FlagReverseCharge == value) return;
				bool valid = true;
				_FlagReverseChargeValid(value, ref valid);

				if (valid)
				{
					_data.FlagReverseCharge = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _FlagReverseChargeValid( bool value, ref bool valid);

	}


	public partial interface IReferenceGroup
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idClient { get; set; }
		Client ClientParent { get; set; }
		string TypeReferenceGroup { get; set; }
		string TitleReferenceGroup { get; set; }
		[ComVisible(false)]
		string BaseCode { get; set; }
		int NextNum { get; set; }
		bool FlagAutoGen { get; set; }
		short AutoDigits { get; set; }
	}


	public partial class ReferenceGroup : BusinessObject<tReferenceGroup>, IReferenceGroup
	{
		public ReferenceGroup() : base() {}
		public ReferenceGroup(Guid id) : base(id) {}
		public Guid idClient
		{
			get => _data.idClient;
			set
			{
				if (_data.idClient == value) return;
				bool valid = true;
				_idClientValid(value, ref valid);

				if (valid)
				{
					_data.idClient = value;
					_Client = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idClientValid( Guid value, ref bool valid);

		private Client _Client;

		public Client ClientParent
		{
			get
			{
				if (_Client == null || _Client.data == null )
				{
						_Client = new Client();
						_Client.Id =_data.idClient;
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
			set
			{
				if (_data.TypeReferenceGroup == value) return;
				bool valid = true;
				_TypeReferenceGroupValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TypeReferenceGroup").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TypeReferenceGroup = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TypeReferenceGroupValid( string value, ref bool valid);

		public string TitleReferenceGroup
		{
			get => _data.TitleReferenceGroup;
			set
			{
				if (_data.TitleReferenceGroup == value) return;
				bool valid = true;
				_TitleReferenceGroupValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TitleReferenceGroup").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TitleReferenceGroup = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TitleReferenceGroupValid( string value, ref bool valid);

		public string BaseCode
		{
			get => _data.BaseCode;
			set
			{
				if (_data.BaseCode == value) return;
				bool valid = true;
				_BaseCodeValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("BaseCode").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.BaseCode = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _BaseCodeValid( string value, ref bool valid);

		public int NextNum
		{
			get => _data.NextNum;
			set
			{
				if (_data.NextNum == value) return;
				bool valid = true;
				_NextNumValid(value, ref valid);

				if (valid)
				{
					_data.NextNum = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _NextNumValid( int value, ref bool valid);

		public bool FlagAutoGen
		{
			get => _data.FlagAutoGen;
			set
			{
				if (_data.FlagAutoGen == value) return;
				bool valid = true;
				_FlagAutoGenValid(value, ref valid);

				if (valid)
				{
					_data.FlagAutoGen = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _FlagAutoGenValid( bool value, ref bool valid);

		public short AutoDigits
		{
			get => _data.AutoDigits;
			set
			{
				if (_data.AutoDigits == value) return;
				bool valid = true;
				_AutoDigitsValid(value, ref valid);

				if (valid)
				{
					_data.AutoDigits = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _AutoDigitsValid( short value, ref bool valid);

	}


	public partial interface IReferenceCode
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idClient { get; set; }
		Client ClientParent { get; set; }
		Guid idReferenceGroup { get; set; }
		ReferenceGroup ReferenceGroupParent { get; set; }
		string RefCode { get; set; }
		[ComVisible(false)]
		string TitleRefCode { get; set; }
		[ComVisible(false)]
		string RefCodeComment { get; set; }
		bool FlagActive { get; set; }
		[ComVisible(false)]
		string TitleRefCodeEnglish { get; set; }
	}


	public partial class ReferenceCode : BusinessObject<tReferenceCode>, IReferenceCode
	{
		public ReferenceCode() : base() {}
		public ReferenceCode(Guid id) : base(id) {}
		public Guid idClient
		{
			get => _data.idClient;
			set
			{
				if (_data.idClient == value) return;
				bool valid = true;
				_idClientValid(value, ref valid);

				if (valid)
				{
					_data.idClient = value;
					_Client = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idClientValid( Guid value, ref bool valid);

		private Client _Client;

		public Client ClientParent
		{
			get
			{
				if (_Client == null || _Client.data == null )
				{
						_Client = new Client();
						_Client.Id =_data.idClient;
					return _Client;
				}
				else return _Client;
			}
			set { 
				_Client = value;
				idClient = _Client.Id;
			}
		}

		public Guid idReferenceGroup
		{
			get => _data.idReferenceGroup;
			set
			{
				if (_data.idReferenceGroup == value) return;
				bool valid = true;
				_idReferenceGroupValid(value, ref valid);

				if (valid)
				{
					_data.idReferenceGroup = value;
					_ReferenceGroup = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idReferenceGroupValid( Guid value, ref bool valid);

		private ReferenceGroup _ReferenceGroup;

		public ReferenceGroup ReferenceGroupParent
		{
			get
			{
				if (_ReferenceGroup == null || _ReferenceGroup.data == null )
				{
						_ReferenceGroup = new ReferenceGroup();
						_ReferenceGroup.Id =_data.idReferenceGroup;
					return _ReferenceGroup;
				}
				else return _ReferenceGroup;
			}
			set { 
				_ReferenceGroup = value;
				idReferenceGroup = _ReferenceGroup.Id;
			}
		}

		public string RefCode
		{
			get => _data.RefCode;
			set
			{
				if (_data.RefCode == value) return;
				bool valid = true;
				_RefCodeValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("RefCode").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.RefCode = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _RefCodeValid( string value, ref bool valid);

		public string TitleRefCode
		{
			get => _data.TitleRefCode;
			set
			{
				if (_data.TitleRefCode == value) return;
				bool valid = true;
				_TitleRefCodeValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TitleRefCode").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TitleRefCode = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TitleRefCodeValid( string value, ref bool valid);

		public string RefCodeComment
		{
			get => _data.RefCodeComment;
			set
			{
				if (_data.RefCodeComment == value) return;
				bool valid = true;
				_RefCodeCommentValid(value, ref valid);

				if (valid)
				{
					_data.RefCodeComment = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _RefCodeCommentValid( string value, ref bool valid);

		public bool FlagActive
		{
			get => _data.FlagActive;
			set
			{
				if (_data.FlagActive == value) return;
				bool valid = true;
				_FlagActiveValid(value, ref valid);

				if (valid)
				{
					_data.FlagActive = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _FlagActiveValid( bool value, ref bool valid);

		public string TitleRefCodeEnglish
		{
			get => _data.TitleRefCodeEnglish;
			set
			{
				if (_data.TitleRefCodeEnglish == value) return;
				bool valid = true;
				_TitleRefCodeEnglishValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TitleRefCodeEnglish").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TitleRefCodeEnglish = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TitleRefCodeEnglishValid( string value, ref bool valid);

	}


	public partial interface IBookingRun
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idClient { get; set; }
		Client ClientParent { get; set; }
		string BookingRunCode { get; set; }
		int PeriodYear { get; set; }
		short PeriodMonth { get; set; }
		string SerialNum { get; set; }
		short VersionCode { get; set; }
		bool StatusPreliminary { get; set; }
		[ComVisible(false)]
		string BookingRunTitle { get; set; }
		string ImportFileName { get; set; }
		DateTime ImportFileDate { get; set; }
		DateTime ImportedDate { get; set; }
		int RecordsImported { get; set; }
		int RecordsOmitted { get; set; }
	}


	public partial class BookingRun : BusinessObject<tBookingRun>, IBookingRun
	{
		public BookingRun() : base() {}
		public BookingRun(Guid id) : base(id) {}
		public Guid idClient
		{
			get => _data.idClient;
			set
			{
				if (_data.idClient == value) return;
				bool valid = true;
				_idClientValid(value, ref valid);

				if (valid)
				{
					_data.idClient = value;
					_Client = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idClientValid( Guid value, ref bool valid);

		private Client _Client;

		public Client ClientParent
		{
			get
			{
				if (_Client == null || _Client.data == null )
				{
						_Client = new Client();
						_Client.Id =_data.idClient;
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
			set
			{
				if (_data.BookingRunCode == value) return;
				bool valid = true;
				_BookingRunCodeValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("BookingRunCode").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.BookingRunCode = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _BookingRunCodeValid( string value, ref bool valid);

		public int PeriodYear
		{
			get => _data.PeriodYear;
			set
			{
				if (_data.PeriodYear == value) return;
				bool valid = true;
				_PeriodYearValid(value, ref valid);

				if (valid)
				{
					_data.PeriodYear = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _PeriodYearValid( int value, ref bool valid);

		public short PeriodMonth
		{
			get => _data.PeriodMonth;
			set
			{
				if (_data.PeriodMonth == value) return;
				bool valid = true;
				_PeriodMonthValid(value, ref valid);

				if (valid)
				{
					_data.PeriodMonth = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _PeriodMonthValid( short value, ref bool valid);

		public string SerialNum
		{
			get => _data.SerialNum;
			set
			{
				if (_data.SerialNum == value) return;
				bool valid = true;
				_SerialNumValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("SerialNum").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.SerialNum = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _SerialNumValid( string value, ref bool valid);

		public short VersionCode
		{
			get => _data.VersionCode;
			set
			{
				if (_data.VersionCode == value) return;
				bool valid = true;
				_VersionCodeValid(value, ref valid);

				if (valid)
				{
					_data.VersionCode = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _VersionCodeValid( short value, ref bool valid);

		public bool StatusPreliminary
		{
			get => _data.StatusPreliminary;
			set
			{
				if (_data.StatusPreliminary == value) return;
				bool valid = true;
				_StatusPreliminaryValid(value, ref valid);

				if (valid)
				{
					_data.StatusPreliminary = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _StatusPreliminaryValid( bool value, ref bool valid);

		public string BookingRunTitle
		{
			get => _data.BookingRunTitle;
			set
			{
				if (_data.BookingRunTitle == value) return;
				bool valid = true;
				_BookingRunTitleValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("BookingRunTitle").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.BookingRunTitle = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _BookingRunTitleValid( string value, ref bool valid);

		public string ImportFileName
		{
			get => _data.ImportFileName;
			set
			{
				if (_data.ImportFileName == value) return;
				bool valid = true;
				_ImportFileNameValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("ImportFileName").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.ImportFileName = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _ImportFileNameValid( string value, ref bool valid);

		public DateTime ImportFileDate
		{
			get => _data.ImportFileDate;
			set
			{
				if (_data.ImportFileDate == value) return;
				bool valid = true;
				_ImportFileDateValid(value, ref valid);

				if (valid)
				{
					_data.ImportFileDate = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _ImportFileDateValid( DateTime value, ref bool valid);

		public DateTime ImportedDate
		{
			get => _data.ImportedDate;
			set
			{
				if (_data.ImportedDate == value) return;
				bool valid = true;
				_ImportedDateValid(value, ref valid);

				if (valid)
				{
					_data.ImportedDate = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _ImportedDateValid( DateTime value, ref bool valid);

		public int RecordsImported
		{
			get => _data.RecordsImported;
			set
			{
				if (_data.RecordsImported == value) return;
				bool valid = true;
				_RecordsImportedValid(value, ref valid);

				if (valid)
				{
					_data.RecordsImported = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _RecordsImportedValid( int value, ref bool valid);

		public int RecordsOmitted
		{
			get => _data.RecordsOmitted;
			set
			{
				if (_data.RecordsOmitted == value) return;
				bool valid = true;
				_RecordsOmittedValid(value, ref valid);

				if (valid)
				{
					_data.RecordsOmitted = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _RecordsOmittedValid( int value, ref bool valid);

	}


	public partial interface IPlan
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idClient { get; set; }
		Client ClientParent { get; set; }
		[ComVisible(false)]
		Guid? idPlanBase { get; set; }
		Plan PlanBaseParent { get; set; }
		string TitlePlan { get; set; }
		DateTime DateValidFrom { get; set; }
		DateTime DateValidTo { get; set; }
		[ComVisible(false)]
		DateTime? ApprovedTo { get; set; }
		bool PlanFlagBaseline { get; set; }
		short TypeStatus { get; set; }
	}


	public partial class Plan : BusinessObject<tPlan>, IPlan
	{
		public Plan() : base() {}
		public Plan(Guid id) : base(id) {}
		public Guid idClient
		{
			get => _data.idClient;
			set
			{
				if (_data.idClient == value) return;
				bool valid = true;
				_idClientValid(value, ref valid);

				if (valid)
				{
					_data.idClient = value;
					_Client = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idClientValid( Guid value, ref bool valid);

		private Client _Client;

		public Client ClientParent
		{
			get
			{
				if (_Client == null || _Client.data == null )
				{
						_Client = new Client();
						_Client.Id =_data.idClient;
					return _Client;
				}
				else return _Client;
			}
			set { 
				_Client = value;
				idClient = _Client.Id;
			}
		}

		public Guid? idPlanBase
		{
			get => _data.idPlanBase.GetValueOrDefault();
			set
			{
				if (_data.idPlanBase == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idPlanBaseValid(value, ref valid);

				if (valid)
				{
					_data.idPlanBase = value;
					_PlanBase = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idPlanBaseValid( Guid? value, ref bool valid);

		private Plan _PlanBase;

		public Plan PlanBaseParent
		{
			get
			{
				if (_PlanBase == null || _PlanBase.data == null )
				{
					if (_data.idPlanBase == null) return null;
					else
					{
						_PlanBase = new Plan();
						_PlanBase.Id =_data.idPlanBase.GetValueOrDefault();
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
			set
			{
				if (_data.TitlePlan == value) return;
				bool valid = true;
				_TitlePlanValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TitlePlan").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TitlePlan = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TitlePlanValid( string value, ref bool valid);

		public DateTime DateValidFrom
		{
			get => _data.DateValidFrom;
			set
			{
				if (_data.DateValidFrom == value) return;
				bool valid = true;
				_DateValidFromValid(value, ref valid);

				if (valid)
				{
					_data.DateValidFrom = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _DateValidFromValid( DateTime value, ref bool valid);

		public DateTime DateValidTo
		{
			get => _data.DateValidTo;
			set
			{
				if (_data.DateValidTo == value) return;
				bool valid = true;
				_DateValidToValid(value, ref valid);

				if (valid)
				{
					_data.DateValidTo = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _DateValidToValid( DateTime value, ref bool valid);

		public DateTime? ApprovedTo
		{
			get => _data.ApprovedTo.GetValueOrDefault();
			set
			{
				if (_data.ApprovedTo == value) return;
				bool valid = true;
				_ApprovedToValid(value, ref valid);

				if (valid)
				{
					_data.ApprovedTo = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _ApprovedToValid( DateTime? value, ref bool valid);

		public bool PlanFlagBaseline
		{
			get => _data.PlanFlagBaseline;
			set
			{
				if (_data.PlanFlagBaseline == value) return;
				bool valid = true;
				_PlanFlagBaselineValid(value, ref valid);

				if (valid)
				{
					_data.PlanFlagBaseline = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _PlanFlagBaselineValid( bool value, ref bool valid);

		public short TypeStatus
		{
			get => _data.TypeStatus;
			set
			{
				if (_data.TypeStatus == value) return;
				bool valid = true;
				_TypeStatusValid(value, ref valid);

				if (valid)
				{
					_data.TypeStatus = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TypeStatusValid( short value, ref bool valid);

	}


	public partial interface IPlanGroup
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idClient { get; set; }
		Client ClientParent { get; set; }
		string TitlePlanGroup { get; set; }
		[ComVisible(false)]
		string TitleEnglishPlanGroup { get; set; }
		[ComVisible(false)]
		string DescriptionPlanGroup { get; set; }
	}


	public partial class PlanGroup : BusinessObject<tPlanGroup>, IPlanGroup
	{
		public PlanGroup() : base() {}
		public PlanGroup(Guid id) : base(id) {}
		public Guid idClient
		{
			get => _data.idClient;
			set
			{
				if (_data.idClient == value) return;
				bool valid = true;
				_idClientValid(value, ref valid);

				if (valid)
				{
					_data.idClient = value;
					_Client = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idClientValid( Guid value, ref bool valid);

		private Client _Client;

		public Client ClientParent
		{
			get
			{
				if (_Client == null || _Client.data == null )
				{
						_Client = new Client();
						_Client.Id =_data.idClient;
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
			set
			{
				if (_data.TitlePlanGroup == value) return;
				bool valid = true;
				_TitlePlanGroupValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TitlePlanGroup").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TitlePlanGroup = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TitlePlanGroupValid( string value, ref bool valid);

		public string TitleEnglishPlanGroup
		{
			get => _data.TitleEnglishPlanGroup;
			set
			{
				if (_data.TitleEnglishPlanGroup == value) return;
				bool valid = true;
				_TitleEnglishPlanGroupValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TitleEnglishPlanGroup").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TitleEnglishPlanGroup = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TitleEnglishPlanGroupValid( string value, ref bool valid);

		public string DescriptionPlanGroup
		{
			get => _data.DescriptionPlanGroup;
			set
			{
				if (_data.DescriptionPlanGroup == value) return;
				bool valid = true;
				_DescriptionPlanGroupValid(value, ref valid);

				if (valid)
				{
					_data.DescriptionPlanGroup = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _DescriptionPlanGroupValid( string value, ref bool valid);

	}


	public partial interface IPlanElement
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idClient { get; set; }
		Client ClientParent { get; set; }
		[ComVisible(false)]
		Guid? idCostCenterPlanElement { get; set; }
		CostCenter CostCenterPlanElementParent { get; set; }
		[ComVisible(false)]
		Guid? idCurrency { get; set; }
		Currency CurrencyParent { get; set; }
		short TypePlanElement { get; set; }
		[ComVisible(false)]
		Guid? idPlanGroup { get; set; }
		PlanGroup PlanGroupParent { get; set; }
		string TitlePlanElement { get; set; }
		[ComVisible(false)]
		string ReferenceIDPlanElement { get; set; }
		bool ElementFlagBaseline { get; set; }
		[ComVisible(false)]
		string PlanElementDescription { get; set; }
	}


	public partial class PlanElement : BusinessObject<tPlanElement>, IPlanElement
	{
		public PlanElement() : base() {}
		public PlanElement(Guid id) : base(id) {}
		public Guid idClient
		{
			get => _data.idClient;
			set
			{
				if (_data.idClient == value) return;
				bool valid = true;
				_idClientValid(value, ref valid);

				if (valid)
				{
					_data.idClient = value;
					_Client = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idClientValid( Guid value, ref bool valid);

		private Client _Client;

		public Client ClientParent
		{
			get
			{
				if (_Client == null || _Client.data == null )
				{
						_Client = new Client();
						_Client.Id =_data.idClient;
					return _Client;
				}
				else return _Client;
			}
			set { 
				_Client = value;
				idClient = _Client.Id;
			}
		}

		public Guid? idCostCenterPlanElement
		{
			get => _data.idCostCenterPlanElement.GetValueOrDefault();
			set
			{
				if (_data.idCostCenterPlanElement == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idCostCenterPlanElementValid(value, ref valid);

				if (valid)
				{
					_data.idCostCenterPlanElement = value;
					_CostCenterPlanElement = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idCostCenterPlanElementValid( Guid? value, ref bool valid);

		private CostCenter _CostCenterPlanElement;

		public CostCenter CostCenterPlanElementParent
		{
			get
			{
				if (_CostCenterPlanElement == null || _CostCenterPlanElement.data == null )
				{
					if (_data.idCostCenterPlanElement == null) return null;
					else
					{
						_CostCenterPlanElement = new CostCenter();
						_CostCenterPlanElement.Id =_data.idCostCenterPlanElement.GetValueOrDefault();
						return _CostCenterPlanElement;
					}
				}
				else return _CostCenterPlanElement;
			}
			set { 
				_CostCenterPlanElement = value;
				idCostCenterPlanElement = _CostCenterPlanElement.Id;
			}
		}

		public Guid? idCurrency
		{
			get => _data.idCurrency.GetValueOrDefault();
			set
			{
				if (_data.idCurrency == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idCurrencyValid(value, ref valid);

				if (valid)
				{
					_data.idCurrency = value;
					_Currency = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idCurrencyValid( Guid? value, ref bool valid);

		private Currency _Currency;

		public Currency CurrencyParent
		{
			get
			{
				if (_Currency == null || _Currency.data == null )
				{
					if (_data.idCurrency == null) return null;
					else
					{
						_Currency = new Currency();
						_Currency.Id =_data.idCurrency.GetValueOrDefault();
						return _Currency;
					}
				}
				else return _Currency;
			}
			set { 
				_Currency = value;
				idCurrency = _Currency.Id;
			}
		}

		public short TypePlanElement
		{
			get => _data.TypePlanElement;
			set
			{
				if (_data.TypePlanElement == value) return;
				bool valid = true;
				_TypePlanElementValid(value, ref valid);

				if (valid)
				{
					_data.TypePlanElement = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TypePlanElementValid( short value, ref bool valid);

		public Guid? idPlanGroup
		{
			get => _data.idPlanGroup.GetValueOrDefault();
			set
			{
				if (_data.idPlanGroup == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idPlanGroupValid(value, ref valid);

				if (valid)
				{
					_data.idPlanGroup = value;
					_PlanGroup = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idPlanGroupValid( Guid? value, ref bool valid);

		private PlanGroup _PlanGroup;

		public PlanGroup PlanGroupParent
		{
			get
			{
				if (_PlanGroup == null || _PlanGroup.data == null )
				{
					if (_data.idPlanGroup == null) return null;
					else
					{
						_PlanGroup = new PlanGroup();
						_PlanGroup.Id =_data.idPlanGroup.GetValueOrDefault();
						return _PlanGroup;
					}
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
			set
			{
				if (_data.TitlePlanElement == value) return;
				bool valid = true;
				_TitlePlanElementValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TitlePlanElement").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TitlePlanElement = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TitlePlanElementValid( string value, ref bool valid);

		public string ReferenceIDPlanElement
		{
			get => _data.ReferenceIDPlanElement;
			set
			{
				if (_data.ReferenceIDPlanElement == value) return;
				bool valid = true;
				_ReferenceIDPlanElementValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("ReferenceIDPlanElement").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.ReferenceIDPlanElement = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _ReferenceIDPlanElementValid( string value, ref bool valid);

		public bool ElementFlagBaseline
		{
			get => _data.ElementFlagBaseline;
			set
			{
				if (_data.ElementFlagBaseline == value) return;
				bool valid = true;
				_ElementFlagBaselineValid(value, ref valid);

				if (valid)
				{
					_data.ElementFlagBaseline = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _ElementFlagBaselineValid( bool value, ref bool valid);

		public string PlanElementDescription
		{
			get => _data.PlanElementDescription;
			set
			{
				if (_data.PlanElementDescription == value) return;
				bool valid = true;
				_PlanElementDescriptionValid(value, ref valid);

				if (valid)
				{
					_data.PlanElementDescription = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _PlanElementDescriptionValid( string value, ref bool valid);

	}


	public partial interface IPlanInflationRule
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idPlan { get; set; }
		Plan PlanParent { get; set; }
		string TitleInflationRule { get; set; }
		short InflationInterval { get; set; }
		double InflationRateAnnual { get; set; }
		[ComVisible(false)]
		string InflationRuleComment { get; set; }
	}


	public partial class PlanInflationRule : BusinessObject<tPlanInflationRule>, IPlanInflationRule
	{
		public PlanInflationRule() : base() {}
		public PlanInflationRule(Guid id) : base(id) {}
		public Guid idPlan
		{
			get => _data.idPlan;
			set
			{
				if (_data.idPlan == value) return;
				bool valid = true;
				_idPlanValid(value, ref valid);

				if (valid)
				{
					_data.idPlan = value;
					_Plan = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idPlanValid( Guid value, ref bool valid);

		private Plan _Plan;

		public Plan PlanParent
		{
			get
			{
				if (_Plan == null || _Plan.data == null )
				{
						_Plan = new Plan();
						_Plan.Id =_data.idPlan;
					return _Plan;
				}
				else return _Plan;
			}
			set { 
				_Plan = value;
				idPlan = _Plan.Id;
			}
		}

		public string TitleInflationRule
		{
			get => _data.TitleInflationRule;
			set
			{
				if (_data.TitleInflationRule == value) return;
				bool valid = true;
				_TitleInflationRuleValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TitleInflationRule").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TitleInflationRule = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TitleInflationRuleValid( string value, ref bool valid);

		public short InflationInterval
		{
			get => _data.InflationInterval;
			set
			{
				if (_data.InflationInterval == value) return;
				bool valid = true;
				_InflationIntervalValid(value, ref valid);

				if (valid)
				{
					_data.InflationInterval = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _InflationIntervalValid( short value, ref bool valid);

		public double InflationRateAnnual
		{
			get => _data.InflationRateAnnual;
			set
			{
				if (_data.InflationRateAnnual == value) return;
				bool valid = true;
				_InflationRateAnnualValid(value, ref valid);

				if (valid)
				{
					_data.InflationRateAnnual = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _InflationRateAnnualValid( double value, ref bool valid);

		public string InflationRuleComment
		{
			get => _data.InflationRuleComment;
			set
			{
				if (_data.InflationRuleComment == value) return;
				bool valid = true;
				_InflationRuleCommentValid(value, ref valid);

				if (valid)
				{
					_data.InflationRuleComment = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _InflationRuleCommentValid( string value, ref bool valid);

	}


	public partial interface ICurrencyExchangeRate
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idClient { get; set; }
		Client ClientParent { get; set; }
		[ComVisible(false)]
		Guid? idPlan { get; set; }
		Plan PlanParent { get; set; }
		Guid idCurrencyExchangeRate { get; set; }
		Currency CurrencyExchangeRateParent { get; set; }
		DateTime DateExchangeRate { get; set; }
		double RatePerClientCurrency { get; set; }
	}


	public partial class CurrencyExchangeRate : BusinessObject<tCurrencyExchangeRate>, ICurrencyExchangeRate
	{
		public CurrencyExchangeRate() : base() {}
		public CurrencyExchangeRate(Guid id) : base(id) {}
		public Guid idClient
		{
			get => _data.idClient;
			set
			{
				if (_data.idClient == value) return;
				bool valid = true;
				_idClientValid(value, ref valid);

				if (valid)
				{
					_data.idClient = value;
					_Client = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idClientValid( Guid value, ref bool valid);

		private Client _Client;

		public Client ClientParent
		{
			get
			{
				if (_Client == null || _Client.data == null )
				{
						_Client = new Client();
						_Client.Id =_data.idClient;
					return _Client;
				}
				else return _Client;
			}
			set { 
				_Client = value;
				idClient = _Client.Id;
			}
		}

		public Guid? idPlan
		{
			get => _data.idPlan.GetValueOrDefault();
			set
			{
				if (_data.idPlan == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idPlanValid(value, ref valid);

				if (valid)
				{
					_data.idPlan = value;
					_Plan = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idPlanValid( Guid? value, ref bool valid);

		private Plan _Plan;

		public Plan PlanParent
		{
			get
			{
				if (_Plan == null || _Plan.data == null )
				{
					if (_data.idPlan == null) return null;
					else
					{
						_Plan = new Plan();
						_Plan.Id =_data.idPlan.GetValueOrDefault();
						return _Plan;
					}
				}
				else return _Plan;
			}
			set { 
				_Plan = value;
				idPlan = _Plan.Id;
			}
		}

		public Guid idCurrencyExchangeRate
		{
			get => _data.idCurrencyExchangeRate;
			set
			{
				if (_data.idCurrencyExchangeRate == value) return;
				bool valid = true;
				_idCurrencyExchangeRateValid(value, ref valid);

				if (valid)
				{
					_data.idCurrencyExchangeRate = value;
					_CurrencyExchangeRate = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idCurrencyExchangeRateValid( Guid value, ref bool valid);

		private Currency _CurrencyExchangeRate;

		public Currency CurrencyExchangeRateParent
		{
			get
			{
				if (_CurrencyExchangeRate == null || _CurrencyExchangeRate.data == null )
				{
						_CurrencyExchangeRate = new Currency();
						_CurrencyExchangeRate.Id =_data.idCurrencyExchangeRate;
					return _CurrencyExchangeRate;
				}
				else return _CurrencyExchangeRate;
			}
			set { 
				_CurrencyExchangeRate = value;
				idCurrencyExchangeRate = _CurrencyExchangeRate.Id;
			}
		}

		public DateTime DateExchangeRate
		{
			get => _data.DateExchangeRate;
			set
			{
				if (_data.DateExchangeRate == value) return;
				bool valid = true;
				_DateExchangeRateValid(value, ref valid);

				if (valid)
				{
					_data.DateExchangeRate = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _DateExchangeRateValid( DateTime value, ref bool valid);

		public double RatePerClientCurrency
		{
			get => _data.RatePerClientCurrency;
			set
			{
				if (_data.RatePerClientCurrency == value) return;
				bool valid = true;
				_RatePerClientCurrencyValid(value, ref valid);

				if (valid)
				{
					_data.RatePerClientCurrency = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _RatePerClientCurrencyValid( double value, ref bool valid);

	}


	public partial interface IPlanParameter
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idPlan { get; set; }
		Plan PlanParent { get; set; }
		short TypePlanParameter { get; set; }
		string TitlePlanParameter { get; set; }
		double ValueNum { get; set; }
		[ComVisible(false)]
		DateTime? ValueDate { get; set; }
		[ComVisible(false)]
		string ValueText { get; set; }
		[ComVisible(false)]
		string UnitParameter { get; set; }
		[ComVisible(false)]
		string PlanParameterComment { get; set; }
	}


	public partial class PlanParameter : BusinessObject<tPlanParameter>, IPlanParameter
	{
		public PlanParameter() : base() {}
		public PlanParameter(Guid id) : base(id) {}
		public Guid idPlan
		{
			get => _data.idPlan;
			set
			{
				if (_data.idPlan == value) return;
				bool valid = true;
				_idPlanValid(value, ref valid);

				if (valid)
				{
					_data.idPlan = value;
					_Plan = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idPlanValid( Guid value, ref bool valid);

		private Plan _Plan;

		public Plan PlanParent
		{
			get
			{
				if (_Plan == null || _Plan.data == null )
				{
						_Plan = new Plan();
						_Plan.Id =_data.idPlan;
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
			set
			{
				if (_data.TypePlanParameter == value) return;
				bool valid = true;
				_TypePlanParameterValid(value, ref valid);

				if (valid)
				{
					_data.TypePlanParameter = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TypePlanParameterValid( short value, ref bool valid);

		public string TitlePlanParameter
		{
			get => _data.TitlePlanParameter;
			set
			{
				if (_data.TitlePlanParameter == value) return;
				bool valid = true;
				_TitlePlanParameterValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TitlePlanParameter").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TitlePlanParameter = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TitlePlanParameterValid( string value, ref bool valid);

		public double ValueNum
		{
			get => _data.ValueNum;
			set
			{
				if (_data.ValueNum == value) return;
				bool valid = true;
				_ValueNumValid(value, ref valid);

				if (valid)
				{
					_data.ValueNum = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _ValueNumValid( double value, ref bool valid);

		public DateTime? ValueDate
		{
			get => _data.ValueDate.GetValueOrDefault();
			set
			{
				if (_data.ValueDate == value) return;
				bool valid = true;
				_ValueDateValid(value, ref valid);

				if (valid)
				{
					_data.ValueDate = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _ValueDateValid( DateTime? value, ref bool valid);

		public string ValueText
		{
			get => _data.ValueText;
			set
			{
				if (_data.ValueText == value) return;
				bool valid = true;
				_ValueTextValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("ValueText").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.ValueText = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _ValueTextValid( string value, ref bool valid);

		public string UnitParameter
		{
			get => _data.UnitParameter;
			set
			{
				if (_data.UnitParameter == value) return;
				bool valid = true;
				_UnitParameterValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("UnitParameter").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.UnitParameter = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _UnitParameterValid( string value, ref bool valid);

		public string PlanParameterComment
		{
			get => _data.PlanParameterComment;
			set
			{
				if (_data.PlanParameterComment == value) return;
				bool valid = true;
				_PlanParameterCommentValid(value, ref valid);

				if (valid)
				{
					_data.PlanParameterComment = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _PlanParameterCommentValid( string value, ref bool valid);

	}


	public partial interface IPlanAllocationSchedule
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idPlan { get; set; }
		Plan PlanParent { get; set; }
		string TitleAllocationSchedule { get; set; }
		int MonthsBetweenItems { get; set; }
		double PerpetualRate { get; set; }
		bool FlagScheduleShared { get; set; }
		bool FlagAbsoluteRates { get; set; }
		int AdvanceDelayPeriods { get; set; }
		bool FlagAuto { get; set; }
		[ComVisible(false)]
		short? Period1 { get; set; }
		[ComVisible(false)]
		double? Rate1 { get; set; }
		[ComVisible(false)]
		short? Period2 { get; set; }
		[ComVisible(false)]
		double? Rate2 { get; set; }
		[ComVisible(false)]
		short? Period3 { get; set; }
		[ComVisible(false)]
		double? Rate3 { get; set; }
	}


	public partial class PlanAllocationSchedule : BusinessObject<tPlanAllocationSchedule>, IPlanAllocationSchedule
	{
		public PlanAllocationSchedule() : base() {}
		public PlanAllocationSchedule(Guid id) : base(id) {}
		public Guid idPlan
		{
			get => _data.idPlan;
			set
			{
				if (_data.idPlan == value) return;
				bool valid = true;
				_idPlanValid(value, ref valid);

				if (valid)
				{
					_data.idPlan = value;
					_Plan = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idPlanValid( Guid value, ref bool valid);

		private Plan _Plan;

		public Plan PlanParent
		{
			get
			{
				if (_Plan == null || _Plan.data == null )
				{
						_Plan = new Plan();
						_Plan.Id =_data.idPlan;
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
			set
			{
				if (_data.TitleAllocationSchedule == value) return;
				bool valid = true;
				_TitleAllocationScheduleValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TitleAllocationSchedule").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TitleAllocationSchedule = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TitleAllocationScheduleValid( string value, ref bool valid);

		public int MonthsBetweenItems
		{
			get => _data.MonthsBetweenItems;
			set
			{
				if (_data.MonthsBetweenItems == value) return;
				bool valid = true;
				_MonthsBetweenItemsValid(value, ref valid);

				if (valid)
				{
					_data.MonthsBetweenItems = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _MonthsBetweenItemsValid( int value, ref bool valid);

		public double PerpetualRate
		{
			get => _data.PerpetualRate;
			set
			{
				if (_data.PerpetualRate == value) return;
				bool valid = true;
				_PerpetualRateValid(value, ref valid);

				if (valid)
				{
					_data.PerpetualRate = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _PerpetualRateValid( double value, ref bool valid);

		public bool FlagScheduleShared
		{
			get => _data.FlagScheduleShared;
			set
			{
				if (_data.FlagScheduleShared == value) return;
				bool valid = true;
				_FlagScheduleSharedValid(value, ref valid);

				if (valid)
				{
					_data.FlagScheduleShared = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _FlagScheduleSharedValid( bool value, ref bool valid);

		public bool FlagAbsoluteRates
		{
			get => _data.FlagAbsoluteRates;
			set
			{
				if (_data.FlagAbsoluteRates == value) return;
				bool valid = true;
				_FlagAbsoluteRatesValid(value, ref valid);

				if (valid)
				{
					_data.FlagAbsoluteRates = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _FlagAbsoluteRatesValid( bool value, ref bool valid);

		public int AdvanceDelayPeriods
		{
			get => _data.AdvanceDelayPeriods;
			set
			{
				if (_data.AdvanceDelayPeriods == value) return;
				bool valid = true;
				_AdvanceDelayPeriodsValid(value, ref valid);

				if (valid)
				{
					_data.AdvanceDelayPeriods = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _AdvanceDelayPeriodsValid( int value, ref bool valid);

		public bool FlagAuto
		{
			get => _data.FlagAuto;
			set
			{
				if (_data.FlagAuto == value) return;
				bool valid = true;
				_FlagAutoValid(value, ref valid);

				if (valid)
				{
					_data.FlagAuto = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _FlagAutoValid( bool value, ref bool valid);

		public short? Period1
		{
			get => _data.Period1.GetValueOrDefault();
			set
			{
				if (_data.Period1 == value) return;
				bool valid = true;
				_Period1Valid(value, ref valid);

				if (valid)
				{
					_data.Period1 = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _Period1Valid( short? value, ref bool valid);

		public double? Rate1
		{
			get => _data.Rate1.GetValueOrDefault();
			set
			{
				if (_data.Rate1 == value) return;
				bool valid = true;
				_Rate1Valid(value, ref valid);

				if (valid)
				{
					_data.Rate1 = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _Rate1Valid( double? value, ref bool valid);

		public short? Period2
		{
			get => _data.Period2.GetValueOrDefault();
			set
			{
				if (_data.Period2 == value) return;
				bool valid = true;
				_Period2Valid(value, ref valid);

				if (valid)
				{
					_data.Period2 = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _Period2Valid( short? value, ref bool valid);

		public double? Rate2
		{
			get => _data.Rate2.GetValueOrDefault();
			set
			{
				if (_data.Rate2 == value) return;
				bool valid = true;
				_Rate2Valid(value, ref valid);

				if (valid)
				{
					_data.Rate2 = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _Rate2Valid( double? value, ref bool valid);

		public short? Period3
		{
			get => _data.Period3.GetValueOrDefault();
			set
			{
				if (_data.Period3 == value) return;
				bool valid = true;
				_Period3Valid(value, ref valid);

				if (valid)
				{
					_data.Period3 = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _Period3Valid( short? value, ref bool valid);

		public double? Rate3
		{
			get => _data.Rate3.GetValueOrDefault();
			set
			{
				if (_data.Rate3 == value) return;
				bool valid = true;
				_Rate3Valid(value, ref valid);

				if (valid)
				{
					_data.Rate3 = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _Rate3Valid( double? value, ref bool valid);

	}


	public partial interface IPlanAllocationScheduleItems
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idPlanAllocationSchedule { get; set; }
		PlanAllocationSchedule PlanAllocationScheduleParent { get; set; }
		int OrderNum { get; set; }
		double ItemRate { get; set; }
	}


	public partial class PlanAllocationScheduleItems : BusinessObject<tPlanAllocationScheduleItems>, IPlanAllocationScheduleItems
	{
		public PlanAllocationScheduleItems() : base() {}
		public PlanAllocationScheduleItems(Guid id) : base(id) {}
		public Guid idPlanAllocationSchedule
		{
			get => _data.idPlanAllocationSchedule;
			set
			{
				if (_data.idPlanAllocationSchedule == value) return;
				bool valid = true;
				_idPlanAllocationScheduleValid(value, ref valid);

				if (valid)
				{
					_data.idPlanAllocationSchedule = value;
					_PlanAllocationSchedule = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idPlanAllocationScheduleValid( Guid value, ref bool valid);

		private PlanAllocationSchedule _PlanAllocationSchedule;

		public PlanAllocationSchedule PlanAllocationScheduleParent
		{
			get
			{
				if (_PlanAllocationSchedule == null || _PlanAllocationSchedule.data == null )
				{
						_PlanAllocationSchedule = new PlanAllocationSchedule();
						_PlanAllocationSchedule.Id =_data.idPlanAllocationSchedule;
					return _PlanAllocationSchedule;
				}
				else return _PlanAllocationSchedule;
			}
			set { 
				_PlanAllocationSchedule = value;
				idPlanAllocationSchedule = _PlanAllocationSchedule.Id;
			}
		}

		public int OrderNum
		{
			get => _data.OrderNum;
			set
			{
				if (_data.OrderNum == value) return;
				bool valid = true;
				_OrderNumValid(value, ref valid);

				if (valid)
				{
					_data.OrderNum = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _OrderNumValid( int value, ref bool valid);

		public double ItemRate
		{
			get => _data.ItemRate;
			set
			{
				if (_data.ItemRate == value) return;
				bool valid = true;
				_ItemRateValid(value, ref valid);

				if (valid)
				{
					_data.ItemRate = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _ItemRateValid( double value, ref bool valid);

	}


	public partial interface IPlanHRTariff
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idPlan { get; set; }
		Plan PlanParent { get; set; }
		string TitleTariff { get; set; }
		Guid idAccountSalary { get; set; }
		Account AccountSalaryParent { get; set; }
		short PayDay { get; set; }
		[ComVisible(false)]
		string TariffDescription { get; set; }
		bool FlagShared { get; set; }
		[ComVisible(false)]
		DateTime? DateInflationBase { get; set; }
	}


	public partial class PlanHRTariff : BusinessObject<tPlanHRTariff>, IPlanHRTariff
	{
		public PlanHRTariff() : base() {}
		public PlanHRTariff(Guid id) : base(id) {}
		public Guid idPlan
		{
			get => _data.idPlan;
			set
			{
				if (_data.idPlan == value) return;
				bool valid = true;
				_idPlanValid(value, ref valid);

				if (valid)
				{
					_data.idPlan = value;
					_Plan = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idPlanValid( Guid value, ref bool valid);

		private Plan _Plan;

		public Plan PlanParent
		{
			get
			{
				if (_Plan == null || _Plan.data == null )
				{
						_Plan = new Plan();
						_Plan.Id =_data.idPlan;
					return _Plan;
				}
				else return _Plan;
			}
			set { 
				_Plan = value;
				idPlan = _Plan.Id;
			}
		}

		public string TitleTariff
		{
			get => _data.TitleTariff;
			set
			{
				if (_data.TitleTariff == value) return;
				bool valid = true;
				_TitleTariffValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TitleTariff").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TitleTariff = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TitleTariffValid( string value, ref bool valid);

		public Guid idAccountSalary
		{
			get => _data.idAccountSalary;
			set
			{
				if (_data.idAccountSalary == value) return;
				bool valid = true;
				_idAccountSalaryValid(value, ref valid);

				if (valid)
				{
					_data.idAccountSalary = value;
					_AccountSalary = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idAccountSalaryValid( Guid value, ref bool valid);

		private Account _AccountSalary;

		public Account AccountSalaryParent
		{
			get
			{
				if (_AccountSalary == null || _AccountSalary.data == null )
				{
						_AccountSalary = new Account();
						_AccountSalary.Id =_data.idAccountSalary;
					return _AccountSalary;
				}
				else return _AccountSalary;
			}
			set { 
				_AccountSalary = value;
				idAccountSalary = _AccountSalary.Id;
			}
		}

		public short PayDay
		{
			get => _data.PayDay;
			set
			{
				if (_data.PayDay == value) return;
				bool valid = true;
				_PayDayValid(value, ref valid);

				if (valid)
				{
					_data.PayDay = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _PayDayValid( short value, ref bool valid);

		public string TariffDescription
		{
			get => _data.TariffDescription;
			set
			{
				if (_data.TariffDescription == value) return;
				bool valid = true;
				_TariffDescriptionValid(value, ref valid);

				if (valid)
				{
					_data.TariffDescription = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TariffDescriptionValid( string value, ref bool valid);

		public bool FlagShared
		{
			get => _data.FlagShared;
			set
			{
				if (_data.FlagShared == value) return;
				bool valid = true;
				_FlagSharedValid(value, ref valid);

				if (valid)
				{
					_data.FlagShared = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _FlagSharedValid( bool value, ref bool valid);

		public DateTime? DateInflationBase
		{
			get => _data.DateInflationBase.GetValueOrDefault();
			set
			{
				if (_data.DateInflationBase == value) return;
				bool valid = true;
				_DateInflationBaseValid(value, ref valid);

				if (valid)
				{
					_data.DateInflationBase = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _DateInflationBaseValid( DateTime? value, ref bool valid);

	}


	public partial interface IPlanHRTariffDetail
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idTariff { get; set; }
		PlanHRTariff TariffParent { get; set; }
		[ComVisible(false)]
		DateTime? DateValidTo { get; set; }
		short WorkTimeWeekly { get; set; }
		double FTEFactor { get; set; }
		double RatioShiftNight { get; set; }
		double RatioShiftSpecial { get; set; }
		double RatioOvertime { get; set; }
		short AnnualLeave { get; set; }
		short StandardHolidays { get; set; }
		double BaseSalaryMonthly { get; set; }
		double RateShiftNight { get; set; }
		double RateShiftSpecial { get; set; }
		double RateOvertime { get; set; }
		[ComVisible(false)]
		double? RateAnnualBonus { get; set; }
		short AnnualBonusMonth { get; set; }
	}


	public partial class PlanHRTariffDetail : BusinessObject<tPlanHRTariffDetail>, IPlanHRTariffDetail
	{
		public PlanHRTariffDetail() : base() {}
		public PlanHRTariffDetail(Guid id) : base(id) {}
		public Guid idTariff
		{
			get => _data.idTariff;
			set
			{
				if (_data.idTariff == value) return;
				bool valid = true;
				_idTariffValid(value, ref valid);

				if (valid)
				{
					_data.idTariff = value;
					_Tariff = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idTariffValid( Guid value, ref bool valid);

		private PlanHRTariff _Tariff;

		public PlanHRTariff TariffParent
		{
			get
			{
				if (_Tariff == null || _Tariff.data == null )
				{
						_Tariff = new PlanHRTariff();
						_Tariff.Id =_data.idTariff;
					return _Tariff;
				}
				else return _Tariff;
			}
			set { 
				_Tariff = value;
				idTariff = _Tariff.Id;
			}
		}

		public DateTime? DateValidTo
		{
			get => _data.DateValidTo.GetValueOrDefault();
			set
			{
				if (_data.DateValidTo == value) return;
				bool valid = true;
				_DateValidToValid(value, ref valid);

				if (valid)
				{
					_data.DateValidTo = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _DateValidToValid( DateTime? value, ref bool valid);

		public short WorkTimeWeekly
		{
			get => _data.WorkTimeWeekly;
			set
			{
				if (_data.WorkTimeWeekly == value) return;
				bool valid = true;
				_WorkTimeWeeklyValid(value, ref valid);

				if (valid)
				{
					_data.WorkTimeWeekly = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _WorkTimeWeeklyValid( short value, ref bool valid);

		public double FTEFactor
		{
			get => _data.FTEFactor;
			set
			{
				if (_data.FTEFactor == value) return;
				bool valid = true;
				_FTEFactorValid(value, ref valid);

				if (valid)
				{
					_data.FTEFactor = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _FTEFactorValid( double value, ref bool valid);

		public double RatioShiftNight
		{
			get => _data.RatioShiftNight;
			set
			{
				if (_data.RatioShiftNight == value) return;
				bool valid = true;
				_RatioShiftNightValid(value, ref valid);

				if (valid)
				{
					_data.RatioShiftNight = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _RatioShiftNightValid( double value, ref bool valid);

		public double RatioShiftSpecial
		{
			get => _data.RatioShiftSpecial;
			set
			{
				if (_data.RatioShiftSpecial == value) return;
				bool valid = true;
				_RatioShiftSpecialValid(value, ref valid);

				if (valid)
				{
					_data.RatioShiftSpecial = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _RatioShiftSpecialValid( double value, ref bool valid);

		public double RatioOvertime
		{
			get => _data.RatioOvertime;
			set
			{
				if (_data.RatioOvertime == value) return;
				bool valid = true;
				_RatioOvertimeValid(value, ref valid);

				if (valid)
				{
					_data.RatioOvertime = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _RatioOvertimeValid( double value, ref bool valid);

		public short AnnualLeave
		{
			get => _data.AnnualLeave;
			set
			{
				if (_data.AnnualLeave == value) return;
				bool valid = true;
				_AnnualLeaveValid(value, ref valid);

				if (valid)
				{
					_data.AnnualLeave = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _AnnualLeaveValid( short value, ref bool valid);

		public short StandardHolidays
		{
			get => _data.StandardHolidays;
			set
			{
				if (_data.StandardHolidays == value) return;
				bool valid = true;
				_StandardHolidaysValid(value, ref valid);

				if (valid)
				{
					_data.StandardHolidays = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _StandardHolidaysValid( short value, ref bool valid);

		public double BaseSalaryMonthly
		{
			get => _data.BaseSalaryMonthly;
			set
			{
				if (_data.BaseSalaryMonthly == value) return;
				bool valid = true;
				_BaseSalaryMonthlyValid(value, ref valid);

				if (valid)
				{
					_data.BaseSalaryMonthly = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _BaseSalaryMonthlyValid( double value, ref bool valid);

		public double RateShiftNight
		{
			get => _data.RateShiftNight;
			set
			{
				if (_data.RateShiftNight == value) return;
				bool valid = true;
				_RateShiftNightValid(value, ref valid);

				if (valid)
				{
					_data.RateShiftNight = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _RateShiftNightValid( double value, ref bool valid);

		public double RateShiftSpecial
		{
			get => _data.RateShiftSpecial;
			set
			{
				if (_data.RateShiftSpecial == value) return;
				bool valid = true;
				_RateShiftSpecialValid(value, ref valid);

				if (valid)
				{
					_data.RateShiftSpecial = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _RateShiftSpecialValid( double value, ref bool valid);

		public double RateOvertime
		{
			get => _data.RateOvertime;
			set
			{
				if (_data.RateOvertime == value) return;
				bool valid = true;
				_RateOvertimeValid(value, ref valid);

				if (valid)
				{
					_data.RateOvertime = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _RateOvertimeValid( double value, ref bool valid);

		public double? RateAnnualBonus
		{
			get => _data.RateAnnualBonus.GetValueOrDefault();
			set
			{
				if (_data.RateAnnualBonus == value) return;
				bool valid = true;
				_RateAnnualBonusValid(value, ref valid);

				if (valid)
				{
					_data.RateAnnualBonus = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _RateAnnualBonusValid( double? value, ref bool valid);

		public short AnnualBonusMonth
		{
			get => _data.AnnualBonusMonth;
			set
			{
				if (_data.AnnualBonusMonth == value) return;
				bool valid = true;
				_AnnualBonusMonthValid(value, ref valid);

				if (valid)
				{
					_data.AnnualBonusMonth = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _AnnualBonusMonthValid( short value, ref bool valid);

	}


	public partial interface IPlanHRExpenseGroup
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idPlan { get; set; }
		Plan PlanParent { get; set; }
		string TitleExpenseGroup { get; set; }
		[ComVisible(false)]
		string ExpenseGroupDescription { get; set; }
		[ComVisible(false)]
		DateTime? DateInflationBase { get; set; }
	}


	public partial class PlanHRExpenseGroup : BusinessObject<tPlanHRExpenseGroup>, IPlanHRExpenseGroup
	{
		public PlanHRExpenseGroup() : base() {}
		public PlanHRExpenseGroup(Guid id) : base(id) {}
		public Guid idPlan
		{
			get => _data.idPlan;
			set
			{
				if (_data.idPlan == value) return;
				bool valid = true;
				_idPlanValid(value, ref valid);

				if (valid)
				{
					_data.idPlan = value;
					_Plan = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idPlanValid( Guid value, ref bool valid);

		private Plan _Plan;

		public Plan PlanParent
		{
			get
			{
				if (_Plan == null || _Plan.data == null )
				{
						_Plan = new Plan();
						_Plan.Id =_data.idPlan;
					return _Plan;
				}
				else return _Plan;
			}
			set { 
				_Plan = value;
				idPlan = _Plan.Id;
			}
		}

		public string TitleExpenseGroup
		{
			get => _data.TitleExpenseGroup;
			set
			{
				if (_data.TitleExpenseGroup == value) return;
				bool valid = true;
				_TitleExpenseGroupValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TitleExpenseGroup").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TitleExpenseGroup = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TitleExpenseGroupValid( string value, ref bool valid);

		public string ExpenseGroupDescription
		{
			get => _data.ExpenseGroupDescription;
			set
			{
				if (_data.ExpenseGroupDescription == value) return;
				bool valid = true;
				_ExpenseGroupDescriptionValid(value, ref valid);

				if (valid)
				{
					_data.ExpenseGroupDescription = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _ExpenseGroupDescriptionValid( string value, ref bool valid);

		public DateTime? DateInflationBase
		{
			get => _data.DateInflationBase.GetValueOrDefault();
			set
			{
				if (_data.DateInflationBase == value) return;
				bool valid = true;
				_DateInflationBaseValid(value, ref valid);

				if (valid)
				{
					_data.DateInflationBase = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _DateInflationBaseValid( DateTime? value, ref bool valid);

	}


	public partial interface IPlanHRExpense
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idExpenseGroup { get; set; }
		PlanHRExpenseGroup ExpenseGroupParent { get; set; }
		[ComVisible(false)]
		DateTime? DateValidTo { get; set; }
		string TitleExpense { get; set; }
		Guid idAccountExpense { get; set; }
		Account AccountExpenseParent { get; set; }
		[ComVisible(false)]
		Guid? idCostCenterFixed { get; set; }
		CostCenter CostCenterFixedParent { get; set; }
		double RatioToSalary { get; set; }
		double ExpenseAmount { get; set; }
		double SalaryCap { get; set; }
		double DeductFromSalary { get; set; }
		short ApplyToBonusMode { get; set; }
		[ComVisible(false)]
		string Assumptions { get; set; }
	}


	public partial class PlanHRExpense : BusinessObject<tPlanHRExpense>, IPlanHRExpense
	{
		public PlanHRExpense() : base() {}
		public PlanHRExpense(Guid id) : base(id) {}
		public Guid idExpenseGroup
		{
			get => _data.idExpenseGroup;
			set
			{
				if (_data.idExpenseGroup == value) return;
				bool valid = true;
				_idExpenseGroupValid(value, ref valid);

				if (valid)
				{
					_data.idExpenseGroup = value;
					_ExpenseGroup = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idExpenseGroupValid( Guid value, ref bool valid);

		private PlanHRExpenseGroup _ExpenseGroup;

		public PlanHRExpenseGroup ExpenseGroupParent
		{
			get
			{
				if (_ExpenseGroup == null || _ExpenseGroup.data == null )
				{
						_ExpenseGroup = new PlanHRExpenseGroup();
						_ExpenseGroup.Id =_data.idExpenseGroup;
					return _ExpenseGroup;
				}
				else return _ExpenseGroup;
			}
			set { 
				_ExpenseGroup = value;
				idExpenseGroup = _ExpenseGroup.Id;
			}
		}

		public DateTime? DateValidTo
		{
			get => _data.DateValidTo.GetValueOrDefault();
			set
			{
				if (_data.DateValidTo == value) return;
				bool valid = true;
				_DateValidToValid(value, ref valid);

				if (valid)
				{
					_data.DateValidTo = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _DateValidToValid( DateTime? value, ref bool valid);

		public string TitleExpense
		{
			get => _data.TitleExpense;
			set
			{
				if (_data.TitleExpense == value) return;
				bool valid = true;
				_TitleExpenseValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TitleExpense").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TitleExpense = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TitleExpenseValid( string value, ref bool valid);

		public Guid idAccountExpense
		{
			get => _data.idAccountExpense;
			set
			{
				if (_data.idAccountExpense == value) return;
				bool valid = true;
				_idAccountExpenseValid(value, ref valid);

				if (valid)
				{
					_data.idAccountExpense = value;
					_AccountExpense = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idAccountExpenseValid( Guid value, ref bool valid);

		private Account _AccountExpense;

		public Account AccountExpenseParent
		{
			get
			{
				if (_AccountExpense == null || _AccountExpense.data == null )
				{
						_AccountExpense = new Account();
						_AccountExpense.Id =_data.idAccountExpense;
					return _AccountExpense;
				}
				else return _AccountExpense;
			}
			set { 
				_AccountExpense = value;
				idAccountExpense = _AccountExpense.Id;
			}
		}

		public Guid? idCostCenterFixed
		{
			get => _data.idCostCenterFixed.GetValueOrDefault();
			set
			{
				if (_data.idCostCenterFixed == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idCostCenterFixedValid(value, ref valid);

				if (valid)
				{
					_data.idCostCenterFixed = value;
					_CostCenterFixed = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idCostCenterFixedValid( Guid? value, ref bool valid);

		private CostCenter _CostCenterFixed;

		public CostCenter CostCenterFixedParent
		{
			get
			{
				if (_CostCenterFixed == null || _CostCenterFixed.data == null )
				{
					if (_data.idCostCenterFixed == null) return null;
					else
					{
						_CostCenterFixed = new CostCenter();
						_CostCenterFixed.Id =_data.idCostCenterFixed.GetValueOrDefault();
						return _CostCenterFixed;
					}
				}
				else return _CostCenterFixed;
			}
			set { 
				_CostCenterFixed = value;
				idCostCenterFixed = _CostCenterFixed.Id;
			}
		}

		public double RatioToSalary
		{
			get => _data.RatioToSalary;
			set
			{
				if (_data.RatioToSalary == value) return;
				bool valid = true;
				_RatioToSalaryValid(value, ref valid);

				if (valid)
				{
					_data.RatioToSalary = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _RatioToSalaryValid( double value, ref bool valid);

		public double ExpenseAmount
		{
			get => _data.ExpenseAmount;
			set
			{
				if (_data.ExpenseAmount == value) return;
				bool valid = true;
				_ExpenseAmountValid(value, ref valid);

				if (valid)
				{
					_data.ExpenseAmount = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _ExpenseAmountValid( double value, ref bool valid);

		public double SalaryCap
		{
			get => _data.SalaryCap;
			set
			{
				if (_data.SalaryCap == value) return;
				bool valid = true;
				_SalaryCapValid(value, ref valid);

				if (valid)
				{
					_data.SalaryCap = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _SalaryCapValid( double value, ref bool valid);

		public double DeductFromSalary
		{
			get => _data.DeductFromSalary;
			set
			{
				if (_data.DeductFromSalary == value) return;
				bool valid = true;
				_DeductFromSalaryValid(value, ref valid);

				if (valid)
				{
					_data.DeductFromSalary = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _DeductFromSalaryValid( double value, ref bool valid);

		public short ApplyToBonusMode
		{
			get => _data.ApplyToBonusMode;
			set
			{
				if (_data.ApplyToBonusMode == value) return;
				bool valid = true;
				_ApplyToBonusModeValid(value, ref valid);

				if (valid)
				{
					_data.ApplyToBonusMode = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _ApplyToBonusModeValid( short value, ref bool valid);

		public string Assumptions
		{
			get => _data.Assumptions;
			set
			{
				if (_data.Assumptions == value) return;
				bool valid = true;
				_AssumptionsValid(value, ref valid);

				if (valid)
				{
					_data.Assumptions = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _AssumptionsValid( string value, ref bool valid);

	}


	public partial interface IPlanElementInstance
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idPlanElement { get; set; }
		PlanElement PlanElementParent { get; set; }
		Guid idPlan { get; set; }
		Plan PlanParent { get; set; }
		bool FlagUpdate { get; set; }
		bool FlagBaseline { get; set; }
		bool FlagDateOffset { get; set; }
		int DueDateYear { get; set; }
		int DueDateMonth { get; set; }
		int DueDateDay { get; set; }
		[ComVisible(false)]
		int? UntilDateYear { get; set; }
		[ComVisible(false)]
		int? UntilDateMonth { get; set; }
		[ComVisible(false)]
		int? UntilDateDay { get; set; }
		[ComVisible(false)]
		Guid? idParTriggerDueDate { get; set; }
		PlanParameter ParTriggerDueDateParent { get; set; }
		[ComVisible(false)]
		string Assumptions { get; set; }
		[ComVisible(false)]
		string Revisions { get; set; }
	}


	public partial class PlanElementInstance : BusinessObject<tPlanElementInstance>, IPlanElementInstance
	{
		public PlanElementInstance() : base() {}
		public PlanElementInstance(Guid id) : base(id) {}
		public Guid idPlanElement
		{
			get => _data.idPlanElement;
			set
			{
				if (_data.idPlanElement == value) return;
				bool valid = true;
				_idPlanElementValid(value, ref valid);

				if (valid)
				{
					_data.idPlanElement = value;
					_PlanElement = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idPlanElementValid( Guid value, ref bool valid);

		private PlanElement _PlanElement;

		public PlanElement PlanElementParent
		{
			get
			{
				if (_PlanElement == null || _PlanElement.data == null )
				{
						_PlanElement = new PlanElement();
						_PlanElement.Id =_data.idPlanElement;
					return _PlanElement;
				}
				else return _PlanElement;
			}
			set { 
				_PlanElement = value;
				idPlanElement = _PlanElement.Id;
			}
		}

		public Guid idPlan
		{
			get => _data.idPlan;
			set
			{
				if (_data.idPlan == value) return;
				bool valid = true;
				_idPlanValid(value, ref valid);

				if (valid)
				{
					_data.idPlan = value;
					_Plan = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idPlanValid( Guid value, ref bool valid);

		private Plan _Plan;

		public Plan PlanParent
		{
			get
			{
				if (_Plan == null || _Plan.data == null )
				{
						_Plan = new Plan();
						_Plan.Id =_data.idPlan;
					return _Plan;
				}
				else return _Plan;
			}
			set { 
				_Plan = value;
				idPlan = _Plan.Id;
			}
		}

		public bool FlagUpdate
		{
			get => _data.FlagUpdate;
			set
			{
				if (_data.FlagUpdate == value) return;
				bool valid = true;
				_FlagUpdateValid(value, ref valid);

				if (valid)
				{
					_data.FlagUpdate = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _FlagUpdateValid( bool value, ref bool valid);

		public bool FlagBaseline
		{
			get => _data.FlagBaseline;
			set
			{
				if (_data.FlagBaseline == value) return;
				bool valid = true;
				_FlagBaselineValid(value, ref valid);

				if (valid)
				{
					_data.FlagBaseline = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _FlagBaselineValid( bool value, ref bool valid);

		public bool FlagDateOffset
		{
			get => _data.FlagDateOffset;
			set
			{
				if (_data.FlagDateOffset == value) return;
				bool valid = true;
				_FlagDateOffsetValid(value, ref valid);

				if (valid)
				{
					_data.FlagDateOffset = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _FlagDateOffsetValid( bool value, ref bool valid);

		public int DueDateYear
		{
			get => _data.DueDateYear;
			set
			{
				if (_data.DueDateYear == value) return;
				bool valid = true;
				_DueDateYearValid(value, ref valid);

				if (valid)
				{
					_data.DueDateYear = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _DueDateYearValid( int value, ref bool valid);

		public int DueDateMonth
		{
			get => _data.DueDateMonth;
			set
			{
				if (_data.DueDateMonth == value) return;
				bool valid = true;
				_DueDateMonthValid(value, ref valid);

				if (valid)
				{
					_data.DueDateMonth = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _DueDateMonthValid( int value, ref bool valid);

		public int DueDateDay
		{
			get => _data.DueDateDay;
			set
			{
				if (_data.DueDateDay == value) return;
				bool valid = true;
				_DueDateDayValid(value, ref valid);

				if (valid)
				{
					_data.DueDateDay = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _DueDateDayValid( int value, ref bool valid);

		public int? UntilDateYear
		{
			get => _data.UntilDateYear.GetValueOrDefault();
			set
			{
				if (_data.UntilDateYear == value) return;
				bool valid = true;
				_UntilDateYearValid(value, ref valid);

				if (valid)
				{
					_data.UntilDateYear = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _UntilDateYearValid( int? value, ref bool valid);

		public int? UntilDateMonth
		{
			get => _data.UntilDateMonth.GetValueOrDefault();
			set
			{
				if (_data.UntilDateMonth == value) return;
				bool valid = true;
				_UntilDateMonthValid(value, ref valid);

				if (valid)
				{
					_data.UntilDateMonth = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _UntilDateMonthValid( int? value, ref bool valid);

		public int? UntilDateDay
		{
			get => _data.UntilDateDay.GetValueOrDefault();
			set
			{
				if (_data.UntilDateDay == value) return;
				bool valid = true;
				_UntilDateDayValid(value, ref valid);

				if (valid)
				{
					_data.UntilDateDay = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _UntilDateDayValid( int? value, ref bool valid);

		public Guid? idParTriggerDueDate
		{
			get => _data.idParTriggerDueDate.GetValueOrDefault();
			set
			{
				if (_data.idParTriggerDueDate == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idParTriggerDueDateValid(value, ref valid);

				if (valid)
				{
					_data.idParTriggerDueDate = value;
					_ParTriggerDueDate = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idParTriggerDueDateValid( Guid? value, ref bool valid);

		private PlanParameter _ParTriggerDueDate;

		public PlanParameter ParTriggerDueDateParent
		{
			get
			{
				if (_ParTriggerDueDate == null || _ParTriggerDueDate.data == null )
				{
					if (_data.idParTriggerDueDate == null) return null;
					else
					{
						_ParTriggerDueDate = new PlanParameter();
						_ParTriggerDueDate.Id =_data.idParTriggerDueDate.GetValueOrDefault();
						return _ParTriggerDueDate;
					}
				}
				else return _ParTriggerDueDate;
			}
			set { 
				_ParTriggerDueDate = value;
				idParTriggerDueDate = _ParTriggerDueDate.Id;
			}
		}

		public string Assumptions
		{
			get => _data.Assumptions;
			set
			{
				if (_data.Assumptions == value) return;
				bool valid = true;
				_AssumptionsValid(value, ref valid);

				if (valid)
				{
					_data.Assumptions = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _AssumptionsValid( string value, ref bool valid);

		public string Revisions
		{
			get => _data.Revisions;
			set
			{
				if (_data.Revisions == value) return;
				bool valid = true;
				_RevisionsValid(value, ref valid);

				if (valid)
				{
					_data.Revisions = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _RevisionsValid( string value, ref bool valid);

	}


	public partial interface IPlanElementContract
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idPlanInstance { get; set; }
		PlanElementInstance PlanInstanceParent { get; set; }
		Guid idAccountMain { get; set; }
		Account AccountMainParent { get; set; }
		[ComVisible(false)]
		Guid? idAllocationSchedule { get; set; }
		PlanAllocationSchedule AllocationScheduleParent { get; set; }
		short TypeRepeat { get; set; }
		[ComVisible(false)]
		Guid? idAccountAdvance { get; set; }
		Account AccountAdvanceParent { get; set; }
		[ComVisible(false)]
		Guid? idParTriggerAdvance { get; set; }
		PlanParameter ParTriggerAdvanceParent { get; set; }
		int AdvanceDelay { get; set; }
		[ComVisible(false)]
		Guid? idDepreciationRule { get; set; }
		DepreciationRule DepreciationRuleParent { get; set; }
		[ComVisible(false)]
		Guid? idDepreciationTrigger { get; set; }
		PlanParameter DepreciationTriggerParent { get; set; }
		[ComVisible(false)]
		int? DepreciationStartDay { get; set; }
		[ComVisible(false)]
		int? DepreciationStartMonth { get; set; }
		[ComVisible(false)]
		int? DepreciationStartYear { get; set; }
		int DepreciationDelay { get; set; }
		[ComVisible(false)]
		Guid? idVATRule { get; set; }
		VATRule VATRuleParent { get; set; }
		[ComVisible(false)]
		Guid? idInflationRule { get; set; }
		PlanInflationRule InflationRuleParent { get; set; }
		[ComVisible(false)]
		Guid? idParPrice1 { get; set; }
		PlanParameter ParPrice1Parent { get; set; }
		[ComVisible(false)]
		Guid? idParPrice2 { get; set; }
		PlanParameter ParPrice2Parent { get; set; }
		int PaymentTerm { get; set; }
		int NumberOfUnits { get; set; }
		double Price { get; set; }
		[ComVisible(false)]
		DateTime? PriceDate { get; set; }
		double BudgetFixed { get; set; }
		[ComVisible(false)]
		Guid? idParContingencyRate { get; set; }
		PlanParameter ParContingencyRateParent { get; set; }
	}


	public partial class PlanElementContract : BusinessObject<tPlanElementContract>, IPlanElementContract
	{
		public PlanElementContract() : base() {}
		public PlanElementContract(Guid id) : base(id) {}
		public Guid idPlanInstance
		{
			get => _data.idPlanInstance;
			set
			{
				if (_data.idPlanInstance == value) return;
				bool valid = true;
				_idPlanInstanceValid(value, ref valid);

				if (valid)
				{
					_data.idPlanInstance = value;
					_PlanInstance = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idPlanInstanceValid( Guid value, ref bool valid);

		private PlanElementInstance _PlanInstance;

		public PlanElementInstance PlanInstanceParent
		{
			get
			{
				if (_PlanInstance == null || _PlanInstance.data == null )
				{
						_PlanInstance = new PlanElementInstance();
						_PlanInstance.Id =_data.idPlanInstance;
					return _PlanInstance;
				}
				else return _PlanInstance;
			}
			set { 
				_PlanInstance = value;
				idPlanInstance = _PlanInstance.Id;
			}
		}

		public Guid idAccountMain
		{
			get => _data.idAccountMain;
			set
			{
				if (_data.idAccountMain == value) return;
				bool valid = true;
				_idAccountMainValid(value, ref valid);

				if (valid)
				{
					_data.idAccountMain = value;
					_AccountMain = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idAccountMainValid( Guid value, ref bool valid);

		private Account _AccountMain;

		public Account AccountMainParent
		{
			get
			{
				if (_AccountMain == null || _AccountMain.data == null )
				{
						_AccountMain = new Account();
						_AccountMain.Id =_data.idAccountMain;
					return _AccountMain;
				}
				else return _AccountMain;
			}
			set { 
				_AccountMain = value;
				idAccountMain = _AccountMain.Id;
			}
		}

		public Guid? idAllocationSchedule
		{
			get => _data.idAllocationSchedule.GetValueOrDefault();
			set
			{
				if (_data.idAllocationSchedule == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idAllocationScheduleValid(value, ref valid);

				if (valid)
				{
					_data.idAllocationSchedule = value;
					_AllocationSchedule = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idAllocationScheduleValid( Guid? value, ref bool valid);

		private PlanAllocationSchedule _AllocationSchedule;

		public PlanAllocationSchedule AllocationScheduleParent
		{
			get
			{
				if (_AllocationSchedule == null || _AllocationSchedule.data == null )
				{
					if (_data.idAllocationSchedule == null) return null;
					else
					{
						_AllocationSchedule = new PlanAllocationSchedule();
						_AllocationSchedule.Id =_data.idAllocationSchedule.GetValueOrDefault();
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
			set
			{
				if (_data.TypeRepeat == value) return;
				bool valid = true;
				_TypeRepeatValid(value, ref valid);

				if (valid)
				{
					_data.TypeRepeat = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TypeRepeatValid( short value, ref bool valid);

		public Guid? idAccountAdvance
		{
			get => _data.idAccountAdvance.GetValueOrDefault();
			set
			{
				if (_data.idAccountAdvance == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idAccountAdvanceValid(value, ref valid);

				if (valid)
				{
					_data.idAccountAdvance = value;
					_AccountAdvance = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idAccountAdvanceValid( Guid? value, ref bool valid);

		private Account _AccountAdvance;

		public Account AccountAdvanceParent
		{
			get
			{
				if (_AccountAdvance == null || _AccountAdvance.data == null )
				{
					if (_data.idAccountAdvance == null) return null;
					else
					{
						_AccountAdvance = new Account();
						_AccountAdvance.Id =_data.idAccountAdvance.GetValueOrDefault();
						return _AccountAdvance;
					}
				}
				else return _AccountAdvance;
			}
			set { 
				_AccountAdvance = value;
				idAccountAdvance = _AccountAdvance.Id;
			}
		}

		public Guid? idParTriggerAdvance
		{
			get => _data.idParTriggerAdvance.GetValueOrDefault();
			set
			{
				if (_data.idParTriggerAdvance == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idParTriggerAdvanceValid(value, ref valid);

				if (valid)
				{
					_data.idParTriggerAdvance = value;
					_ParTriggerAdvance = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idParTriggerAdvanceValid( Guid? value, ref bool valid);

		private PlanParameter _ParTriggerAdvance;

		public PlanParameter ParTriggerAdvanceParent
		{
			get
			{
				if (_ParTriggerAdvance == null || _ParTriggerAdvance.data == null )
				{
					if (_data.idParTriggerAdvance == null) return null;
					else
					{
						_ParTriggerAdvance = new PlanParameter();
						_ParTriggerAdvance.Id =_data.idParTriggerAdvance.GetValueOrDefault();
						return _ParTriggerAdvance;
					}
				}
				else return _ParTriggerAdvance;
			}
			set { 
				_ParTriggerAdvance = value;
				idParTriggerAdvance = _ParTriggerAdvance.Id;
			}
		}

		public int AdvanceDelay
		{
			get => _data.AdvanceDelay;
			set
			{
				if (_data.AdvanceDelay == value) return;
				bool valid = true;
				_AdvanceDelayValid(value, ref valid);

				if (valid)
				{
					_data.AdvanceDelay = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _AdvanceDelayValid( int value, ref bool valid);

		public Guid? idDepreciationRule
		{
			get => _data.idDepreciationRule.GetValueOrDefault();
			set
			{
				if (_data.idDepreciationRule == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idDepreciationRuleValid(value, ref valid);

				if (valid)
				{
					_data.idDepreciationRule = value;
					_DepreciationRule = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idDepreciationRuleValid( Guid? value, ref bool valid);

		private DepreciationRule _DepreciationRule;

		public DepreciationRule DepreciationRuleParent
		{
			get
			{
				if (_DepreciationRule == null || _DepreciationRule.data == null )
				{
					if (_data.idDepreciationRule == null) return null;
					else
					{
						_DepreciationRule = new DepreciationRule();
						_DepreciationRule.Id =_data.idDepreciationRule.GetValueOrDefault();
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

		public Guid? idDepreciationTrigger
		{
			get => _data.idDepreciationTrigger.GetValueOrDefault();
			set
			{
				if (_data.idDepreciationTrigger == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idDepreciationTriggerValid(value, ref valid);

				if (valid)
				{
					_data.idDepreciationTrigger = value;
					_DepreciationTrigger = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idDepreciationTriggerValid( Guid? value, ref bool valid);

		private PlanParameter _DepreciationTrigger;

		public PlanParameter DepreciationTriggerParent
		{
			get
			{
				if (_DepreciationTrigger == null || _DepreciationTrigger.data == null )
				{
					if (_data.idDepreciationTrigger == null) return null;
					else
					{
						_DepreciationTrigger = new PlanParameter();
						_DepreciationTrigger.Id =_data.idDepreciationTrigger.GetValueOrDefault();
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

		public int? DepreciationStartDay
		{
			get => _data.DepreciationStartDay.GetValueOrDefault();
			set
			{
				if (_data.DepreciationStartDay == value) return;
				bool valid = true;
				_DepreciationStartDayValid(value, ref valid);

				if (valid)
				{
					_data.DepreciationStartDay = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _DepreciationStartDayValid( int? value, ref bool valid);

		public int? DepreciationStartMonth
		{
			get => _data.DepreciationStartMonth.GetValueOrDefault();
			set
			{
				if (_data.DepreciationStartMonth == value) return;
				bool valid = true;
				_DepreciationStartMonthValid(value, ref valid);

				if (valid)
				{
					_data.DepreciationStartMonth = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _DepreciationStartMonthValid( int? value, ref bool valid);

		public int? DepreciationStartYear
		{
			get => _data.DepreciationStartYear.GetValueOrDefault();
			set
			{
				if (_data.DepreciationStartYear == value) return;
				bool valid = true;
				_DepreciationStartYearValid(value, ref valid);

				if (valid)
				{
					_data.DepreciationStartYear = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _DepreciationStartYearValid( int? value, ref bool valid);

		public int DepreciationDelay
		{
			get => _data.DepreciationDelay;
			set
			{
				if (_data.DepreciationDelay == value) return;
				bool valid = true;
				_DepreciationDelayValid(value, ref valid);

				if (valid)
				{
					_data.DepreciationDelay = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _DepreciationDelayValid( int value, ref bool valid);

		public Guid? idVATRule
		{
			get => _data.idVATRule.GetValueOrDefault();
			set
			{
				if (_data.idVATRule == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idVATRuleValid(value, ref valid);

				if (valid)
				{
					_data.idVATRule = value;
					_VATRule = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idVATRuleValid( Guid? value, ref bool valid);

		private VATRule _VATRule;

		public VATRule VATRuleParent
		{
			get
			{
				if (_VATRule == null || _VATRule.data == null )
				{
					if (_data.idVATRule == null) return null;
					else
					{
						_VATRule = new VATRule();
						_VATRule.Id =_data.idVATRule.GetValueOrDefault();
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

		public Guid? idInflationRule
		{
			get => _data.idInflationRule.GetValueOrDefault();
			set
			{
				if (_data.idInflationRule == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idInflationRuleValid(value, ref valid);

				if (valid)
				{
					_data.idInflationRule = value;
					_InflationRule = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idInflationRuleValid( Guid? value, ref bool valid);

		private PlanInflationRule _InflationRule;

		public PlanInflationRule InflationRuleParent
		{
			get
			{
				if (_InflationRule == null || _InflationRule.data == null )
				{
					if (_data.idInflationRule == null) return null;
					else
					{
						_InflationRule = new PlanInflationRule();
						_InflationRule.Id =_data.idInflationRule.GetValueOrDefault();
						return _InflationRule;
					}
				}
				else return _InflationRule;
			}
			set { 
				_InflationRule = value;
				idInflationRule = _InflationRule.Id;
			}
		}

		public Guid? idParPrice1
		{
			get => _data.idParPrice1.GetValueOrDefault();
			set
			{
				if (_data.idParPrice1 == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idParPrice1Valid(value, ref valid);

				if (valid)
				{
					_data.idParPrice1 = value;
					_ParPrice1 = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idParPrice1Valid( Guid? value, ref bool valid);

		private PlanParameter _ParPrice1;

		public PlanParameter ParPrice1Parent
		{
			get
			{
				if (_ParPrice1 == null || _ParPrice1.data == null )
				{
					if (_data.idParPrice1 == null) return null;
					else
					{
						_ParPrice1 = new PlanParameter();
						_ParPrice1.Id =_data.idParPrice1.GetValueOrDefault();
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

		public Guid? idParPrice2
		{
			get => _data.idParPrice2.GetValueOrDefault();
			set
			{
				if (_data.idParPrice2 == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idParPrice2Valid(value, ref valid);

				if (valid)
				{
					_data.idParPrice2 = value;
					_ParPrice2 = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idParPrice2Valid( Guid? value, ref bool valid);

		private PlanParameter _ParPrice2;

		public PlanParameter ParPrice2Parent
		{
			get
			{
				if (_ParPrice2 == null || _ParPrice2.data == null )
				{
					if (_data.idParPrice2 == null) return null;
					else
					{
						_ParPrice2 = new PlanParameter();
						_ParPrice2.Id =_data.idParPrice2.GetValueOrDefault();
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

		public int PaymentTerm
		{
			get => _data.PaymentTerm;
			set
			{
				if (_data.PaymentTerm == value) return;
				bool valid = true;
				_PaymentTermValid(value, ref valid);

				if (valid)
				{
					_data.PaymentTerm = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _PaymentTermValid( int value, ref bool valid);

		public int NumberOfUnits
		{
			get => _data.NumberOfUnits;
			set
			{
				if (_data.NumberOfUnits == value) return;
				bool valid = true;
				_NumberOfUnitsValid(value, ref valid);

				if (valid)
				{
					_data.NumberOfUnits = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _NumberOfUnitsValid( int value, ref bool valid);

		public double Price
		{
			get => _data.Price;
			set
			{
				if (_data.Price == value) return;
				bool valid = true;
				_PriceValid(value, ref valid);

				if (valid)
				{
					_data.Price = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _PriceValid( double value, ref bool valid);

		public DateTime? PriceDate
		{
			get => _data.PriceDate.GetValueOrDefault();
			set
			{
				if (_data.PriceDate == value) return;
				bool valid = true;
				_PriceDateValid(value, ref valid);

				if (valid)
				{
					_data.PriceDate = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _PriceDateValid( DateTime? value, ref bool valid);

		public double BudgetFixed
		{
			get => _data.BudgetFixed;
			set
			{
				if (_data.BudgetFixed == value) return;
				bool valid = true;
				_BudgetFixedValid(value, ref valid);

				if (valid)
				{
					_data.BudgetFixed = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _BudgetFixedValid( double value, ref bool valid);

		public Guid? idParContingencyRate
		{
			get => _data.idParContingencyRate.GetValueOrDefault();
			set
			{
				if (_data.idParContingencyRate == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idParContingencyRateValid(value, ref valid);

				if (valid)
				{
					_data.idParContingencyRate = value;
					_ParContingencyRate = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idParContingencyRateValid( Guid? value, ref bool valid);

		private PlanParameter _ParContingencyRate;

		public PlanParameter ParContingencyRateParent
		{
			get
			{
				if (_ParContingencyRate == null || _ParContingencyRate.data == null )
				{
					if (_data.idParContingencyRate == null) return null;
					else
					{
						_ParContingencyRate = new PlanParameter();
						_ParContingencyRate.Id =_data.idParContingencyRate.GetValueOrDefault();
						return _ParContingencyRate;
					}
				}
				else return _ParContingencyRate;
			}
			set { 
				_ParContingencyRate = value;
				idParContingencyRate = _ParContingencyRate.Id;
			}
		}

	}


	public partial interface IPlanElementBooking
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idPlanInstance { get; set; }
		PlanElementInstance PlanInstanceParent { get; set; }
		Guid idAccountDebit { get; set; }
		Account AccountDebitParent { get; set; }
		Guid idAccountCredit { get; set; }
		Account AccountCreditParent { get; set; }
		[ComVisible(false)]
		Guid? idAllocationSchedule { get; set; }
		PlanAllocationSchedule AllocationScheduleParent { get; set; }
		short TypeRepeat { get; set; }
		[ComVisible(false)]
		Guid? idInflationRule { get; set; }
		PlanInflationRule InflationRuleParent { get; set; }
		[ComVisible(false)]
		Guid? idParPrice1 { get; set; }
		PlanParameter ParPrice1Parent { get; set; }
		[ComVisible(false)]
		Guid? idParPrice2 { get; set; }
		PlanParameter ParPrice2Parent { get; set; }
		int NumberOfUnits { get; set; }
		double Price { get; set; }
		[ComVisible(false)]
		DateTime? PriceDate { get; set; }
		double BudgetFixed { get; set; }
		[ComVisible(false)]
		Guid? idParContingencyRate { get; set; }
		PlanParameter ParContingencyRateParent { get; set; }
		bool FlagAccountOpening { get; set; }
	}


	public partial class PlanElementBooking : BusinessObject<tPlanElementBooking>, IPlanElementBooking
	{
		public PlanElementBooking() : base() {}
		public PlanElementBooking(Guid id) : base(id) {}
		public Guid idPlanInstance
		{
			get => _data.idPlanInstance;
			set
			{
				if (_data.idPlanInstance == value) return;
				bool valid = true;
				_idPlanInstanceValid(value, ref valid);

				if (valid)
				{
					_data.idPlanInstance = value;
					_PlanInstance = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idPlanInstanceValid( Guid value, ref bool valid);

		private PlanElementInstance _PlanInstance;

		public PlanElementInstance PlanInstanceParent
		{
			get
			{
				if (_PlanInstance == null || _PlanInstance.data == null )
				{
						_PlanInstance = new PlanElementInstance();
						_PlanInstance.Id =_data.idPlanInstance;
					return _PlanInstance;
				}
				else return _PlanInstance;
			}
			set { 
				_PlanInstance = value;
				idPlanInstance = _PlanInstance.Id;
			}
		}

		public Guid idAccountDebit
		{
			get => _data.idAccountDebit;
			set
			{
				if (_data.idAccountDebit == value) return;
				bool valid = true;
				_idAccountDebitValid(value, ref valid);

				if (valid)
				{
					_data.idAccountDebit = value;
					_AccountDebit = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idAccountDebitValid( Guid value, ref bool valid);

		private Account _AccountDebit;

		public Account AccountDebitParent
		{
			get
			{
				if (_AccountDebit == null || _AccountDebit.data == null )
				{
						_AccountDebit = new Account();
						_AccountDebit.Id =_data.idAccountDebit;
					return _AccountDebit;
				}
				else return _AccountDebit;
			}
			set { 
				_AccountDebit = value;
				idAccountDebit = _AccountDebit.Id;
			}
		}

		public Guid idAccountCredit
		{
			get => _data.idAccountCredit;
			set
			{
				if (_data.idAccountCredit == value) return;
				bool valid = true;
				_idAccountCreditValid(value, ref valid);

				if (valid)
				{
					_data.idAccountCredit = value;
					_AccountCredit = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idAccountCreditValid( Guid value, ref bool valid);

		private Account _AccountCredit;

		public Account AccountCreditParent
		{
			get
			{
				if (_AccountCredit == null || _AccountCredit.data == null )
				{
						_AccountCredit = new Account();
						_AccountCredit.Id =_data.idAccountCredit;
					return _AccountCredit;
				}
				else return _AccountCredit;
			}
			set { 
				_AccountCredit = value;
				idAccountCredit = _AccountCredit.Id;
			}
		}

		public Guid? idAllocationSchedule
		{
			get => _data.idAllocationSchedule.GetValueOrDefault();
			set
			{
				if (_data.idAllocationSchedule == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idAllocationScheduleValid(value, ref valid);

				if (valid)
				{
					_data.idAllocationSchedule = value;
					_AllocationSchedule = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idAllocationScheduleValid( Guid? value, ref bool valid);

		private PlanAllocationSchedule _AllocationSchedule;

		public PlanAllocationSchedule AllocationScheduleParent
		{
			get
			{
				if (_AllocationSchedule == null || _AllocationSchedule.data == null )
				{
					if (_data.idAllocationSchedule == null) return null;
					else
					{
						_AllocationSchedule = new PlanAllocationSchedule();
						_AllocationSchedule.Id =_data.idAllocationSchedule.GetValueOrDefault();
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
			set
			{
				if (_data.TypeRepeat == value) return;
				bool valid = true;
				_TypeRepeatValid(value, ref valid);

				if (valid)
				{
					_data.TypeRepeat = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TypeRepeatValid( short value, ref bool valid);

		public Guid? idInflationRule
		{
			get => _data.idInflationRule.GetValueOrDefault();
			set
			{
				if (_data.idInflationRule == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idInflationRuleValid(value, ref valid);

				if (valid)
				{
					_data.idInflationRule = value;
					_InflationRule = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idInflationRuleValid( Guid? value, ref bool valid);

		private PlanInflationRule _InflationRule;

		public PlanInflationRule InflationRuleParent
		{
			get
			{
				if (_InflationRule == null || _InflationRule.data == null )
				{
					if (_data.idInflationRule == null) return null;
					else
					{
						_InflationRule = new PlanInflationRule();
						_InflationRule.Id =_data.idInflationRule.GetValueOrDefault();
						return _InflationRule;
					}
				}
				else return _InflationRule;
			}
			set { 
				_InflationRule = value;
				idInflationRule = _InflationRule.Id;
			}
		}

		public Guid? idParPrice1
		{
			get => _data.idParPrice1.GetValueOrDefault();
			set
			{
				if (_data.idParPrice1 == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idParPrice1Valid(value, ref valid);

				if (valid)
				{
					_data.idParPrice1 = value;
					_ParPrice1 = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idParPrice1Valid( Guid? value, ref bool valid);

		private PlanParameter _ParPrice1;

		public PlanParameter ParPrice1Parent
		{
			get
			{
				if (_ParPrice1 == null || _ParPrice1.data == null )
				{
					if (_data.idParPrice1 == null) return null;
					else
					{
						_ParPrice1 = new PlanParameter();
						_ParPrice1.Id =_data.idParPrice1.GetValueOrDefault();
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

		public Guid? idParPrice2
		{
			get => _data.idParPrice2.GetValueOrDefault();
			set
			{
				if (_data.idParPrice2 == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idParPrice2Valid(value, ref valid);

				if (valid)
				{
					_data.idParPrice2 = value;
					_ParPrice2 = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idParPrice2Valid( Guid? value, ref bool valid);

		private PlanParameter _ParPrice2;

		public PlanParameter ParPrice2Parent
		{
			get
			{
				if (_ParPrice2 == null || _ParPrice2.data == null )
				{
					if (_data.idParPrice2 == null) return null;
					else
					{
						_ParPrice2 = new PlanParameter();
						_ParPrice2.Id =_data.idParPrice2.GetValueOrDefault();
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

		public int NumberOfUnits
		{
			get => _data.NumberOfUnits;
			set
			{
				if (_data.NumberOfUnits == value) return;
				bool valid = true;
				_NumberOfUnitsValid(value, ref valid);

				if (valid)
				{
					_data.NumberOfUnits = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _NumberOfUnitsValid( int value, ref bool valid);

		public double Price
		{
			get => _data.Price;
			set
			{
				if (_data.Price == value) return;
				bool valid = true;
				_PriceValid(value, ref valid);

				if (valid)
				{
					_data.Price = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _PriceValid( double value, ref bool valid);

		public DateTime? PriceDate
		{
			get => _data.PriceDate.GetValueOrDefault();
			set
			{
				if (_data.PriceDate == value) return;
				bool valid = true;
				_PriceDateValid(value, ref valid);

				if (valid)
				{
					_data.PriceDate = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _PriceDateValid( DateTime? value, ref bool valid);

		public double BudgetFixed
		{
			get => _data.BudgetFixed;
			set
			{
				if (_data.BudgetFixed == value) return;
				bool valid = true;
				_BudgetFixedValid(value, ref valid);

				if (valid)
				{
					_data.BudgetFixed = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _BudgetFixedValid( double value, ref bool valid);

		public Guid? idParContingencyRate
		{
			get => _data.idParContingencyRate.GetValueOrDefault();
			set
			{
				if (_data.idParContingencyRate == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idParContingencyRateValid(value, ref valid);

				if (valid)
				{
					_data.idParContingencyRate = value;
					_ParContingencyRate = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idParContingencyRateValid( Guid? value, ref bool valid);

		private PlanParameter _ParContingencyRate;

		public PlanParameter ParContingencyRateParent
		{
			get
			{
				if (_ParContingencyRate == null || _ParContingencyRate.data == null )
				{
					if (_data.idParContingencyRate == null) return null;
					else
					{
						_ParContingencyRate = new PlanParameter();
						_ParContingencyRate.Id =_data.idParContingencyRate.GetValueOrDefault();
						return _ParContingencyRate;
					}
				}
				else return _ParContingencyRate;
			}
			set { 
				_ParContingencyRate = value;
				idParContingencyRate = _ParContingencyRate.Id;
			}
		}

		public bool FlagAccountOpening
		{
			get => _data.FlagAccountOpening;
			set
			{
				if (_data.FlagAccountOpening == value) return;
				bool valid = true;
				_FlagAccountOpeningValid(value, ref valid);

				if (valid)
				{
					_data.FlagAccountOpening = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _FlagAccountOpeningValid( bool value, ref bool valid);

	}


	public partial interface IPlanElementHR
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idPlanInstance { get; set; }
		PlanElementInstance PlanInstanceParent { get; set; }
		[ComVisible(false)]
		Guid? idInflationRule { get; set; }
		PlanInflationRule InflationRuleParent { get; set; }
		Guid idTariff { get; set; }
		PlanHRTariff TariffParent { get; set; }
		Guid idExpenseGroup { get; set; }
		PlanHRExpenseGroup ExpenseGroupParent { get; set; }
		[ComVisible(false)]
		string StaffName { get; set; }
		[ComVisible(false)]
		string Department { get; set; }
	}


	public partial class PlanElementHR : BusinessObject<tPlanElementHR>, IPlanElementHR
	{
		public PlanElementHR() : base() {}
		public PlanElementHR(Guid id) : base(id) {}
		public Guid idPlanInstance
		{
			get => _data.idPlanInstance;
			set
			{
				if (_data.idPlanInstance == value) return;
				bool valid = true;
				_idPlanInstanceValid(value, ref valid);

				if (valid)
				{
					_data.idPlanInstance = value;
					_PlanInstance = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idPlanInstanceValid( Guid value, ref bool valid);

		private PlanElementInstance _PlanInstance;

		public PlanElementInstance PlanInstanceParent
		{
			get
			{
				if (_PlanInstance == null || _PlanInstance.data == null )
				{
						_PlanInstance = new PlanElementInstance();
						_PlanInstance.Id =_data.idPlanInstance;
					return _PlanInstance;
				}
				else return _PlanInstance;
			}
			set { 
				_PlanInstance = value;
				idPlanInstance = _PlanInstance.Id;
			}
		}

		public Guid? idInflationRule
		{
			get => _data.idInflationRule.GetValueOrDefault();
			set
			{
				if (_data.idInflationRule == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idInflationRuleValid(value, ref valid);

				if (valid)
				{
					_data.idInflationRule = value;
					_InflationRule = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idInflationRuleValid( Guid? value, ref bool valid);

		private PlanInflationRule _InflationRule;

		public PlanInflationRule InflationRuleParent
		{
			get
			{
				if (_InflationRule == null || _InflationRule.data == null )
				{
					if (_data.idInflationRule == null) return null;
					else
					{
						_InflationRule = new PlanInflationRule();
						_InflationRule.Id =_data.idInflationRule.GetValueOrDefault();
						return _InflationRule;
					}
				}
				else return _InflationRule;
			}
			set { 
				_InflationRule = value;
				idInflationRule = _InflationRule.Id;
			}
		}

		public Guid idTariff
		{
			get => _data.idTariff;
			set
			{
				if (_data.idTariff == value) return;
				bool valid = true;
				_idTariffValid(value, ref valid);

				if (valid)
				{
					_data.idTariff = value;
					_Tariff = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idTariffValid( Guid value, ref bool valid);

		private PlanHRTariff _Tariff;

		public PlanHRTariff TariffParent
		{
			get
			{
				if (_Tariff == null || _Tariff.data == null )
				{
						_Tariff = new PlanHRTariff();
						_Tariff.Id =_data.idTariff;
					return _Tariff;
				}
				else return _Tariff;
			}
			set { 
				_Tariff = value;
				idTariff = _Tariff.Id;
			}
		}

		public Guid idExpenseGroup
		{
			get => _data.idExpenseGroup;
			set
			{
				if (_data.idExpenseGroup == value) return;
				bool valid = true;
				_idExpenseGroupValid(value, ref valid);

				if (valid)
				{
					_data.idExpenseGroup = value;
					_ExpenseGroup = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idExpenseGroupValid( Guid value, ref bool valid);

		private PlanHRExpenseGroup _ExpenseGroup;

		public PlanHRExpenseGroup ExpenseGroupParent
		{
			get
			{
				if (_ExpenseGroup == null || _ExpenseGroup.data == null )
				{
						_ExpenseGroup = new PlanHRExpenseGroup();
						_ExpenseGroup.Id =_data.idExpenseGroup;
					return _ExpenseGroup;
				}
				else return _ExpenseGroup;
			}
			set { 
				_ExpenseGroup = value;
				idExpenseGroup = _ExpenseGroup.Id;
			}
		}

		public string StaffName
		{
			get => _data.StaffName;
			set
			{
				if (_data.StaffName == value) return;
				bool valid = true;
				_StaffNameValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("StaffName").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.StaffName = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _StaffNameValid( string value, ref bool valid);

		public string Department
		{
			get => _data.Department;
			set
			{
				if (_data.Department == value) return;
				bool valid = true;
				_DepartmentValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("Department").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.Department = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _DepartmentValid( string value, ref bool valid);

	}


	public partial interface IPlanTransaction
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idPlan { get; set; }
		Plan PlanParent { get; set; }
		Guid idBookTransaction { get; set; }
		BookTransaction BookTransactionParent { get; set; }
	}


	public partial class PlanTransaction : BusinessObject<tPlanTransaction>, IPlanTransaction
	{
		public PlanTransaction() : base() {}
		public PlanTransaction(Guid id) : base(id) {}
		public Guid idPlan
		{
			get => _data.idPlan;
			set
			{
				if (_data.idPlan == value) return;
				bool valid = true;
				_idPlanValid(value, ref valid);

				if (valid)
				{
					_data.idPlan = value;
					_Plan = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idPlanValid( Guid value, ref bool valid);

		private Plan _Plan;

		public Plan PlanParent
		{
			get
			{
				if (_Plan == null || _Plan.data == null )
				{
						_Plan = new Plan();
						_Plan.Id =_data.idPlan;
					return _Plan;
				}
				else return _Plan;
			}
			set { 
				_Plan = value;
				idPlan = _Plan.Id;
			}
		}

		public Guid idBookTransaction
		{
			get => _data.idBookTransaction;
			set
			{
				if (_data.idBookTransaction == value) return;
				bool valid = true;
				_idBookTransactionValid(value, ref valid);

				if (valid)
				{
					_data.idBookTransaction = value;
					_BookTransaction = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idBookTransactionValid( Guid value, ref bool valid);

		private BookTransaction _BookTransaction;

		public BookTransaction BookTransactionParent
		{
			get
			{
				if (_BookTransaction == null || _BookTransaction.data == null )
				{
						_BookTransaction = new BookTransaction();
						_BookTransaction.Id =_data.idBookTransaction;
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


	public partial interface IBookRecord
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idClient { get; set; }
		Client ClientParent { get; set; }
		bool FlagOutdated { get; set; }
		[ComVisible(false)]
		DateTime? DateOutdated { get; set; }
		short TypeBookRecord { get; set; }
		bool FlagAccountOpening { get; set; }
		Guid idAccountDebit { get; set; }
		Account AccountDebitParent { get; set; }
		Guid idAccountCredit { get; set; }
		Account AccountCreditParent { get; set; }
		[ComVisible(false)]
		Guid? idCostCenterBookRecord { get; set; }
		CostCenter CostCenterBookRecordParent { get; set; }
		[ComVisible(false)]
		Guid? idBookingRun { get; set; }
		BookingRun BookingRunParent { get; set; }
		[ComVisible(false)]
		string BookingRunCode { get; set; }
		[ComVisible(false)]
		int? BookingSequenceNum { get; set; }
		int AccountCodeDebit { get; set; }
		int AccountCodeCredit { get; set; }
		short DATEVBUCode { get; set; }
		[ComVisible(false)]
		Guid? idPlanElementInstance { get; set; }
		PlanElementInstance PlanElementInstanceParent { get; set; }
		[ComVisible(false)]
		string TitleBookRecord { get; set; }
		DateTime BookingDate { get; set; }
		double Amount { get; set; }
		[ComVisible(false)]
		string BookingDocument { get; set; }
		[ComVisible(false)]
		string ReferenceIDBookRecord { get; set; }
		[ComVisible(false)]
		string BookRecordComment { get; set; }
		[ComVisible(false)]
		int? BCTransactionNo { get; set; }
		[ComVisible(false)]
		DateTime? BCDateUpdated { get; set; }
		[ComVisible(false)]
		DateTime? BCDateCreated { get; set; }
		[ComVisible(false)]
		int? TransactionMainAccountCode { get; set; }
		[ComVisible(false)]
		string BCDocumentNo { get; set; }
		[ComVisible(false)]
		string BCDocumentType { get; set; }
	}


	public partial class BookRecord : BusinessObject<tBookRecord>, IBookRecord
	{
		public BookRecord() : base() {}
		public BookRecord(Guid id) : base(id) {}
		public Guid idClient
		{
			get => _data.idClient;
			set
			{
				if (_data.idClient == value) return;
				bool valid = true;
				_idClientValid(value, ref valid);

				if (valid)
				{
					_data.idClient = value;
					_Client = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idClientValid( Guid value, ref bool valid);

		private Client _Client;

		public Client ClientParent
		{
			get
			{
				if (_Client == null || _Client.data == null )
				{
						_Client = new Client();
						_Client.Id =_data.idClient;
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
			set
			{
				if (_data.FlagOutdated == value) return;
				bool valid = true;
				_FlagOutdatedValid(value, ref valid);

				if (valid)
				{
					_data.FlagOutdated = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _FlagOutdatedValid( bool value, ref bool valid);

		public DateTime? DateOutdated
		{
			get => _data.DateOutdated.GetValueOrDefault();
			set
			{
				if (_data.DateOutdated == value) return;
				bool valid = true;
				_DateOutdatedValid(value, ref valid);

				if (valid)
				{
					_data.DateOutdated = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _DateOutdatedValid( DateTime? value, ref bool valid);

		public short TypeBookRecord
		{
			get => _data.TypeBookRecord;
			set
			{
				if (_data.TypeBookRecord == value) return;
				bool valid = true;
				_TypeBookRecordValid(value, ref valid);

				if (valid)
				{
					_data.TypeBookRecord = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TypeBookRecordValid( short value, ref bool valid);

		public bool FlagAccountOpening
		{
			get => _data.FlagAccountOpening;
			set
			{
				if (_data.FlagAccountOpening == value) return;
				bool valid = true;
				_FlagAccountOpeningValid(value, ref valid);

				if (valid)
				{
					_data.FlagAccountOpening = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _FlagAccountOpeningValid( bool value, ref bool valid);

		public Guid idAccountDebit
		{
			get => _data.idAccountDebit;
			set
			{
				if (_data.idAccountDebit == value) return;
				bool valid = true;
				_idAccountDebitValid(value, ref valid);

				if (valid)
				{
					_data.idAccountDebit = value;
					_AccountDebit = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idAccountDebitValid( Guid value, ref bool valid);

		private Account _AccountDebit;

		public Account AccountDebitParent
		{
			get
			{
				if (_AccountDebit == null || _AccountDebit.data == null )
				{
						_AccountDebit = new Account();
						_AccountDebit.Id =_data.idAccountDebit;
					return _AccountDebit;
				}
				else return _AccountDebit;
			}
			set { 
				_AccountDebit = value;
				idAccountDebit = _AccountDebit.Id;
			}
		}

		public Guid idAccountCredit
		{
			get => _data.idAccountCredit;
			set
			{
				if (_data.idAccountCredit == value) return;
				bool valid = true;
				_idAccountCreditValid(value, ref valid);

				if (valid)
				{
					_data.idAccountCredit = value;
					_AccountCredit = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idAccountCreditValid( Guid value, ref bool valid);

		private Account _AccountCredit;

		public Account AccountCreditParent
		{
			get
			{
				if (_AccountCredit == null || _AccountCredit.data == null )
				{
						_AccountCredit = new Account();
						_AccountCredit.Id =_data.idAccountCredit;
					return _AccountCredit;
				}
				else return _AccountCredit;
			}
			set { 
				_AccountCredit = value;
				idAccountCredit = _AccountCredit.Id;
			}
		}

		public Guid? idCostCenterBookRecord
		{
			get => _data.idCostCenterBookRecord.GetValueOrDefault();
			set
			{
				if (_data.idCostCenterBookRecord == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idCostCenterBookRecordValid(value, ref valid);

				if (valid)
				{
					_data.idCostCenterBookRecord = value;
					_CostCenterBookRecord = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idCostCenterBookRecordValid( Guid? value, ref bool valid);

		private CostCenter _CostCenterBookRecord;

		public CostCenter CostCenterBookRecordParent
		{
			get
			{
				if (_CostCenterBookRecord == null || _CostCenterBookRecord.data == null )
				{
					if (_data.idCostCenterBookRecord == null) return null;
					else
					{
						_CostCenterBookRecord = new CostCenter();
						_CostCenterBookRecord.Id =_data.idCostCenterBookRecord.GetValueOrDefault();
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

		public Guid? idBookingRun
		{
			get => _data.idBookingRun.GetValueOrDefault();
			set
			{
				if (_data.idBookingRun == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idBookingRunValid(value, ref valid);

				if (valid)
				{
					_data.idBookingRun = value;
					_BookingRun = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idBookingRunValid( Guid? value, ref bool valid);

		private BookingRun _BookingRun;

		public BookingRun BookingRunParent
		{
			get
			{
				if (_BookingRun == null || _BookingRun.data == null )
				{
					if (_data.idBookingRun == null) return null;
					else
					{
						_BookingRun = new BookingRun();
						_BookingRun.Id =_data.idBookingRun.GetValueOrDefault();
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

		public string BookingRunCode
		{
			get => _data.BookingRunCode;
			set
			{
				if (_data.BookingRunCode == value) return;
				bool valid = true;
				_BookingRunCodeValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("BookingRunCode").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.BookingRunCode = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _BookingRunCodeValid( string value, ref bool valid);

		public int? BookingSequenceNum
		{
			get => _data.BookingSequenceNum.GetValueOrDefault();
			set
			{
				if (_data.BookingSequenceNum == value) return;
				bool valid = true;
				_BookingSequenceNumValid(value, ref valid);

				if (valid)
				{
					_data.BookingSequenceNum = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _BookingSequenceNumValid( int? value, ref bool valid);

		public int AccountCodeDebit
		{
			get => _data.AccountCodeDebit;
			set
			{
				if (_data.AccountCodeDebit == value) return;
				bool valid = true;
				_AccountCodeDebitValid(value, ref valid);

				if (valid)
				{
					_data.AccountCodeDebit = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _AccountCodeDebitValid( int value, ref bool valid);

		public int AccountCodeCredit
		{
			get => _data.AccountCodeCredit;
			set
			{
				if (_data.AccountCodeCredit == value) return;
				bool valid = true;
				_AccountCodeCreditValid(value, ref valid);

				if (valid)
				{
					_data.AccountCodeCredit = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _AccountCodeCreditValid( int value, ref bool valid);

		public short DATEVBUCode
		{
			get => _data.DATEVBUCode;
			set
			{
				if (_data.DATEVBUCode == value) return;
				bool valid = true;
				_DATEVBUCodeValid(value, ref valid);

				if (valid)
				{
					_data.DATEVBUCode = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _DATEVBUCodeValid( short value, ref bool valid);

		public Guid? idPlanElementInstance
		{
			get => _data.idPlanElementInstance.GetValueOrDefault();
			set
			{
				if (_data.idPlanElementInstance == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idPlanElementInstanceValid(value, ref valid);

				if (valid)
				{
					_data.idPlanElementInstance = value;
					_PlanElementInstance = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idPlanElementInstanceValid( Guid? value, ref bool valid);

		private PlanElementInstance _PlanElementInstance;

		public PlanElementInstance PlanElementInstanceParent
		{
			get
			{
				if (_PlanElementInstance == null || _PlanElementInstance.data == null )
				{
					if (_data.idPlanElementInstance == null) return null;
					else
					{
						_PlanElementInstance = new PlanElementInstance();
						_PlanElementInstance.Id =_data.idPlanElementInstance.GetValueOrDefault();
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
			set
			{
				if (_data.TitleBookRecord == value) return;
				bool valid = true;
				_TitleBookRecordValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("TitleBookRecord").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.TitleBookRecord = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TitleBookRecordValid( string value, ref bool valid);

		public DateTime BookingDate
		{
			get => _data.BookingDate;
			set
			{
				if (_data.BookingDate == value) return;
				bool valid = true;
				_BookingDateValid(value, ref valid);

				if (valid)
				{
					_data.BookingDate = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _BookingDateValid( DateTime value, ref bool valid);

		public double Amount
		{
			get => _data.Amount;
			set
			{
				if (_data.Amount == value) return;
				bool valid = true;
				_AmountValid(value, ref valid);

				if (valid)
				{
					_data.Amount = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _AmountValid( double value, ref bool valid);

		public string BookingDocument
		{
			get => _data.BookingDocument;
			set
			{
				if (_data.BookingDocument == value) return;
				bool valid = true;
				_BookingDocumentValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("BookingDocument").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.BookingDocument = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _BookingDocumentValid( string value, ref bool valid);

		public string ReferenceIDBookRecord
		{
			get => _data.ReferenceIDBookRecord;
			set
			{
				if (_data.ReferenceIDBookRecord == value) return;
				bool valid = true;
				_ReferenceIDBookRecordValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("ReferenceIDBookRecord").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.ReferenceIDBookRecord = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _ReferenceIDBookRecordValid( string value, ref bool valid);

		public string BookRecordComment
		{
			get => _data.BookRecordComment;
			set
			{
				if (_data.BookRecordComment == value) return;
				bool valid = true;
				_BookRecordCommentValid(value, ref valid);

				if (valid)
				{
					_data.BookRecordComment = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _BookRecordCommentValid( string value, ref bool valid);

		public int? BCTransactionNo
		{
			get => _data.BCTransactionNo.GetValueOrDefault();
			set
			{
				if (_data.BCTransactionNo == value) return;
				bool valid = true;
				_BCTransactionNoValid(value, ref valid);

				if (valid)
				{
					_data.BCTransactionNo = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _BCTransactionNoValid( int? value, ref bool valid);

		public DateTime? BCDateUpdated
		{
			get => _data.BCDateUpdated.GetValueOrDefault();
			set
			{
				if (_data.BCDateUpdated == value) return;
				bool valid = true;
				_BCDateUpdatedValid(value, ref valid);

				if (valid)
				{
					_data.BCDateUpdated = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _BCDateUpdatedValid( DateTime? value, ref bool valid);

		public DateTime? BCDateCreated
		{
			get => _data.BCDateCreated.GetValueOrDefault();
			set
			{
				if (_data.BCDateCreated == value) return;
				bool valid = true;
				_BCDateCreatedValid(value, ref valid);

				if (valid)
				{
					_data.BCDateCreated = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _BCDateCreatedValid( DateTime? value, ref bool valid);

		public int? TransactionMainAccountCode
		{
			get => _data.TransactionMainAccountCode.GetValueOrDefault();
			set
			{
				if (_data.TransactionMainAccountCode == value) return;
				bool valid = true;
				_TransactionMainAccountCodeValid(value, ref valid);

				if (valid)
				{
					_data.TransactionMainAccountCode = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TransactionMainAccountCodeValid( int? value, ref bool valid);

		public string BCDocumentNo
		{
			get => _data.BCDocumentNo;
			set
			{
				if (_data.BCDocumentNo == value) return;
				bool valid = true;
				_BCDocumentNoValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("BCDocumentNo").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.BCDocumentNo = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _BCDocumentNoValid( string value, ref bool valid);

		public string BCDocumentType
		{
			get => _data.BCDocumentType;
			set
			{
				if (_data.BCDocumentType == value) return;
				bool valid = true;
				_BCDocumentTypeValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("BCDocumentType").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.BCDocumentType = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _BCDocumentTypeValid( string value, ref bool valid);

	}


	public partial interface IBookTransaction
	{
		string IdString { get; set; }
		Guid IdMigrate { get; set; }
		DateTime DateCreated { get; set; }
		DateTime DateUpdated { get; set; }
		Guid idBookingRecord { get; set; }
		BookRecord BookingRecordParent { get; set; }
		Guid idClient { get; set; }
		[ComVisible(false)]
		Guid? idPlan { get; set; }
		Plan PlanParent { get; set; }
		[ComVisible(false)]
		Guid? idPlanElement { get; set; }
		PlanElement PlanElementParent { get; set; }
		Guid idAccountReport { get; set; }
		Account AccountReportParent { get; set; }
		Guid idAccountBooking { get; set; }
		Account AccountBookingParent { get; set; }
		[ComVisible(false)]
		Guid? idCostCenter { get; set; }
		CostCenter CostCenterParent { get; set; }
		[ComVisible(false)]
		int? AccountCodeReport { get; set; }
		[ComVisible(false)]
		string CostCenterCode { get; set; }
		[ComVisible(false)]
		short? TypeBookRecord { get; set; }
		bool FlagAccountOpening { get; set; }
		[ComVisible(false)]
		DateTime? BookingDate { get; set; }
		int MonthIndex { get; set; }
		double AmountDebit { get; set; }
		double AmountCredit { get; set; }
		[ComVisible(false)]
		string ReviewComment { get; set; }
		short FlagForecast { get; set; }
		[ComVisible(false)]
		string ReferenceIDBookTransaction { get; set; }
		short FlagBaseline { get; set; }
		[ComVisible(false)]
		int? BCTransactionNo { get; set; }
		[ComVisible(false)]
		int? BCGeneralLedgerPageAPIEntryNo { get; set; }
		[ComVisible(false)]
		string ExternalDocumentNo { get; set; }
		[ComVisible(false)]
		string Description { get; set; }
	}


	public partial class BookTransaction : BusinessObject<tBookTransaction>, IBookTransaction
	{
		public BookTransaction() : base() {}
		public BookTransaction(Guid id) : base(id) {}
		public Guid idBookingRecord
		{
			get => _data.idBookingRecord;
			set
			{
				if (_data.idBookingRecord == value) return;
				bool valid = true;
				_idBookingRecordValid(value, ref valid);

				if (valid)
				{
					_data.idBookingRecord = value;
					_BookingRecord = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idBookingRecordValid( Guid value, ref bool valid);

		private BookRecord _BookingRecord;

		public BookRecord BookingRecordParent
		{
			get
			{
				if (_BookingRecord == null || _BookingRecord.data == null )
				{
						_BookingRecord = new BookRecord();
						_BookingRecord.Id =_data.idBookingRecord;
					return _BookingRecord;
				}
				else return _BookingRecord;
			}
			set { 
				_BookingRecord = value;
				idBookingRecord = _BookingRecord.Id;
			}
		}

		public Guid idClient
		{
			get => _data.idClient;
			set
			{
				if (_data.idClient == value) return;
				bool valid = true;
				_idClientValid(value, ref valid);

				if (valid)
				{
					_data.idClient = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idClientValid( Guid value, ref bool valid);

		public Guid? idPlan
		{
			get => _data.idPlan.GetValueOrDefault();
			set
			{
				if (_data.idPlan == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idPlanValid(value, ref valid);

				if (valid)
				{
					_data.idPlan = value;
					_Plan = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idPlanValid( Guid? value, ref bool valid);

		private Plan _Plan;

		public Plan PlanParent
		{
			get
			{
				if (_Plan == null || _Plan.data == null )
				{
					if (_data.idPlan == null) return null;
					else
					{
						_Plan = new Plan();
						_Plan.Id =_data.idPlan.GetValueOrDefault();
						return _Plan;
					}
				}
				else return _Plan;
			}
			set { 
				_Plan = value;
				idPlan = _Plan.Id;
			}
		}

		public Guid? idPlanElement
		{
			get => _data.idPlanElement.GetValueOrDefault();
			set
			{
				if (_data.idPlanElement == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idPlanElementValid(value, ref valid);

				if (valid)
				{
					_data.idPlanElement = value;
					_PlanElement = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idPlanElementValid( Guid? value, ref bool valid);

		private PlanElement _PlanElement;

		public PlanElement PlanElementParent
		{
			get
			{
				if (_PlanElement == null || _PlanElement.data == null )
				{
					if (_data.idPlanElement == null) return null;
					else
					{
						_PlanElement = new PlanElement();
						_PlanElement.Id =_data.idPlanElement.GetValueOrDefault();
						return _PlanElement;
					}
				}
				else return _PlanElement;
			}
			set { 
				_PlanElement = value;
				idPlanElement = _PlanElement.Id;
			}
		}

		public Guid idAccountReport
		{
			get => _data.idAccountReport;
			set
			{
				if (_data.idAccountReport == value) return;
				bool valid = true;
				_idAccountReportValid(value, ref valid);

				if (valid)
				{
					_data.idAccountReport = value;
					_AccountReport = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idAccountReportValid( Guid value, ref bool valid);

		private Account _AccountReport;

		public Account AccountReportParent
		{
			get
			{
				if (_AccountReport == null || _AccountReport.data == null )
				{
						_AccountReport = new Account();
						_AccountReport.Id =_data.idAccountReport;
					return _AccountReport;
				}
				else return _AccountReport;
			}
			set { 
				_AccountReport = value;
				idAccountReport = _AccountReport.Id;
			}
		}

		public Guid idAccountBooking
		{
			get => _data.idAccountBooking;
			set
			{
				if (_data.idAccountBooking == value) return;
				bool valid = true;
				_idAccountBookingValid(value, ref valid);

				if (valid)
				{
					_data.idAccountBooking = value;
					_AccountBooking = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idAccountBookingValid( Guid value, ref bool valid);

		private Account _AccountBooking;

		public Account AccountBookingParent
		{
			get
			{
				if (_AccountBooking == null || _AccountBooking.data == null )
				{
						_AccountBooking = new Account();
						_AccountBooking.Id =_data.idAccountBooking;
					return _AccountBooking;
				}
				else return _AccountBooking;
			}
			set { 
				_AccountBooking = value;
				idAccountBooking = _AccountBooking.Id;
			}
		}

		public Guid? idCostCenter
		{
			get => _data.idCostCenter.GetValueOrDefault();
			set
			{
				if (_data.idCostCenter == value) return;
				if (value == Guid.Empty) value = null;

				bool valid = true;
				_idCostCenterValid(value, ref valid);

				if (valid)
				{
					_data.idCostCenter = value;
					_CostCenter = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idCostCenterValid( Guid? value, ref bool valid);

		private CostCenter _CostCenter;

		public CostCenter CostCenterParent
		{
			get
			{
				if (_CostCenter == null || _CostCenter.data == null )
				{
					if (_data.idCostCenter == null) return null;
					else
					{
						_CostCenter = new CostCenter();
						_CostCenter.Id =_data.idCostCenter.GetValueOrDefault();
						return _CostCenter;
					}
				}
				else return _CostCenter;
			}
			set { 
				_CostCenter = value;
				idCostCenter = _CostCenter.Id;
			}
		}

		public int? AccountCodeReport
		{
			get => _data.AccountCodeReport.GetValueOrDefault();
			set
			{
				if (_data.AccountCodeReport == value) return;
				bool valid = true;
				_AccountCodeReportValid(value, ref valid);

				if (valid)
				{
					_data.AccountCodeReport = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _AccountCodeReportValid( int? value, ref bool valid);

		public string CostCenterCode
		{
			get => _data.CostCenterCode;
			set
			{
				if (_data.CostCenterCode == value) return;
				bool valid = true;
				_CostCenterCodeValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("CostCenterCode").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.CostCenterCode = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _CostCenterCodeValid( string value, ref bool valid);

		public short? TypeBookRecord
		{
			get => _data.TypeBookRecord.GetValueOrDefault();
			set
			{
				if (_data.TypeBookRecord == value) return;
				bool valid = true;
				_TypeBookRecordValid(value, ref valid);

				if (valid)
				{
					_data.TypeBookRecord = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _TypeBookRecordValid( short? value, ref bool valid);

		public bool FlagAccountOpening
		{
			get => _data.FlagAccountOpening;
			set
			{
				if (_data.FlagAccountOpening == value) return;
				bool valid = true;
				_FlagAccountOpeningValid(value, ref valid);

				if (valid)
				{
					_data.FlagAccountOpening = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _FlagAccountOpeningValid( bool value, ref bool valid);

		public DateTime? BookingDate
		{
			get => _data.BookingDate.GetValueOrDefault();
			set
			{
				if (_data.BookingDate == value) return;
				bool valid = true;
				_BookingDateValid(value, ref valid);

				if (valid)
				{
					_data.BookingDate = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _BookingDateValid( DateTime? value, ref bool valid);

		public int MonthIndex
		{
			get => _data.MonthIndex;
			set
			{
				if (_data.MonthIndex == value) return;
				bool valid = true;
				_MonthIndexValid(value, ref valid);

				if (valid)
				{
					_data.MonthIndex = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _MonthIndexValid( int value, ref bool valid);

		public double AmountDebit
		{
			get => _data.AmountDebit;
			set
			{
				if (_data.AmountDebit == value) return;
				bool valid = true;
				_AmountDebitValid(value, ref valid);

				if (valid)
				{
					_data.AmountDebit = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _AmountDebitValid( double value, ref bool valid);

		public double AmountCredit
		{
			get => _data.AmountCredit;
			set
			{
				if (_data.AmountCredit == value) return;
				bool valid = true;
				_AmountCreditValid(value, ref valid);

				if (valid)
				{
					_data.AmountCredit = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _AmountCreditValid( double value, ref bool valid);

		public string ReviewComment
		{
			get => _data.ReviewComment;
			set
			{
				if (_data.ReviewComment == value) return;
				bool valid = true;
				_ReviewCommentValid(value, ref valid);

				if (valid)
				{
					_data.ReviewComment = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _ReviewCommentValid( string value, ref bool valid);

		public short FlagForecast
		{
			get => _data.FlagForecast;
			set
			{
				if (_data.FlagForecast == value) return;
				bool valid = true;
				_FlagForecastValid(value, ref valid);

				if (valid)
				{
					_data.FlagForecast = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _FlagForecastValid( short value, ref bool valid);

		public string ReferenceIDBookTransaction
		{
			get => _data.ReferenceIDBookTransaction;
			set
			{
				if (_data.ReferenceIDBookTransaction == value) return;
				bool valid = true;
				_ReferenceIDBookTransactionValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("ReferenceIDBookTransaction").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.ReferenceIDBookTransaction = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _ReferenceIDBookTransactionValid( string value, ref bool valid);

		public short FlagBaseline
		{
			get => _data.FlagBaseline;
			set
			{
				if (_data.FlagBaseline == value) return;
				bool valid = true;
				_FlagBaselineValid(value, ref valid);

				if (valid)
				{
					_data.FlagBaseline = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _FlagBaselineValid( short value, ref bool valid);

		public int? BCTransactionNo
		{
			get => _data.BCTransactionNo.GetValueOrDefault();
			set
			{
				if (_data.BCTransactionNo == value) return;
				bool valid = true;
				_BCTransactionNoValid(value, ref valid);

				if (valid)
				{
					_data.BCTransactionNo = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _BCTransactionNoValid( int? value, ref bool valid);

		public int? BCGeneralLedgerPageAPIEntryNo
		{
			get => _data.BCGeneralLedgerPageAPIEntryNo.GetValueOrDefault();
			set
			{
				if (_data.BCGeneralLedgerPageAPIEntryNo == value) return;
				bool valid = true;
				_BCGeneralLedgerPageAPIEntryNoValid(value, ref valid);

				if (valid)
				{
					_data.BCGeneralLedgerPageAPIEntryNo = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _BCGeneralLedgerPageAPIEntryNoValid( int? value, ref bool valid);

		public string ExternalDocumentNo
		{
			get => _data.ExternalDocumentNo;
			set
			{
				if (_data.ExternalDocumentNo == value) return;
				bool valid = true;
				_ExternalDocumentNoValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("ExternalDocumentNo").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.ExternalDocumentNo = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _ExternalDocumentNoValid( string value, ref bool valid);

		public string Description
		{
			get => _data.Description;
			set
			{
				if (_data.Description == value) return;
				bool valid = true;
				_DescriptionValid(value, ref valid);

				if (valid)
				{
					if (value != null) {						var attr = (StringLengthAttribute)_data.GetType().GetProperty("Description").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.Description = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _DescriptionValid( string value, ref bool valid);

	}

    public partial interface IApproval
    {
         Guid idClient { get; set; }
        string IdString { get; set; }
        DateTime DateCreated { get; set; }
        DateTime DateUpdated { get; set; }
    
        string ApproverOneEmail { get; set; }

         string ApproverOneStatus { get; set; }

         string ApproverOneNote { get; set; }

    
         string ApproverOneTime { get; set; }

    
         string ApproverTwoEmail { get; set; }

       
         string ApproverTwoStatus { get; set; }

         string ApproverTwoNote { get; set; }

       
         string ApproverTwoTime { get; set; }

        
         string ApproverThreeEmail { get; set; }

        
         string ApproverThreeStatus { get; set; }

         string ApproverThreeNote { get; set; }

       
         string ApproverThreeTime { get; set; }

         string ApproverItemLink { get; set; }

        
         string DocumentNumber { get; set; }

         double? ApprovalAmount { get; set; }

       
         string ApprovalDate { get; set; }

       
         string ApprovalFinal { get; set; }

        
         string ApproverOneRequestDate { get; set; }

        
         string ApproverTwoRequestDate { get; set; }

        
         string ApproverThreeRequestDate { get; set; }

       
         string ApprovalSourceSystem { get; set; }

        
         string ApprovalObject { get; set; }

         Guid? idSellerPurchaser { get; set; }

         Guid? idBudgetResponsible { get; set; }

         Guid? idExecutiveApprover { get; set; }


        string CostCenterCode { get; set; }
         string RefCode { get; set; }

    }
    public partial class Approval : BusinessObject<tApproval>, IApproval
    {
        public Approval() : base() { }
        public Approval(Guid id) : base(id) { }

        public Guid? idSellerPurchaser
        {
            get => _data.idSellerPurchaser.GetValueOrDefault();
            set
            {
                if (_data.idSellerPurchaser == value) return;
                if (value == Guid.Empty) value = null;

                bool valid = true;
                _idSellerPurchaserValid(value, ref valid);

                if (valid)
                {
                    _data.idSellerPurchaser = value;
                    idSellerPurchaser = null;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }
		public Guid idClient
		{
			get => _data.idClient;
			set
			{
				if (_data.idClient == value) return;
				bool valid = true;
				_idClientValid(value, ref valid);

				if (valid)
				{
					_data.idClient = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idClientValid(Guid value, ref bool valid);

		partial void _idSellerPurchaserValid(Guid? value, ref bool valid);
        public Guid? idBudgetResponsible
        {
            get => _data.idBudgetResponsible.GetValueOrDefault();
            set
            {
                if (_data.idBudgetResponsible == value) return;
                if (value == Guid.Empty) value = null;

                bool valid = true;
                _idBudgetResponsibleValid(value, ref valid);

                if (valid)
                {
                    _data.idBudgetResponsible = value;
                    idBudgetResponsible = null;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }

        partial void _idBudgetResponsibleValid(Guid? value, ref bool valid);
        public Guid? idExecutiveApprover
        {
            get => _data.idExecutiveApprover.GetValueOrDefault();
            set
            {
                if (_data.idExecutiveApprover == value) return;
                if (value == Guid.Empty) value = null;

                bool valid = true;
                _idExecutiveApproverValid(value, ref valid);

                if (valid)
                {
                    _data.idBudgetResponsible = value;
                    idExecutiveApprover = null;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }

        partial void _idExecutiveApproverValid(Guid? value, ref bool valid);
        public string CostCenterCode
        {
            get => _data.CostCenterCode;
            set
            {
                if (_data.CostCenterCode == value) return;
                bool valid = true;
                _CostCenterValid(value, ref valid);

                if (valid)
                {
                    if (value != null)
                    {
                        var attr = (StringLengthAttribute)_data.GetType().GetProperty("CostCenterCode").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
                        if (value.Length > attr.MaximumLength)
                            value = value.Substring(0, attr.MaximumLength);
                    }
                    _data.CostCenterCode = value;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }

        partial void _CostCenterValid(string value, ref bool valid);

        public string RefCode
        {
            get => _data.RefCode;
            set
            {
                if (_data.RefCode == value) return;
                bool valid = true;
                _RefCodeValid(value, ref valid);

                if (valid)
                {
                    if (value != null)
                    {
                        var attr = (StringLengthAttribute)_data.GetType().GetProperty("RefCode").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
                        if (value.Length > attr.MaximumLength)
                            value = value.Substring(0, attr.MaximumLength);
                    }
                    _data.RefCode = value;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }
        partial void _RefCodeValid(string value, ref bool valid);

        public string ApprovalObject
        {
            get => _data.ApprovalObject;
            set
            {
                if (_data.ApprovalObject == value) return;
                bool valid = true;
                _ApprovalObjectValid(value, ref valid);

                if (valid)
                {
                    if (value != null)
                    {
                        var attr = (StringLengthAttribute)_data.GetType().GetProperty("ApprovalObject").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
                        if (value.Length > attr.MaximumLength)
                            value = value.Substring(0, attr.MaximumLength);
                    }
                    _data.ApprovalObject = value;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }
        partial void _ApprovalObjectValid(string value, ref bool valid);

        public string ApprovalSourceSystem
        {
            get => _data.ApprovalSourceSystem;
            set
            {
                if (_data.ApprovalSourceSystem == value) return;
                bool valid = true;
                _ApprovalSourceSystemValid(value, ref valid);

                if (valid)
                {
                    if (value != null)
                    {
                        var attr = (StringLengthAttribute)_data.GetType().GetProperty("ApprovalSourceSystem").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
                        if (value.Length > attr.MaximumLength)
                            value = value.Substring(0, attr.MaximumLength);
                    }
                    _data.ApprovalSourceSystem = value;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }
        partial void _ApprovalSourceSystemValid(string value, ref bool valid);
        public string ApproverTwoRequestDate
        {
            get => _data.ApproverThreeRequestDate;
            set
            {
                if (_data.ApproverThreeRequestDate == value) return;
                bool valid = true;
                _ApproverTwoRequestDateValid(value, ref valid);

                if (valid)
                {
                    if (value != null)
                    {
                        var attr = (StringLengthAttribute)_data.GetType().GetProperty("ApproverTwoRequestDate").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
                        if (value.Length > attr.MaximumLength)
                            value = value.Substring(0, attr.MaximumLength);
                    }
                    _data.ApproverTwoRequestDate = value;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }
        partial void _ApproverTwoRequestDateValid(string value, ref bool valid);
        public string ApproverThreeRequestDate
        {
            get => _data.ApproverThreeRequestDate;
            set
            {
                if (_data.ApproverThreeRequestDate == value) return;
                bool valid = true;
                _ApproverThreeRequestDateValid(value, ref valid);

                if (valid)
                {
                    if (value != null)
                    {
                        var attr = (StringLengthAttribute)_data.GetType().GetProperty("ApproverThreeRequestDate").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
                        if (value.Length > attr.MaximumLength)
                            value = value.Substring(0, attr.MaximumLength);
                    }
                    _data.ApprovalSourceSystem = value;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }
        partial void _ApproverThreeRequestDateValid(string value, ref bool valid);
        public string ApproverOneRequestDate
        {
            get => _data.ApproverOneRequestDate;
            set
            {
                if (_data.ApproverOneRequestDate == value) return;
                bool valid = true;
                _ApproverOneRequestDateValid(value, ref valid);

                if (valid)
                {
                    if (value != null)
                    {
                        var attr = (StringLengthAttribute)_data.GetType().GetProperty("ApproverOneRequestDate").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
                        if (value.Length > attr.MaximumLength)
                            value = value.Substring(0, attr.MaximumLength);
                    }
                    _data.ApproverOneRequestDate = value;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }
        partial void _ApproverOneRequestDateValid(string value, ref bool valid);
        public string ApprovalFinal
        {
            get => _data.ApprovalFinal;
            set
            {
                if (_data.ApprovalFinal == value) return;
                bool valid = true;
                _ApprovalFinalValid(value, ref valid);

                if (valid)
                {
                    if (value != null)
                    {
                        var attr = (StringLengthAttribute)_data.GetType().GetProperty("ApprovalFinal").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
                        if (value.Length > attr.MaximumLength)
                            value = value.Substring(0, attr.MaximumLength);
                    }
                    _data.ApprovalFinal = value;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }
        partial void _ApprovalFinalValid(string value, ref bool valid);
        public string ApprovalDate
        {
            get => _data.ApprovalDate;
            set
            {
                if (_data.ApprovalDate == value) return;
                bool valid = true;
                _ApprovalDatelValid(value, ref valid);

                if (valid)
                {
                    if (value != null)
                    {
                        var attr = (StringLengthAttribute)_data.GetType().GetProperty("ApprovalDate").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
                        if (value.Length > attr.MaximumLength)
                            value = value.Substring(0, attr.MaximumLength);
                    }
                    _data.ApprovalDate = value;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }
        partial void _ApprovalDatelValid(string value, ref bool valid);
        public string DocumentNumber
        {
            get => _data.DocumentNumber;
            set
            {
                if (_data.DocumentNumber == value) return;
                bool valid = true;
                _DocumentNumberValid(value, ref valid);

                if (valid)
                {
                    if (value != null)
                    {
                        var attr = (StringLengthAttribute)_data.GetType().GetProperty("DocumentNumber").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
                        if (value.Length > attr.MaximumLength)
                            value = value.Substring(0, attr.MaximumLength);
                    }
                    _data.DocumentNumber = value;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }
        partial void _DocumentNumberValid(string value, ref bool valid);
        public string ApproverItemLink
        {
            get => _data.ApproverItemLink;
            set
            {
                if (_data.ApproverItemLink == value) return;
                bool valid = true;
                _ApproverItemLinkValid(value, ref valid);

                if (valid)
                {
                    if (value != null)
                    {
                        var attr = (StringLengthAttribute)_data.GetType().GetProperty("ApproverItemLink").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
                        if (value.Length > attr.MaximumLength)
                            value = value.Substring(0, attr.MaximumLength);
                    }
                    _data.ApproverItemLink = value;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }
        partial void _ApproverItemLinkValid(string value, ref bool valid);
        public string ApproverThreeTime
        {
            get => _data.ApproverThreeTime;
            set
            {
                if (_data.ApproverThreeTime == value) return;
                bool valid = true;
                _ApproverThreeTimeValid(value, ref valid);

                if (valid)
                {
                    if (value != null)
                    {
                        var attr = (StringLengthAttribute)_data.GetType().GetProperty("ApproverThreeTime").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
                        if (value.Length > attr.MaximumLength)
                            value = value.Substring(0, attr.MaximumLength);
                    }
                    _data.ApproverThreeTime = value;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }
        partial void _ApproverThreeTimeValid(string value, ref bool valid);
        public string ApproverThreeNote
        {
            get => _data.ApproverThreeNote;
            set
            {
                if (_data.ApproverThreeNote == value) return;
                bool valid = true;
                _ApproverThreeNoteValid(value, ref valid);

                if (valid)
                {
                    if (value != null)
                    {
                        var attr = (StringLengthAttribute)_data.GetType().GetProperty("ApproverThreeNote").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
                        if (value.Length > attr.MaximumLength)
                            value = value.Substring(0, attr.MaximumLength);
                    }
                    _data.ApproverThreeNote = value;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }
        partial void _ApproverThreeNoteValid(string value, ref bool valid);
        public string ApproverThreeStatus
        {
            get => _data.ApproverThreeStatus;
            set
            {
                if (_data.ApproverThreeStatus == value) return;
                bool valid = true;
                _ApproverThreeStatusValid(value, ref valid);

                if (valid)
                {
                    if (value != null)
                    {
                        var attr = (StringLengthAttribute)_data.GetType().GetProperty("ApproverThreeStatus").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
                        if (value.Length > attr.MaximumLength)
                            value = value.Substring(0, attr.MaximumLength);
                    }
                    _data.ApproverThreeStatus = value;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }
        partial void _ApproverThreeStatusValid(string value, ref bool valid);
        public string ApproverThreeEmail
        {
            get => _data.ApproverThreeEmail;
            set
            {
                if (_data.ApproverThreeEmail == value) return;
                bool valid = true;
                _ApproverThreeEmailValid(value, ref valid);

                if (valid)
                {
                    if (value != null)
                    {
                        var attr = (StringLengthAttribute)_data.GetType().GetProperty("ApproverThreeEmail").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
                        if (value.Length > attr.MaximumLength)
                            value = value.Substring(0, attr.MaximumLength);
                    }
                    _data.ApproverThreeEmail = value;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }
        partial void _ApproverThreeEmailValid(string value, ref bool valid);
        public string ApproverTwoTime
        {
            get => _data.ApproverTwoTime;
            set
            {
                if (_data.ApproverTwoTime == value) return;
                bool valid = true;
                _ApproverTwoTimeValid(value, ref valid);

                if (valid)
                {
                    if (value != null)
                    {
                        var attr = (StringLengthAttribute)_data.GetType().GetProperty("ApproverTwoTime").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
                        if (value.Length > attr.MaximumLength)
                            value = value.Substring(0, attr.MaximumLength);
                    }
                    _data.ApproverTwoTime = value;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }
        partial void _ApproverTwoTimeValid(string value, ref bool valid);
        public string ApproverTwoNote
        {
            get => _data.ApproverTwoNote;
            set
            {
                if (_data.ApproverTwoNote == value) return;
                bool valid = true;
                _ApproverTwoNoteValid(value, ref valid);

                if (valid)
                {
                    if (value != null)
                    {
                        var attr = (StringLengthAttribute)_data.GetType().GetProperty("ApproverTwoNote").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
                        if (value.Length > attr.MaximumLength)
                            value = value.Substring(0, attr.MaximumLength);
                    }
                    _data.ApproverTwoNote = value;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }
        partial void _ApproverTwoNoteValid(string value, ref bool valid);
        public string ApproverTwoStatus
        {
            get => _data.ApproverTwoStatus;
            set
            {
                if (_data.ApproverTwoStatus == value) return;
                bool valid = true;
                _ApproverTwoStatusValid(value, ref valid);

                if (valid)
                {
                    if (value != null)
                    {
                        var attr = (StringLengthAttribute)_data.GetType().GetProperty("ApproverTwoStatus").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
                        if (value.Length > attr.MaximumLength)
                            value = value.Substring(0, attr.MaximumLength);
                    }
                    _data.ApproverTwoStatus = value;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }
        partial void _ApproverTwoStatusValid(string value, ref bool valid);
        public string ApproverTwoEmail
        {
            get => _data.ApproverTwoEmail;
            set
            {
                if (_data.ApproverTwoEmail == value) return;
                bool valid = true;
                _ApproverTwoEmailValid(value, ref valid);

                if (valid)
                {
                    if (value != null)
                    {
                        var attr = (StringLengthAttribute)_data.GetType().GetProperty("ApproverTwoEmail").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
                        if (value.Length > attr.MaximumLength)
                            value = value.Substring(0, attr.MaximumLength);
                    }
                    _data.ApproverTwoEmail = value;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }
        partial void _ApproverTwoEmailValid(string value, ref bool valid);
        public string ApproverOneTime
        {
            get => _data.ApproverOneTime;
            set
            {
                if (_data.ApproverOneTime == value) return;
                bool valid = true;
                _ApproverOneTimeValid(value, ref valid);

                if (valid)
                {
                    if (value != null)
                    {
                        var attr = (StringLengthAttribute)_data.GetType().GetProperty("ApproverOneTime").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
                        if (value.Length > attr.MaximumLength)
                            value = value.Substring(0, attr.MaximumLength);
                    }
                    _data.ApproverOneTime = value;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }
        partial void _ApproverOneTimeValid(string value, ref bool valid);
        public string ApproverOneNote
        {
            get => _data.ApproverOneNote;
            set
            {
                if (_data.ApproverOneNote == value) return;
                bool valid = true;
                _ApproverOneNoteValid(value, ref valid);

                if (valid)
                {
                    if (value != null)
                    {
                        var attr = (StringLengthAttribute)_data.GetType().GetProperty("ApproverOneNote").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
                        if (value.Length > attr.MaximumLength)
                            value = value.Substring(0, attr.MaximumLength);
                    }
                    _data.ApproverOneNote = value;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }
        partial void _ApproverOneNoteValid(string value, ref bool valid);
        public string ApproverOneStatus
        {
            get => _data.ApproverOneStatus;
            set
            {
                if (_data.ApproverOneStatus == value) return;
                bool valid = true;
                _ApproverOneStatusValid(value, ref valid);

                if (valid)
                {
                    if (value != null)
                    {
                        var attr = (StringLengthAttribute)_data.GetType().GetProperty("ApproverOneStatus").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
                        if (value.Length > attr.MaximumLength)
                            value = value.Substring(0, attr.MaximumLength);
                    }
                    _data.ApproverOneStatus = value;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }
        partial void _ApproverOneStatusValid(string value, ref bool valid);
        public string ApproverOneEmail
        {
            get => _data.ApproverOneEmail;
            set
            {
                if (_data.ApproverOneEmail == value) return;
                bool valid = true;
                _ApproverOneEmailValid(value, ref valid);

                if (valid)
                {
                    if (value != null)
                    {
                        var attr = (StringLengthAttribute)_data.GetType().GetProperty("ApproverOneEmail").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
                        if (value.Length > attr.MaximumLength)
                            value = value.Substring(0, attr.MaximumLength);
                    }
                    _data.ApproverOneEmail = value;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }
        partial void _ApproverOneEmailValid(string value, ref bool valid);

        public double? ApprovalAmount
        {
            get => _data.ApprovalAmount.GetValueOrDefault();
            set
            {
                if (_data.ApprovalAmount == value) return;
                bool valid = true;
                _ApprovalAmountValid(value, ref valid);

                if (valid)
                {
                    _data.ApprovalAmount = value;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }

        partial void _ApprovalAmountValid( double? value, ref bool valid);

    }

    public partial interface IAuthority
    {
        string IdString { get; set; }
        Guid IdMigrate { get; set; }
        Guid idUser { get; set; }
        DateTime DateCreated { get; set; }
        DateTime DateUpdated { get; set; }
        Guid idClient { get; set; }
        Client ClientParent { get; set; }
        string CostCenter { get; set; }
        int? ApprovalLimit { get; set; }
        string RefCode { get; set; }
        short? UserRole { get; set; }
        //string UserName { get; set; }

    }
	public partial class Authority : BusinessObject<tAuthority>, IAuthority
	{
		public Authority() : base() { }
		public Authority(Guid id) : base(id) { }
		public Guid idClient
		{
			get => _data.idClient;
			set
			{
				if (_data.idClient == value) return;
				bool valid = true;
				_idClientValid(value, ref valid);

				if (valid)
				{
					_data.idClient = value;
					_Client = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idClientValid(Guid value, ref bool valid);
		public Guid idUser
        {
			get => _data.idUser;
			set
			{
				if (_data.idUser == value) return;
				bool valid = true;
                _idUserValid(value, ref valid);

				if (valid)
				{
					_data.idUser = value;
                    _Client = null;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _idUserValid(Guid value, ref bool valid);

		private Client _Client;

		public Client ClientParent
		{
			get
			{
				if (_Client == null || _Client.data == null)
				{
					_Client = new Client();
					_Client.Id = _data.idClient;
					return _Client;
				}
				else return _Client;
			}
			set
			{
				_Client = value;
				idClient = _Client.Id;
			}
		}

		public string CostCenter
		{
			get => _data.CostCenter;
			set
			{
				if (_data.CostCenter == value) return;
				bool valid = true;
				_CostCenterValid(value, ref valid);

				if (valid)
				{
					if (value != null)
					{
						var attr = (StringLengthAttribute)_data.GetType().GetProperty("CostCenter").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
						if (value.Length > attr.MaximumLength)
							value = value.Substring(0, attr.MaximumLength);
					}
					_data.CostCenter = value;
					_changed = true;
					NotifyPropertyChanged();
				}
				else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
			}
		}

		partial void _CostCenterValid(string value, ref bool valid);

		//public string UserName
		//{
		//	get => _data.UserName;
		//	set
		//	{
		//		if (_data.UserName == value) return;
		//		bool valid = true;
		//		_UserNameValid(value, ref valid);

		//		if (valid)
		//		{
		//			if (value != null)
		//			{
		//				var attr = (StringLengthAttribute)_data.GetType().GetProperty("UserName").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
		//				if (value.Length > attr.MaximumLength)
		//					value = value.Substring(0, attr.MaximumLength);
		//			}
		//			_data.UserName = value;
		//			_changed = true;
		//			NotifyPropertyChanged();
		//		}
		//		else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
		//	}
		//}

		//partial void _UserNameValid(string value, ref bool valid);

		public string RefCode
        {
            get => _data.RefCode;
            set
            {
                if (_data.CostCenter == value) return;
                bool valid = true;
                _RefCodeValid(value, ref valid);

                if (valid)
                {
                    if (value != null)
                    {
                        var attr = (StringLengthAttribute)_data.GetType().GetProperty("RefCode").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
                        if (value.Length > attr.MaximumLength)
                            value = value.Substring(0, attr.MaximumLength);
                    }
                    _data.RefCode = value;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }

        partial void _RefCodeValid(string value, ref bool valid);

        public int? ApprovalLimit
        {
            get => _data.ApprovalLimit.GetValueOrDefault();
            set
            {
                if (_data.ApprovalLimit == value) return;
                bool valid = true;
                _ApprovalLimitValid(value, ref valid);

                if (valid)
                {
                    _data.ApprovalLimit = value;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }

        partial void _ApprovalLimitValid(int? value, ref bool valid);

        public short? UserRole
        {
            get => _data.UserRole.GetValueOrDefault();
            set
            {
                if (_data.UserRole == value) return;
                bool valid = true;
                _UserRoleValid(value, ref valid);

                if (valid)
                {
                    _data.ApprovalLimit = value;
                    _changed = true;
                    NotifyPropertyChanged();
                }
                else throw new Exception(Properties.Errors.BusinessObjectAssignedInvalidValue);
            }
        }

        partial void _UserRoleValid(int? value, ref bool valid);



    }



}
