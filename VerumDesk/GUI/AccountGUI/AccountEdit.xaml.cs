using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using VerumBusinessObjects.Views;
using VerumBusinessObjects;
using System.Collections.ObjectModel;
using System.Collections.Generic;
using VerumBusinessObjects.Framework;
using System.Data.Entity.Validation;
using VerumDesk.GUI.AccountGUI;

namespace VerumDesk.GUI
{
    /// <summary>
    /// Interaktionslogik für AccountEdit.xaml
    /// </summary>
    public partial class AccountEdit : Window
    {
        Account item;

        public AccountEdit()
        {
            InitializeComponent();
            item = new Account();
            item.New();
            this.DataContext = item;
            InitTabElement();
        }

        public AccountEdit(Account item)
        {
            InitializeComponent();
            this.item = item;
            this.DataContext = item;
            InitTabElement();
            if (item.isUsed())
            {
                this.tbCode.IsReadOnly = true;
            }
        }

        ObservableCollection<AccountGroup> colGroup;
        ObservableCollection<AccountMainGroup> colMainGroup;
        ObservableCollection<AccountSection> colSection;

        private void InitTabElement()
        {
            // init reference group combo box
            colGroup = AccountGroup.GetBOCollection().GetObservableCollection();
            colMainGroup = AccountMainGroup.GetBOCollection().GetObservableCollection();
            colSection = AccountSection.GetBOCollection().GetObservableCollection();
            tbGroup.Text = (from g in colGroup where g.Id == item.idAccountGroup select g.TitleLocalAccountGroup).FirstOrDefault();
            tbMainGroup.Text = (from g in colMainGroup where g.Id == item.idAccountMainGroup select g.TitleLocalMainGroup).FirstOrDefault();
            tbSection.Text = (from g in colSection where g.Id == item.idAccountSection select g.TitleLocalSection).FirstOrDefault();

            cbTypeAccount.ItemsSource = TypeValues;
            cbTypeAccount.SelectedIndex = item.TypeAccount;
        }

        public IEnumerable<TypeAccountEnum> TypeValues
        {
            get
            {
                return Enum.GetValues(typeof(TypeAccountEnum))
                    .Cast<TypeAccountEnum>();
            }
        }

        private void cmdOK_Click(object sender, RoutedEventArgs e)
        {
            //if (tbRefCode.Text.Trim() == "")
            //{
            //    System.Windows.MessageBox.Show("Bei Anlage eines neuen Buchungsschlüssels muss ein Schlüssel vergeben werden..", "Buchungsschlüssel anlegen", MessageBoxButton.OK, MessageBoxImage.Warning);
            //    return;
            //}
            //else if (cbReferenceGroup.SelectedIndex == -1)
            //{
            //    System.Windows.MessageBox.Show("Einem neuen Buchungsschlüssel muss ein Gruppe zugewiesen werden.", "Buchungsschlüssel anlegen", MessageBoxButton.OK, MessageBoxImage.Warning);
            //}
            //else if (Account.CheckCodeExists(tbRefCode.Text.Trim()))
            //{
            //    System.Windows.MessageBox.Show("Diesen Buchungsschlüssel gibt es bereits.", "Buchungsschlüssel anlegen", MessageBoxButton.OK, MessageBoxImage.Warning);
            //    return;
            //}
            //else if (tbTitleRefCode.Text.Trim() == "")
            //{
            //    System.Windows.MessageBox.Show("Einem neuen Buchungsschlüssel muss ein Titel zugewiesen werden.", "Buchungsschlüssel anlegen", MessageBoxButton.OK, MessageBoxImage.Warning);
            //    return;
            //}


            try
            {
                item.CommitChanges();
                OnRaiseItemUpdated();
                this.Close();
            }
            catch (Exception ex)
            {
                System.Windows.MessageBox.Show("Unerwarteter Fehler beim Anlegen des Kontos.", "Konto anlegen", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            this.Close();
        }

        private void cmdCancel_Click(object sender, RoutedEventArgs e)
        {
            item.RollbackChanges();
            OnRaiseItemUpdated();
            this.Close();
        }

        public event EventHandler<Account> ItemUpdated;

        protected virtual void OnRaiseItemUpdated()
        {
            // Raise event if event handler is set (i.e. not null)
            ItemUpdated?.Invoke(this, item);
        }

        protected virtual void OnItemUpdated(object sender, RoutedEventArgs e)
        {
            EventHandler<Account> handler = ItemUpdated;
            handler?.Invoke(this, item);
        }

        private void Picker_Click(object sender, RoutedEventArgs e)
        {
            AccountGroupPicker picker = new AccountGroupPicker(item);
            picker.Show();
        }
    }
}
