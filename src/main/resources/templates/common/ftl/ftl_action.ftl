<#----------------------------- 内容 ----------------------------->
<#assign list_tbl=table.view!table/>
/*---------代码生成请勿手工修改---------*/
<@imports/>
<@class/>
<#----------------------------- 定义 ----------------------------->
<#macro imports>
package ${pkg}.${namespace}.action;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import ${pkg}.mrmf.util.TransactionException;
import com.github.pagehelper.PageInfo;
import ${pkg}.${namespace}.service.inter.${table.alias}Service;
import ${pkg}.base.action.SysBaseAction;
import ${pkg}.utils.JsonResult;
import ${pkg}.utils.JsonHelper;
import ${pkg}.${namespace}.vo.${table.alias}Vo;
import com.ssm.utils.SessionDataUtil;
<@imports_other/>
</#macro>
<#macro class>
/**
 * ${table.des!table.name}
 */
@Controller
@RequestMapping("${namespace?replace('.','/')}/${table.alias?lower_case}")
public class ${table.alias}Action extends SysBaseAction {
	<@body/>
}
</#macro>
<#macro body>
	<@fields/>
	<@setterGetters/>
	<@list/>
	<@loadList/>
	<#if table.add>
	<@toAddList/>
	<@add/>
	</#if>
	<#if table.edit>
	<@toEditList/>
	<@edit/>
	</#if>
	<#if table.delete>
	<@delete/>
	</#if>
	<@checkUnique/>
	<@start/>
	<@stop/>
	<@methods/>
</#macro>
<#macro imports_other></#macro>
<#macro methods></#macro>
<#macro beforeAdd></#macro>
<#macro before_edit></#macro>
<#macro before_delete></#macro>
<#macro fields>
	public static final String AUTH_LIST="${table.name}_LIST";
	<#if table.add>
	public static final String AUTH_ADD="${table.name}_ADD";
	</#if>
	<#if table.add>
	public static final String AUTH_EDIT="${table.name}_EDIT";
	</#if>
	<#if table.delete>
	public static final String AUTH_DEL="${table.name}_DEL";
	</#if>
	<#if table.delete>
	public static final String AUTH_START="${table.name}_START";
	</#if>
	<#if table.delete>
	public static final String AUTH_STOP="${table.name}_STOP";
	</#if>
	<@otherFields/>
	/**
	 * 服务层
	 */
	@Autowired
	${table.alias}Service ${table.alias?uncap_first}Service;
	<@otherAutowired/>
</#macro>
<#macro otherFields></#macro>
<#macro setterGetters></#macro>
<#macro otherAutowired></#macro>
<#macro list>
   /**
	 * http://127.0.0.1/ssm/${namespace?replace('.','/')}/${table.alias?lower_case}/list.do
	 * 跳转到列表页面
	 * @return
	 */
	@RequestMapping(value = "list.do",method = RequestMethod.GET)
	public String list(Model model,HttpServletRequest request) {
	   <#if table.checkAuth>
	   this.checkAuth(AUTH_LIST,request);
	   </#if>
	   <@listAfter/>
	  return "${namespace?replace('.','/')}/${table.alias?lower_case}/list";
	}
</#macro>
<#macro loadList>
   /**
	 * http://127.0.0.1/ssm/${namespace?replace('.','/')}/${table.alias?lower_case}/loadList.do
	 * 加载列表数据集
	 * @param formMap   参数
	 * @param pageInfo  分页对象
	 * @param page      页码
	 * @param rows      每页数据行数
	 * @param request   
	 * @return
	 */
	@RequestMapping(value = "loadList.do")
	@ResponseBody
	public Map loadList(@RequestParam Map<String, Object> formMap,PageInfo<Map> pageInfo,
		                    @RequestParam(defaultValue="0")int page,
		                    @RequestParam(defaultValue="0")int rows,HttpServletRequest request) {
		pageInfo.setPageSize(rows);
		pageInfo.setPageNum(page);
		if(!checkAuth(AUTH_START,request)) {
			formMap.put("state", "1");	
		}
		List<Map<String, Object>> resultList = this.${table.alias?uncap_first}Service.list(pageInfo, formMap);
		Map resultMap = new HashMap();
		resultMap.put("total", pageInfo.getTotal());
		resultMap.put("rows", resultList);
		return resultMap;
	}
