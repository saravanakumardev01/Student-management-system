using System;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace student_Management
{
    public partial class AddStudent : System.Web.UI.Page
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

            if (!IsPostBack && Request.QueryString["StudentId"] != null)
            {
                int id = Convert.ToInt32(Request.QueryString["StudentId"]);
                LoadStudent(id);
                btnSave.Text = "Update";
            }
        }

        private void LoadStudent(int id)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            using (SqlCommand cmd =
                new SqlCommand("SELECT * FROM Students WHERE StudentId=@Id", con))
            {
                cmd.Parameters.AddWithValue("@Id", id);
                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtName.Text = dr["Name"].ToString();
                    txtEmail.Text = dr["Email"].ToString();
                    txtPassword.Text = dr["Password"].ToString();
                    txtDOB.Text = Convert.ToDateTime(dr["DOB"]).ToString("yyyy-MM-dd");
                    txtRoll.Text = dr["RollNo"].ToString();
                    ddlState.SelectedValue = dr["State"].ToString();
                    txtMobile.Text = dr["Mobile"].ToString();
                    txtTotalFee.Text = dr["TotalFee"].ToString();
                    txtPaidFee.Text = dr["PaidFee"].ToString();
                    rblGender.SelectedValue = dr["Gender"].ToString();

                    string[] courses = dr["Department"].ToString().Split(',');
                    foreach (string c in courses)
                        foreach (ListItem li in cblCourse.Items)
                            if (li.Text.Trim() == c.Trim())
                                li.Selected = true;
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            decimal totalFee = Convert.ToDecimal(txtTotalFee.Text);
            decimal paidFee = Convert.ToDecimal(txtPaidFee.Text);

            if (paidFee > totalFee)
            {
                Show("Paid fee cannot be greater than total fee");
                return;
            }

            string courses = "";
            foreach (ListItem li in cblCourse.Items)
                if (li.Selected) courses += li.Text + ", ";
            courses = courses.TrimEnd(',', ' ');

            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();

                if (Request.QueryString["StudentId"] == null)
                {
                    SqlCommand cmd = new SqlCommand(
                        @"INSERT INTO Students
                          (Name,Email,Password,DOB,Gender,Department,RollNo,State,
                           Mobile,TotalFee,PaidFee)
                          VALUES
                          (@Name,@Email,@Password,@DOB,@Gender,@Dept,@Roll,@State,
                           @Mobile,@Total,@Paid)", con);

                    AddParams(cmd, courses);
                    cmd.ExecuteNonQuery();
                    Show("Student added successfully");
                }
                else
                {
                    SqlCommand cmd = new SqlCommand(
                        @"UPDATE Students SET
                          Name=@Name, Email=@Email, Password=@Password, DOB=@DOB,
                          Gender=@Gender, Department=@Dept, RollNo=@Roll,
                          State=@State, Mobile=@Mobile,
                          TotalFee=@Total, PaidFee=@Paid
                          WHERE StudentId=@Id", con);

                    AddParams(cmd, courses);
                    cmd.Parameters.AddWithValue("@Id",
                        Convert.ToInt32(Request.QueryString["StudentId"]));

                    cmd.ExecuteNonQuery();
                    Show("Student updated successfully");
                }
            }
        }

        private void AddParams(SqlCommand cmd, string courses)
        {
            cmd.Parameters.AddWithValue("@Name", txtName.Text);
            cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
            cmd.Parameters.AddWithValue("@Password", txtPassword.Text);
            cmd.Parameters.AddWithValue("@DOB", txtDOB.Text);
            cmd.Parameters.AddWithValue("@Gender", rblGender.SelectedValue);
            cmd.Parameters.AddWithValue("@Dept", courses);
            cmd.Parameters.AddWithValue("@Roll", txtRoll.Text);
            cmd.Parameters.AddWithValue("@State", ddlState.SelectedValue);
            cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text);
            cmd.Parameters.AddWithValue("@Total", txtTotalFee.Text);
            cmd.Parameters.AddWithValue("@Paid", txtPaidFee.Text);
        }

        // ✅ ROLL NUMBER DUPLICATE VALIDATION (UNCHANGED)
        protected void cvRollDuplicate_ServerValidate(object source, ServerValidateEventArgs args)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd;

                if (Request.QueryString["StudentId"] == null)
                {
                    cmd = new SqlCommand(
                        "SELECT COUNT(*) FROM Students WHERE RollNo=@Roll", con);
                }
                else
                {
                    cmd = new SqlCommand(
                        "SELECT COUNT(*) FROM Students WHERE RollNo=@Roll AND StudentId<>@Id", con);
                    cmd.Parameters.AddWithValue("@Id",
                        Convert.ToInt32(Request.QueryString["StudentId"]));
                }

                cmd.Parameters.AddWithValue("@Roll", txtRoll.Text.Trim());

                con.Open();
                int count = (int)cmd.ExecuteScalar();

                args.IsValid = (count == 0);
            }
        }

        // ✅ DOB AGE VALIDATION (ONLY NEW METHOD ADDED)
        protected void cvDOB_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DateTime dob;
            if (DateTime.TryParse(txtDOB.Text, out dob))
            {
                DateTime today = DateTime.Today;
                int age = today.Year - dob.Year;

                if (dob > today.AddYears(-age))
                    age--;

                args.IsValid = age >= 18;
            }
            else
            {
                args.IsValid = false;
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddStudent.aspx");
        }

        protected void btnViewStudents_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewStudents.aspx");
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }

        private void Show(string msg)
        {
            ClientScript.RegisterStartupScript(
                this.GetType(), "a", $"alert('{msg}');", true);
        }
    }
}