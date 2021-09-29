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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.zhongkexinli.micro.serv.common.bean.RestAPIResult2;
import com.zhongkexinli.micro.serv.common.msg.LayUiTableResultResponse;
import com.zhongkexinli.micro.serv.common.pagination.Query;
import com.zhongkexinli.micro.serv.common.util.DateUtil;

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
	
	@ApiOperation(value = "列表")
	@RequestMapping(value = "/api/${className}", method = RequestMethod.GET)
	public LayUiTableResultResponse page(@RequestParam(defaultValue = "10") int limit,
	      @RequestParam(defaultValue = "1") int offset,@RequestParam Map<String, Object> params) {
			Query query= new Query(params);
			return  ${classNameLower}Service.selectByQuery(query);
	}
	 
		@ApiOperation(value = "新增")
		@RequestMapping(value = "/api/${className}",method=RequestMethod.POST)
		public RestAPIResult2 create(@ModelAttribute ${className} ${classNameLower},HttpServletRequest request)  {
			
			try {
					Long createBy = getLoginId(request);
					${classNameLower}.setCreateUserId(createBy);
					${classNameLower}.setCreateUserName(getUserName(request));
					${classNameLower}.setCreateTime(new Date());
					${classNameLower}Service.insertSelective(${classNameLower});
					
				}catch(Exception e) {
					logger.error("[${table.remarks}]-->新增失败" ,e);
					return new RestAPIResult2().respCode(0).respMsg("新增失败 {}" ,e.getMessage());
				}
				
				return new RestAPIResult2();
	}
	 
		@ApiOperation(value = "更新")
		@RequestMapping(value="/api/${className}/{${table.idColumn.columnNameFirstLower}}",method=RequestMethod.PUT)
		public RestAPIResult2 update(@PathVariable("${table.idColumn.columnNameFirstLower}") ${table.idColumn.javaType} ${table.idColumn.columnNameFirstLower} ,@ModelAttribute ${className} ${classNameLower},HttpServletRequest request)  {
			try {
					
					Long createBy = getLoginId(request);
					${classNameLower}.setUpdateUserId(createBy);
					${classNameLower}.setUpdateByUname(getUserName(request));
					${classNameLower}.setUpdateDate(DateUtil.getNowDateYYYYMMddHHMMSS());
					${classNameLower}Service.updateByPrimaryKeySelective(${classNameLower});
					
				}catch(Exception e) {
					logger.error("[${table.remarks}]-->更新失败" ,e);
					return new RestAPIResult2().respCode(0).respMsg("更新失败 {}" ,e.getMessage());
				}
				
				return new RestAPIResult2();
	}
		
	/** 显示 */
	@ApiOperation(value = "查看")
	@RequestMapping(value="/api/${className}/{${table.idColumn.columnNameFirstLower}}", method = RequestMethod.GET)
	public ${className} show(@PathVariable("id") ${table.idColumn.javaType} ${table.idColumn.columnNameFirstLower} )  {
		${className} ${classNameLower} =${classNameLower}Service.selectByPrimaryKey(${table.idColumn.columnNameFirstLower});
		if(${classNameLower}== null) {
			${classNameLower} = new ${className}();
		}
		return ${classNameLower};
	}
		
	/** 逻辑删除 */
	@ApiOperation(value = "逻辑删除")
	@RequestMapping(value="/api/${className}/{${table.idColumn.columnNameFirstLower}}",method=RequestMethod.DELETE)
	public RestAPIResult2 delete(@PathVariable("${table.idColumn.columnNameFirstLower}") ${table.idColumn.javaType} ${table.idColumn.columnNameFirstLower} ) {
		${className} ${classNameLower} = ${classNameLower}Service.selectByPrimaryKey(id);
		 ${classNameLower}.setEnableFlag("0");//失效
		 ${classNameLower}Service.updateByPrimaryKey(${classNameLower});
			
		return new RestAPIResult2();
	}

	/** 显示 */
	@ApiOperation(value = "显示")
	@RequestMapping(value="/api/${className}/showInfo/{${table.idColumn.columnNameFirstLower}}", method = RequestMethod.GET)
	public  Map<String,Object> showInfo(@PathVariable("${table.idColumn.columnNameFirstLower}") ${table.idColumn.javaType} ${table.idColumn.columnNameFirstLower} ){
		Map<String,Object> retMap =new HashMap();
		${className} ${classNameLower} =${classNameLower}Service.selectByPrimaryKey(${table.idColumn.columnNameFirstLower});
		if(${classNameLower}== null) {
			${classNameLower} = new ${className}();
		}
		
		retMap.put("${classNameLower}", ${classNameLower});
		
		return retMap;
	}
	
	@ApiOperation(value = "列表")
	@RequestMapping(value = "/api/${className}/queryList", method = RequestMethod.GET)
	public RestAPIResult2 queryList(@RequestParam Map<String, Object> params) {
			Query query= new Query(params);
			List<${className}> list = ${classNameLower}Service.selectByExample(query);
			return new RestAPIResult2().respData(list);
	}
}

