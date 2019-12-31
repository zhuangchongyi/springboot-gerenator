<#assign list_tbl=table.view!table/>
<#----------------------------- 内容 ----------------------------->
/*---------代码生成请勿手工修改---------*/
<@imports/>
<@class/>
<#----------------------------- 定义 ----------------------------->
<#macro imports>
package ${pkg}.${namespace}.vo;
</#macro>
<#macro class>
/**
 * ${table.des!table.name}
 */
public class ${table.alias}Vo {
<#list list_tbl.columns.values() as col>
 private ${col.columnType} ${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first};//${col.des}
</#list>
<#list list_tbl.columns.values() as col>
    public ${col.columnType} get${col.name?replace('_',' ')?capitalize?replace(' ','')}(){
       return ${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first};
    }
    public void set${col.name?replace('_',' ')?capitalize?replace(' ','')} (${col.columnType} ${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first}){
       this.${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first} = ${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first} == null ? null : ${col.name?replace('_',' ')?capitalize?replace(' ','')?uncap_first}.trim();
    }
</#list>
}
</#macro>