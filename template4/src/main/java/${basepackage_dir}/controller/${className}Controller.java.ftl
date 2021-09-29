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
	@GetMapping(value = "/api/${className}")
	public LayUiTableResultResponse<${className}> page(${className} ${classNameLower}) {
			Query query= new Query().putFilter("${classNameLower}", ${classNameLower});
            LayUiTableResultResponse<${className}> restApiResult2LayUiTableResultResponse =  ${classNameLower}Service.selectByQuery(query);
            return restApiResult2LayUiTableResultResponse;
	}
	 
		@ApiOperation(value = "新增")
		@PostMapping(value = "/api/${className}")
		public RestApiResult2 create(@ModelAttribute ${className} ${classNameLower},HttpServletRequest request)  {
			
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
				
				return new RestApiResult2();
	}
	 
		@ApiOperation(value = "更新")
		@PutMapping(value="/api/${className}/{${table.idColumn.columnNameFirstLower}}")
		public RestApiResult2 update(@PathVariable("${table.idColumn.columnNameFirstLower}") ${table.idColumn.javaType} ${table.idColumn.columnNameFirstLower} ,@ModelAttribute ${className} ${classNameLower},HttpServletRequest request)  {
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
				
				return new RestApiResult2();
	}
		
	/** 显示 */
	@ApiOperation(value = "查看")
	@GetMapping(value="/api/${className}/{${table.idColumn.columnNameFirstLower}}")
	public ${className} show(@PathVariable("id") ${table.idColumn.javaType} ${table.idColumn.columnNameFirstLower} )  {
		${className} ${classNameLower} =${classNameLower}Service.selectByPrimaryKey(${table.idColumn.columnNameFirstLower});
		if(${classNameLower}== null) {
			${classNameLower} = new ${className}();
		}
		return ${classNameLower};
	}
		
	/** 物理删除 */
	@ApiOperation(value = "物理删除")
	@DeleteMapping(value="/api/${className}/{${table.idColumn.columnNameFirstLower}}")
	public RestApiResult2 delete(@PathVariable("${table.idColumn.columnNameFirstLower}") ${table.idColumn.javaType} ${table.idColumn.columnNameFirstLower} ) {
		${classNameLower}Service.deleteByPrimaryKey(${table.idColumn.columnNameFirstLower});
		return new RestApiResult2();
	}

	/** 显示 */
	@ApiOperation(value = "显示")
	@GetMapping(value="/api/${className}/showInfo/{${table.idColumn.columnNameFirstLower}}")
	public  RestApiResult2 showInfo(@PathVariable("${table.idColumn.columnNameFirstLower}") ${table.idColumn.javaType} ${table.idColumn.columnNameFirstLower} ){
		${className} ${classNameLower} =${classNameLower}Service.selectByPrimaryKey(${table.idColumn.columnNameFirstLower});
		if(${classNameLower}== null) {
			${classNameLower} = new ${className}();
		}
		return new RestApiResult2().respData(${classNameLower});
	}
	
	@ApiOperation(value = "列表")
	@GetMapping(value = "/api/${className}/queryList")
	public RestApiResult2 queryList(@RequestParam Map<String, Object> params) {
			Query query= new Query(params);
			List<${className}> list = ${classNameLower}Service.selectByExample(query);
			return new RestApiResult2().respData(list);
	}
}

