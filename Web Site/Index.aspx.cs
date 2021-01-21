using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web_Site
{
    public partial class Index : System.Web.UI.Page
    {
        string conStr = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            conStr = System.Configuration.ConfigurationManager.ConnectionStrings["BubbleTeaConnectionString"].ConnectionString;
        }
        private void AddItem()
        {

            try
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    con.Open();
                    String query = "INSERT INTO Orders (Size, Base, Tea, Toppings, Price) VALUES (@Size, @Base, @Tea, @Toppings, @Price)";

                    using (SqlCommand command = new SqlCommand(query, con))
                    {
                        command.Parameters.AddWithValue("@Size", rdbSize.SelectedValue);
                        command.Parameters.AddWithValue("@Base", ddlBaseTea.SelectedItem.Text);
                        command.Parameters.AddWithValue("@Tea", ddlFlavor.SelectedItem.Text);

                        int numSelected = 0;
                        foreach (ListItem li in chkListToppings.Items)
                        {
                            if (li.Selected)
                            {
                                numSelected++;
                            }
                        }


                        command.Parameters.AddWithValue("@Toppings", "(" + numSelected.ToString()+") Toppings");
                        command.Parameters.AddWithValue("@Price", Decimal.Parse(hddCost.Value));
                        command.ExecuteNonQuery();
                    }
                    con.Close();
                }
            }
            catch (SystemException ex)
            {
            }
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            AddItem();
            GridView1.DataBind();
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                for (int i = 0; i < GridView1.HeaderRow.Cells.Count; i++)
                {
                    string strHeader = GridView1.HeaderRow.Cells[i].Text;
                    if (strHeader.ToString() == "Price")
                    {
                     //   e.Row.Cells[i].Text = "$"+e.Row.Cells[i].Text;
                    }
                }
            }
        }
    }
}