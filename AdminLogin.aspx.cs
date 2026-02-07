using System;
using System.Data;
using System.Data.SqlClient;

namespace student_Management
{
    public partial class AdminLogin : System.Web.UI.Page
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
                !string.Equals(txtCaptcha.Text.Trim(),
                Session["captcha"].ToString(),
                StringComparison.OrdinalIgnoreCase))
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "alert",
                    "alert('Invalid Captcha');",
                    true);

                GenerateCaptcha();
                txtCaptcha.Text = "";
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(conStr))
                using (SqlCommand cmd = new SqlCommand("sp_AdminLogin", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
                    cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());

                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        Session["admin"] = dr["Username"].ToString();
                        Response.Redirect("AddStudent.aspx");
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(
                            this.GetType(),
                            "alert",
                            "alert('Invalid Username or Password');",
                            true);

                        GenerateCaptcha();
                        txtCaptcha.Text = "";
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "alert",
                    "alert('" + ex.Message.Replace("'", "") + "');",
                    true);
            }
        }


        protected void btnBackHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }
    }
}