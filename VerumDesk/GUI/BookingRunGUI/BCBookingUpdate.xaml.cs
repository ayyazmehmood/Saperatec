using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
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
using VerumBusinessObjects.Framework;
using VerumBusinessObjects;
using VerumDesk.Controller;
using System.Collections.ObjectModel;
using System.Web.UI.WebControls;

namespace VerumDesk.GUI.BookingRunGUI
{
    /// <summary>
    /// Interaction logic for BCBookingUpdate.xaml
    /// </summary>
    public partial class BCBookingUpdate : Window
    {
        private BOCollection<Client, tClient> BOCollClient;
        private ObservableCollection<Client> listItems;

        public BCBookingUpdate()
        {
            InitializeComponent();
            SetBCUrl();
        }

        public void SetBCUrl()
        {
            var bcurl = Client.GetBOCollectionBCUrl();
            txtBCUrl.Text = bcurl;
        }

        private void btnClose_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void TextBox_TextChanged(object sender, TextChangedEventArgs e)
        {

        }

        private async void btnRunUrl_Click(object sender, RoutedEventArgs e)
        {
            var res = await VerumAPI.CallApiAsync(VerumDesk.Properties.Settings.Default.VerumAPIBaseUrl + "/BackgroundRun/UpdateBookRecord?clietId=" + WebUtility.UrlEncode(VerumInstance.IdClient.ToString()) + "&userId="+ WebUtility.UrlEncode(VerumInstance.User.Id.ToString()));
            if (res != null)
            {
                var resDes = Newtonsoft.Json.JsonConvert.DeserializeObject<ApiResponse<Object>>(res);
                System.Windows.MessageBox.Show(resDes.message);
            }
            else
            {
                System.Windows.MessageBox.Show("Something went wrong.");
            }
        }

        private void btnSaveUrl_Click(object sender, RoutedEventArgs e)
        {
            var url = txtBCUrl.Text;
            if(string.IsNullOrEmpty(url))
            {
                System.Windows.MessageBox.Show("Url cannot be blank.");
            }
            
            Client.UpdateBCUrl(url);
        }
    }
}