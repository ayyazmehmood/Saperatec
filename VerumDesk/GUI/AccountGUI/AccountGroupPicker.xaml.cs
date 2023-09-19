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

namespace VerumDesk.GUI.AccountGUI
{
    /// <summary>
    /// Interaction logic for AccountPicker.xaml
    /// </summary>
    public partial class AccountGroupPicker : Window
    {
        private Account account;
        private AccountGroup accountGroup;
        private AccountMainGroup accountMainGroup;

        public event EventHandler GroupSelected;

        public AccountGroupPicker(Account a)
        {
            InitializeComponent();
            InitTabElement();
            account = a;
        }

        public AccountGroupPicker(AccountGroup a)
        {
            InitializeComponent();
            InitTabElement();
            accountGroup = a;
            cbGroup.Visibility = Visibility.Collapsed;
            lbGroup.Visibility = Visibility.Collapsed;
        }

        public AccountGroupPicker(AccountMainGroup a)
        {
            InitializeComponent();
            InitTabElement();
            accountMainGroup = a;
            cbGroup.Visibility = Visibility.Collapsed;
            cbMainGroup.Visibility = Visibility.Collapsed;
            lbGroup.Visibility = Visibility.Collapsed;
            lbMainGroup.Visibility = Visibility.Collapsed;
        }

        ObservableCollection<AccountGroup> colGroup;
        ObservableCollection<AccountMainGroup> colMainGroup;
        ObservableCollection<AccountSection> colSection;
        private void InitTabElement()
        {
            colGroup = AccountGroup.GetBOCollection().GetObservableCollection();
            colMainGroup = AccountMainGroup.GetBOCollection().GetObservableCollection();
            colSection = AccountSection.GetBOCollection().GetObservableCollection();


            cbGroup.ItemsSource = colGroup.Select(i => $"{i.TitleLocalAccountGroup}");
            cbMainGroup.ItemsSource = colMainGroup.Select(i => $"{i.TitleLocalMainGroup}");
            cbSection.ItemsSource = colSection.Select(i => $"{i.TitleLocalSection}");
        }

        private void cbGroup_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            account.idAccountGroup = colGroup.ElementAt(cbGroup.SelectedIndex).Id;
        }

        private void cbMainGroup_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {          
            if (cbMainGroup.SelectedIndex != -1)
            {
                if (account != null) account.idAccountMainGroup = colMainGroup.ElementAt(cbMainGroup.SelectedIndex).Id;
                else if (accountGroup != null) accountGroup.idAccountMainGroup = colMainGroup.ElementAt(cbMainGroup.SelectedIndex).Id;
                colGroup = new ObservableCollection<AccountGroup>(from item in AccountGroup.GetBOCollection().GetObservableCollection() where item.idAccountMainGroup == colMainGroup.ElementAt(cbMainGroup.SelectedIndex).Id select item);
                cbGroup.ItemsSource = colGroup.Select(i => $"{i.TitleLocalAccountGroup}");
                cbGroup.SelectedItem = null;
                cbGroup.IsEnabled = true;
            }
        }

        private void cbSection_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {           
            if (cbSection.SelectedIndex != -1)
            {
                if (account != null) account.idAccountSection = colSection.ElementAt(cbSection.SelectedIndex).Id;
                else if (accountMainGroup != null) accountMainGroup.idAccountSection = colSection.ElementAt(cbSection.SelectedIndex).Id;
                colMainGroup = new ObservableCollection<AccountMainGroup>(from item in AccountMainGroup.GetBOCollection().GetObservableCollection() where item.idAccountSection == colSection.ElementAt(cbSection.SelectedIndex).Id select item);
                cbMainGroup.ItemsSource = colMainGroup.Select(i => $"{i.TitleLocalMainGroup}");
                cbMainGroup.SelectedItem = null;
                cbGroup.SelectedItem = null;
                cbMainGroup.IsEnabled = true;
            }
        }

        private void cmdOK_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (account != null) account.CommitChanges();
                else if (accountGroup != null) accountGroup.CommitChanges();
                else if (accountMainGroup != null) accountMainGroup.CommitChanges();

                EventHandler handler = GroupSelected;
                handler?.Invoke(this, EventArgs.Empty);

                this.Close();
            }
            catch (Exception ex)
            {
                System.Windows.MessageBox.Show("Unerwarteter Fehler" , "Gruppe auswählen", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void cmdCancel_Click(object sender, RoutedEventArgs e)
        {
            //item.RollbackChanges();
            this.Close();
        }
    }
}
