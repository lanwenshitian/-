using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebPage.Page.FuWenBen
{
    public partial class FuWenBen_List : System.Web.UI.Page
    {
        public string str;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                ///要求在使用时传数字
                str = Request.QueryString["LeiXing"].ToString();
            }
            catch
            {
                str = "";
            }
        }
    }
}