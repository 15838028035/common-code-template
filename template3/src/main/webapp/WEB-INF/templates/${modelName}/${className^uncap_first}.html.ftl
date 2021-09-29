<#assign className = table.className>   
<#assign classNameLower = className?uncap_first> 

<!DOCTYPE html>
<html xmlns:shiro="http://www.pollix.at/thymeleaf/shiro">
<head lang="en">
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="../../../assert/css/font.css"/>
    <link rel="stylesheet" href="../../../assert/css/bootstrap.min.css"/>
    <link href="../../../app/lib/jqwidgets-ver4.0.0/jqwidgets/styles/jqx.base.css" rel="stylesheet" type="text/css"/>
    <link href="../../../app/lib/jqwidgets-ver4.0.0/jqwidgets/styles/jqx.custom.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="../../../assert/css/index.css"/>
    <link href="../../../app/qTip2/jquery.qtip.min.css" rel="stylesheet" type="text/css"/>
    <style>
        body {
            min-width: 1200px;
        }

        .query-list .edit {
            width: 140px;
            top: -46px;
            left: 170px;
        }

        .query-list .edit li {
            margin-left: 10px;
        }

        .query-list .edit li:last-child, .query-list .edit li:nth-child(4) {
            padding: 6px;
        }

        .query-list .query > li input, select {
            width: 100px;
            height: 24px;
            line-height: 24px;
            color: #000;
        }

        .time-box label {
            float: left;
            font-weight: normal;
            position: relative;
            top: 5px;
        }

        .time-box div {
            float: left;
        }

        .time-box div input {
            top: -3px !important;
        }

        .dot {
            display: inline-block;
            width: 15px;
            height: 15px;
            border-radius: 50%;
        }

        .red {
            background: red;
        }

        .green {
            background: green;
        }

        .redRequired {
            color: red;
        }
    </style>
</head>
<body>
<!--提示框-->
<div id="prompt">
    <b>提示！</b>
    <p>请选择要编辑的行。</p>
</div>

<!--添加对话框-->
<div class="modal fade" id="${classNameLower}AddWindow" tabindex="-1" role="dialog"
     aria-labelledby="${classNameLower}AddWindowLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close"
                        data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="${classNameLower}AddWindowLabel">
                    新增${table.remarks}
                </h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="lanAddForm">
                    <div class="form-group">
                        <label class="col-sm-3 control-label"></label>
                        <div class="col-sm-8 redTip">
                                                                                                 有<span style="color: red">*</span>标记的是必填项
                        </div>
                    </div>
                    
               <#list table.columns as column>
             <#if column.listIsShow>
               <div class="form-group">
                    <label lass="col-sm-3 control-label" for="${column.columnNameLower}">${column.remarks}</label>
                 <#if column.isDateTimeColumn>
                  <div class="col-sm-8">
                    <input type="text" name="${column.columnNameLower}Begin" id = "${column.columnNameLower}Begin"  class="datetimepicker"  readonly="readonly"/>
                    <input type="text" name="${column.columnNameLower}End" id = "${column.columnNameLower}End"  class="datetimepicker"  readonly="readonly"/>
                  </div>
                <#elseif column.formShowType=='textarea'>
                    <textarea class="form-control" rows="3" name="${column.columnNameLower}" id="${column.columnNameLower}"></textarea>
                <#elseif column.formShowType=='select'>
                <div class="col-sm-8">
                                 <select name="${column.columnNameLower}" id="${column.columnNameLower}"  
                                        class="selectpicker show-tick form-control"  data-live-search="true" data-actions-box="true">
                                </select>
                </div>
                <#elseif column.formShowType=='radio'>
                <div class="col-sm-8"> <input type="radio" name="${column.columnNameLower}" id="${column.columnNameLower}" value=""></div>
                <#elseif column.formShowType=='file'>
                <div class="col-sm-8"><input type="file" name="${column.columnNameLower}" id="${column.columnNameLower}" value=""></div>
                <#elseif column.formShowType=='checkbox'>
               <div class="col-sm-8"> <input type="checkbox" name="${column.columnNameLower}" id="${column.columnNameLower}" value=""></div>
                <#elseif column.formShowType=='input'>
                   <div class="col-sm-8"> <input type="text" class="form-control" id="${column.columnNameLower}"></div>
                        
                </#if>
            </#if>
                <div class="redRequired">*</div>
             </div>
            </#list>

                    <div class="form-group">
                        <div align="center">
                            <button class="btn btn-default" type="button" data-dismiss="modal">取消</button>
                            <button id="${classNameLower}AddFormSubmitBtn" type="button" class="btn btn-primary">保存</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!--修改对话框-->
