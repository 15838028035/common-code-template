<#assign className = table.className>   
<#assign classNameLower = className?uncap_first>   
package ${basepackage}.service;

import java.util.List;

import ${basepackage}.bean.${className};
import com.zhongkexinli.micro.serv.common.msg.LayUiTableResultResponse;
import com.zhongkexinli.micro.serv.common.pagination.Query;


public interface ${className}Service  {

    public java.lang.Integer deleteByPrimaryKey(${table.idColumn.javaType} ${table.idColumn.columnNameFirstLower});

    public java.lang.Integer insert(${className} ${classNameLower});

    public java.lang.Integer insertSelective(${className} ${classNameLower});

    public ${className} selectByPrimaryKey(${table.idColumn.javaType} ${table.idColumn.columnNameFirstLower});

    public java.lang.Integer updateByPrimaryKeySelective(${className} ${classNameLower});

    public java.lang.Integer updateByPrimaryKey(${className} ${classNameLower});

    public LayUiTableResultResponse	 selectByQuery(Query query) ;

    public  List<${className}> selectByExample(Query query);
}
