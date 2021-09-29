<#assign className = table.className>   
<#assign classNameLower = className?uncap_first>   
package ${basepackage}.service.${modelName};

import java.util.List;

import ${basepackage}.model.${modelName}.${className};
import ${basepackage}.model.${modelName}.${className}Example;

/**
*${table.tableAlias}服务层
*/
public interface ${className}Service  {
    
    public java.lang.Integer countByExample(${className}Example example);

    public java.lang.Integer deleteByExample(${className}Example example);

    public java.lang.Integer delByPrimaryKey(Integer id);

    public java.lang.Integer deleteByPrimaryKey(Long id);

    public java.lang.Integer insert(${className} record);

    public java.lang.Integer insertSelective(${className} record);

    List<${className}> selectByExample(${className}Example example);
    
    public    List<${className}> selectByExample(Page<${className}> page, ${className}Example example);

    public ${className} selectByPrimaryKey(Long id);

    public java.lang.Integer updateByExampleSelective(@Param("record") ${className} record, @Param("example") ${className}Example example);

    public java.lang.Integer updateByExample(@Param("record") ${className} record, @Param("example")${className}Example example);

    public java.lang.Integer updateByPrimaryKeySelective(${className} record);

    public java.lang.Integer updateByPrimaryKey(${className} record);
}
