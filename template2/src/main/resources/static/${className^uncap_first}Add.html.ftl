<#assign className = table.className>   
<#assign classNameLower = className?uncap_first> 

<!DOCTYPE html>
<html>
<head>
<title>${table.remarks}新增、编辑</title>
   <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!--css样式-->
    <link href="scripts/bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="scripts/bootstrap-table/bootstrap-table.css" rel="stylesheet">
    <!--js-->

    <script src="scripts/jquery/jquery-3.2.0.min.js"></script>
    <script src="scripts/bootstrap/js/bootstrap.js"></script>

    <script src="scripts/bootbox/bootbox.min.js"></script>

    <script src="scripts/bootstrap-datetimepicker/js/moment.js"></script>
    <script src="scripts/bootstrap-datetimepicker/js/moment_zh-CN.js"></script>
    <link href="scripts/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css" rel="stylesheet">
    <script src="scripts/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
    <script src="scripts/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>

    <link href="scripts/bootstrapvalidator/css/bootstrapValidator.css" rel="stylesheet">
    <script src="scripts/bootstrapvalidator/js/bootstrapValidator.js"></script>
    <script src="scripts/bootstrapvalidator/js/language/zh_CN.js"></script>

    <link href="scripts/bootstrap-fileinput/css/fileinput.css" rel="stylesheet">
    <script src="scripts/bootstrap-fileinput/js/fileinput.js"></script>

    <script src="scripts/jquery.cookie.js"></script>
    <script src="scripts/common.js"></script>
	
</head>
<body>
<div class="container">
	<form  class="form-horizontal" method="post" name="${classNameLower}Form" id="${classNameLower}Form">
	<input type="hidden" name="${table.idColumn.columnNameFirstLower}" id="${table.idColumn.columnNameFirstLower}" />
	<input type="hidden" name="operate" id="operate"  />
           
        <#list table.columns as column>
        <#if column.formIsShow>
      		<div class="form-group">
			 <label for="${column.columnNameLower}">${column.remarks}</label>
			  <#if column.isDateTimeColumn>
				<input class="form-control" type="text" name="${column.columnNameLower}" id = "${column.columnNameLower}"  class="datetimepicker"  readonly="readonly"/>
			<#elseif column.formShowType=='textarea'>
                <textarea class="form-control" rows="3" name="${column.columnNameLower}" id="${column.columnNameLower}"></textarea>
            <#elseif column.formShowType=='select'>
                 <select name="${column.columnNameLower}" id="${column.columnNameLower}"  
                        class="selectpicker show-tick form-control"  data-live-search="true" data-actions-box="true">
                </select>
            <#elseif column.formShowType=='radio'>
                <input type="radio" name="${column.columnNameLower}" id="${column.columnNameLower}" value="">
            <#elseif column.formShowType=='file'>
                 <input type="file" name="${column.columnNameLower}" id="${column.columnNameLower}" value="">
            <#elseif column.formShowType=='checkbox'>
                <input type="checkbox" name="${column.columnNameLower}" id="${column.columnNameLower}" value="">
            <#elseif column.formShowType=='input'>
		 	     <input class="form-control" type="text"  name="${column.columnNameLower}" id="${column.columnNameLower}"  />
            </#if>
		 	</div>
        </#if>
    </#list>
       
 	  <div class="form-group"> 
                 <button id="save"  class="btn btn-default">保存</button>
                <button type="button" id="backToHomeButton"  class="btn btn-default">返回</button>
        </div>	
       
    	</form>
