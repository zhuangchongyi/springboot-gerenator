<@extends path="../ftl_action.ftl"/>
<#macro body>
	<@fields/>
	<@setterGetters/>
	<@list/>
	<#if table.add>
	<@toAdd/>
	<@toAddList/>
	<@add/>
	</#if>
	<#if table.edit>
	<@toEdit/>
	<@toEditList/>
	<@edit/>
	</#if>
	<#if table.delete>
	<@delete/>
	</#if>
	<@checkUnique/>
	<@methods/>
</#macro>

<#macro toAddList>
<#if table.add>
   /**
	 * 跳转到新增界面
	 * @return
	 */
	@RequestMapping(value = "toAddList.do",method = RequestMethod.GET)
	public String toAddList() {
	   this.checkAuth(AUTH_ADD);
	 return "/mrmf/${table.alias?lower_case}/add_list";
	}
</#if>	
</#macro>
<#macro add>
<#if table.add>
	/**
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
<#macro afterAdd></#macro>
<#macro toEditList>
<#if table.edit>
	/**
	 * 跳转到修改界面
	 * @param formMap  请求参数
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "toEditList.do",method = RequestMethod.GET)
	public String toEditList(@RequestParam(defaultValue="0")int page,Model model) {
		model.addAttribute("pageNum", page);
		return "mrmf/${table.alias?lower_case}/edit_list";
	}
</#if>	
</#macro>
<#macro edit>
<#if table.edit>
	/**
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
