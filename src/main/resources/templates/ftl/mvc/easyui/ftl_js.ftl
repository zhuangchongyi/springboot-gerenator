<@extends path="../ftl_js.ftl"/>
<#macro doSearch>
//查询功能 暂时写死
function doSearch(){
	 $.ajax({
		 type:'POST',
		 url:'loadList.do',
		 async:false,//改为同步方式，获取返回值
		 data:{
			 '${table.alias?uncap_first}Num':$("input[name='${table.alias?uncap_first}Num']").val(),
			 '${table.alias?uncap_first}Name':$("input[name='${table.alias?uncap_first}Name']").val(),
			 'dateBegin':$("input[name='dateStart']").val(),
			 'dateEnd':$("input[name='dateEnd']").val(),
		 },
		 success:function(data){
			 console.log(data)
			 $(table).datagrid('loadData',data);//刷新数据，去掉旧行
		 }
	 })
}
</#macro>