<#----------------------------- 内容 ----------------------------->
/*---------代码生成请勿手工修改---------*/
<@imports/>
<@class/>
<#----------------------------- 定义 ----------------------------->
<#macro imports>
package ${pkg}.${namespace}.service.impl;
import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Service;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.utils.CommonUtils;
import com.ssm.base.page.PageObjectWrapper;
import ${pkg}.${namespace}.dao.${table.alias}Dao;
import ${pkg}.${namespace}.service.inter.${table.alias}Service;
import ${pkg}.${namespace}.vo.${table.alias}Vo;
import ${pkg}.mrmf.util.TransactionException;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.ObjectUtils;
import ${pkg}.utils.JsonHelper;
import ${pkg}.utils.SessionDataUtil;
import javax.servlet.http.HttpServletRequest;
<@imports_other/>
</#macro>
<#macro imports_other></#macro>
<#macro class>
/**
 * ${table.des!table.name}
 */
@Service
public class ${table.alias}ServiceImpl implements ${table.alias}Service {
  private static Logger logger = Logger.getLogger(${table.alias}ServiceImpl.class);
  @Autowired
  ${table.alias}Dao ${table.alias?uncap_first}Dao;
  <@otherAutowired/>
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
	 * @throws InvocationTargetException 
	 * @throws IllegalAccessException 
	 */
	@Transactional
	@Override
	public Map insert(List<Map> list,HttpServletRequest request) throws IllegalAccessException, InvocationTargetException {
		HashMap resultMap=new HashMap();
		Map userMap=new HashMap();
		userMap= SessionDataUtil.getUserMap(request);
		for(Map map:list) {
			${table.alias}Vo vo = new ${table.alias}Vo();
			BeanUtils.populate(vo, map);
			vo.set${table.alias}Id(CommonUtils.getUuid());
			vo.setCreatedBy(ObjectUtils.toString(userMap.get("name")));
			vo.setCreatedId(ObjectUtils.toString(userMap.get("userId")));
			String ts = CommonUtils.getSysDate();
			System.out.println(ts + "###");
			vo.setCreatedDate(ts);
			vo.setUpdatedDate(ts);
			${table.alias?uncap_first}Dao.insert(vo);
		}
		
		return resultMap;
	 }
</#if>
</#macro>
<#macro insertBatch>
<#if table.add>
   /**
	 * 批量新增
	 * @param list
	 */
	@Override
	@Transactional 
	public int  insertBatch(List  list){
	return this.${table.alias?uncap_first}Dao.insertBatch(list);
	}
</#if>	  
</#macro>
<#macro update>
<#if table.edit>
   /**
	 * 修改
	 * @param vo
	 * @return
	 */
	@Override 
	public Map update(List<Map> list,HttpServletRequest request) throws IllegalAccessException, InvocationTargetException{
		HashMap resultMap=new HashMap();
		Map userMap=new HashMap();
		userMap= SessionDataUtil.getUserMap(request);
		for(Map map:list) {
			String ts=CommonUtils.getSysDate();
			System.out.println(ts);
			${table.alias}Vo vo = new ${table.alias}Vo();
			BeanUtils.populate(vo, map);
			vo.setUpdatedDate(ts);
			vo.setUpdatedId(ObjectUtils.toString(userMap.get("userId")));
			vo.setUpdatedBy(ObjectUtils.toString(userMap.get("name")));
			${table.alias?uncap_first}Dao.update(vo);
		}
		return resultMap;
	}
</#if>	
</#macro>
<#macro updateBatch>
<#if table.edit>
   /**
	 * 批量修改
	 * @param list
	 */
	@Override
	@Transactional  
	public int  updateBatch(List  list){
	return this.${table.alias?uncap_first}Dao.updateBatch(list);
	}
</#if>
</#macro>
<#macro delete>
<#if table.delete>
   /**
	 * 删除
	 * @param formMap
	 * @return
	 */
	@Override
	@Transactional 
	public int delete(Map formMap) {
		return this.${table.alias?uncap_first}Dao.delete(formMap);
	}
</#if>		
</#macro>
<#macro deleteBatch>
<#if table.delete>
   /**
	 * 删除
	 * @param formMap
	 * @return
	 */
	@Override
	@Transactional 
	public int deleteBatch(Map formMap) {
		return this.${table.alias?uncap_first}Dao.deleteBatch(formMap);
	}
</#if>		
</#macro>
<#macro one>
  /**
	 * 查询对象
	 * @param Map
	 * @return
	 */
	@Override
	public Map one(Map formMap) {
		List<Map<String, Object>> list=this.${table.alias?uncap_first}Dao.list(formMap);
		if(null!=list&&!list.isEmpty()){
			return list.get(0);
		}
		return null;
	}
</#macro>
<#macro list>
   /**
	 * 查询结果集
	 * @param formMap
	 * @return
	 */
	@Override
	public List<Map<String, Object>> list(Map formMap) {
	List<Map<String, Object>> maps=this.${table.alias?uncap_first}Dao.list(formMap);
	return CommonUtils.formatHumpNameForList(maps);
	}
</#macro>
<#macro pageList>
	/**
	 *  分页查询结果集
	 * @param page
	 * @param formMap
	 * @return
	 */
	@Override
	public List<Map<String, Object>>  list(PageInfo<Map> pageInfo, Map formMap) {
		if (pageInfo.getPageSize() == 0) {
			pageInfo.setPageSize(10);
			pageInfo.setPageNum(1);
		}
		if (pageInfo != null) {
			PageHelper.startPage(pageInfo.getPageNum(), pageInfo.getPageSize());
		}
		List<Map<String, Object>> list = this.${table.alias?uncap_first}Dao.list(formMap);
		PageObjectWrapper pw = new PageObjectWrapper(pageInfo);
		pw.addAll(list);
		List<Map<String, Object>>  resultList=list;
		//List<Map<String, Object>>  resultList=CommonUtils.formatHumpNameForList(list);
		return resultList;
	}
</#macro>
<#macro count>
   /**
	 * 统计
	 * @param formMap
	 * @return
	 */
	public int  count(Map formMap){
	return this.${table.alias?uncap_first}Dao.count(formMap);
	}
</#macro>
<#macro exists>
   /**
	 * 检查是否存在
	 * @param formMap
	 * @return
	 */
	public boolean  exists (Map formMap){
	return this.${table.alias?uncap_first}Dao.exists(formMap);
	}
</#macro>
<#macro checkUnique>
<#if (table.uniqueColumns.size()>0)>
  /**
	 * 检查唯一
	 * @param formMap
	 * @return
	 * @throws InvocationTargetException 
	 * @throws IllegalAccessException 
	 */
	@Transactional
	public boolean checkUnique (List<Map> list,String columnName,String msg,String sort) throws IllegalAccessException, InvocationTargetException{
		Map resultMap=new HashMap();
		Map sortMap=new HashMap();
		String str="('";
		int i=1;
		for(Map map:list) {
			${table.alias}Vo vo = new ${table.alias}Vo();
			BeanUtils.populate(vo, map);
			if(!sortMap.containsKey(map.get(columnName))){//防止重复添加key
				sortMap.put(map.get(columnName), i);
			}
			else {
				resultMap.put("msg", msg);//1代表编码重复
				resultMap.put("sort", i);
				resultMap.put("columnName",columnName);
				throw new TransactionException(resultMap);
			}
			if(i==list.size()) {
				str+=map.get(columnName)+"')";
			}
			else {
				str+=map.get(columnName)+"','";
			}
			i++;
		}
		HashMap checkMap = new HashMap();// 可添加多个唯一字段，进行判断
		checkMap.put(columnName, str);
		List<String> result=${table.alias?uncap_first}Dao.checkUnique(checkMap);
		if (result.size()!=0) {
			resultMap.put("msg", msg);//1代表编码重复
			resultMap.put("sort", sortMap.get(result.get(0)));
			resultMap.put("columnName",columnName);
			throw new TransactionException(resultMap);
		}
		return true;
	}
</#if>	
</#macro>
<#macro start>
	/**
	 * 启用
	 * @param vo
	 * @param request
	 */
	public void start(${table.alias}Vo vo,HttpServletRequest request) {
		vo.setState("1");
		${table.alias?uncap_first}Dao.update(vo);
	}
</#macro>
<#macro stop>
	/**
	 * 停用
	 * @param vo
	 */
	public void stop(${table.alias}Vo vo) {
		vo.setState("0");
		${table.alias?uncap_first}Dao.update(vo);
	}
</#macro>
<#macro methods></#macro>
<#macro otherAutowired></#macro>