</#macro>

 
<#macro toAddList>
<#if table.add>
   /**
	 * http://127.0.0.1/ssm/${namespace?replace('.','/')}/${table.alias?lower_case}/toAddList.do
	 * 跳转到新增界面
	 * @return
	 */
	@RequestMapping(value = "toAdd.do",method = RequestMethod.GET)
	public String toAdd(@RequestParam Map<String,Object> formMap,Model model,HttpServletRequest request) {
	   this.checkAuth(AUTH_ADD,request);
	    <@addAfter/>
	 return "/${namespace?replace('.','/')}/${table.alias?lower_case}/add";
	}
</#if>	
</#macro>
<#macro add>
<#if table.add>
	/**
	 * http://127.0.0.1/ssm/sys/${table.alias?lower_case}/add.do
	 * 新增数据
	 * @param vo 新增对象
	 * @return
	 */
	@RequestMapping(value = "add.do")
	@ResponseBody // 如果没有跳转页面要加上，否则会提示404
	public JsonResult add(String json ,HttpServletRequest request) throws IllegalAccessException, InvocationTargetException {
		System.out.println(json);
		List<Map>  list= JsonHelper.jsonToList(json);
		JsonResult jsonResult=new JsonResult();
		Map map=new HashMap();
		try{
			if(${table.alias?uncap_first}Service.checkUnique(list,"${table.alias?uncap_first}Num","编码重复","sort")&&${table.alias?uncap_first}Service.checkUnique(list,"${table.alias?uncap_first}Name","名称重复","sort")) {
				map=${table.alias?uncap_first}Service.insert(list,request);
				jsonResult.setSuccess(true);
				jsonResult.setMsg("新增成功");
			}
		}
		catch(TransactionException e) {
			map=(Map)e.getObj();
				/* return "{\"errorMsg\":\"编码重复无法添加！！！！########\",\"vo\":"+vo.getSort()+"}"; */
				jsonResult.setSuccess(false);
				jsonResult.setMsg(map.get("msg").toString());
				jsonResult.setObj(map);
		}
		return jsonResult;
		
	}
</#if>	
</#macro>
<#macro beforeAdd></#macro>
<#macro afterAdd></#macro>
<#macro toEditList>
<#if table.edit>
	/**
	 * http://127.0.0.1/ssm/${namespace?replace('.','/')}/${table.alias?lower_case}/toEditList.do
	 * 跳转到修改界面
	 * @param formMap  请求参数
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "toEdit.do",method = RequestMethod.GET)
	public String toEdit(@RequestParam(defaultValue="0")int page,Model model) {
		model.addAttribute("pageNum", page);
		return "${namespace?replace('.','/')}/${table.alias?lower_case}/edit";
	}
</#if>	
</#macro>
<#macro edit>
<#if table.edit>
	/**
	 * http://127.0.0.1/ssm/${namespace?replace('.','/')}/${table.alias?lower_case}/edit.do
	 * 修改数据
	 * @param vo  修改对象
	 * @return
	 */
	@RequestMapping(value = "edit.do")
	@ResponseBody
	public JsonResult edit(@RequestParam String json,HttpServletRequest request) throws IllegalAccessException, InvocationTargetException {
		JsonResult jsonResult=new JsonResult();
		System.out.println(json);
		List<Map>  list= JsonHelper.jsonToList(json);
		Map map=new HashMap();
		try {
			${table.alias?uncap_first}Service.update(list,request);
				jsonResult.setSuccess(true);
				jsonResult.setMsg("修改成功");
			/*if(${table.alias?uncap_first}Service.checkUnique(list,"${table.alias?uncap_first}Name","名称重复","ROW_ID")) {
				${table.alias?uncap_first}Service.update(list);
				jsonResult.setSuccess(true);
				jsonResult.setMsg("修改成功");
			}*/
		}
		catch(TransactionException e) {
			map=(Map)e.getObj();
				/* return "{\"errorMsg\":\"编码重复无法添加！！！！########\",\"vo\":"+vo.getSort()+"}"; */
				jsonResult.setSuccess(false);
				jsonResult.setMsg(map.get("msg").toString());
				jsonResult.setObj(map);
		}
		return jsonResult;
	}
