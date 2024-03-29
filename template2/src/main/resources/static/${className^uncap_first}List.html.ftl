<#assign className = table.className>   
<#assign classNameLower = className?uncap_first> 

<!DOCTYPE html>
<html>
<head>
<title>${table.remarks}管理</title>
   <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!--css样式-->
    <link href="scripts/bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="scripts/bootstrap-table/bootstrap-table.css" rel="stylesheet">
    <!--js-->

    <script src="scripts/jquery/jquery-3.2.0.min.js"></script>
    <script src="scripts/bootstrap/js/bootstrap.js"></script>
    <script src="scripts/bootstrap-table/bootstrap-table.js"></script>
    <script src="scripts/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
    <script src="scripts/bootstrap-table/extensions/multiple-sort/bootstrap-table-multiple-sort.js"></script>

    <link href="scripts/x-editable/bootstrap3-editable/css/bootstrap-editable.css" rel="stylesheet">
    <script src="scripts/bootstrap-table/extensions/editable/bootstrap-table-editable.js"></script>
    <script src="scripts/x-editable/bootstrap3-editable/js/bootstrap-editable.js"></script>

    <script src="scripts/bootstrap-table/extensions/export/tableExport.js"></script>
    <script src="scripts/bootstrap-table/extensions/export/bootstrap-table-export.js"></script>

    <script src="scripts/bootbox/bootbox.min.js"></script>

    <script src="scripts/bootstrap-datetimepicker/js/moment.js"></script>
    <script src="scripts/bootstrap-datetimepicker/js/moment_zh-CN.js"></script>
    <link href="scripts/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css" rel="stylesheet">
    <script src="scripts/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
    <script src="scripts/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>

    <script src="scripts/jquery.cookie.js"></script>
    <script src="scripts/common.js"></script>

<script language="javascript"  type="text/javascript">
</script>
</head>

<body>

