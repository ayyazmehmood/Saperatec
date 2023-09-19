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
    /// Interaktionslogik für AccountSectionEdit.xaml
    /// </summary>
    public partial class AccountSectionEdit : Window
    {
        AccountSection item;

        public AccountSectionEdit()
        {
            InitializeComponent();
            item = new AccountSection();
            item.New();
            this.DataContext = item;
            InitTabElement();
        }

        public AccountSectionEdit(AccountSection item)
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
            //else if (AccountSection.CheckCodeExists(tbRefCode.Text.Trim()))
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
                System.Windows.MessageBox.Show("Unerwarteter Fehler beim Anlegen der Kontosektion", "Kontosektion anlegen", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            this.Close();
        }

        private void cmdCancel_Click(object sender, RoutedEventArgs e)
        {
            item.RollbackChanges();
            OnRaiseItemUpdated();
            this.Close();
        }

        public event EventHandler<AccountSection> ItemUpdated;

        protected virtual void OnRaiseItemUpdated()
        {
            // Raise event if event handler is set (i.e. not null)
            ItemUpdated?.Invoke(this, item);
        }

        protected virtual void OnItemUpdated(object sender, RoutedEventArgs e)
        {
            EventHandler<AccountSection> handler = ItemUpdated;
            handler?.Invoke(this, item);
        }

        private void NumberValidation(object sender, TextCompositionEventArgs e)
        {
            Regex regex = new Regex("[^0-9]+");
            e.Handled = regex.IsMatch(e.Text);
        }
    }
}
