<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cyxx_add.aspx.cs" Inherits="ChanYeZhengCe_cyxx_add" %>

<%@ Register Assembly="FredCK.FCKeditorV2" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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
    <style type="text/css">
        .fuText {
            width:100%;color:#333;font-size:18px;background-color:#fff;
        }
        select {
          width:195px;height:30px;border-radius:4px;
        }
        .btn {
          width:120px;heigth:36px;color:#fff;background-color:#217fce;border-radius:6px;text-align:center;margin:20px auto;
        }
        .txtRight {
          text-align:right;
        }
        table {
         width:100%;
        }
        td{
          line-heigth:38px;
        }
        input {
         height:30px;line-height:28px;padding:0 12px;border:#ccc solid 1px;border-radius:4px;box-sizing:border-box;
         color:#333;
        }
    </style>
</head>
<body style="background-color:#fff;">
    <form id="form1" runat="server">
    <div class="fuText">
        <table>
            
            <%--<tr>
                <td width="45%" class="txtRight">
                    类型 ：
                </td>
                <td>
                    <asp:Label ID="lblLX" runat="server" Text="产业信息"></asp:Label>
                </td>

            </tr>--%>
            <tr>
                <td width="45%" class="txtRight">
                    标题 ：
                </td>
                <td>
                    <asp:TextBox ID="BiaoTi" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr style="height: 20px;"> 
                
                <td  width="45%" class="txtRight"> 是否显示：</td>
                    <td>
                    <select id="ZhuangTai">
                        <option value="是">是</option>
                        <option value="否">否</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td  width="45%" class="txtRight">图标：</td>
                <td >
                    <div id="file-pretty">
                        <div>
                            <label class="font-noraml"></label>
                            <input type="file" class="form-control" name="uploadFile" id="uploadFile"<%-- onchange="tubiao_change()"--%> />
                            <input type="image" id="image_chakan"/>
                        </div>
                    </div>
                    
                </td>
            </tr>
        </table>
        <div style="width:1024px;margin:auto;">
             <script id="editor"  name="editor"  type="text/plain" style="width:780px;height:500px; margin-left: 100px;"></script>
        </div>
    </div>
    </form>
    <script type="text/javascript">
        var ue = UE.getEditor('editor');
    </script>
    <script type="text/javascript">
        var urls = "<%=System.Web.Configuration.WebConfigurationManager.AppSettings["ShanFuUrl_LinShi"] %>";
        var id = $.query.get("id");
        //alert(id)
        //是否新增状态
        var isAddNew = "" == id || "0" == id || null == id;
        $("#image_chakan").hide();
        $(function () {
            if (isAddNew) {
            }
            else {
                $.ajax({
                    type: "post",
                    url: urls + "api/FuWenBen/SelectAll",
                    dataType: "json",
                    async: false,
                    data: JSON.stringify({ 'id': id }),
                    contentType: "application/json",
                    success: function (data) {
                        ObjectToForm(data.data[0]);
                    },
                    error: function (data) {

                    }
                });
            }
        })
        //function tubiao_change()
        //{
        //    $("#image_chakan").show();
        //    var objUrl = getObjectURL(document.getElementById("uploadFile").files[0]);//获取文件信息 
        //    console.log("objUrl = " + objUrl);
        //    if (objUrl) {
        //        $("#image_chakan").attr("src", "https://www.itss120.com"+objUrl);
        //    }
        //}
        
        //function getObjectURL(file) {  
        //    var url = null;   
        //    if (window.createObjectURL!=undefined) {  
        //        url = window.createObjectURL(file) ;  
        //    } else if (window.URL!=undefined) { // mozilla(firefox)  
        //        url = window.URL.createObjectURL(file) ;  
        //    } else if (window.webkitURL!=undefined) { // webkit or chrome  
        //        url = window.webkitURL.createObjectURL(file) ;  
        //    }  
        //    return url ;  
        //}  


        function ObjectToForm(data) {
            $("#image_chakan").show();
            id = data.id;
            $("#BiaoTi").val(data.MingCheng);
            $("#ZhuangTai").val(data.ZhuangTai);
            ue.addListener("ready", function () {
                // editor准备好之后才可以使用
                ue.setContent(data.html_item);
            });
            if (data.TuBiao != "") {
                $("#image_chakan").attr("src", "https://www.itss120.com" + data.TuBiao);
            } else {
                $("#image_chakan").hide();
            }
            
            return;
        }

        //Web表单到对象绑定
        function FormToObject() {
            debugger;
            var dataObject = null || {};
            dataObject.IsAdded = isAddNew;
            dataObject.id = id;

            dataObject.file = document.getElementById("uploadFile").files[0];

            var bt = $("#BiaoTi").val().trim();
            if (bt == "") {
                LG.tip("请填写标题！");
                return;
            }
            dataObject.MingCheng = bt;
            
            var zt = $("#ZhuangTai").val();
            dataObject.ZhuangTai = zt;

            dataObject.htmlData = ue.getContent();
            //dataObject.YeMianDiZhi = $("#htmlurl").val();
            dataObject.file = document.getElementById("uploadFile").files[0];
            return dataObject;
        }

        function GetEditeData() {
            return FormToObject();
        }
    </script>
</body>
</html>