<div class="modal fade" id=""${classNameLower}EditWindow" tabindex="-1" role="dialog"
     aria-labelledby=""${classNameLower}EditWindowLabe" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close"
                        data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="dialectInfoEditWindowLabe">
                    编辑${table.remarks}
                </h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" id="lanEditForm">
                    <div class="form-group">
                        <label class="col-sm-3 control-label"></label>
                        <div class="col-sm-8 redTip">
                            有<span style="color: red">*</span>标记的是必填项
                        </div>
                    </div>
              <#list table.columns as column>
             <#if column.listIsShow>
               <div class="form-group">
                    <label lass="col-sm-3 control-label" for="${column.columnNameLower}_e">${column.remarks}</label>
                 <#if column.isDateTimeColumn>
                  <div class="col-sm-8">
                    <input type="text" name="${column.columnNameLower}Begin" id = "${column.columnNameLower}Begin"  class="datetimepicker"  readonly="readonly"/>
                    <input type="text" name="${column.columnNameLower}End" id = "${column.columnNameLower}End"  class="datetimepicker"  readonly="readonly"/>
                  </div>
                <#elseif column.formShowType=='textarea'>
                    <textarea class="form-control" rows="3" name="${column.columnNameLower}" id="${column.columnNameLower}_e"></textarea>
                <#elseif column.formShowType=='select'>
                <div class="col-sm-8">
                                 <select name="${column.columnNameLower}" id="${column.columnNameLower}_e"  
                                        class="selectpicker show-tick form-control"  data-live-search="true" data-actions-box="true">
                                </select>
                </div>
                <#elseif column.formShowType=='radio'>
                <div class="col-sm-8"> <input type="radio" name="${column.columnNameLower}" id="${column.columnNameLower}_e" value=""></div>
                <#elseif column.formShowType=='file'>
                <div class="col-sm-8"><input type="file" name="${column.columnNameLower}" id="${column.columnNameLower}_e" value=""></div>
                <#elseif column.formShowType=='checkbox'>
               <div class="col-sm-8"> <input type="checkbox" name="${column.columnNameLower}" id="${column.columnNameLower}_e" value=""></div>
                <#elseif column.formShowType=='input'>
                   <div class="col-sm-8"> <input type="text" class="form-control" id="${column.columnNameLower}_e"></div>
                        
                </#if>
            </#if>
                <div class="redRequired">*</div>
             </div>
            </#list>
            
                    <div class="form-group">
                        <div align="center">
                            <button class="btn btn-default" type="button" data-dismiss="modal">取消</button>
                            <button id=""${classNameLower}FormSubmitBtn" type="button" class="btn btn-primary">修改</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!--删除对话框-->
<div class="modal fade" id="${classNameLower}DeleteWindow" tabindex="-1" role="dialog"
     aria-labelledby="${classNameLower}DeleteWindowLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="${classNameLower}DeleteWindowLabel">删除${table.remarks}</h4>
            </div>
            <div class="modal-body">
                <div style="max-width: 100%;" align="center">
                    <span class="glyphicon glyphicon-question-sign"></span>&nbsp;确定要删除${table.remarks}吗？
                </div>
            </div>
            <div class="modal-footer">
                <div align="center">
                    <button class="btn btn-default" type="button" data-dismiss="modal">取消</button>
                    <button id="languageture" type="button" class="btn btn-primary">确定</button>
                </div>
            </div>
        </div>
    </div>
</div>

