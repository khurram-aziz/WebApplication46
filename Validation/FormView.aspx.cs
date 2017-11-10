using System;
using WebApplication.Models;

namespace WebApplication.Validation
{
    public partial class FormView : System.Web.UI.Page
    {
        public UserModel GetUser()
        {
            return new UserModel();
        }

        public void AddUser(UserModel user)
        {
            this.TryUpdateModel(user);
            if (this.ModelState.IsValid)
            {
                //save
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }
    }
}