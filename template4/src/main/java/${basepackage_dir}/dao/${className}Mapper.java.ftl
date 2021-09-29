<#assign className = table.className>   
<#assign classNameLower = className?uncap_first>   
package ${basepackage}.dao;

import java.util.List;
import java.util.Map;

import ${basepackage}.bean.${className};


public interface ${className}Mapper  {

    public java.lang.Integer deleteByPrimaryKey(${table.idColumn.javaType} ${table.idColumn.columnNameFirstLower});

    public java.lang.Integer insert(${className} ${classNameLower});

    public java.lang.Integer insertSelective(${className} ${classNameLower});

    public ${className} selectByPrimaryKey(${table.idColumn.javaType} ${table.idColumn.columnNameFirstLower});

    public java.lang.Integer updateByPrimaryKeySelective(${className} ${classNameLower});

    public java.lang.Integer updateByPrimaryKey(${className} ${classNameLower});

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
    public List<${className}> selectByPageExample(Object mapAndObject);
}
