<#----------------------------- 内容 ----------------------------->
/*---------代码生成请勿手工修改---------*/
<@imports/>
<@class/>
<#----------------------------- 定义 ----------------------------->
<#macro imports>
package ${pkg}.${namespace}.dao;
import java.util.List;
import java.util.Map;
import ${pkg}.${namespace}.vo.${table.alias}Vo;
<@imports_other/>
</#macro>
<#macro imports_other></#macro>
<#macro class>
/**
 * ${table.des!table.name}
 */
public interface ${table.alias}Dao {
<@insert/>
<@insertBatch/>
<@update/>
<@updateBatch/>
<@delete/>
<@deleteBatch/>
<@one/>
<@list/>
<@count/>
<@exists/>
<@checkUnique/>
<@methods/>
}
</#macro>
<#macro insert>
<#if table.add>
  <#if table.add>
  /**
    * 增加
	* @param vo
	* @return
	*/
	public void insert(${table.alias}Vo vo);
</#if>
</#if>
</#macro>
<#macro insertBatch>
<#if table.add>
   /**
	 * 批量新增
	 * @param list
	 */
	public int  insertBatch(List  list); 
</#if>	 
</#macro>
<#macro update>
<#if table.edit>
   /**
	 * 修改
	 * @param vo
	 * @return
	 */
	public int update(${table.alias}Vo vo);
</#if>		
</#macro>
<#macro updateBatch>
<#if table.edit>
   /**
	 * 批量修改
	 * @param list
	 */
	public int  updateBatch(List  list);	
</#if>	 
</#macro>
<#macro delete>
<#if table.delete>
   /**
	 * 删除
	 * @param formMap
	 * @return
	 */
	public int delete(Map formMap);
</#if>	
</#macro>
<#macro deleteBatch>
<#if table.delete>
   /**
	 * 批量删除
	 * @param formMap
	 * @return
	 */
	public int deleteBatch(Map formMap);
</#if>	
</#macro>
<#macro one>
   /**
	 * 查询对象
	 * @param formMap
	 * @return
	 */
	public Map one(Map formMap);
</#macro>
<#macro list>
   /**
	 * 查询结果集
	 * @param formMap
	 * @return
	 */
	public List<Map<String, Object>> list(Map formMap);
</#macro>
<#macro count>
   /**
	 * 统计
	 * @param formMap
	 * @return
	 */
	public int  count(Map formMap);
</#macro>
<#macro exists>
   /**
	 * 检查是否存在
	 * @param formMap
	 * @return
	 */
	public boolean  exists (Map formMap);
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
<#macro methods></#macro>