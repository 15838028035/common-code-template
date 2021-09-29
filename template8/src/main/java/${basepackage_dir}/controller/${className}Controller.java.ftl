<#assign className = table.className>   
<#assign classNameLower = className?uncap_first> 
package ${basepackage}.controller;

import ${basepackage}.bean.${className};
import ${basepackage}.service.${className}Service;


import java.util.Date;
import java.util.Map;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.zhongkexinli.micro.serv.common.bean.RestApiResult2;
import com.zhongkexinli.micro.serv.common.msg.LayUiTableResultResponse;
import com.zhongkexinli.micro.serv.common.pagination.Query;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;

/**
 *${table.remarks}管理
 */
@Api(value = "${table.remarks}服务", tags = "${table.remarks}服务接口")
@RestController()
public class ${className}Controller extends BaseController{

private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private ${className}Service ${classNameLower}Service;
	
	@ApiOperation(value = "分页列表")
	@ApiImplicitParams({  
	        	
			<#list table.columns as column>
			@ApiImplicitParam(name = "${column.columnNameLower}",value = "${column.remarks}",paramType = "path",dataType = "${column.javaType}"),
			</#list>
		})
	@GetMapping(value = "/api/${className}")
	public LayUiTableResultResponse page(@RequestParam(defaultValue = "10") int limit,
	      @RequestParam(defaultValue = "1") int offset,@RequestParam Map<String, Object> params) {
			Query query= new Query(params);
			return  ${classNameLower}Service.selectByQuery(query);
	}
	 
		@ApiOperation(value = "新增")
		@ApiImplicitParams({  
	        	
			<#list table.columns as column>
			@ApiImplicitParam(name = "${column.columnNameLower}",value = "${column.remarks}",paramType = "path",dataType = "${column.javaType}", required=true),
			</#list>
		})
		@PostMapping(value = "/api/${className}")
		public RestApiResult2 create(@RequestBody ${className} ${classNameLower},HttpServletRequest request)  {
			
			try {
					Long createBy = getLoginId(request);
					${classNameLower}.setCreateUserId(createBy);
					${classNameLower}.setCreateUserName(getUserName(request));
					${classNameLower}.setCreateTime(new Date());
					${classNameLower}Service.insertSelective(${classNameLower});
					
				}catch(Exception e) {
					logger.error("[${table.remarks}]-->新增失败" ,e);
					return new RestApiResult2().respCode(0).respMsg("新增失败 {}" ,e.getMessage());
				}
				
				return new RestApiResult2<>().respData(${classNameLower});
	}
	 
		@ApiOperation(value = "更新")
		@ApiImplicitParams({  
	        	
			<#list table.columns as column>
			@ApiImplicitParam(name = "${column.columnNameLower}",value = "${column.remarks}",paramType = "path",dataType = "${column.javaType}", required=true),
			</#list>
		})
		@PutMapping(value="/api/${className}/{${table.idColumn.columnNameFirstLower}}")
		public RestApiResult2<String> update(@PathVariable("${table.idColumn.columnNameFirstLower}") ${table.idColumn.javaType} ${table.idColumn.columnNameFirstLower} ,@RequestBody ${className} ${classNameLower},HttpServletRequest request)  {
			try {
					
					Long createBy = getLoginId(request);
					${classNameLower}.setUpdateUserId(createBy);
					${classNameLower}.setUpdateUserName(getUserName(request));
					${classNameLower}.setUpdateTime(new Date());
					${classNameLower}Service.updateByPrimaryKeySelective(${classNameLower});
					
				}catch(Exception e) {
					logger.error("[${table.remarks}]-->更新失败" ,e);
					return new RestApiResult2().respCode(0).respMsg("更新失败 {}" ,e.getMessage());
				}
				
				return new RestApiResult2<>();
	}
		
	/** 显示 */
	@ApiOperation(value = "查看")
	@GetMapping(value="/api/${className}/{${table.idColumn.columnNameFirstLower}}")
	public ${className} show(@PathVariable("{${table.idColumn.columnNameFirstLower}}") ${table.idColumn.javaType} ${table.idColumn.columnNameFirstLower} )  {
		${className} ${classNameLower} =${classNameLower}Service.selectByPrimaryKey(${table.idColumn.columnNameFirstLower});
		if(${classNameLower}== null) {
			${classNameLower} = new ${className}();
		}
		return ${classNameLower};
	}
		
	/** 物理删除 */
	@ApiOperation(value = "物理删除")
	@DeleteMapping(value="/api/${className}/{${table.idColumn.columnNameFirstLower}}")
	public RestApiResult2<String> delete(@PathVariable("${table.idColumn.columnNameFirstLower}") ${table.idColumn.javaType} ${table.idColumn.columnNameFirstLower} ) {
		${classNameLower}Service.deleteByPrimaryKey(${table.idColumn.columnNameFirstLower});
		return new RestApiResult2<>();
	}

	/** 显示 */
	@ApiOperation(value = "显示")
	@GetMapping(value="/api/${className}/showInfo/{${table.idColumn.columnNameFirstLower}}")
	public  Map<String,Object> showInfo(@PathVariable("${table.idColumn.columnNameFirstLower}") ${table.idColumn.javaType} ${table.idColumn.columnNameFirstLower} ){
		Map<String,Object> retMap =new HashMap<>();
		${className} ${classNameLower} =${classNameLower}Service.selectByPrimaryKey(${table.idColumn.columnNameFirstLower});
		if(${classNameLower}== null) {
			${classNameLower} = new ${className}();
		}
		
		retMap.put("${classNameLower}", ${classNameLower});
		
		return retMap;
	}
	
	@ApiOperation(value = "列表不分页")
	@ApiImplicitParams({  
	        	
			<#list table.columns as column>
			@ApiImplicitParam(name = "${column.columnNameLower}",value = "${column.remarks}",paramType = "path",dataType = "${column.javaType}"),
			</#list>
		})
	@GetMapping(value = "/api/${className}/queryList")
		@ApiResponses({
        @ApiResponse(code = 200, message = "ok", response=${className}.class),
    })
	public RestApiResult2 queryList(@RequestParam Map<String, Object> params) {
			Query query= new Query(params);
			List<${className}> list = ${classNameLower}Service.selectByExample(query);
			return new RestApiResult2().respData(list);
	}
	
	 <#list table.columns as column>
		 <#if column.genUnique>
		 @ApiOperation(value = "唯一性校验")
		@PostMapping(value = "/api/${className}/check/{${column.columnNameLower}}/{${table.idColumn.columnNameFirstLower}}")
		public Boolean check${column.columnNameLower}(@PathVariable("${column.columnNameLower}")  ${column.javaType}  ${column.columnNameLower},@PathVariable("${table.idColumn.columnNameFirstLower}") ${table.idColumn.javaType} ${table.idColumn.columnNameFirstLower} ) {
		
			Map<String,Object> params =new HashMap<>();
			params.put("${column.columnNameLower}",${column.columnNameLower});
			Query query= new Query(params);
			
			List<${className}> list = ${classNameLower}Service.selectByExample(query);
			
			if(!list.isEmpty()){
			 ${className} ${classNameLower} = list.get(0);
			 
			 ${table.idColumn.javaType} ${table.idColumn.columnNameFirstLower}Obj = ${classNameLower}.get${table.idColumn.columnNameFirstUpper}();
			 
			 if(${table.idColumn.columnNameFirstLower}Obj != ${table.idColumn.columnNameFirstLower}) {
			         return true;
			     }
			 
			}
			return false;
		}
		 </#if>
	</#list>
}

