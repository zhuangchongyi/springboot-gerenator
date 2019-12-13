<@extends path="../ftl_dao.ftl"/>
<#macro insert>
<#if table.add>
  /**
    * 增加
	* @param vo
	* @return
	*/
	public void insert(${table.alias}Vo vo);
</#if>
</#macro>
<#macro checkUnique>
<#if (table.uniqueColumns.size()>0)>
   /**
	 * 检查唯一
	 * @param formMap
	 * @return
	 */
	public List<String> checkUnique (Map formMap);
</#if>	
</#macro>
