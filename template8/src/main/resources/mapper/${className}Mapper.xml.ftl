<#assign className = table.className>   
<#assign classNameLower = className?uncap_first> 
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
	
<#macro mapperEl value>${r"#{"}${value}}</#macro>
<#macro mapperE2 value>${r"${"}${value}}</#macro>

<#macro mapperElJdbc value jdbcValue >${r"#{"}${value},jdbcType=${jdbcValue}}</#macro>
<#macro namespace>${className}.</#macro>

<mapper namespace="${basepackage}.dao.${className}Mapper">
    <resultMap id="${classNameLower}Result" type="${basepackage}.bean.${className}">
        <#list table.columns as column>
      	<#if !column.fk>	
   	  	<result property="${column.columnNameLower}" column="${column.sqlName}" jdbcType="${column.jdbcSqlTypeName}"  <#if column.hasNullValue> nullValue="${column.nullValue}"</#if> />
		<#else>
		<#list table.importedKeys.associatedTables?values as foreignKey>
			<#assign fkSqlTable = foreignKey.sqlTable>
			<#assign primaryKeyColumns = fkSqlTable.primaryKeyColumns>
			<#list primaryKeyColumns as pkCol>
				<#if pkCol == column.sqlName>
					<#assign fkTable = fkSqlTable.className>
					<#assign fkPojoClass = fkSqlTable.className>
					<#assign fkPojoClassVar = fkPojoClass?uncap_first>
   	  	<result property="${fkPojoClassVar}" column="${column.sqlName}" select="${fkPojoClass}.findById"/>
				</#if>
			</#list>
		</#list>		
		</#if>
		</#list>
    </resultMap>

	<sql id="Base_Column_List">
	    <![CDATA[
	   
        <#list table.columns as column>
        	${column.sqlName} <#if column_has_next>,</#if>
        </#list>
	    ]]>
	</sql>

   <select id="selectByPrimaryKey" resultMap="${classNameLower}Result">
	 select 
	    <include refid="Base_Column_List"/>
	    
	        from ${table.sqlName} 
	        where 
		<#list table.compositeIdColumns as column>
		       ${column.sqlName} = <@mapperElJdbc column.columnNameFirstLower column.jdbcSqlTypeName/>
			<#if column_has_next>,</#if>
		  </#list>
</select>

 <delete id="deleteByPrimaryKey" parameterType="${table.idColumn.javaType}">
           delete from ${table.sqlName} where
        <#list table.compositeIdColumns as column>
        ${column.sqlName} = <@mapperElJdbc column.columnNameFirstLower column.jdbcSqlTypeName/>
	<#if column_has_next>,</#if>
		</#list>
       </delete>

 <insert id="insert" useGeneratedKeys="true" keyProperty="${table.idColumn.columnNameFirstLower}">

        INSERT INTO ${table.sqlName} (
        <#list table.columns as column> ${column.sqlName}<#if column_has_next>,</#if></#list>
        ) VALUES (
        <#list table.columns as column> <@mapperElJdbc column.columnNameFirstLower column.jdbcSqlTypeName /><#if column_has_next>,</#if></#list>        
        )
   