</#if>	
</#macro>
<#macro beforeEdit></#macro>
<#macro afterEdit></#macro>
<#macro delete>
<#if table.delete>
/**
	 * http://127.0.0.1/ssm/${namespace?replace('.','/')}/${table.alias?lower_case}/delete.do
	 * 删除数据
	 * @param formMap  请求参数
	 * @return
	 */
	@RequestMapping(value = "delete.do")
	@ResponseBody
	public JsonResult delete(@RequestParam Map<String,String> formMap,HttpServletRequest request) {
		JsonResult result = new JsonResult();
		<#if table.checkAuth>
	    this.checkAuth(AUTH_DEL,request);
	    </#if>
	    <@beforeDelete/>
	    //删除数据库
		<@deleteBody/>
		int delete=this.${table.alias?uncap_first}Service.delete(formMap);
	    //end删除数据库
		this.auditLog(AUTH_DEL, "删除:"<#rt>
		<#list table.primaryKeys.values() as col>
		+<#if col_index !=0>","+</#if>formMap.get("${col.name}")<#t>
		</#list>	
		,request);//操作日志<#lt>
		<@afterDelete/>
		
		if(delete==1) {
			result.setMsg("删除成功");
		}else {
			result.setSuccess(false);
			result.setMsg("删除失败");
		}
		return result;
	}
</#if>	
</#macro>
<#macro start>
	/**
	 * http://127.0.0.1/ssm/${namespace?replace('.','/')}/${table.alias?lower_case}/start.do
	 * 修改数据
	 * @param vo  修改对象
	 * @return
	 */
	@RequestMapping(value = "start.do")
	@ResponseBody
	public JsonResult start(${table.alias}Vo vo,HttpServletRequest request) throws IllegalAccessException, InvocationTargetException {
		JsonResult result = new JsonResult();
		try {
			${table.alias?uncap_first}Service.start(vo,request);
			result.setSuccess(true);
			result.setMsg("启用成功");
		}catch (Exception e) {
			result.setSuccess(false);
			result.setMsg("启用失败");
			System.out.println(e);
		}
		return result;
	}
</#macro>
<#macro stop>
	/**
	 * http://127.0.0.1/ssm/${namespace?replace('.','/')}/${table.alias?lower_case}/stop.do
	 * 修改数据
	 * @param vo  修改对象
	 * @return
	 */
	@RequestMapping(value = "stop.do")
	@ResponseBody
	public JsonResult stop(${table.alias}Vo vo,HttpServletRequest request) throws IllegalAccessException, InvocationTargetException {
		JsonResult result = new JsonResult();
		try {
			${table.alias?uncap_first}Service.stop(vo);
			result.setSuccess(true);
			result.setMsg("停用成功");
		}catch (Exception e) {
			result.setSuccess(false);
			result.setMsg("停用失败");
			System.out.println(e);
		}
		return result;
	}
</#macro>
<#macro beforeDelete></#macro>
<#macro deleteBody></#macro>
<#macro afterDelete></#macro>
<#macro checkUnique></#macro>
<#macro listAfter></#macro>
<#macro addAfter></#macro>