<!--工具栏-->
<div class="hidden">
    <div class="query-list">
        <ul class="edit">
            <shiro:hasPermission name="${classNameLower}_add">
                <li class="fa fa-plus" data-toggle="modal" data-target="#${classNameLower}AddWindow" title="添加方言信息"></li>
            </shiro:hasPermission>
            <shiro:hasPermission name="${classNameLower}_update">
                <li class="fa fa-pencil" id="editBut" title="修改信息"></li>
            </shiro:hasPermission>
            <shiro:hasPermission name="${classNameLower}_delete">
                <li class="fa fa-close" id="deleteBut" title="删除信息"></li>
            </shiro:hasPermission>
            <li class="fa fa-refresh" title="刷新"></li>
        </ul>
        <ul class="query">
            <#list table.columns as column>
             <li>${column.remarks}：
                <input type="text" placeholder="${column.remarks}" id="${column.columnNameLower}Search"/>
            </li>
                        
            </#list>
            
            <li class="time-box">
                <label>修改时间： </label>
                <div id="beginTime"></div>
                <label>-</label>
                <div id="endTime"></div>
            </li>
            
            <li>
                <button class="fa fa-search" id="${classNameLower}Search" title="查询"></button>
            </li>
            <li>
                <button id="moreResetAndSearch">重置</button>
            </li>
        </ul>
        <ul class="last">
            <li>
                <button title="分页切换" id="pageModeBtn" class="btn fa fa-expand"
                        onclick="bs.tooglePageMode('.table-box');"></button>
            </li>
        </ul>
    </div>
</div>
<div class="main-table">
    <div class="table-box" id="table-box"></div>
</div>

<script src="../../../assert/js/jquery.js"></script>
<script src="../../../assert/js/ajaxfileupload.js"></script>
<script src="../../../assert/js/bootstrap.min.js"></script>
<script src="../../../assert/js/changeTime.js"></script>
<script src="../../../app/lib/jqwidgets-ver4.0.0/jqwidgets/jqx-all.js"></script>
<script src="../../../app/lib/jqwidgets-ver4.0.0/jqwidgets/localization.js" type="text/javascript"></script>
<script src="../../../app/lib/jqwidgets-ver4.0.0/jqwidgets/globalization/globalize.js" type="text/javascript"></script>
<script src="../../../app/lib/jqwidgets-ver4.0.0/jqwidgets/globalization/globalize.culture.zh-CN.js"
        type="text/javascript"></script>
