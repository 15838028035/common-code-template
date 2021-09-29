<#assign className = table.className>   
<#assign classNameLower = className?uncap_first>   
package ${basepackage}.dao.${modelName}${modelName};

import java.util.List;
import java.util.Map;

import ${basepackage}.model.${modelName}.${className};


public interface ${className}Mapper  {
    
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