</insert>

 <insert id="insertSelective" parameterType="${basepackage}.bean.${className}" useGeneratedKeys="true" keyProperty="${table.idColumn.columnNameFirstLower}">
          INSERT INTO ${table.sqlName} 
	         <trim prefix="(" suffix=")" suffixOverrides="," >
	        <#list table.columns as column>
	    	<if test="${column.columnNameLower} != null" >
        		${column.sqlName},
     	 	</if>
	        </#list>
		</trim>
		<trim prefix="values (" suffix=")" suffixOverrides="," >

		 <#list table.columns as column>
	    		<if test="${column.columnNameLower} != null" >
        		     <@mapperElJdbc column.columnNameFirstLower column.jdbcSqlTypeName/>,
     	 		</if>
	        </#list>
		</trim>
 </insert>

    <update id="updateByPrimaryKeySelective" parameterType="${basepackage}.bean.${className}">
    
        UPDATE ${table.sqlName} 
     
      <set >
	    <#list table.notPkColumns as column>
			<#if column.isStringColumn>
				<if test="${column.columnNameLower} != null and  ${column.columnNameLower} != ''" >
				${column.sqlName} = <@mapperElJdbc column.columnNameFirstLower column.jdbcSqlTypeName/> ,
				</if>
			<#else>
				<if test="${column.columnNameLower} != null ">
				${column.sqlName} = <@mapperElJdbc column.columnNameFirstLower column.jdbcSqlTypeName/> ,
				</if>
			</#if>
	 </#list>

	 </set>
        WHERE 
        	<#list table.compositeIdColumns as column>
	        ${column.sqlName} = <@mapperElJdbc column.columnNameFirstLower column.jdbcSqlTypeName/>
		<#if column_has_next>,</#if>
	        </#list>
    </update>
   
    <update id="updateByPrimaryKey" >

        UPDATE ${table.sqlName} SET
	        <#list table.notPkColumns as column>${column.sqlName} = <@mapperEl column.columnNameFirstLower/> <#if column_has_next>,</#if> </#list>
        WHERE 
        	<#list table.compositeIdColumns as column>
		${column.sqlName} = <@mapperElJdbc column.columnNameFirstLower column.jdbcSqlTypeName/>
		<#if column_has_next> AND </#if> 
		</#list>	        
  
</update>
           
<select id="selectByExample" resultMap="${classNameLower}Result" >
	 select 
		<include refid="Base_Column_List"/>
   	       	   from ${table.sqlName} WHERE 1=1  
	  
		<#list table.columns as column>
		<#if column.isStringColumn>
			<#if column.listMatchType =='like'>
			<if test="${column.columnNameLower} != null and  ${column.columnNameLower} != ''" >
				and   ${column.sqlName} like concat('%', <@mapperElJdbc column.columnNameFirstLower column.jdbcSqlTypeName/>, '%')
			</if>
			<#else>
			<if test="${column.columnNameLower} != null and  ${column.columnNameLower} != ''" >
				and   ${column.sqlName} = <@mapperElJdbc column.columnNameFirstLower column.jdbcSqlTypeName/>
			</if>
							
			</#if>
		<#else>
			<if test="${column.columnNameLower} != null ">
			and   ${column.sqlName} = <@mapperElJdbc column.columnNameFirstLower column.jdbcSqlTypeName/>
			</if>
		 </#if>
		</#list>
		
		<if test="sortName!= null and  sortName != ''" >
            order by <@mapperE2 "sortName"/>  <@mapperE2 "sortOrder"/>
        </if>
					
  </select>

<select id="selectByPageExample" resultType="java.util.HashMap" >
	 select 
		<include refid="Base_Column_List"/>
   	       	   from ${table.sqlName} WHERE 1=1  
	  
		<#list table.columns as column>
		<#if column.isStringColumn>
			<#if column.listMatchType =='like'>
			<if test="${column.columnNameLower} != null and  ${column.columnNameLower} != ''" >
				and   ${column.sqlName} like concat('%', <@mapperElJdbc column.columnNameFirstLower column.jdbcSqlTypeName/>, '%')
			</if>
			<#else>
			<if test="${column.columnNameLower} != null and  ${column.columnNameLower} != ''" >
				and   ${column.sqlName} = <@mapperElJdbc column.columnNameFirstLower column.jdbcSqlTypeName/>
			</if>
							
			</#if>
		<#else>
			<if test="${column.columnNameLower} != null ">
			and   ${column.sqlName} = <@mapperElJdbc column.columnNameFirstLower column.jdbcSqlTypeName/>
			</if>
		 </#if>
		</#list>
		
		<if test="sortName!= null and  sortName != ''" >
			order by <@mapperE2 "sortName"/>  <@mapperE2 "sortOrder"/>
		</if>
			
  </select>

</mapper>
