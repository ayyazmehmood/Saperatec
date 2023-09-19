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
using System.Text.RegularExpressions;

namespace VerumDesk.GUI
{
    /// <summary>
    /// Interaktionslogik für AccountMainGroupEdit.xaml
    /// </summary>
    public partial class AccountMainGroupEdit : Window
    {
        AccountMainGroup item;

        public AccountMainGroupEdit()
        {
            InitializeComponent();
            item = new AccountMainGroup();
            item.New();
            this.DataContext = item;
            InitTabElement();
        }

        public AccountMainGroupEdit(AccountMainGroup item)
        {
            InitializeComponent();
            this.item = item;
            this.DataContext = item;
            InitTabElement();
        }

        ObservableCollection<AccountSection> colSection;


        private void InitTabElement()
        {
            // init reference group combo box
            colSection = AccountSection.GetBOCollection().GetObservableCollection();
            tbSection.Text = (from g in colSection where g.Id == item.idAccountSection select g.TitleLocalSection).FirstOrDefault();
        }

        private void cmdOK_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                item.CommitChanges();
                OnRaiseItemUpdated();
                this.Close();
            }
            catch (Exception ex)
            {
                System.Windows.MessageBox.Show("Unerwarteter Fehler beim Anlegen der Hauptkontogruppe", "Hauptkontogruppe anlegen", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            this.Close();
        }

        private void cmdCancel_Click(object sender, RoutedEventArgs e)
        {
            item.RollbackChanges();
            OnRaiseItemUpdated();
            this.Close();
        }

        public event EventHandler<AccountMainGroup> ItemUpdated;

        protected virtual void OnRaiseItemUpdated()
        {
            // Raise event if event handler is set (i.e. not null)
            ItemUpdated?.Invoke(this, item);
        }

        protected virtual void OnItemUpdated(object sender, RoutedEventArgs e)
        {
            EventHandler<AccountMainGroup> handler = ItemUpdated;
            handler?.Invoke(this, item);
        }

        private void Picker_Click(object sender, RoutedEventArgs e)
        {
            AccountGroupPicker picker = new AccountGroupPicker(item);
            picker.GroupSelected += UpdateSectionText;
            picker.Show();
        }

        private void UpdateSectionText(object sender, EventArgs e)
        {
            tbSection.Text = (from g in colSection where g.Id == item.idAccountSection select g.TitleLocalSection).FirstOrDefault();
        }

        private void NumberValidation(object sender, TextCompositionEventArgs e)
        {
            Regex regex = new Regex("[^0-9]+");
            e.Handled = regex.IsMatch(e.Text);
        }
    }
}