</div>
<script>
		 //拦截器判断
     var token = $.cookie('bearcktkaeskey');
    if (token == ""||token==undefined) {
        location.href = ctx + '/login.html';
    }

    //加载
    var loadInfo = {
        init: function () {
            this.load_Info();
        },
        load_Info:function(){
            //截取参数
            $.getUrlParam = function (name) {
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
                var r = window.location.search.substr(1).match(reg);
                if (r != null) return unescape(r[2]);
                return null;
            }

            var id = $.getUrlParam('${table.idColumn.columnNameFirstLower}');
            var operate = $.getUrlParam('operate');
            
            if(id != null){
                $("#${table.idColumn.columnNameFirstLower}").val(id);
                $.ajax({
                    url: ctx+"/api/${className}/"+id+"?TOKEN="+token,
                    type: "get",
                    dataType: "json",
                    success: function(data){
                       <#list table.columns as column>
                       <#if column.formIsShow>
                         <#if column.isDateTimeColumn>
                            $("#${column.columnNameLower}").val(data.${column.columnNameLower});
                         <#elseif column.formShowType=='textarea'>
                            $("#${column.columnNameLower}").val(data.${column.columnNameLower});
                        <#elseif column.formShowType=='select'>
                            $("#${column.columnNameLower}").val(data.${column.columnNameLower});
                        <#elseif column.formShowType=='radio'>
                            $("input [name='${column.columnNameLower}'][value='"+data.${column.columnNameLower}+"']").prop("checked", "checked");
                        <#elseif column.formShowType=='file'>
                            $("#${column.columnNameLower}").val(data.${column.columnNameLower});
                        <#elseif column.formShowType=='checkbox'>
                            $("#${column.columnNameLower}").val(data.${column.columnNameLower});
                        <#elseif column.formShowType=='input'>
                            $("#${column.columnNameLower}").val(data.${column.columnNameLower});
                        </#if>
                        </#if>
                     </#list>
                    },
                    error: function(data){
                        bootbox.alert("异常");
                        return false;
                    }
                });
            }
        }
    };//end loadInfo
    
    //校验
     var bootstrapValidator = {
        init: function () {
            this.doBootstrapValidator();
        },
        doBootstrapValidator:function(){
              $("#${classNameLower}Form").bootstrapValidator({
            
            fields: {
               <#list table.columns as column>
               <#if column.formIsShow>
                 "${column.columnNameLower}": {
                    message: '${column.remarks}不能为空',
                    validators: {  
                                     notEmpty: {  
                                        message: '${column.remarks}不能为空'  
                                    } 
                                    
                                }  
                
               }<#if column_has_next>,</#if>
               </#if>
                </#list>
            }
        }
        );
        
        }
    };//end bootstrapValidator
    
    //保存或更新
    var saveOrUpdate = {
        init: function () {
            this.doSaveOrUpdate();
        },
        doSaveOrUpdate:function(){
        
          //截取参数
            $.getUrlParam = function (name) {
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
                var r = window.location.search.substr(1).match(reg);
                if (r != null) return unescape(r[2]);
                return null;
            }

            var id = $.getUrlParam('${table.idColumn.columnNameFirstLower}');
            
         $("#save").click(function () {//非submit按钮点击后进行验证，如果是submit则无需此句直接验证
                $("#${classNameLower}Form").bootstrapValidator('validate');//提交验证
                if ($("#${classNameLower}Form").data('bootstrapValidator').isValid()) {//获取验证结果，如果成功，执行下面代码
                    var type = "post";
                    var url = ctx + "/api/${className}?TOKEN="+token;
                    var operate = $.getUrlParam('operate');
                    if (operate == "edit"){
                        type = "put";
                        url = ctx + "/api/${className}/"+id+"?TOKEN="+token;
                    }else {
                        $("#${table.idColumn.columnNameFirstLower}").val(0);
                    }
                    
                    var data = $('#${classNameLower}Form').serialize();
                    $.ajax({
                        url: url,
                        data:data,
                        type: type,
                        dataType: "json",
                        success: function (data) {
                            bootbox.alert(data.respMsg);
                        },
                        error: function (data) {
                            bootbox.alert("异常");
                            return false;
                        }
                    });
                }

            });
        
        }
    };//end saveOrUpdate
    
    //返回
     var backToHome = {
        init: function () {
            this.doBackToHome();
        },
        doBackToHome:function(){
            $("#backToHomeButton").click(function () {
                window.history.go(-1);
            });
        }
    };//end backToHomeButton
        
    //初始化加载    
    $(function () {
        loadInfo.init();
        bootstrapValidator.init();
        saveOrUpdate.init();
        backToHome.init();
    });
    
</script>
</body>
</html>
