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
    /// Interaktionslogik für BookRecordList.xaml
    /// </summary>
    public partial class BookRecordList : Window
    {
        private BOCollection<BookRecord, tBookRecord> BOColl;
        private ObservableCollection<BookRecord> listItems;
        private Guid bookingRunId;

        public BookRecordList(Guid br)
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
            //listItems = BookRecord.GetBOCollectionByBookingRun(bookingRunId).GetObservableCollection();
            dgMain.ItemsSource = listItems;
        }

        private void ItemCreatedEventHandler(object sender, BookRecord item)
        {
            //Dispatcher.BeginInvoke(new Action(() => { ctrlProgress.Value = e.ItemsComplete; }));
            listItems.Add(item);
        }

        private void ItemUpdatedEventHandler(object sender, BookRecord user)
        {
            ListUpdate();
        }
        private void tbFilter_TextChanged(object sender, TextChangedEventArgs e)
        {
            ListUpdate();
        }

    }
}
