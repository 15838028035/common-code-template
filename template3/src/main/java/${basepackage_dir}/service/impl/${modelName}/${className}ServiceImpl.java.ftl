<#assign className = table.className>   
<#assign classNameLower = className?uncap_first>   
package ${basepackage}.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ${basepackage}.dao.{modelName}${className}Mapper;
import ${basepackage}.service.{modelName}.${className}Service;
import ${basepackage}.model.${modelName}.${className};
import ${basepackage}.model.${modelName}.${className}Example;

@Service
public class ${className}ServiceImpl  implements ${className}Service{
	
	@Override
	public java.lang.Integer countByExample(${className}Example example) {
	   return ${classNameLower}Mapper.countByExample(countByExample);
	}
	
    @Override
    public java.lang.Integer deleteByExample(${className}Example example) {
         return ${classNameLower}Mapper.deleteByExample(countByExample);
    }
    
    @Override
    public java.lang.Integer delByPrimaryKey(Integer id) {
        return ${classNameLower}Mapper.deleteByExample(id);
    }

    @Override
    public java.lang.Integer deleteByPrimaryKey(Long id) {
        return ${classNameLower}Mapper.deleteByExample(id);
    }
    
    @Override
    public java.lang.Integer insert(${className} record) {
         return ${classNameLower}Mapper.insert(record);
    }
    @Override
    public java.lang.Integer insertSelective(${className} record) {
        return ${classNameLower}Mapper.insertSelective(record);
    }
    
    @Override
    List<${className}> selectByExample(${className}Example example) {
        return ${classNameLower}Mapper.selectByExample(record);
    }
    
    @Override
    public    List<${className}> selectByExample(Page<${className}> page, ${className}Example example) {
        return ${classNameLower}Mapper.selectByExample(page,example);
    }
    
    @Override
    public ${className} selectByPrimaryKey(Long id) {
         return ${classNameLower}Mapper.selectByPrimaryKey(id);
    }
    
    @Override
    public java.lang.Integer updateByExampleSelective(@Param("record") ${className} record, @Param("example") ${className}Example example) {
        return ${classNameLower}Mapper.updateByExampleSelective(record,example);
    }
    
    @Override
    public java.lang.Integer updateByExample(@Param("record") ${className} record, @Param("example")${className}Example example) {
        return ${classNameLower}Mapper.updateByExample(record,example);
    }
    
    @Override
    public java.lang.Integer updateByPrimaryKeySelective(${className} record) {
        return ${classNameLower}Mapper.updateByPrimaryKeySelective(record);
    }
    
    @Override
    public java.lang.Integer updateByPrimaryKey(${className} record) {
        return ${classNameLower}Mapper.updateByPrimaryKey(record);
    }

}
