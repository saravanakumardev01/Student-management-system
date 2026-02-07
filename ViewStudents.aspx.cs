using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace student_Management
{
    public partial class ViewStudents : System.Web.UI.Page
    {
        string conStr =
            "Data Source=DESKTOP-0A8E9N0\\SQLEXPRESS;Initial Catalog=StudentSystemDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] == null)
            {
                Response.Redirect("AdminLogin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadAllStudents();
            }
        }


        private void LoadAllStudents()
        {
            using (SqlConnection con = new SqlConnection(conStr))
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM Students", con))
            {
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvStudents.DataSource = dt;
                gvStudents.DataBind();
            }
        }


        protected void gvStudents_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditStudent")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int id = Convert.ToInt32(gvStudents.DataKeys[index].Value);

                Response.Redirect("AddStudent.aspx?StudentId=" + id);
            }
        }


        protected void gvStudents_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvStudents.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(conStr))
            using (SqlCommand cmd =
                new SqlCommand("DELETE FROM Students WHERE StudentId=@Id", con))
            {
                cmd.Parameters.AddWithValue("@Id", id);
                con.Open();
                cmd.ExecuteNonQuery();
            }

            LoadAllStudents();
        }


        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddStudent.aspx");
        }


        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("AdminLogin.aspx");
        }
    }
}