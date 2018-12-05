<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChaKanYe.aspx.cs" Inherits="WebPage.Page.FuWenBen.ChaKanYe" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" charset="utf-8"  src="utf8-net/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8"  src="utf8-net/ueditor.all.min.js"></script>
    <script type="text/javascript" charset="utf-8"  src="utf8-net/lang/zh-cn/zh-cn.js"></script>
    <link href="../../Source/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../Source/lib/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
    <link href="../../Source/lib/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
    <script src="../../Source/lib/jquery/jquery-1.9.0.min.js" type="text/javascript"></script>
    <script src="../../Source/lib/ligerUI/js/core/base.js" type="text/javascript"></script>
    <script src="../../Source/lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script type="text/javascript" src="../../Source/lib/ligerUI/js/ligerui.all.js"></script>
    <script src="../../Source/lib/ligerUI/js/plugins/ligerCheckBox.js"></script>
    <script src="../../Source/lib/ligerUI/js/plugins/ligerResizable.js"></script>
    <script src="../../Source/lib/ligerUI/js/plugins/ligerCheckBoxList.js"></script>
    <script src="../../Source/lib/ligerUI/js/plugins/ligerRadioList.js"></script>
    <script src="../../Source/lib/ligerUI/js/plugins/ligerListBox.js"></script>
    <script type="text/javascript" src="../../Common/js/LG.js"></script>
    <script type="text/javascript" src="../../Common/js/Jquery.Query.js"></script>
    <link href="../../Source/select2/select2.min.css" rel="stylesheet" />
    <script src="../../Source/select2/select2.min.js"></script>
    <script src="../../Common/js/ligerComboBox.js"></script>
    <script src="../../Common/common.js"></script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
            
    </form>
</body>
</html>
<script  type="text/javascript">
    var urls = "<%=System.Web.Configuration.WebConfigurationManager.AppSettings["ShanFuUrl_LinShi"] %>";
    var id = $.query.get("id");
    $.ajax({
        type: "POST",
        url: urls + "api/FuWenBen/SelectAll",
        contentType: "application/json; charset=utf-8",
        processData: false,
        data: JSON.stringify({ "id": id }),
        success: function (data) {
            console.log(data.data)
            $("#form1").html(data.data[0].html_item)
        },
        error: function (data) {
        }
    });
</script>
