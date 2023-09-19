using System;
using System.Collections.Generic;
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
    /// Interaktionslogik für UserEdit.xaml
    /// </summary>
    public partial class UserEdit : Window
    {
        User user;

        public UserEdit()
        {
            InitializeComponent();
            user = new User();


            if (user.New() is null)
            {
                System.Windows.MessageBox.Show("Benutzer ist zur Anlage eines neuen Benutzers nicht berechtigt.", "Benutzer anlegen", MessageBoxButton.OK, MessageBoxImage.Warning);
                this.Close();
            }
            else
            {
                user.idClientDefault = VerumInstance.IdClient;
                user.TypeUser = (short)TypeUserEnum.Standard;
                this.DataContext = user;
            }
        }

        public UserEdit(User user)
        {
            InitializeComponent();
            this.user = user;
            this.DataContext = user;
        }

        private void cmdOK_Click(object sender, RoutedEventArgs e)
        {
            if (user.Bound)
            {
                user.SetPassword(tbPassword.Text);
                this.Close();
            }
            else                // new user - must specify password
            {
                if (tbPassword.Text == "")
                {
                    System.Windows.MessageBox.Show("Bei Anlage eines neuen Benutzers muss ein Passwort vergeben werden.", "Benutzer anlegen", MessageBoxButton.OK, MessageBoxImage.Warning);
                }
                else
                {
                    

                    switch (user.SetPassword(tbPassword.Text))
                    {
                        case BOResult.GeneralError:
                            System.Windows.MessageBox.Show("Unerwarteter Fehler beim Anlegen des Benutzers.", "Benutzer anlegen", MessageBoxButton.OK, MessageBoxImage.Error);
                            break;

                        case BOResult.UserNotAuthorized:
                            System.Windows.MessageBox.Show("Sie haben nicht die zur Erstellung eines Nutzers erforderlichen Rechte.", "Benutzer anlegen", MessageBoxButton.OK, MessageBoxImage.Error);
                            break;

                        case BOResult.UserCreateFailed:
                            System.Windows.MessageBox.Show("Die eingegebenen Benutzerdaten erfüllen nicht die Anforderungen.", "Benutzer anlegen", MessageBoxButton.OK, MessageBoxImage.Warning);
                            break;

                        case BOResult.Success:
                            OnRaiseUserCreated();
                            this.Close();
                            break;
                    }

                }
            }

        }

        private void cmdCancel_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        public event EventHandler<User> UserCreated;

        protected virtual void OnRaiseUserCreated()
        {
            // Raise event if event handler is set (i.e. not null)
            UserCreated?.Invoke(this, user);
        }
    }
}
