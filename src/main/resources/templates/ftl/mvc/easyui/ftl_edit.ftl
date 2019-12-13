<#assign list_tbl=table.view!table/>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${table.des!table.name}</title> 
<%@ include file="/commons/head.jsp"%>
<script language="JavaScript" type="text/javascript" src="${"$"}{ctx}/js/${namespace?replace('.','/')}/${table.alias?replace('_',' ')?capitalize?replace(' ','')?uncap_first}.js"></script>
<script language="JavaScript" type="text/javascript"  src="${"$"}{ctx}/js/commons.js"></script>
</head>
<body class="easyui-layout">
	<div region="center" title="" style="padding:5px;" border="false" data-options="fit:true">
	<form id="edit_data_list_form" method="post">
		<table style="width:100%;" id="edit_data_list" title="数据列表" 
			class="easyui-datagrid" toolbar="#toolbar"
			data-options="rownumbers:true,singleSelect:true,pagination:true,onClickRow:onClickRow,onLoadSuccess:onLoadSuccess,onBeforeEdit:onBeforeEdit,onBeforeLoad:onBeforeLoad,onAfterEdit:onAfterEdit,url:'${"$"}{ctx}/${namespace?replace('.','/')}/${table.alias?replace('_',' ')?capitalize?replace(' ','')?uncap_first}/loadList.do',method:'post'">
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
	   	<th data-options="field:'${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first}',halign:'center',align:'left',width:${col.width},editor:{ <#if (col.required)>type:'validatebox',options:{${col.requiredType}}</#if>}"><ssm:i18n value="${table.name}_${col.name}" def="${col.des}"/></th>
	   </#list>
</#macro>
<#macro menu_list>
<a  class="easyui-linkbutton"  plain="true" iconCls="icon-edit" onclick="toEditList('${"$"}{ctx}')">修改</a>
<a  class="easyui-linkbutton"  plain="true" iconCls="icon-remove" onclick="removeit('${"$"}{ctx}')">删除</a> 
<a  class="easyui-linkbutton"  plain="true" iconCls="icon-save" onclick="acceptList(table)">保存</a>
<a  class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject(table)">取消</a>
</#macro>
<#macro search>
    		编码<input name="${table.alias?uncap_first}Num" style="width:5em"/>
			名称<input name="${table.alias?uncap_first}Name" style="width:5em"/>
			开始日期<input name="dateStart" type="text" class="easyui-datetimebox"/>
			结束日期<input name="dateEnd" type="text" class="easyui-datetimebox"/>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true"
				onclick="doSearch('#data_list')">查询列表</a>
</#macro>
<#macro script>
var ctx="${'$'}{ctx}"
    var pageNum="${"$"}{pageNum}";
    var table="#edit_data_list"
    	 $(function(){
    		 
    		 //跳转页数
    		 /* $('#edit_data_list').datagrid('getPager').pagination('select',parseInt('${"$"}{pageNum}')) */
    		 /* p.pagination('select',2) */
    			//隐藏主键值列
    		 ${"$"}('#edit_data_list').datagrid('hideColumn','${table.primaryKeyColumnNames[0]?replace('_',' ')?capitalize?replace(' ','')?uncap_first}');
    		    });
    		    
var editIndex = undefined;
		function endEditing1(){
			if (editIndex == undefined){return true;}
			if (onAfterEdit(editIndex)){
				editIndex = undefined;
				return true;
			} else {
				return false;
			}
		}
		function onClickRow(index){
			if (editIndex != index){
				if (endEditing1()){
					$('#edit_data_list').datagrid('selectRow', index).datagrid('beginEdit', index);
					editIndex = index;
				} else {
					$('#edit_data_list').datagrid('selectRow', editIndex);
				}
			}
		}	    
    		    
</#macro>
<#macro jsp>
<c:set var="pageNum" value="${"$"}{pageNum}" scope="request"/><!--使用c标签把pageNum保存到session中  -->
<c:set var="ctx" value="${"$"}{ctx}" scope="request"/>
</#macro>
<#macro list_body_other></#macro>
<#macro menu_list_others></#macro>
