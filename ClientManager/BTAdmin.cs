using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ClientManager
{
    public partial class BTAdmin : Form
    {
        string conStr = "";
        public BTAdmin()
        {
            InitializeComponent();
            conStr = System.Configuration.ConfigurationManager.ConnectionStrings["BubbleTeaConnectionString"].ConnectionString;
            LoadData();
        }
        private void LoadData()
        {
            GetData(lBoxBaseTea, "BaseTea");
            GetData(lBoxFlavors, "Flavors");
            GetData(lBoxToppings, "Toppings");
            LoadCustomerData(lBoxCustomers, "Customers");
        }

        private void LoadCustomerData(ListBox lbObj, string tableName)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    con.Open();
                    using (SqlCommand command = new SqlCommand("select * from " + tableName, con))
                    {
                        SqlDataAdapter adapter = new SqlDataAdapter(command);
                        DataSet ds = new DataSet();
                        adapter.Fill(ds, tableName);
                        lbObj.DataSource = ds.Tables[tableName];
                        lbObj.DisplayMember = "FirstName";
                        lbObj.ValueMember = "Id";
                    }
                    con.Close();
                }
            }
            catch (SystemException ex)
            {
                MessageBox.Show(string.Format("An error occurred: {0}", ex.Message));
            }
        }

        private void GetData(ListBox lbObj, string tableName)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    con.Open();
                    using (SqlCommand command = new SqlCommand("select * from " + tableName, con))
                    {
                        SqlDataAdapter adapter = new SqlDataAdapter(command);
                        DataSet ds = new DataSet();
                        adapter.Fill(ds, tableName);
                        lbObj.DataSource = ds.Tables[tableName];
                        lbObj.DisplayMember = "Name";
                        lbObj.ValueMember = "Id";
                    }
                    con.Close();
                }
            }
            catch (SystemException ex)
            {
                MessageBox.Show(string.Format("An error occurred: {0}", ex.Message));
            }
        }

        private void AddItem(ListBox lbObj, string tableName, string value)
        {

            try
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    con.Open();
                    String query = "INSERT INTO " + tableName + " (Name) VALUES (@name)";

                    using (SqlCommand command = new SqlCommand(query, con))
                    {
                        command.Parameters.AddWithValue("@name", value);
                        command.ExecuteNonQuery();
                    }
                    con.Close();
                }
            }
            catch (SystemException ex)
            {
                MessageBox.Show(string.Format("An error occurred: {0}", ex.Message));
            }
            LoadData();
        }
        private void RemoveItem(ListBox lbObj, string tableName)
        {
            string i = lbObj.GetItemText(lbObj.SelectedValue);

            try
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    con.Open();
                    using (SqlCommand command = new SqlCommand("delete from " + tableName + " where Id=" + i, con))
                    {
                        command.ExecuteNonQuery();
                    }
                    con.Close();
                }
            }
            catch (SystemException ex)
            {
                MessageBox.Show(string.Format("An error occurred: {0}", ex.Message));
            }
            LoadData();
        }

        private void btnRmvBt_Click(object sender, EventArgs e)
        {
            RemoveItem(lBoxBaseTea, "BaseTea");
        }

        private void btnRmvFlavors_Click(object sender, EventArgs e)
        {
            RemoveItem(lBoxFlavors, "Flavors");
        }

        private void btnRmvTop_Click(object sender, EventArgs e)
        {
            RemoveItem(lBoxToppings, "Toppings");
        }

        private void btnBTAdd_Click(object sender, EventArgs e)
        {
            AddItem(lBoxBaseTea, "BaseTea", txtBT.Text);
        }

        private void btnFlavorsAdd_Click(object sender, EventArgs e)
        {
            AddItem(lBoxFlavors, "Flavors", txtFlavors.Text);
        }

        private void btnToppinsAdd_Click(object sender, EventArgs e)
        {
            AddItem(lBoxToppings, "Toppings", txtToppins.Text);
        }

        private void btnCustomerSave_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    con.Open();
                    String query = "INSERT INTO Customers(FirstName, LastName, DOB) VALUES (@fname, @lname, @dob)";

                    using (SqlCommand command = new SqlCommand(query, con))
                    {
                        command.Parameters.AddWithValue("@fname", txtFName.Text);
                        command.Parameters.AddWithValue("@lname", txtLName.Text);
                        command.Parameters.AddWithValue("@dob", dobPicker.Value);
                        command.ExecuteNonQuery();
                    }
                    con.Close();
                }
            }
            catch (SystemException ex)
            {
                MessageBox.Show(string.Format("An error occurred: {0}", ex.Message));
            }
            LoadCustomerData(lBoxCustomers, "Customers");
        }

        private void btnRmvCustomers_Click(object sender, EventArgs e)
        {
            RemoveItem(lBoxCustomers, "Customers");
        }
    }
}
