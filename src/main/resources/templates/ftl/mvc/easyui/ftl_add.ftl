<#assign list_tbl=table.view!table/>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${table.des!table.name}</title> 
<%@ include file="/commons/head.jsp"%>
<script language="JavaScript" type="text/javascript" src="${"$"}{ctx}/js/${namespace}/${table.alias?replace('_',' ')?capitalize?replace(' ','')?uncap_first}.js"></script>
<script language="JavaScript" type="text/javascript"  src="${"$"}{ctx}/js/commons.js"></script>
</head>
<body class="easyui-layout">
	<div region="center" title="" style="padding:5px;" border="false" data-options="fit:true">
	<form id="add_data_list_form" method="post">
		<table style="width:100%;" id="add_data_list" title="数据列表" 
			class="easyui-datagrid" toolbar="#toolbar"
			data-options="rownumbers:true,singleSelect:true,pagination:true,onClickRow:onClickRow,onLoadSuccess:onLoadSuccess,url:'',method:'post'">
			<thead>
				<tr>
				  <@list_body/>
				  <@list_body_other/>
				</tr>
			</thead>
		</table>
		</form>
		<div id="toolbar">
		  <@menu_list/>
		  <@menu_list_others/>
		  <@search/>
		</div>
		<div id="openDialog" class="easyui-dialog" title="Dialog"  
		     style="width:640px;height:360px;padding-top:10px;"
		     data-options="iconCls:'icon-save',modal:true,closed:true,maximizable:true,resizable:true">
		</div>	
	</div>
	
</body>
<@jsp/>
<script type="text/javascript">
	  <@script/>
</script>
<#macro list_body>
	   <#list list_tbl.columns.values() as col>
	   <#if col.edit>
	   <th data-options="field:'${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first}',halign:'center',align:'left',width:${col.width},editor:{ <#if (col.required)>type:'validatebox',options:{${col.requiredType}}</#if>}"><ssm:i18n value="${table.name}_${col.name}" def="${col.des}"/></th>
	   </#if>
	   </#list>
	   <th data-options="field:'sort',halign:'center',align:'left',width:80"><ssm:i18n value="SORT" def="排序"/></th>
</#macro>
<#macro menu_list>
<a  class="easyui-linkbutton"  plain="true" iconCls="icon-add" onclick="addList()">新增</a>
<a  class="easyui-linkbutton"  plain="true" iconCls="icon-save" onclick="acceptList(table)">保存</a>
<a  class="easyui-linkbutton"  plain="true" iconCls="icon-remove" onclick="deleteList('#add_data_list')">删除</a>
<a  class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject(table)">取消</a>
</#macro>
<#macro script>
var ctx="${"$"}{ctx}"
    var table="#add_data_list"
    $(function(){
    	${"$"}('#add_data_list').datagrid('hideColumn','${table.primaryKeyColumnNames[0]?replace('_',' ')?capitalize?replace(' ','')?uncap_first}');
		${"$"}('#add_data_list').datagrid('hideColumn','sort');
		addList();
    });
</#macro>
<#macro search>
</#macro>
<#macro list_body_other></#macro>
<#macro menu_list_others></#macro>
<#macro jsp>
<c:set var="ctx" value="${"$"}{ctx}" scope="request"/>
</#macro>
