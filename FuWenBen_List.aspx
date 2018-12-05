<%@ Page Language="C#" AutoEventWireup="true" validateRequest="false" CodeBehind="FuWenBen_List.aspx.cs" Inherits="WebPage.Page.FuWenBen.FuWenBen_List" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="../../Source/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="../../Source/lib/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
    <link href="../../Source/lib/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
    <script src="../../Source/lib/jquery/jquery-1.9.0.min.js" type="text/javascript"></script>
    <script src="../../Source/lib/ligerUI/js/core/base.js" type="text/javascript"></script>
    <script src="../../Source/lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script type="text/javascript" src="../../Source/lib/ligerUI/js/ligerui.all.js"></script>
    <script src="../../Common/js/LG.js"></script>
    <script src="../../Common/js/Jquery.Query.js"></script>
    <link href="../../Source/layui.css" rel="stylesheet" />
    <link href="../../Source/StyleLY.css" rel="stylesheet" />
    <script src="../../Common/common.js"></script>
    <link href="../../Common/LoadIng.css" rel="stylesheet" />
    <script src="../../Common/LoadIng.js"></script>
    <title></title>
</head>
<body>
    <div class="loading" style="">
        <div class="loadingtext">
            <img src="../../Common/img/loading.gif" />
        </div>
    </div>
    <div style="padding: 10px;">
        <div id="layout" style="margin-top: 5px;">
            <div position="top" id="head">
                <table width="100%">
                    <tr style="height: 50px;">
                        <td style="width: 80px; text-align: right;">
                            <label>名称：</label>
                        </td>
                        <td style="width: 150px">
                            <input type="text" id="helpmc" name="helpmc" class="inputxt" style="width: 120px; height: 23px;" />
                        </td>
                        <td>
                            <button class="layui-btn layui-btn-normal" style="height: 30px; background-color: #6794b1; width: 80px; line-height: 30px;" type="button" onclick="GetData()">
                                查询</button>
                            <button class="layui-btn layui-btn-normal" style="height: 30px; background-color: #6794b1; width: 80px; line-height: 30px;" type="button" onclick="AddData()">
                                添加</button>
                            <button class="layui-btn layui-btn-normal" style="height: 30px; background-color: #6794b1; width: 80px; line-height: 30px;" type="button" onclick="XiuGai()">
                                修改</button>
                            <button class="layui-btn layui-btn-normal" style="height: 30px; background-color: #6794b1; width: 80px; line-height: 30px;" type="button" onclick="Delete()">
                                删除</button>
                        </td>
                    </tr>
                </table>
            </div>
            <div position="center" id="maingrid" title="列表">
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var str = '<%=str %>';
        var urls = "<%=System.Web.Configuration.WebConfigurationManager.AppSettings["ShanFuUrl_LinShi"] %>";
        var htmlurls = "<%=System.Web.Configuration.WebConfigurationManager.AppSettings["HtmlUrls"] %>";
        var comids = session.GetSession("child_company_id");
        var supids = session.GetSession("super_company_id");

        var grid = $("#maingrid").ligerGrid({
            columns: [
                {
                    display: '序号', width: "60", align: "center",
                    render: function (result, rowindex) {
                        var pageindex = this.get("page");
                        var pagesize = this.get("pageSize");
                        return rowindex + 1 + ((pageindex - 1) * pagesize);
                    }
                },
                { display: 'id', name: 'id', width: 80 },
                { display: '名称', name: 'MingCheng', width: 230 },
                { display: '创建时间', name: 'ChuangJianShiJian', width: 150 },
                { display: '是否显示', name: 'ZhuangTai', width: 80 },
                {
                    display: '图标', width: 100,
                    render: function (result) {
                        var html = "";
                        if (result.TuBiao != "") {
                            html = " <img src='https://www.itss120.com" + result.TuBiao + "'  width='20' height='20' />";

                        } else {
                            html = "";
                        }
                        
                        return html;
                    }
                },
                {
                    display: '操作', name: 'XiuGaiShiJian', width: 160,
                    render: function (result, rowindex) {
                        var html = "";
                        if (result.YeMianDiZhi == "") {
                            html = "<a href='javascript:;'>查看</a>";
                        }
                        else {
                            if (htmlurls != "") {
                                html = "<a href='ChaKanYe.aspx?id=" + result.id + "' target='_blank'>查看</a>";
                            }
                            else {
                                html = "<a href='ChaKanYe.aspx?id=" + result.id + "' target='_blank'>查看</a>";
                            }
                        }
                        return html;
                    }
                }
            ],
            pageSize: 10,
            usePager: true,
            frozenRownumbers: false,
            frozenCheckbox: false,
            allowUnSelectRow: true,
            width: '99.5%',
            height: '99.5%',
            checkbox: false,
            pageSizeOptions: [10, 20]
        });
        //页面加载事件
        $(document).ready(function () {
            GetData();
        });
        //查询
        function GetData() {
            var name = $("#helpmc").val();
            $.ajax({
                type: "POST",
                url: urls + "api/FuWenBen/SelectAll",
                contentType: "application/json; charset=utf-8",
                processData: false,
                data: JSON.stringify({ "MingCheng": name, "LeiXing": str }),
                success: function (data) {
                    var dataone = { Rows: data.data };
                    grid.set("data", dataone);
                    grid.changePage("first");
                },
                error: function (data) {
                }
            });
        }
        //删除
        function Delete() {
            var selected = grid.getSelected();
            var id = selected.id;
            if (selected) {
                $.ajax({
                    type: "post",
                    url: urls + "api/FuWenBen/deleteData",
                    contentType: 'application/json',
                    data: JSON.stringify({ id: id }),
                    success: function (data, status) {
                        if (data.data == 1) {
                            LG.tip("删除成功！");
                            GetData();
                        }
                        else {
                            LG.tip(data.ErrorMsg);
                        }
                    },
                    error: function (data) {

                    }
                });
            }
            else {
                LG.tip('请选择行!');
            }
        }
        //修改操作
        function XiuGai() {
            var selected = grid.getSelected();
            $.query.empty();
            if (!selected) { LG.tip('请选择行!'); return; };
            var where = $.query.set("id", selected.id);
            $.ligerDialog.open({
                show: false,
                title: "修改标签",
                url: "cyxx_add.aspx" + where,
                width: 1050,
                height: 800,
                top: 50,
                showMax: true,
                buttons:
                [
                    { text: '提交', onclick: DataSave },
                    { text: '取消', onclick: DataCance }
                ]
            });
        }
        //新增数据
        function AddData() {
            $.ligerDialog.open({
                show: false,
                title: "新增标签",
                url: "cyxx_add.aspx?LeiXing=" + str,
                width: 1050,
                height: 800,
                top: 50,
                showMax: true,
                buttons:
                [
                    { text: '提交', onclick: DataSave },
                    { text: '取消', onclick: DataCance }
                ]
            });
        }
        //取消事件
        function DataCance(item, dialog) {
            dialog.close();
            GetData();
        }
        //调整高度
        function updateGridHeight() {
            var topHeight = $("#layout > .l-layout-center").height();
            var bottomHeight = $("#layout > .l-layout-bottom").height();
        }
        updateGridHeight();


        function DataSave(item, dialog) {
            var fn = dialog.frame.GetEditeData || dialog.frame.window.GetEditeData;
            var data = fn();
            if (!data) return;
            var formData = new FormData();
            debugger;
            formData.append("file", data.file);
            formData.append("id", data.id);
            formData.append("MingCheng", data.MingCheng);
            formData.append("ZhuangTai", data.ZhuangTai);
            formData.append("html", data.htmlData);
            formData.append("LeiXing", str);
            console.log(formData);
            $.ajax({
                type: "POST",
                url: urls + (data.IsAdded ? "api/FuWenBen/AddData" : "api/FuWenBen/UpdataData"),
                contentType: "application/json; charset=utf-8",
                contentType: false,
                processData: false,
                data: formData,
                success: function (data, status) {
                    console.log(data.Status)
                    console.log(data.data)
                    if (data.Status == "200") {
                        LG.tip(data.data);
                        dialog.close();
                    }
                    else {
                        LG.tip(data.ErrorMsg);
                        dialog.close();
                    }
                    GetData();
                },
                error: function (data) {
                    LG.tip(data);
                }
            })
        }


        
    </script>
</body>
</html>
