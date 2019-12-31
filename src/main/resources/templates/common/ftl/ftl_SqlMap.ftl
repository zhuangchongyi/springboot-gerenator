<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<!--代码生成请勿手工修改 -->
<@mapperSpace/><#macro mapperSpace><mapper namespace="${pkg}.${namespace}.dao.${table.alias}Dao"></#macro>
<@mapper/>
</mapper>
<#macro mapper>
    <@resultMap/>
    <@baseColumnList/>
	<@list/>
	<@one/>
	<@insert/>
	<@insertBatch/>
	<@update/>
	<@updateBatch/>
	<@delete/>
	<@deleteBatch/>
	<@count/>
	<@exists/>
	<@checkUnique/>
	<@methods/>
</#macro>
<#macro resultMap>
<resultMap id="BaseResultMap" type="java.util.Map">
  <#assign list_tbl=table.view!table/>
  <#list list_tbl.columns.values() as col>
     <result column="${col.name}" jdbcType="${col.typeName}" property="${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first}" />
  </#list>
</resultMap>
</#macro>
<#macro baseColumnList>
<sql id="baseColumnList">
		 <#list list_tbl.columns.values() as col>
		 a.${col.name}<#if col_has_next>,</#if><#t>
		 </#list> 
<#nt></sql>
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
		  <if test="${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first}Begin != null and ${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first}Begin != '' ">
        	<![CDATA[and to_timestamp(${col.name},'yyyy-mm-dd hh24:mi:ss.ff') >= to_timestamp('${"${"}${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first}Begin}','yyyy-mm-dd hh24:mi:ss.ff')]]> 
         </if>
         <if test="${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first}End != null and ${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first}End != ''">
        	<![CDATA[and to_timestamp(${col.name},'yyyy-mm-dd hh24:mi:ss.ff') <= to_timestamp('${"${"}${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first}End}','yyyy-mm-dd hh24:mi:ss.ff')]]> 
         </if>
        </#if>
		<#if (col.name=="UPDATED_DATE")>
		  <if test="${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first}Begin != null and ${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first}Begin != '' ">
        	<![CDATA[and to_timestamp(${col.name},'yyyy-mm-dd hh24:mi:ss.ff') >= to_timestamp('${"${"}${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first}Begin}','yyyy-mm-dd hh24:mi:ss.ff')]]> 
         </if>
         <if test="${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first}End != null and ${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first}End != ''">
        	<![CDATA[and to_timestamp(${col.name},'yyyy-mm-dd hh24:mi:ss.ff') <= to_timestamp('${"${"}${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first}End}','yyyy-mm-dd hh24:mi:ss.ff')]]> 
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
<#macro one>	
<select id="one" resultType="java.util.HashMap" parameterType="java.util.HashMap">
		SELECT
		<include refid="baseColumnList" />
		 FROM ${list_tbl.name} a
		 <trim prefix="WHERE" prefixOverrides="AND|OR">
		  <#list table.columns.values() as col>
	     <#if (col.pk)>
			AND  ${col.name}=${"#{"}${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first},jdbcType=${col.typeName}${"}"}
	   </#if>	
	 </#list>
	  </trim>
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
<#macro insertBatch>	
<insert id="insertBatch" parameterType="java.util.List">
    INSERT INTO ${table.name}(<#list list_tbl.columns.values() as col>${col.name}<#if col_has_next>,</#if><#t></#list> )
    select <#list list_tbl.columns.values() as col>${col.name}<#if col_has_next>,</#if><#t></#list> from(
    <foreach collection="list" item="item" index="index"  close=")" open="(" separator="union">
        SELECT
        <#list table.columns.values() as col>
		${"#{"}item.${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first},jdbcType=${col.typeName}${"}"},
		</#list>
        FROM DUAL
    </foreach>
    ) 
   </insert>
</#macro>
<#macro update>
	<update id="update" parameterType="${pkg}.${namespace}.vo.${table.alias}Vo">
		UPDATE ${table.name} 
		<set>
			<#list table.columns.values() as col>
			<if test="${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first} !=null">
				<#if (col.name=="CREATED_DATE"||col.name=="UPDATED_DATE")>
				${col.name} =${"#{"}${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first},jdbcType=${col.typeName}${"}"},
				<#else>
				${col.name} = ${"#{"}${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first},jdbcType=${col.typeName}${"}"},
				</#if>
			</if>
			</#list>
		</set>
		
	  <trim prefix="WHERE" prefixOverrides="AND|OR">
		  <#list table.columns.values() as col>
	     <#if (col.pk)>
			AND  ${col.name}=${"#{"}${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first},jdbcType=${col.typeName}${"}"}
	   </#if>	
	 </#list>
	  </trim>
	</update>
