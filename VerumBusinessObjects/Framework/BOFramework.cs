using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Runtime.CompilerServices;


namespace VerumBusinessObjects.Framework
{
    [ComVisible(false)]
    public interface IBusinessObject<T>
    {
		Guid Id { get; set; }
		T data { get; set; }
		Boolean Bound { get; }
        Boolean Changed { get; }
        BOResult CommitChanges( bool force);
    }

	public interface IDataObject
	{
		Guid Id { get; set; }
		DateTime DateCreated { get; set; }
		DateTime? DateUpdated { get; set; }

		Guid? IdMigrate { get; set; }
	}

	public class BusinessObject<T> : INotifyPropertyChanged, IBusinessObject<T> where T : class, IDataObject 
	{
		internal VerumDBContext _db = VerumInstance.Context;

		internal T _data;

		public T data
		{
			get => _data;
			set
			{
				_data = value;
				_id = data.Id;
				_bound = true;
				_changed = false;
				_CustomInit();
			}
		}

		internal Boolean _bound;
		public Boolean Bound { get => _bound; }

		internal Boolean _changed;
		public Boolean Changed { get => _changed; }

		public BusinessObject()
		{
		}

		public BusinessObject(Guid id)
		{
			_id = id;
			Load();
		}

		public BusinessObject(T t)
		{
			_data = t;

			if (t.Id != null)
			{
				_id = t.Id;
				_bound = true;
				_changed = false;
			}

			_CustomInit();
		}
		

		private void Load()
		{
			IQueryable<T> dbQuery = _db.Set<T>();

			if (_id == null) _bound = false;
			else
			{
				T o = dbQuery.Where<T>(b => b.Id == _id).FirstOrDefault();

				if (o == null)
				{
					New(_id);
				}
				else
				{
					_data = o;
					_bound = true;
					_CustomInit();
				}
			}
			_changed = false;
		}

		/// <summary>
		/// Auto-generated method <c>_CustomInit</c>: Enables additional business object initialization activities when
		/// a business object is bound to new data. For optional implementation in custom business object code
		/// </summary>
		public virtual void _CustomInit()
		{

		}

		/// <summary>
		/// Auto-generated method <c>_CustomCommit</c>: Enables additional business object commit activities when
		/// a business object is committed. For optional implementation in custom business object code
		/// </summary>
		public virtual BOResult _CustomCommitBefore()
		{
			return BOResult.Success;
		}

		/// <summary>
		/// Auto-generated method <c>_CustomCommit</c>: Enables additional business object commit activities when
		/// a business object is committed. For optional implementation in custom business object code
		/// </summary>
		public virtual void _CustomCommitAfter()
		{

		}

		/// <summary>
		/// Auto-generated method <c>Clone</c>: Copies source data record with new Id
		/// </summary>
		public BusinessObject<T> Clone(BusinessObject<T> source)
		{
			var context = VerumInstance.Context;
			_data = (T)context.Entry(source.data).CurrentValues.ToObject();
			_id = Guid.NewGuid();
			_data.Id = _id;
			_data.IdMigrate = source.Id;
			_data.DateCreated = DateTime.UtcNow;
			_bound = false;
			_changed = true;
			_CustomInit();

			return this;
		}

		/// <summary>
		/// Auto-generated method <c>New</c>: Creates new table record and assigns to business object
		/// </summary>
		public BusinessObject<T> New(Guid guid) 
		{
			_data = (T) Activator.CreateInstance(typeof(T), true);
			_id = guid;
			_data.Id = _id;
			_data.DateCreated = DateTime.UtcNow;
			_bound = false;
			_changed = true;
			_CustomInit();

			return this;
		}

		public BusinessObject<T> New()
		{
			return New(Guid.NewGuid());
		}

		public BOResult CommitChanges(bool force = false)
		{
			if (_changed)
			{
				var result = _CustomCommitBefore();
				if (result != BOResult.Success) return result;

				VerumInstance.TransactionStart();
				if (!_bound)
					_db.Entry(_data).State = System.Data.Entity.EntityState.Added;
				
				VerumInstance.SaveChanges(force);
				_id = _data.Id;
				_CustomCommitAfter();
				VerumInstance.TransactionEnd();

				if (_id != null) _bound = true;
				_changed = false;
				_CustomInit();
			}

			return BOResult.Success;
		}

		public BOResult RollbackChanges(bool force = false)
		{
			_changed = true;
			_db.Entry(_data).Reload();
			return BOResult.Success;
		}

		private Guid _id;
		public Guid Id
		{
			get => _id;


			set
			{
				_id = value;
				Load();
				NotifyPropertyChanged();
			}
		}

		public string IdString
		{
			get => _id.ToString();


			set
			{
				_id = Guid.Parse(value);
				Load();
				NotifyPropertyChanged();
			}
		}
		public Guid IdMigrate
		{
			get => _data.IdMigrate.GetValueOrDefault();
			set
			{
				_data.IdMigrate = value;
				_changed = true;
				NotifyPropertyChanged();
			}
		}

		public DateTime DateCreated
		{
			get => _data.DateCreated;
			set
			{
				_data.DateCreated = value;
				_changed = true;
				NotifyPropertyChanged();
			}
		}

		public DateTime DateUpdated
		{
			get => _data.DateUpdated.GetValueOrDefault();
			set
			{
				_data.DateUpdated = value;
				_changed = true;
				NotifyPropertyChanged();
			}
		}

		public event PropertyChangedEventHandler PropertyChanged;

		// This method is called by the Set accessor of each property.
		// The CallerMemberName attribute that is applied to the optional propertyName
		// parameter causes the property name of the caller to be substituted as an argument.
		internal void NotifyPropertyChanged([CallerMemberName] String propertyName = "")
		{
			if (PropertyChanged != null)
			{
				PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
			}
		}
    }

	[ComVisible(false)]
    public class BOCollection<BO, T> : IEnumerator<BO> where BO : IBusinessObject<T>, new()
    {
		ObservableCollection<BO> query = new ObservableCollection<BO>();
		int index = -1;

        public BOCollection(IQueryable<T> us)
        {
			if (us != null)
				foreach (T obj in us)
				{
					BO bO = new BO();
					bO.data = obj;              // ACTION: Change this to constructor call after changing BO to base/abstract class
					query.Add(bO);
				}
        }

        public int Count { get => query.Count(); }

        public object SyncRoot => this;

        public bool IsSynchronized => false;

        public object Current => query.ElementAt(index);

        BO IEnumerator<BO>.Current => query.ElementAt(index);

        public void Dispose()
        {
            query = null;
        }

        public IEnumerator<BO> GetEnumerator()
        {
            return query.GetEnumerator();
        }

		public ObservableCollection<BO> GetObservableCollection()
		{
			return query;
		}

		public bool MoveNext()
        {
            index++;
            return (index != query.Count());
        }

        public void Reset()
        {
            index = -1;
        }
    }

}