<script src="../../../app/js/base.js"></script>
<script src="../../../app/js/path.jsp"></script>
<script src="../../../app/qTip2/jquery.qtip.min.js"></script>
<script src="../../../assert/js/jquery-ui.min.js"></script>
<!--用户拖动元素，链接：http://api.jqueryui.com/draggable/#method-disable/-->
<script>

    var mytable = {

        validateParam: null,

        queryParam: null,

        initTable: function () {
            //渲染表格
            var url = basePath + "rest/${classNameLower}Controller/${classNameLower}Search";
            var source = {
                dataType: "json",
                dataFields: [
                    <#list table.columns as column>
                    <#if column.listColumnIsShow>
                    {name:'${column.sqlName}'}<#if column_has_next>,</#if>
                    </#if>
                     </#list>
             
                ],
                root: "content",
                url: url
            };
            var dataAdapter = new $.jqx.dataAdapter(source, {
                formatData: function (data) {
                    var param = {
                       dialectname: $("#dialectnameSearch").val(),
                        beginTime: $("#beginTime").val(),
                        endTime: $("#endTime").val()
                    };
                    $.extend(data, param);
                    mytable.queryParam = data;
                    return data;
                },
                downloadComplete: function (data, status, xhr) {
                    source.totalRecords = data.page.totalCount;
                }
            });
            $("#table-box").jqxDataTable({
                width: "100%",
                height: "100%",
                pageable: true,
                pageSize: 20,
                pagerMode: "advanced",
                pagerButtonsCount: 5,
                pageSizeOptions: ["10","20", "40", "60", "80", "100"],
                sortable: true,
                source: dataAdapter,
                showToolbar: true,
                serverProcessing: true,
                altRows: true,
                columnsResize: true,
                renderToolbar: function (toolbar) {
                    var toolBarAppendItems = $('.query-list');
                    toolbar.append(toolBarAppendItems);
                },
                columns: [
                    {
                        text: '编号', dataField: 'auto', width: 40,sortable: false,
                        cellsRenderer: function (row, column, value, rowData) {
                            var pagenum = mytable.queryParam.pagenum;
                            var pagesize = mytable.queryParam.pagesize;
                            var st = pagenum * pagesize;
                            return (st + row + 1) + "";
                        }
                    },
                     <#list table.columns as column>
                    <#if column.listColumnIsShow>
                    {dataField:'${column.sqlName}',text:'${column.remarks}', width: 'auto', hidden: true}<#if column_has_next>,</#if>
                    </#if>
             </#list>
                ],
                localization: Local.getLocalization()
                , rendered: function () {
                    //找到设置表格行数那个下拉框，使下拉框的宽度自增20
                    var drop = $("#dropdownlistContentgridpagerlistbottom" + "table-box");
                    drop.width(drop.width() + 20);
                }
            });
            $("#table-box").find("div").css("word-wrap", "break-word");//表格中的字段长度过长时自动换行显示
        },

        refresh: function () {
            $("#table-box").jqxDataTable("updateBoundData");
        }

    };

    var ${classNameLower}Add = {

        init: function () {

            this.initKeyValidator();

            this.initSave();

            $("#${classNameLower}AddWindow").on('hidden.bs.modal', function (e) {
                ${classNameLower}Add.hideHints();
            });

        },// end spAdd.init

        //隐藏form的警告提示
        hideHints: function () {
            var form = $("#lanAddForm");
            form.jqxValidator('hideHint', "#dialectname");
        },// end keyAdd.hideHints

        initKeyValidator: function () {

            $("#${classNameLower}AddForm").jqxValidator({
                focus: false,
                rules: [
                    {
                        input: '#dialectname',
                        message: "方言名称并不能为空!",
                        action: 'keyup,blur',
                        rule: 'required'
                    },
                    {
                        input: '#dialectname',
                        message: "不能为空"
                    }
                ],
                hintType: "label"
            });
        },

        initSave: function () {

            $("#${classNameLower}AddFormSubmitBtn").unbind().on("click", function () {
                $("#${classNameLower}AddForm").jqxValidator("validate");
            });

            $("#lanAddForm").on("validationSuccess", function (event) {
                var data = $('#lanAddForm').serialize();
                var url = basePath + "rest/${classNameLower}Controller/save";
                $.post(url, data, function (result) {
                    $("#${classNameLower}AddWindow").modal('hide');
                    $("#lanAddForm")[0].reset();
                    if (result.success) {
                        parent.tip.showRightTop("添加成功！");
                        mytable.refresh();
                    } else {
                        parent.tip.showRightTop("添加失败！", 'error');
                    }
                });
            });
        }
    };

    var ${classNameLower}Edit = {

        init: function () {

            this.initKeyValidator();

            this.initSave();

        },// end spAdd.init

        initKeyValidator: function () {

            $("#${classNameLower}EditForm").jqxValidator({
                focus: false,
                rules: [
                    {
                        input: '#dialectname_e',
                        message: "方言名称并不能为空!",
                        action: 'keyup,blur',
                        rule: 'required'
                    },
                   {
                        input: '#dialectname_e',
                        message: "方言名称已经存在!"
                    } 
                ],
                hintType: "label"
            });
        },

        initSave: function () {

            $('#editBut').unbind().on("click", function () {
                var selection = $("#table-box").jqxDataTable('getSelection');
                if (selection.length === 0) {
                    parent.tip.showRightTop("请勾选要修改的行！", 'error');
                    return;
                } else if (selection.length > 1) {
                    parent.tip.showRightTop("请选择一行进行修改！", 'error');
                    return;
                } else {
                    var rowData = selection[0];
                    bs.loadFormData($('#${classNameLower}EditForm'), rowData);
                    $('#dialectInfoEditWindow').modal('show');
                }
            });

            $("#${classNameLower}EditFormSubmitBtn").unbind().on("click", function () {
                $("#${classNameLower}EditForm").jqxValidator("validate");
            });

            $("#lanEditForm").on("validationSuccess", function (event) {
                var data = $('#lanEditForm').serialize();
                var url = basePath + "rest/${classNameLower}Controller/update";
                $.post(url, data, function (result) {
                    $("#${classNameLower}EditWindow").modal('hide');
                    if (result.success) {
                        parent.tip.showRightTop("修改成功！");
                        mytable.refresh();
                    } else {
                        parent.tip.showRightTop("修改失败！", 'error');
                    }
                });
            });

        }

    };

    var ${classNameLower}Del = {

        init: function () {

            this.initVaidator();

            this.initDel();

        },

        initVaidator: function () {

            $('#deleteBut').unbind().on("click", function () {
                var selection = $("#table-box").jqxDataTable('getSelection');
                if (selection.length === 0) {
                    parent.tip.showRightTop("请选择要删除的记录！", 'error');
                    return false;
                } else {
                    bs.loadFormData($('#dialectInfoDeleteWindow'));
                    $('#${classNameLower}DeleteWindow').modal('show');
                }
            });

        },

        initDel: function () {

            $('#languageture').unbind().on("click", function () {
                var selection = $("#table-box").jqxDataTable('getSelection');
                var ids;
                for (var i = 0; i < selection.length; i++) {
                    if (i === 0) {
                        ids = selection[i].id;
                    } else {
                        ids = ids + ',' + selection[i].id;
                    }
                }
                var url = basePath + "rest/${classNameLower}Controller/delete";
                var data = {
                    id: ids
                };
                $.post(url, data, function (msg) {
                    $('#dialectInfoDeleteWindow').modal('hide');
                    mytable.refresh();
                });
            });

        }

    };

    var addQtip = {
        init: function () {
            this.addLiQtip();
            this.addBtnQtip();
        },
        addLiQtip: function () {
            $(".query-list li").each(function () {
                var title = $(this).attr("title");
                if (title) {
                    bs.addQtip($(this), title, 'top left', 'yellow');
                }
            });
        },
        addBtnQtip: function () {
            $(".query-list button").each(function () {
                var title = $(this).attr("title");
                if (title) {
                    bs.addQtip($(this), title, 'top right', 'yellow');
                }
            });
        }
    };

    var draggables = {
        init: function () {
            draggable($('#${classNameLower}AddWindow'));
            draggable($('#${classNameLower}EditWindow'));
            draggable($('#${classNameLower}oDeleteWindow'));
        }
    };

    $(function () {
        //初始化
        $(".main-table").height($(window).height() - 2);
        $(window).resize(function () {
            $(".main-table").height($(window).height() - 2);
        });
        mytable.initTable();
        ${classNameLower}Add.init();
        ${classNameLower}Edit.init();
        ${classNameLower}Del.init();
        addQtip.init();
        draggables.init();

        //刷新按钮点击事件
        $(".fa-refresh, #dialectInfoSearch").click(function () {
            mytable.refresh();
        });

        //分页切换按钮图标切换
        $('#pageModeBtn').click(function () {
            var classType = $(this).attr("class");
            if (classType === "btn fa fa-expand") {
                $(this).attr("class", "btn fa fa-compress");
            } else {
                $(this).attr("class", "btn fa fa-expand");
            }
        });

        //input边框阴影样式
        $("input").on("focus", function () {
            $(this).css({"-webkit-box-shadow": "0 0 5px #006633"});
        }).on("blur", function () {
            $(this).css({"-webkit-box-shadow": "0 0 5px #fff"});
        });

        //日历
        $("#beginTime").jqxDateTimeInput({
            formatString: "yyyy-MM-dd",
            value: null,
            showTimeButton: false,
            culture: "zh-CN",
            dayNameFormat: "shortest",
            readonly: true,
            showFooter: true,
            clearString: "清空",
            todayString: "今天",
            width: '100px',
            height: '22px'
        }).on('valueChanged', function (event) {
            var jsDate = event.args.date;
            if (jsDate)
                $("#endTime").jqxDateTimeInput({min: jsDate});
            else
                $("#endTime").jqxDateTimeInput({min: "1978/08/01"});
        });

        $("#endTime").jqxDateTimeInput({
            formatString: "yyyy-MM-dd",
            value: null,
            showTimeButton: false,
            culture: "zh-CN",
            dayNameFormat: "shortest",
            readonly: true,
            showFooter: true,
            clearString: "清空",
            todayString: "今天",
            width: '100px',
            height: '22px'
        }).on('valueChanged', function (event) {
            var jsDate = event.args.date;
            if (jsDate)
                $("#beginTime").jqxDateTimeInput({max: jsDate});
            else
                $("#beginTime").jqxDateTimeInput({max: "2320/12/31"});
        });
        $("#moreResetAndSearch").click(function () {
            $("#moreResetAndSearch").val("");
            $("#beginTime").val("");
            $("#endTime").val("");
            mytable.refresh();
        });
    });

    function draggable(obj) {
        $(obj).draggable();
    }

</script>
</body>
</html>
