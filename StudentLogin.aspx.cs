using System;
using System.Data.SqlClient;

namespace student_Management
{
    public partial class StudentLogin : System.Web.UI.Page
    {
        string conStr =
            "Data Source=DESKTOP-0A8E9N0\\SQLEXPRESS;Initial Catalog=StudentSystemDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GenerateCaptcha();
            }
        }

        private void GenerateCaptcha()
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            Random r = new Random();
            string captcha = "";

            for (int i = 0; i < 6; i++)
                captcha += chars[r.Next(chars.Length)];

            lblCaptcha.Text = captcha;
            Session["captcha"] = captcha;
        }

        protected void lnkRefreshCaptcha_Click(object sender, EventArgs e)
        {
            GenerateCaptcha();
            txtCaptcha.Text = "";
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Session["captcha"] == null ||
                !string.Equals(
                    txtCaptcha.Text.Trim(),
                    Session["captcha"].ToString(),
                    StringComparison.OrdinalIgnoreCase))
            {
                Response.Write("<script>alert('Invalid Captcha');</script>");
                GenerateCaptcha();
                txtCaptcha.Text = "";
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(conStr))
                using (SqlCommand cmd = new SqlCommand(
                    "SELECT StudentId, Name FROM Students WHERE Email=@Email AND Password=@Password", con))
                {
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());

                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        Session["studentId"] = dr["StudentId"].ToString();
                        Session["studentName"] = dr["Name"].ToString();
                        Response.Redirect("StudentDashboard.aspx");
                    }
                    else
                    {
                        Response.Write("<script>alert('Invalid Email or Password');</script>");
                        GenerateCaptcha();
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message.Replace("'", "") + "');</script>");
            }
        }


        protected void btnBackHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }
    }
}