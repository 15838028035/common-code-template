<#assign className = table.className>   
<#assign classNameLower = className?uncap_first>   
package ${basepackage}.dao;

import java.util.List;
import java.util.Map;

import ${basepackage}.bean.${className};


public interface ${className}Mapper  {

    public ${table.idColumn.javaType} deleteByPrimaryKey(${table.idColumn.javaType} ${table.idColumn.columnNameFirstLower});

    public ${table.idColumn.javaType} insert(${className} ${classNameLower});

    public ${table.idColumn.javaType} insertSelective(${className} ${classNameLower});

    public ${className} selectByPrimaryKey(${table.idColumn.javaType} ${table.idColumn.columnNameFirstLower});

    public ${table.idColumn.javaType} updateByPrimaryKeySelective(${className} ${classNameLower});

    public ${table.idColumn.javaType} updateByPrimaryKey(${className} ${classNameLower});

   /**
     * 根据条件查询列表
     *
     * @param example
     */
   public  List<${className}> selectByExample(Object mapAndObject);

   /**
     * 根据条件查询列表
     *
     * @param example
     */
    public List<Map<String,Object>> selectByPageExample(Object mapAndObject);
}
