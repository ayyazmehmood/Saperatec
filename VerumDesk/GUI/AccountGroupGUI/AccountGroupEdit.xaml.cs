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
    /// Interaktionslogik für AccountGroupEdit.xaml
    /// </summary>
    public partial class AccountGroupEdit : Window
    {
        AccountGroup item;

        public AccountGroupEdit()
        {
            InitializeComponent();
            item = new AccountGroup();
            item.New();
            this.DataContext = item;
            InitTabElement();
        }

        public AccountGroupEdit(AccountGroup item)
        {
            InitializeComponent();
            this.item = item;
            this.DataContext = item;
            InitTabElement();
        }

        ObservableCollection<AccountMainGroup> colMainGroup;


        private void InitTabElement()
        {
            // init reference group combo box
            colMainGroup = AccountMainGroup.GetBOCollection().GetObservableCollection();
            tbMainGroup.Text = (from g in colMainGroup where g.Id == item.idAccountMainGroup select g.TitleLocalMainGroup).FirstOrDefault();
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
            //else if (AccountGroup.CheckCodeExists(tbRefCode.Text.Trim()))
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
                System.Windows.MessageBox.Show("Unerwarteter Fehler beim Anlegen der Kontogruppe.", "Kontogruppe anlegen", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            this.Close();
        }

        private void cmdCancel_Click(object sender, RoutedEventArgs e)
        {
            item.RollbackChanges();
            OnRaiseItemUpdated();
            this.Close();
        }

        public event EventHandler<AccountGroup> ItemUpdated;

        protected virtual void OnRaiseItemUpdated()
        {
            // Raise event if event handler is set (i.e. not null)
            ItemUpdated?.Invoke(this, item);
        }

        protected virtual void OnItemUpdated(object sender, RoutedEventArgs e)
        {
            EventHandler<AccountGroup> handler = ItemUpdated;
            handler?.Invoke(this, item);
        }

        private void Picker_Click(object sender, RoutedEventArgs e)
        {
            AccountGroupPicker picker = new AccountGroupPicker(item);
            picker.GroupSelected += UpdateMainGroupText;
            picker.Show();
        }

        private void UpdateMainGroupText(object sender, EventArgs e)
        {
            tbMainGroup.Text = (from g in colMainGroup where g.Id == item.idAccountMainGroup select g.TitleLocalMainGroup).FirstOrDefault();
        }

        private void NumberValidation(object sender, TextCompositionEventArgs e)
        {
            Regex regex = new Regex("[^0-9]+");
            e.Handled = regex.IsMatch(e.Text);
        }
    }
}
