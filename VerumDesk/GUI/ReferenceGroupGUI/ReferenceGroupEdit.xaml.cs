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
    /// Interaktionslogik für ReferenceGroupEdit.xaml
    /// </summary>
    public partial class ReferenceGroupEdit : Window
    {
        ReferenceGroup item;

        public ReferenceGroupEdit()
        {
            InitializeComponent();
            item = new ReferenceGroup();
            item.New();
            this.DataContext = item;
            InitTabElement();
        }


        public ReferenceGroupEdit(ReferenceGroup item)
        {
            InitializeComponent();
            this.item = item;
            this.DataContext = item;
            InitTabElement();
        }

        ObservableCollection<ReferenceGroup> colReferenceGroup;

        private void InitTabElement()
        {
            // init reference group combo box
            //colReferenceGroup = ReferenceGroup.GetBOCollection().GetObservableCollection();
            //cbReferenceGroup.ItemsSource = colReferenceGroup.Select(i => $"{i.TitleReferenceGroup}");
            //cbReferenceGroup.SelectedIndex = colReferenceGroup.IndexOf(colReferenceGroup.FirstOrDefault(b => b.Id == item.idReferenceGroup));
        }

        private void cbReferenceGroup_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            //item.idReferenceGroup = colReferenceGroup.ElementAt(cbReferenceGroup.SelectedIndex).Id;
            //OnRaiseItemUpdated();
        }

        private void cmdOK_Click(object sender, RoutedEventArgs e)
        {
            if (tbTitle.Text.Trim() == "")
            {
                System.Windows.MessageBox.Show("Bei Anlage einer neuen Buchungsschlüsselgruppe muss ein Titel vergeben werden..", "Buchungsschlüsselgruppe anlegen", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            
            else if (ReferenceGroup.CheckGroupExists(tbTitle.Text.Trim()))
            {
                System.Windows.MessageBox.Show("Diesen Buchungsschlüssel gibt es bereits.", "Buchungsschlüssel anlegen", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
           


            try
            {
                item.CommitChanges();
                OnRaiseItemUpdated();
                this.Close();
            }
            catch (Exception ex)
            {
                System.Windows.MessageBox.Show("Unerwarteter Fehler beim Anlegen des Buchungsschlüssels.", "Buchungsschlüssel anlegen", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void cmdCancel_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        public event EventHandler<ReferenceGroup> ItemUpdated;

        protected virtual void OnRaiseItemUpdated()
        {
            // Raise event if event handler is set (i.e. not null)
            ItemUpdated?.Invoke(this, item);
        }

    }
}
