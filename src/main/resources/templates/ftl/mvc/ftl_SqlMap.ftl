<@extends path="../ftl_SqlMap.ftl"/>
<#macro resultMap>
<resultMap id="BaseResultMap" type="java.util.Map">
  <#assign list_tbl=table.view!table/>
  <#list list_tbl.columns.values() as col>
     <result column="${col.name}" jdbcType="${col.typeName}" property="${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first}" />
  </#list>
</resultMap>
</#macro>
<#macro list>
<select id="list" resultMap="BaseResultMap" parameterType="java.util.HashMap">
    SELECT 
    <include refid="baseColumnList" />
       FROM ${list_tbl.name} a
		where 1=1  
		 <#list table.columns.values() as col>
	     <#if (col.pk)>
		   <if test="${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first} != null and ${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first} !=''">
			and  ${col.name}=${"#{"}${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first},jdbcType=${col.typeName}${"}"}
		   </if>
		 </#if>
		<#if col.be>
		<if test="${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first}Start != null and ${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first}Start !=''">
        <![CDATA[and ${col.name} >= ${"${"}lengthStart} ]]>
		</if>
		<if test="${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first}End != null and ${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first}End !=''">
        <![CDATA[and ${col.name} <= ${"${"}lengthEnd} ]]>
		</if>
		</#if>
		<#if (col.name=="CREATED_DATE")>
		  <if test="dateBegin != null and dateBegin != '' ">
        	<![CDATA[and to_timestamp(${col.name},'yyyy-mm-dd hh24:mi:ss.ff') >= to_timestamp('${"${"}dateBegin}','yyyy-mm-dd hh24:mi:ss.ff')]]> 
         </if>
         <if test="dateEnd != null and dateEnd != ''">
        	<![CDATA[and to_timestamp(${col.name},'yyyy-mm-dd hh24:mi:ss.ff') <= to_timestamp('${"${"}dateEnd}','yyyy-mm-dd hh24:mi:ss.ff')]]> 
         </if>
        </#if>
		 <#if col.search>
		  <if test="${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first} != null and ${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first} !=''">
		 and  ${col.name}=${"#{"}${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first},jdbcType=${col.typeName}${"}"}
		 </if>
		 <#elseif col.simpleSearch>
		  <if test="${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first} != null and ${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first} !=''">
		  and ${col.name} LIKE '%${"$"}{${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first}}%'
		</if>											
		  </#if>
	 </#list>	
		
		 <@orderby pre="a"/>
		 order by created_date asc
</select>
</#macro>
<#macro orderby pre="">
<#if (table.sortColumns.size()>0)>
		order by <#rt>
		<#list table.sortColumns.values() as col>
			<#if pre!="">${pre}.</#if>${col.name} ${col.sortType}<#if col_has_next>,</#if><#t>
		</#list>
		
	</#if>
</#macro>
<#macro insert>	
<insert id="insert" parameterType="${pkg}.${namespace}.vo.${table.alias}Vo">
		INSERT INTO ${table.name}(<#assign flag=false><#list table.columns.values() as col><#if (col.name!="UPDATED_BY" && col.name!="UPDATED_DATE")><#if flag>,</#if><#assign flag=true>${col.name}</#if></#list>)
		VALUES(<#rt>
		<#assign flag=false>
		<#list table.columns.values() as col><#t>
		<#if (col.name!="UPDATED_BY" && col.name!="UPDATED_DATE")><#if flag>,</#if>
		<#if (col.name=="CREATED_DATE")>
		 ${"#{"}${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first},jdbcType=${col.typeName}${"}"}
		 <#else>
		 <#assign flag=true>${"#{"}${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first},jdbcType=${col.typeName}${"}"}
		</#if>
		</#if></#list>)
</insert>
</#macro>
<#macro update>
	<update id="update" parameterType="${pkg}.${namespace}.vo.${table.alias}Vo">
		UPDATE ${table.name} 
		<set>
			<#list table.columns.values() as col>
			<if test="${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first} !=null and ${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first} !=''">
				<#if (col.name=="CREATED_DATE"||col.name=="UPDATED_DATE")>
				${col.name} =${"#{"}${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first},jdbcType=${col.typeName}${"}"},
				<#else>
				${col.name} = ${"#{"}${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first},jdbcType=${col.typeName}${"}"},
				</#if>
			</if>
			</#list>
		</set>
		
	  <#list table.columns.values() as col>
	     <#if (col.pk)>
		   <if test="${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first} != null and ${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first} !=''">
			WHERE  ${col.name}=${"#{"}${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first},jdbcType=${col.typeName}${"}"}
		 </if>
	   </#if>	
	 </#list>
	</update>
</#macro>

<#macro checkUnique>	
	<#if (table.uniqueColumns.size()>0)>
	<select id="checkUnique" resultType="java.lang.String" parameterType="java.util.HashMap">
		 SELECT case when count(1)>0 then 
 		 <#list table.uniqueColumns.values() as col>
 		 <if test="${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first} !=null and ${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first} !=''">
				${col.name}
		 </if>
		 </#list>
		  else '1'
   		  end as VALUE FROM ${list_tbl.name} a
 		  WHERE 1=1 		 
		 <#list table.uniqueColumns.values() as col>
			   <if test="${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first} !=null and ${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first} !=''">
			    and ${col.name} in ${"${"}${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first}${"}"}
			   </if>
		  </#list>
		  GROUP BY
		   <#list table.uniqueColumns.values() as col>
 		 <if test="${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first} !=null and ${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first} !=''">
				${col.name}
		 </if>
		 </#list>
	</select>
	</#if>
</#macro>
<#macro methods></#macro>	
