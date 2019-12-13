<@extends path="../ftl_list.ftl"/>
<#macro menu_list_others>
<a  class="easyui-linkbutton"  plain="true" iconCls="icon-add" onclick="toAddList('${"$"}{ctx}')">新增</a>
<a  class="easyui-linkbutton"  plain="true" iconCls="icon-edit" onclick="toEditList('${"$"}{ctx}')">修改</a>
<a  class="easyui-linkbutton"  plain="true" iconCls="icon-remove" onclick="removeit('${"$"}{ctx}')">删除</a> 
</#macro>
<#macro search>
   编码<input name="${table.alias?uncap_first}Num" style="width:5em"/>
			名称<input name="${table.alias?uncap_first}Name" style="width:5em"/>
			开始日期<input name="dateStart" type="text" class="easyui-datetimebox"/>
			结束日期<input name="dateEnd" type="text" class="easyui-datetimebox"/>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true"
				onclick="doSearch('#data_list')">查询列表</a>
</#macro>
