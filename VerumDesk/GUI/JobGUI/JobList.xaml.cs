using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using VerumBusinessObjects;
using VerumBusinessObjects.Framework;

namespace VerumDesk.GUI.Job
{
    /// <summary>
    /// Interaktionslogik für JobList.xaml
    /// </summary>
    public partial class JobList : Window
    {
		private BOCollection<JobReport, tJobReport> BOColl;
		private ObservableCollection<JobReport> listItems;
		private BOCollection<User, tUser> users = User.GetUsers();

		public JobList()
        {
            InitializeComponent();
			ListUpdate();
			List<String> list = new List<String>();
			foreach (User user in users)
            {
				list.Add(user.UserName);
            }
			cbUser.ItemsSource = list;
        }

        private void btnOpen_Click(object sender, RoutedEventArgs e)
        {
			if (dgMain.SelectedItem != null)
			{
				var wnd = new JobItemList((JobReport)dgMain.SelectedItem);
				wnd.Show();
			}

		}

		private void btnClose_Click(object sender, RoutedEventArgs e)
        {
			this.Close();
        }

        private void btnDelete_Click(object sender, RoutedEventArgs e)
        {
			JobReport item;

			if (dgMain.SelectedItem != null)
			{
				item = (JobReport)dgMain.SelectedItem;

				switch (item.Delete())
				{
					case BOResult.GeneralError:
						System.Windows.MessageBox.Show("Unerwarteter Fehler beim Löschen des Jobs.", "Job löschen", MessageBoxButton.OK, MessageBoxImage.Error);
						break;

					case BOResult.Success:
						listItems.Remove(item);
						ListUpdate();
						break;
				}
			}
		}

		private void ListUpdate()
		{
			BOColl = JobReport.GetBOCollection();

			listItems = new ObservableCollection<JobReport>();//.Join(users,report => report.idUser, user => user.,);

			foreach (var BO in BOColl)
				listItems.Add(BO);

			//listItems = new ObservableCollection<JobReport>(from item in listItems where item.TypeJobSuccess == (int)cbStatus.SelectedValue select item);

			dgMain.ItemsSource = listItems;
			dgMain.Items.SortDescriptions.Clear();
		}
	}

	public class TypeJobConverter : IValueConverter
	{
		public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
		{
			switch ((TypeJobEnum)value)
			{
				case TypeJobEnum.JournalImport:
					return "Journal importieren";
				case TypeJobEnum.PlanImplement:
					return "Plan buchen";
				case TypeJobEnum.PlanImport:
					return "Plan importieren";
				case TypeJobEnum.BusinessCenterImport:
					return "Business Center importieren";
            }

			return "";
		}

		public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
		{
			if (value is string)
			{
				switch ((string)value)
				{
					case "Journal importieren":
						return TypeJobEnum.JournalImport;
					case "Plan buchen":
						return TypeJobEnum.PlanImplement;
					case "Plan importieren":
						return TypeJobEnum.PlanImport;
                }
			}
			return null;
		}
	}

	public class TypeJobSuccessConverter : IValueConverter
	{
		public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
		{
			switch ((TypeJobSuccessEnum)value)
			{
				case TypeJobSuccessEnum.Error:
					return "Fehler";
				case TypeJobSuccessEnum.Success:
					return "Erfolg";
				case TypeJobSuccessEnum.Warning:
					return "Warnung";
			}
			return "";
		}

		public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
		{
			if (value is string)
			{
				switch ((string)value)
				{
					case "Fehler":
						return TypeJobSuccessEnum.Error;
					case "Erfolg":
						return TypeJobSuccessEnum.Success;
					case "Warnung":
						return TypeJobSuccessEnum.Warning;
				}
			}
			return null;
		}
	}

}
