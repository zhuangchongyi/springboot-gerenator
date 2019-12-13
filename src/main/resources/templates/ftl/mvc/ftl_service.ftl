<@extends path="../ftl_service.ftl"/>
<#macro imports_other>
import javax.servlet.http.HttpServletRequest;
</#macro>
<#macro insert>
<#if table.add>
  /**
    * 增加
	* @param vo
	* @return
	*/
	public Map insert(List<Map> list,HttpServletRequest request) throws IllegalAccessException, InvocationTargetException;
</#if>		
</#macro>
<#macro update>
<#if table.edit>
   /**
	 * 修改
	 * @param vo
	 * @return
	 */
	public Map update(List<Map> list,HttpServletRequest request) throws IllegalAccessException, InvocationTargetException;
</#if>	
</#macro>
<#macro checkUnique>
 <#if (table.uniqueColumns.size()>0)>
   /**
	 * 检查唯一
	 * @param formMap
	 * @return
	 */
	public boolean checkUnique (List<Map> list,String columnName,String msg,String sort) throws IllegalAccessException, InvocationTargetException;
 </#if>
</#macro>
<#macro methods></#macro>

