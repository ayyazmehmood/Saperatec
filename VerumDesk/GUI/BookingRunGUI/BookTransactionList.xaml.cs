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

namespace VerumDesk.GUI
{
    /// <summary>
    /// Interaktionslogik für BookTransactionList.xaml
    /// </summary>
    public partial class BookTransactionList : Window
    {
        private BOCollection<BookTransaction, tBookTransaction> BOColl;
        //private List<TransactionEntry> listItems;
        private Guid bookingRunId;

        public BookTransactionList(Guid br)
        {
            bookingRunId = br;
            InitializeComponent();
            ListUpdate();
            InitTabElement();
        }


        private void InitTabElement()
        {
            // init reference group combo box
        }

        private void btnClose_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void ListUpdate()
        {
            // get all records in bookingrun
            var bookRecords = BookRecord.GetBOCollection(bookingRunId).GetObservableCollection();
            var transactions = new ObservableCollection<BookTransaction>();
            BOCollection<BookTransaction, tBookTransaction> t;
            // get transactions from records
            foreach (var bookRecord in bookRecords)
            {
                t = BookTransaction.GetBOCollectionFromRecord(bookRecord.Id);
                transactions = new ObservableCollection<BookTransaction>(transactions.Concat(t.GetObservableCollection()));
            }
            // join transactions with records
            var query = from transaction in transactions join record in bookRecords on transaction.idBookingRecord equals record.Id select new { transaction, record };

            dgMain.ItemsSource = query;
        }

        //private void ItemCreatedEventHandler(object sender, BookTransaction item)
        //{
        //    //Dispatcher.BeginInvoke(new Action(() => { ctrlProgress.Value = e.ItemsComplete; }));
        //    listItems.Add(item);
        //}

        private void ItemUpdatedEventHandler(object sender, BookTransaction user)
        {
            ListUpdate();
        }
        private void tbFilter_TextChanged(object sender, TextChangedEventArgs e)
        {
            ListUpdate();
        }
    }
}
 