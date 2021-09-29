<#assign className = table.className>   
<#assign classNameLower = className?uncap_first> 
package ${basepackage}.bean;
import com.zhongkexinli.micro.serv.common.base.entity.BaseEntity;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;


/**
*${table.tableAlias}
*/
@ApiModel(value = "${table.tableAlias}")
public class ${className} extends BaseEntity{
	
<#list table.columns as column>
	<#if !column.fk>
	/**
	 * ${column.remarks}  ${column.sqlName}
	 */
	@ApiModelProperty(value = "${column.remarks}")
	<#if column.isStringColumn>
	private ${column.javaType} ${column.columnNameLower} = "";
	</#if>
	<#if column.isDateTimeColumn>
	private ${column.javaType} ${column.columnNameLower};
	</#if>
	<#if column.isNumberColumn>
	private ${column.javaType} ${column.columnNameLower};
	</#if>
	
	 <#if column.isDateTimeColumn>
	 /**
	 * ${column.remarks}Begin
	 */
	private String  ${column.columnNameLower}Begin;
	/**
	 * ${column.remarks}End
	 */
	private String ${column.columnNameLower}End;
	</#if>
	</#if>
</#list>

<#list table.importedKeys.associatedTables?values as foreignKey>
	<#assign fkSqlTable = foreignKey.sqlTable>
	<#assign fkTable    = fkSqlTable.className>
	<#assign fkPojoClass = fkSqlTable.className>
	<#assign fkPojoClassVar = fkPojoClass?uncap_first>
	private ${fkPojoClass} ${fkPojoClassVar};
	
	public void set${fkPojoClass}(${fkPojoClass} ${fkPojoClassVar}){
		this.${fkPojoClassVar} = ${fkPojoClassVar};
	}
	
	public ${fkPojoClass} get${fkPojoClass}() {
		return ${fkPojoClassVar};
	}
</#list>

<@generateJavaColumns/>

	
}

<#macro generateJavaColumns>
	<#list table.columns as column>
	<#if !column.fk>
	public void set${column.columnName}(${column.javaType} value) {
		this.${column.columnNameLower} = value;
	}
	
	public ${column.javaType} get${column.columnName}() {
		return this.${column.columnNameLower};
	}
	</#if>
	</#list>
</#macro>

