using System;
using System.Windows;
using VerumBusinessObjects;

namespace VerumDesk.GUI
{
    /// <summary>
    /// Interaktionslogik für CostCenterEdit.xaml
    /// </summary>
    public partial class CostCenterEdit : Window
    {
        CostCenter item;

        public CostCenterEdit()
        {
            InitializeComponent();
            item = new CostCenter();
            item.New();
            item.FlagProfitCenter = false;
            this.DataContext = item;
        }

        public CostCenterEdit(CostCenter item)
        {
            InitializeComponent();
            this.item = item;
            this.DataContext = item;
        }

        private void cmdOK_Click(object sender, RoutedEventArgs e)
        {
            if (tbCostCenterCode.Text.Trim() == "")
            {
                System.Windows.MessageBox.Show("Bei Anlage einer neuen Kostenstelle muss ein Schlüssel vergeben werden..", "Kostenstelle anlegen", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            else if (!CostCenter.CheckKeyExists(tbCostCenterCode.Text.Trim()))
            {
                // A cost center with this key already exists
                //System.Windows.MessageBox.Show("Eine Kostenstelle mit diesem Schlüssel gibt es bereits.", "Kostenstelle anlegen", MessageBoxButton.OK, MessageBoxImage.Warning);

                //A cost center with this key is not exists
                System.Windows.MessageBox.Show("Eine Kostenstelle mit diesem Schlüssel ist nicht vorhanden.", "Kostenstelle anlegen", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            else if (tbTitleCostCenter.Text.Trim() == "")
            {
                System.Windows.MessageBox.Show("Einer neuen Kostenstelle muss ein Titel zugewiesen werden.", "Kostenstelle anlegen", MessageBoxButton.OK, MessageBoxImage.Warning);
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
                System.Windows.MessageBox.Show("Unerwarteter Fehler beim Anlegen der Kostenstelle.", "Kostenstelle anlegen", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void cmdCancel_Click(object sender, RoutedEventArgs e)
        {
            item.RollbackChanges();
            OnRaiseItemUpdated();
            this.Close();
        }

        public event EventHandler<CostCenter> ItemUpdated;

        protected virtual void OnRaiseItemUpdated()
        {
            // Raise event if event handler is set (i.e. not null)
            ItemUpdated?.Invoke(this, item);
        }

    }
}
