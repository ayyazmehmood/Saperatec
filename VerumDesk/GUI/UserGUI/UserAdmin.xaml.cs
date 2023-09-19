using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel;
using System.Collections.ObjectModel;
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
using System.Windows.Forms;


namespace VerumDesk.GUI
{
    /// <summary>
    /// Interaktionslogik für UserAdmin.xaml
    /// </summary>
    public partial class UserAdmin : Window
    {
        private BOCollection<User, tUser> users;
        private ObservableCollection<User> listItems;
        private GridViewColumnHeader listViewSortCol = null;
        private SortAdorner listViewSortAdorner = null;

        public UserAdmin()
        {
            InitializeComponent();
            UserListUpdate();
        }

        private void btnUserEdit_Click(object sender, RoutedEventArgs e)
        {
            if (lbUsers.SelectedItem != null)
            {
                var wnd = new UserEdit((User)lbUsers.SelectedItem);
                wnd.Show();
            }
        }

        private void btnUserCreate_Click(object sender, RoutedEventArgs e)
        {
            var wnd = new UserEdit();
            wnd.UserCreated += UserCreatedEventHandler;
            wnd.Show();
        }

        private void btnUserDelete_Click(object sender, RoutedEventArgs e)
        {
            User user;

            if (lbUsers.SelectedItem != null)
            {
                user = (User)lbUsers.SelectedItem;

                switch (user.Delete())
                {
                    case BOResult.GeneralError:
                        System.Windows.MessageBox.Show("Unerwarteter Fehler beim Löschen des Benutzers.", "Benutzer löschen", MessageBoxButton.OK, MessageBoxImage.Error);
                        break;

                    case BOResult.Success:
                        listItems.Remove(user);
                        UserListUpdate();
                        break;
                }
            }
        }

        private void btnClose_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void UserCreatedEventHandler(object sender, User user)
        {
            //Dispatcher.BeginInvoke(new Action(() => { ctrlProgress.Value = e.ItemsComplete; }));
            listItems.Add(user);
        }

        private void UserUpdatedEventHandler(object sender, User user)
        {
            UserListUpdate();
        }

        private void UserListUpdate()
        {
            users = User.GetUsers();

            listItems = new ObservableCollection<User>();

            foreach (var user in users)
                listItems.Add(user);
            lbUsers.ItemsSource = listItems;

            lbUsers.Items.SortDescriptions.Clear();
            lbUsers.Items.SortDescriptions.Add(new SortDescription("UserName", ListSortDirection.Ascending));

        }

        private void lvUsersColumnHeader_Click(object sender, RoutedEventArgs e)
        {
            GridViewColumnHeader column = (sender as GridViewColumnHeader);
            string sortBy = column.Tag.ToString();

            if (listViewSortCol != null)
            {
                AdornerLayer.GetAdornerLayer(listViewSortCol).Remove(listViewSortAdorner);
                lbUsers.Items.SortDescriptions.Clear();
            }

            ListSortDirection newDir = ListSortDirection.Ascending;
            if (listViewSortCol == column && listViewSortAdorner.Direction == newDir)
                newDir = ListSortDirection.Descending;

            listViewSortCol = column;
            listViewSortAdorner = new SortAdorner(listViewSortCol, newDir);
            AdornerLayer.GetAdornerLayer(listViewSortCol).Add(listViewSortAdorner);
            lbUsers.Items.SortDescriptions.Add(new SortDescription(sortBy, newDir));
        }
    }
}
