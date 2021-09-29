<#assign className = table.className>   
<#assign classNameLower = className?uncap_first>   
package ${basepackage}.service;

import java.util.List;
import java.util.Map;

import ${basepackage}.bean.${className};
import com.zhongkexinli.micro.serv.common.msg.LayUiTableResultResponse;
import com.zhongkexinli.micro.serv.common.pagination.Query;


public interface ${className}Service  {

    public ${table.idColumn.javaType} deleteByPrimaryKey(${table.idColumn.javaType} ${table.idColumn.columnNameFirstLower});

    public ${table.idColumn.javaType} insert(${className} ${classNameLower});

    public ${table.idColumn.javaType} insertSelective(${className} ${classNameLower});

    public ${className} selectByPrimaryKey(${table.idColumn.javaType} ${table.idColumn.columnNameFirstLower});

    public ${table.idColumn.javaType} updateByPrimaryKeySelective(${className} ${classNameLower});

    public ${table.idColumn.javaType} updateByPrimaryKey(${className} ${classNameLower});

    public LayUiTableResultResponse	 selectByQuery(Query query) ;

    public  List<${className}> selectByExample(Query query);
}
