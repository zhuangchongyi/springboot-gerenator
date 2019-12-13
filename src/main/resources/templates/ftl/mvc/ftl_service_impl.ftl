<@extends path="../ftl_service_impl.ftl"/>
<#macro imports_other>
import com.ssm.mrmf.util.TransactionException;
import java.lang.reflect.InvocationTargetException;
import java.sql.Timestamp;
import java.util.HashMap;
import com.ssm.sys.util.DateUtils;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.ObjectUtils;
import com.ssm.utils.JsonHelper;
import com.ssm.utils.SessionDataUtil;
import javax.servlet.http.HttpServletRequest;
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
			vo.setUpdatedBy(ObjectUtils.toString(userMap.get("name")));
			${table.alias?uncap_first}Dao.update(vo);
		}
		return resultMap;
	}
</#if>	
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
		return resultList;
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
<#macro methods></#macro>