<div class="panel-body" style="padding-bottom:0px;">
        <div class="panel panel-default">
            <div class="panel-heading">查询条件</div>
            <div class="panel-body">
                <form id="formSearch" class="form-horizontal">
                    <input type="hidden" class="form-control" id="hiddenTxt">
                    <div class="form-group" style="margin-top:15px">

			<#list table.columns as column>
			 <#if column.listIsShow>
    			 	<label class="control-label col-sm-1" for="${column.columnNameLower}">${column.remarks}</label>
    			 <#if column.isDateTimeColumn>
    			  <div class="col-sm-4">
                    <input type="text" name="${column.columnNameLower}Begin" id = "${column.columnNameLower}Begin"  class="datetimepicker"  readonly="readonly"/>
    				<input type="text" name="${column.columnNameLower}End" id = "${column.columnNameLower}End"  class="datetimepicker"  readonly="readonly"/>
                  </div>
    			<#elseif column.formShowType=='textarea'>
    				<textarea class="form-control" rows="3" name="${column.columnNameLower}" id="${column.columnNameLower}"></textarea>
    			<#elseif column.formShowType=='select'>
    			<div class="col-sm-2"> 
    			                 <select name="${column.columnNameLower}" id="${column.columnNameLower}"  
                                        class="selectpicker show-tick form-control"  data-live-search="true" data-actions-box="true">
                                </select>
    			</div>
    			<#elseif column.formShowType=='radio'>
    			<div class="col-sm-2"> <input type="radio" name="${column.columnNameLower}" id="${column.columnNameLower}" value=""></div>
    			<#elseif column.formShowType=='file'>
                <div class="col-sm-2"> <input type="file" name="${column.columnNameLower}" id="${column.columnNameLower}" value=""></div>
                <#elseif column.formShowType=='checkbox'>
                <div class="col-sm-2"> <input type="checkbox" name="${column.columnNameLower}" id="${column.columnNameLower}" value=""></div>
    			<#elseif column.formShowType=='input'>
    				<div class="col-sm-2"> <input type="text" class="form-control" id="${column.columnNameLower}"></div>
    			 		
    			</#if>
			</#if>
	       	</#list>

				<div class="col-sm-12" style="text-align:left;">
					<button type="button" style="margin-left:50px" id="btn_query" class="btn btn-primary">查询</button>
				</div>
                </div>
                </form>
            </div>
        </div>       

        <div id="toolbar" class="btn-group">
	
            <button id="btn_add" type="button" class="btn btn-default">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
            </button>
	
            <button id="btn_edit" type="button" class="btn btn-default">
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
            </button>
	
            <button id="btn_delete" type="button" class="btn btn-default">
                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
            </button>
	
        </div>
        
        <table id="tableList" style="word-break:break-all; word-wrap:break-word;"></table>
    </div>


    <script type="text/javascript">
    //拦截器判断
        var token = $.cookie('bearcktkaeskey');
     if (token == ""||token==undefined) {
            location.href = ctx + '/login.html';
        }
        
     var $tableList = $('#tableList');
	 var $btn_query = $('#btn_query');
        
  	     $btn_query.click(function () {
        	 refreshGrid();
        });

      	function refreshGrid(){
		  $tableList.bootstrapTable('refresh');
      	}
      	
     
     var TableInit = function () {
        var oTableInit = new Object();
        //初始化Table
        oTableInit.Init = function () {
            $('#tableList').bootstrapTable({
                url: ctx+'/api/${className}?TOKEN='+token,         //请求后台的URL（*）
                method: 'get',                     //请求方式（*）
                dataType: "json",
                contentType : "application/x-www-form-urlencoded;charset=UTF-8",
                dataField: "rows",//服务端返回数据键值 就是说记录放的键值是rows，分页时使用总记录数的键值为total
                totalField: 'total',
                toolbar: '#toolbar',                //工具按钮用哪个容器
                undefinedText:'',                   //默认值-
                striped: true,                      //是否显示行间隔色
                cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                pagination: true,                   //是否显示分页（*）
                smartDisplay:false,
                showRefresh:true,
                showColumns:true,
                showExport: true,
                searchOnEnterKey:true,
                showFooter:true,
                search:false,
                sortable: true,                     //是否启用排序
                sortName:"${table.idColumn.columnNameFirstLower}",
                sortOrder: "asc",                   //排序方式
                singleSelect:false,
                clickToSelect: true,
                smartDisplay:true,
                queryParams: oTableInit.queryParams,//传递参数（*）
                queryParamsType:'',                 //  queryParamsType = 'limit' 参数: limit, offset, search, sort, order;
                                                    //  queryParamsType = '' 参数: pageSize, pageNumber, searchText, sortName, sortOrder.
                sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
                pageNumber:1,                       //初始化加载第一页，默认第一页
                pageSize: 25,                       //每页的记录行数（*）
                pageList: [5,10, 25, 40, 50, 100,'all'],        //可供选择的每页的行数（*）
                strictSearch: true,
                clickToSelect: true,                //是否启用点击选中行
                 uniqueId: "${table.idColumn.columnNameFirstLower}",                     //每一行的唯一标识，一般为主键列
                cardView: false,                    //是否显示详细视图
                detailView: false,                   //是否显示父子表
                columns: [  
                        { field: 'checkStatus', title: '',checkbox:true }, 
                           {field : 'Number', title : '行号', formatter : function(value, row, index) {  
                                       var pageSize = $('#tableList').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                                       var pageNumber = $('#tableList').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                                       return pageSize * (pageNumber - 1) + index + 1;
                                    }  
                           },
                  <#list table.columns as column>
                    <#if column.listColumnIsShow>
                    {field:'${column.sqlName}',title:'${column.remarks}', sortable:true}<#if column_has_next>,</#if>
                    </#if>
             </#list>
                        ],                      
                formatLoadingMessage: function () {
                    return "请稍等，正在加载中...";
                },
                formatNoMatches: function () { //没有匹配的结果
                    return '无符合条件的记录';
                },
                onLoadError: function (data) {
                    $('#tableList').bootstrapTable('removeAll');
                },
                responseHandler: function (res) {
                    return {
                        total: res.count,
                        rows: res.data
                    };
                }
              
            });
            
     if(navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)){//如果是移动端
          $("#tableList").bootstrapTable("toggleView");
         }
        };
 
        //得到查询的参数
      oTableInit.queryParams = function (params) {
    <#list table.columns as column>
        <#if column.listIsShow>
        <#if column.isDateTimeColumn>
                var ${column.columnNameLower}Begin=$("#${column.columnNameLower}Begin").val();
                var ${column.columnNameLower}End=$("#${column.columnNameLower}End").val();
        <#else>
            var ${column.columnNameLower}=$("#${column.columnNameLower}").val();
        </#if>
        </#if>
    </#list>

            var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                 limit:params.pageSize,
                 page:params.pageNumber,
                "sortName":this.sortName,
                "sortOrder":this.sortOrder,
            <#list table.columns as column>
            <#if column.listIsShow>
            <#if column.isDateTimeColumn>
                "${column.columnNameLower}Begin":${column.columnNameLower}Begin,
                "${column.columnNameLower}End":${column.columnNameLower}End<#if column_has_next>,</#if>
            <#else>
                "${column.columnNameLower}":${column.columnNameLower}<#if column_has_next>,</#if>
             </#if>
         </#if>
    </#list>
            };
            return temp;
        };
        return oTableInit;
    };
        
   var add = {
        init: function () {
            this.btn_add();
        },
        btn_add:function(){
            $("#btn_add").click(function() {
                window.location.href = ctx+'/${classNameLower}Add.html';
            })
        }
    };//end add
        
     var edit = {
        init: function () {
            this.btn_edit();
        },
        btn_edit:function(){
            $("#btn_edit").click(function() {
                var ids = $.map($tableList.bootstrapTable('getSelections'), function (row) {
             return row.${table.idColumn.columnNameFirstLower};
                });
            if(ids == ''|| ids==null){
                bootbox.alert('请选择要操作的记录');
                return;
            }
            
            if(ids.length>1){
                bootbox.alert('请选择一条操作的记录');
                return;
            }
            window.location.href = ctx+"/${classNameLower}Add.html?operate=edit&${table.idColumn.columnNameFirstLower}=" + ids;
            })
        }
    };//end edit
    
     var del = {
        init: function () {
            this.btn_del();
        },
        btn_del:function(){
            $("#btn_delete").click(function() {
             var ids = $.map($tableList.bootstrapTable('getSelections'), function (row) {
                 return row.${table.idColumn.columnNameFirstLower};
             });
             
            if(ids == ""){
                bootbox.alert('请选择要操作的记录');
                return;
            }

            bootbox.confirm('确认要删除么?',function (result) {  
                if(result) {  
                    del.doDelete();
                }
            });
        })
        },
        doDelete:function () {
            var ids = $.map($tableList.bootstrapTable('getSelections'), function (row) {
                 return row.${table.idColumn.columnNameFirstLower};
             });
            var result = jQuery.ajax({
                  url:ctx+"/api/${className}/" + ids+"?TOKEN="+token,
                  async:false,
                  type: "delete",
                  cache:false,
                  dataType:"json"
              }).responseText;
            var obj = eval("("+result+")");
            bootbox.alert(obj.respMsg);
            refreshGrid();
        }
        
    };//end del
    	
     $(function () {
        var oTable = new TableInit();
        oTable.Init();
        
         //回车绑定查询
        $(document).keydown(function(event){
            if(event.keyCode == 13){ //13是Enter的keycode
                $btn_query.click();
            }
        });
        
         $(".datetimepicker").datetimepicker({
                language: 'zh-CN',
                 format: 'yyyy-mm-dd hh:ii:ss',//格式化时间,
                 autoclose:true,//日期选择完成后是否关闭选择框
                 //minView: "month",//设置只显示到月份
                 clearBtn:true // 自定义属性,true 显示 清空按钮 false 隐藏 默认:true
           });
             
        add.init();
        edit.init();
        del.init();
    });
    
    </script>

</body>
</html>
