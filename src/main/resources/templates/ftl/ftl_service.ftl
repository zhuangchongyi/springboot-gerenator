<#----------------------------- 内容 ----------------------------->
/*---------代码生成请勿手工修改---------*/
<@imports/>
<@class/>
<#----------------------------- 定义 ----------------------------->
<#macro imports>
package ${pkg}.${namespace}.service.inter;
import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.Map;
import com.github.pagehelper.PageInfo;
import ${pkg}.${namespace}.vo.${table.alias}Vo;
import javax.servlet.http.HttpServletRequest;
<@imports_other/>
</#macro>
<#macro imports_other></#macro>
<#macro class>
/**
 * ${table.des!table.name}
 */
public interface ${table.alias}Service {
<@insert/>
<@insertBatch/>
<@update/>
<@updateBatch/>
<@delete/>
<@deleteBatch/>
<@one/>
<@list/>
<@pageList/>
<@count/>
<@exists/>
<@checkUnique/>
<@start/>
<@stop/>
<@methods/>
}
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
	public Map update(List<Map> list,HttpServletRequest request) throws IllegalAccessException, InvocationTargetException;
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
<#macro pageList>
   /**
	 *  分页查询结果集
	 * @param page
	 * @param formMap
	 * @return
	 */
	public List<Map<String, Object>> list(PageInfo<Map> pageInfo, Map formMap);
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
	public boolean checkUnique (List<Map> list,String columnName,String msg,String sort) throws IllegalAccessException, InvocationTargetException;
</#if>		
</#macro>
<#macro start>
	/**
	 * 启用
	 * @param vo
	 * @param request
	 */
	public void start(${table.alias}Vo vo,HttpServletRequest request);
</#macro>
<#macro stop>
	/**
	 * 停用
	 * @param vo
	 */
	public void stop(${table.alias}Vo vo);
</#macro>
<#macro methods></#macro>

