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

namespace VerumDesk.GUI
{
    /// <summary>
    /// Interaktionslogik für DepreciationRuleEdit.xaml
    /// </summary>
    public partial class DepreciationRuleEdit : Window
    {
        DepreciationRule item;
        PlanItemEdit planWindow;

        public DepreciationRuleEdit()
        {
            InitializeComponent();
            item = new DepreciationRule();
            item.New();
            this.DataContext = item;
            InitTabElement();
        }

        public DepreciationRuleEdit(DepreciationRule item)
        {
            InitializeComponent();
            this.item = item;
            this.DataContext = item;
            InitTabElement();
        }

        ObservableCollection<ReferenceGroup> colReferenceGroup;
        ObservableCollection<Account> colAccount;


        private void InitTabElement()
        {
            // init reference group combo box
            colReferenceGroup = ReferenceGroup.GetBOCollection().GetObservableCollection();
            colAccount = Account.GetBOCollection().GetObservableCollection();
            cbAccountActivation.ItemsSource = colAccount.Select(i => $"{i.TitleLocalAccount} {i.AccountCode}");
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
                System.Windows.MessageBox.Show("Unerwarteter Fehler beim Anlegen der Abschreibungsregel.", "Abschreibungsregel anlegen", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void cmdCancel_Click(object sender, RoutedEventArgs e)
        {
            item.RollbackChanges();
            OnRaiseItemUpdated();
            this.Close();
        }

        public event EventHandler<DepreciationRule> ItemUpdated;

        protected virtual void OnRaiseItemUpdated()
        {
            // Raise event if event handler is set (i.e. not null)
            ItemUpdated?.Invoke(this, item);
        }
    }
}
