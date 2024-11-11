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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Украшения
{
    /// <summary>
    /// Логика взаимодействия для LoginPage.xaml
    /// </summary>
    public partial class LoginPage : Page
    {
        public LoginPage()
        {
            InitializeComponent();
        }

        private void LoginBtn_Click(object sender, RoutedEventArgs e)
        {
            var currentUser = SharipovEntities.GetContext().User.ToList();
            currentUser = currentUser.Where(p => p.UserLogin == LoginTB.Text && p.UserPassword == PasvordTB.Password).ToList();
            int userID = 0;
            foreach (User user in currentUser)
            {
                userID = user.UserID;
            }
            if (currentUser.Count == 0)
            {

            }
            else if (currentUser.Count == 1)
            {
                MainClass.MainFrame.Navigate(new ProductPage(userID - 1));
            }
        }

        private void VizitBtn_Click(object sender, RoutedEventArgs e)
        {
            MainClass.MainFrame.Navigate(new ProductPage(-1));
        }
    }
}
