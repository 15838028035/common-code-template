<#assign className = table.className>   
<#assign classNameLower = className?uncap_first> 
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
	
<#macro mapperEl value>${r"#{"}${value}}</#macro>
<#macro mapperE2 value>${r"${"}${value}}</#macro>

<#macro mapperElJdbc value jdbcValue >${r"#{"}${value},jdbcType=${jdbcValue}}</#macro>
<#macro namespace>${className}.</#macro>
<mapper namespace="${basepackage}.dao.${modelName}.${className}Mapper">
    <resultMap id="BaseResultMap" type="${basepackage}.model.${modelName}.${className}">
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
  <#noparse>  
  <sql id="Example_Where_Clause" >
    <where >
      <foreach collection="oredCriteria" item="criteria" separator="or" >
        <if test="criteria.valid" >
          <trim prefix="(" suffix=")" prefixOverrides="and" >
            <foreach collection="criteria.criteria" item="criterion" >
              <choose >
                <when test="criterion.noValue" >
                  and ${criterion.condition}
                </when>
                <when test="criterion.singleValue" >
                  and ${criterion.condition} #{criterion.value}
                </when>
                <when test="criterion.betweenValue" >
                  and ${criterion.condition} #{criterion.value} and #{criterion.secondValue}
                </when>
                <when test="criterion.listValue" >
                  and ${criterion.condition}
                  <foreach collection="criterion.value" item="listItem" open="(" close=")" separator="," >
                    #{listItem}
                  </foreach>
                </when>
              </choose>
            </foreach>
          </trim>
        </if>
      </foreach>
    </where>
  </sql>
  
  </#noparse>
  
  <#noparse>
  <sql id="Update_By_Example_Where_Clause" >
    <where >
      <foreach collection="example.oredCriteria" item="criteria" separator="or" >
        <if test="criteria.valid" >
          <trim prefix="(" suffix=")" prefixOverrides="and" >
            <foreach collection="criteria.criteria" item="criterion" >
              <choose >
                <when test="criterion.noValue" >
                  and ${criterion.condition}
                </when>
                <when test="criterion.singleValue" >
                  and ${criterion.condition} #{criterion.value}
                </when>
                <when test="criterion.betweenValue" >
                  and ${criterion.condition} #{criterion.value} and #{criterion.secondValue}
                </when>
                <when test="criterion.listValue" >
                  and ${criterion.condition}
                  <foreach collection="criterion.value" item="listItem" open="(" close=")" separator="," >
                    #{listItem}
                  </foreach>
                </when>
              </choose>
            </foreach>
          </trim>
        </if>
      </foreach>
    </where>
  </sql>

</#noparse>
	<sql id="Base_Column_List">
	    <![CDATA[
	   
        <#list table.columns as column>
        	${column.sqlName} <#if column_has_next>,</#if>
        </#list>
	    ]]>
	</sql>

<select id="selectByExample" resultMap="BaseResultMap">
     select 
        <include refid="Base_Column_List"/>
       
            from ${table.sqlName} WHERE 1=1  
      
        <if test="_parameter != null" >
      <include refid="Example_Where_Clause" />
    </if>
    <if test="orderByClause != null" >
     <#noparse>  order by ${orderByClause} </#noparse>
    </if>
    
    </select>
      
      
   <select id="selectByPrimaryKey" resultMap="BaseResultMap">
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
       
<delete id="deleteByExample" parameterType="${basepackage}.model.{modelName}.${className}Example">
   delete from ${table.sqlName} where
    <<if test="_parameter != null" >
      <include refid="Example_Where_Clause" />
    </if>
   </delete>
       

 <insert id="insert" useGeneratedKeys="true" keyProperty="${table.idColumn.columnNameFirstLower}">

        INSERT INTO ${table.sqlName} (
        <#list table.columns as column> ${column.sqlName}<#if column_has_next>,</#if></#list>
        ) VALUES (
        <#list table.columns as column> <@mapperElJdbc column.columnNameFirstLower column.jdbcSqlTypeName /><#if column_has_next>,</#if></#list>        
        )
   
</insert>

 <insert id="insertSelective" parameterType="${basepackage}.model.{modelName}.${className}">
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
 
 <select id="countByExample" parameterType="${basepackage}.model.{modelName}.${className}Example" resultType="java.lang.Integer" >
    select count(*) from ${table.sqlName}
    <if test="_parameter != null" >
      <include refid="Example_Where_Clause" />
    </if>
  </select>
  

    <update id="updateByPrimaryKeySelective" parameterType="${basepackage}.model.${modelName}.${className}">
    
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
    
 <update id="updateByExample" parameterType="${basepackage}.model.${modelName}.${className}">

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

</mapper>