</#macro>
<#macro updateBatch>	
<update id="updateBatch" parameterType="java.util.List">
		<foreach collection="list" item="item" index="index" open="begin"
			close=";end;" separator=";">
			UPDATE ${table.name} 
			<set>
			<#list table.columns.values() as col>
			 <#if (!col.pk)>
			<if test="item.${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first} !=null">
				${col.name} = ${"#{"}item.${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first},jdbcType=${col.typeName}${"}"},
			</if>
			</#if>	
			</#list>
			</set>
			<trim prefix="WHERE" prefixOverrides="AND|OR">
		  <#list table.columns.values() as col>
	     <#if (col.pk)>
			AND  ${col.name}=${"#{"}${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first},jdbcType=${col.typeName}${"}"}
	   </#if>	
	 </#list>
	  </trim>
		</foreach>
	</update>
</#macro>

<#macro delete>
   <#assign flag=false>
   <#list table.columns.values() as col>
	   <#if (col.name=="DR")>
		<#assign flag=true>
	      </#if>	
	</#list>
	 <delete id="delete"   parameterType="java.util.HashMap">
    <#if flag>
      UPDATE ${table.name} a set a.DR='1'
	 <#elseif !flag>
       DELETE FROM ${table.name} 
	 </#if>
	  <trim prefix="WHERE" prefixOverrides="AND|OR">
		  <#list table.columns.values() as col>
	     <#if (col.pk)>
			AND  ${col.name}=${"#{"}${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first},jdbcType=${col.typeName}${"}"}
	   </#if>	
	 </#list>
	  </trim>
	 
     </delete>
</#macro>
<#macro deleteBatch>
   <#assign flag=false>
   <#list table.columns.values() as col>
	   <#if (col.name=="DR")>
		<#assign flag=true>
	      </#if>	
	</#list>
	 <delete id="deleteBatch"   parameterType="java.util.HashMap">
    <#if flag>
      UPDATE ${table.name}  set  DR='1'
	 <#elseif !flag>
       DELETE FROM ${table.name} 
	 </#if>
	  <#list table.columns.values() as col>
	     <#if (col.pk)>
		   <if test="${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first} != null and ${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first} !=''">
			WHERE  ${col.name} in 
				<foreach item="${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first}" collection="array" open="(" separator="," close=")">
			${"#{"}${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first},jdbcType=${col.typeName}${"}"}
		</foreach>
		</if>
	   </#if>	
	 </#list>
	 
     </delete>
</#macro>
<#macro count>
<select id="count" resultType="int" parameterType="java.util.HashMap">
		SELECT count(1) FROM ${table.name} a
		<#assign flag=false>
		   <#list table.columns.values() as col>
			   <#if (col.name=="DR")>
				<#assign flag=true>
			      </#if>	
			</#list>
			 <#if flag> WHERE a.DR=0 <#elseif !flag> </#if>
		<trim prefix="WHERE" prefixOverrides="AND|OR">
		  <#list table.columns.values() as col>
	     <#if (col.pk)>
		   <if test="${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first} != null and ${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first} !=''">
			and  ${col.name}=${"#{"}${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first},jdbcType=${col.typeName}${"}"}
		 </if>
	   </#if>	
	 </#list>
	 </trim>		 
			 
</select>
</#macro>
<#macro exists>	
<select id="exists" resultType="java.lang.Boolean" parameterType="java.util.HashMap">
 SELECT case when count(1)>0 then 1 else 0 end as VALUE FROM ${table.name} a
    <#assign flag=false>
	   <#list table.columns.values() as col>
		   <#if (col.name=="DR")><#assign flag=true></#if>	
	  </#list>
	  <#if flag> WHERE a.DR='0'<#elseif !flag> WHERE 1=1 </#if><#t>	
	    <#list table.columns.values() as col>
	     <#if (col.pk)>
		   <if test="${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first} != null and ${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first} !=''">
		 and   ${col.name}=${"#{"}${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first},jdbcType=${col.typeName}${"}"}
		 </if>
	   </#if>	
	 </#list>	  
</select>
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
 		  <trim prefix="WHERE" prefixOverrides="AND|OR">
		 <#list table.uniqueColumns.values() as col>
			   <if test="${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first} !=null and ${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first} !=''">
			    AND ${col.name} in ${"${"}${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first}${"}"}
			   </if>
		  </#list>
		  </trim>
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
