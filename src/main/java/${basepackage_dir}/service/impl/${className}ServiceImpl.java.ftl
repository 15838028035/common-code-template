<#assign className = table.className>   
<#assign classNameLower = className?uncap_first>   
package ${basepackage}.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import ${basepackage}.dao.${className}Mapper;
import ${basepackage}.service.${className}Service;
import ${basepackage}.bean.${className};

import com.zhongkexinli.micro.serv.common.msg.LayUiTableResultResponse;
import com.zhongkexinli.micro.serv.common.pagination.Query;

@Service
public class ${className}ServiceImpl  implements ${className}Service{
	
	@Autowired
	private ${className}Mapper ${classNameLower}Mapper;
	
	@Override
	public ${table.idColumn.javaType} deleteByPrimaryKey(${table.idColumn.javaType} ${table.idColumn.columnNameFirstLower}) {
		return ${classNameLower}Mapper.deleteByPrimaryKey(${table.idColumn.columnNameFirstLower});
	}

	@Override
	public ${table.idColumn.javaType} insert(${className} ${classNameLower}){
		return ${classNameLower}Mapper.insert(${classNameLower});
	}

	@Override
	public ${table.idColumn.javaType} insertSelective(${className} ${classNameLower}) {
		return ${classNameLower}Mapper.insertSelective(${classNameLower});
	}

	@Override
	public ${className} selectByPrimaryKey(${table.idColumn.javaType} ${table.idColumn.columnNameFirstLower}) {
		return ${classNameLower}Mapper.selectByPrimaryKey(${table.idColumn.columnNameFirstLower});
	}

	@Override
	public ${table.idColumn.javaType} updateByPrimaryKeySelective(${className} ${classNameLower}) {
		return ${classNameLower}Mapper.updateByPrimaryKeySelective(${classNameLower});
	}

	@Override
	public ${table.idColumn.javaType} updateByPrimaryKey(${className} ${classNameLower}) {
		return ${classNameLower}Mapper.updateByPrimaryKey(${classNameLower});
	}

	@Override
	 public LayUiTableResultResponse selectByQuery(Query query) {
	        com.github.pagehelper.Page<Object> result = PageHelper.startPage(query.getPage(), query.getLimit());
	        List<Map<String,Object>> list  = ${classNameLower}Mapper.selectByPageExample(query);
	        return new LayUiTableResultResponse(result.getTotal(), list);
	}

	@Override
	public List<${className}> selectByExample(Query query) {
		return ${classNameLower}Mapper.selectByExample(query);
	}

}
