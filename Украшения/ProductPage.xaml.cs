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
    /// Логика взаимодействия для ProductPage.xaml
    /// </summary>
    public partial class ProductPage : Page
    {
        int AllCount = 0;
        public ProductPage(int userID)
        {
            InitializeComponent();
            var currentUser = SharipovEntities.GetContext().User.ToList();
            if (userID >= 0)
            {
                userRoleTB.Text = currentUser[userID].UserSurname.ToString() + " " + currentUser[userID].UserName.ToString() + " " + currentUser[userID].UserPatronymic.ToString();
            }
            else
            {
                userRoleTB.Text = "Гостевой режим";
            }
            var currentProduct = SharipovEntities.GetContext().Product.ToList();
            ProdList.ItemsSource = currentProduct;
            ComboFilter.SelectedIndex = 0;
            ComboType.SelectedIndex = 0;
        }

        public void Update()
        {
            var currentProduct = SharipovEntities.GetContext().Product.ToList();
            AllCount = currentProduct.Count;

            if (ComboType.SelectedIndex == 1)
            {
                currentProduct = currentProduct.Where(p => p.ProductDiscountAmount < 10).ToList();
            }

            if (ComboType.SelectedIndex == 2)
            {
                currentProduct = currentProduct.Where(p => p.ProductDiscountAmount >= 10 && p.ProductDiscountAmount < 15).ToList();
            }

            if (ComboType.SelectedIndex == 3)
            {
                currentProduct = currentProduct.Where(p => p.ProductDiscountAmount >= 15).ToList();
            }

            if (ComboFilter.SelectedIndex == 1)
            {
                currentProduct = currentProduct.OrderBy(p => p.ProductName).ToList();
            }
            if (ComboFilter.SelectedIndex == 2)
            {
                currentProduct = currentProduct.OrderByDescending(p => p.ProductName).ToList();
            }
            currentProduct = currentProduct.Where(p => p.ProductName.ToLower().Contains(Search.Text.ToLower())).ToList();
            CountTB.Text = currentProduct.Count.ToString() + " из " + AllCount.ToString();
            ProdList.ItemsSource = currentProduct;
        }
        private void Search_TextChanged(object sender, TextChangedEventArgs e)
        {
            Update();
        }

        private void ComboFilter_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Update();
        }

        private void ComboType_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Update();
        }
    }
}
