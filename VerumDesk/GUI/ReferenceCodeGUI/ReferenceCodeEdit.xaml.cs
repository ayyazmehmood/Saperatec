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
    /// Interaktionslogik für ReferenceCodeEdit.xaml
    /// </summary>
    public partial class ReferenceCodeEdit : Window
    {
        ReferenceCode item;
        PlanItemEdit planWindow;

        public ReferenceCodeEdit()
        {
            InitializeComponent();
            item = new ReferenceCode();
            item.New();
            this.DataContext = item;
            InitTabElement();
            item.FlagActive = true;
            this.tbFlagActive.IsChecked = true;
        }

        public ReferenceCodeEdit(string code, PlanItemEdit planWindow)
        {
            InitializeComponent();
            item = new ReferenceCode();
            item.New();
            this.DataContext = item;
            InitTabElement();
            item.RefCode = code;
            this.tbRefCode.IsReadOnly = true;
            item.FlagActive = true;
            this.tbFlagActive.IsChecked = true;
            this.planWindow = planWindow;
        }

        public ReferenceCodeEdit(ReferenceCode item)
        {
            InitializeComponent();
            this.item = item;
            this.DataContext = item;
            InitTabElement();
            if (item.isUsed())
            {
                this.tbRefCode.IsReadOnly = true;
            }
        }

        ObservableCollection<ReferenceGroup> colReferenceGroup;


        private void InitTabElement()
        {
            // init reference group combo box
            colReferenceGroup = ReferenceGroup.GetBOCollection().GetObservableCollection();
            cbReferenceGroup.ItemsSource = colReferenceGroup.Select(i => $"{i.TitleReferenceGroup}");
            cbReferenceGroup.SelectedIndex = colReferenceGroup.IndexOf(colReferenceGroup.FirstOrDefault(b => b.Id == item.idReferenceGroup));
        }

        private void cbReferenceGroup_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if(cbReferenceGroup.SelectedIndex >= 0)
            {
                item.idReferenceGroup = colReferenceGroup.ElementAt(cbReferenceGroup.SelectedIndex).Id;
                OnRaiseItemUpdated();
            }          
        }

        private void cmdOK_Click(object sender, RoutedEventArgs e)
        {
            if (tbRefCode.Text.Trim() == "")
            {
                System.Windows.MessageBox.Show("Bei Anlage eines neuen Buchungsschlüssels muss ein Schlüssel vergeben werden..", "Buchungsschlüssel anlegen", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            else if (cbReferenceGroup.SelectedIndex == -1)
            {
                System.Windows.MessageBox.Show("Einem neuen Buchungsschlüssel muss ein Gruppe zugewiesen werden.", "Buchungsschlüssel anlegen", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
            else if (ReferenceCode.CheckCodeExists(tbRefCode.Text.Trim()))
            {
                System.Windows.MessageBox.Show("Diesen Buchungsschlüssel gibt es bereits.", "Buchungsschlüssel anlegen", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            else if (tbTitleRefCode.Text.Trim() == "")
            {
                System.Windows.MessageBox.Show("Einem neuen Buchungsschlüssel muss ein Titel zugewiesen werden.", "Buchungsschlüssel anlegen", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            

            try
            {
                item.CommitChanges();
                OnRaiseItemUpdated();
                if (planWindow != null) planWindow.tbReferenceID.Text = item.RefCode;
                this.Close();
            }
            catch (Exception ex)
            {
                System.Windows.MessageBox.Show("Unerwarteter Fehler beim Anlegen des Buchungsschlüssels.", "Buchungsschlüssel anlegen", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void cmdCancel_Click(object sender, RoutedEventArgs e)
        {
            item.RollbackChanges();
            OnRaiseItemUpdated();
            this.Close();
        }

        public event EventHandler<ReferenceCode> ItemUpdated;

        protected virtual void OnRaiseItemUpdated()
        {
            // Raise event if event handler is set (i.e. not null)
            ItemUpdated?.Invoke(this, item);
        }
    }
}
