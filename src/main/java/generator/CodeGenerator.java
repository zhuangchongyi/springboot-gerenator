package generator;

import com.baomidou.mybatisplus.core.exceptions.MybatisPlusException;
import com.baomidou.mybatisplus.core.toolkit.StringPool;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.InjectionConfig;
import com.baomidou.mybatisplus.generator.config.*;
import com.baomidou.mybatisplus.generator.config.po.TableInfo;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
import com.baomidou.mybatisplus.generator.engine.VelocityTemplateEngine;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

// 演示例子，执行 main 方法控制台输入模块表名回车自动生成对应项目目录中
@SuppressWarnings("Duplicates")
public class CodeGenerator {
    public static String scanner(String tip) {
        Scanner scanner = new Scanner(System.in);
        StringBuilder help = new StringBuilder();
        help.append("请输入" + tip + "：");
        System.out.println(help.toString());
        if (scanner.hasNext()) {
            String ipt = scanner.next();
            if (StringUtils.isNotEmpty(ipt)) {
                return ipt;
            }
        }
        throw new MybatisPlusException("请输入正确的" + tip + "！");
    }

    public static void main(String[] args) {
        // 代码生成器
        AutoGenerator mpg = new AutoGenerator();
        // 全局配置
        GlobalConfig gc = getGlobalConfig();
        mpg.setGlobalConfig(gc);
        // 包配置
        PackageConfig pc = getPackageConfig();
        mpg.setPackageInfo(pc);
        // 策略配置
        StrategyConfig strategy = getStrategyConfig(pc);
        mpg.setStrategy(strategy);
        // 数据源配置
        DataSourceConfig dsc = getDataSourceConfig();
        mpg.setDataSource(dsc);
        // mapper.xml输出配置
//        InjectionConfig cfg = getInjectionConfig(projectPath, pc);
//        mpg.setCfg(cfg);
        // 自定义模板
        TemplateConfig templateConfig = getTemplateConfig();
        mpg.setTemplate(templateConfig);
        // 模板类型
        mpg.setTemplateEngine(new VelocityTemplateEngine());
        mpg.execute();
    }

    /**
     * 策略配置
     *
     * @param pc
     * @return
     */
    private static StrategyConfig getStrategyConfig(PackageConfig pc) {
        StrategyConfig strategy = new StrategyConfig();
        strategy.setNaming(NamingStrategy.underline_to_camel);// 表名生成策略
        strategy.setColumnNaming(NamingStrategy.underline_to_camel);
        strategy.setEntityLombokModel(true);        // 加Lombok注解
//        strategy.setSuperEntityClass("com.zcy.entity.BaseEntity");
//        strategy.setRestControllerStyle(false);      // 加@RestController注解
        strategy.setControllerMappingHyphenStyle(false);
        strategy.setInclude(scanner("表名，多个英文逗号分割").split(","));// 需要生成的表
        strategy.setTablePrefix(pc.getModuleName() + "_");// 此处可以修改为的表前缀
        return strategy;
    }

    /**
     * 配置包路径
     *
     * @return
     */
    private static PackageConfig getPackageConfig() {
        PackageConfig pc = new PackageConfig();
//        pc.setModuleName(scanner("模块名"));
        pc.setParent("com.zcy")
        .setController("controller")
        .setEntity("entity")
        .setMapper("dao")
        .setService("service")
        .setServiceImpl("service.impl")
        .setXml("mapper");
        return pc;
    }

    /**
     * 配置全局参数
     *
     * @return
     */
    private static GlobalConfig getGlobalConfig() {
        // 项目路径
//        String projectPath = System.getProperty("user.dir") + "/src/main/java";
        String projectPath = "F:/temp/";
        GlobalConfig gc = new GlobalConfig();
        gc.setOutputDir(projectPath);//c输出路径
        gc.setAuthor("zhuangcy");
        gc.setFileOverride(true);// 是否覆盖文件
        gc.setActiveRecord(false);// 开启 activeRecord 模式
//        gc.setEnableCache(false);// XML 二级缓存
//        gc.setBaseResultMap(true);// XML ResultMap
//        gc.setBaseColumnList(true);// XML columList
        gc.setOpen(false);//生成后打开文件夹
//        gc.setSwagger2(false); //实体属性 Swagger2 注解
        // 自定义文件命名，注意 %s 会自动填充表实体属性！
       gc.setMapperName("%sDao");
       gc.setXmlName("%sMapper");
       gc.setServiceName("%sService");
       gc.setServiceImplName("%sServiceImpl");
       gc.setControllerName("%sController");
        return gc;
    }

    /**
     * 配置模板
     * 配置自定义输出模板
     * 指定自定义模板路径，注意不要带上.ftl/.vm, 会根据使用的模板引擎自动识别
     */
    private static TemplateConfig getTemplateConfig() {
        TemplateConfig templateConfig = new TemplateConfig();
        templateConfig.setController("/templates/common/controller.java");
        templateConfig.setEntity("/templates/common/entity.java");
        templateConfig.setMapper("/templates/common/mapper.java");
        templateConfig.setXml("/templates/common/mapper.xml");
        templateConfig.setServiceImpl("/templates/common/service.impl.java");
        templateConfig.setService("/templates/common/service.java");
        return templateConfig;
    }

    /**
     * 配置mapper.xml输出
     *
     * @param projectPath
     * @param pc
     * @return
     */
    private static InjectionConfig getInjectionConfig(String projectPath, PackageConfig pc) {
        InjectionConfig cfg = new InjectionConfig() {
            @Override
            public void initMap() {
                // to do nothing
            }
        };
        // 如果模板引擎是 freemarker
        // String templatePath = "/templates/mapper.xml.ftl";
        //如果模板引擎是 velocity
        String templatePath = "/templates/mapper.xml.vm";
        //自定义输出配置
        List<FileOutConfig> focList = new ArrayList<>();
        //自定义配置会被优先输出
        focList.add(new FileOutConfig(templatePath) {
            @Override
            public String outputFile(TableInfo tableInfo) {
                // 自定义输出文件名 ， 如果你 Entity 设置了前后缀、此处注意 xml 的名称会跟着发生变化！！
                String path = pc.getModuleName();
                if (null != path && path != "") path = path + "/";
                return projectPath + "/src/main/resources/mapper/" + path + tableInfo.getEntityName() + "Mapper" + StringPool.DOT_XML;
            }
        });
        cfg.setFileOutConfigList(focList);
        return cfg;
    }

    /**
     * 配置数据源
     *
     * @return
     */
    private static DataSourceConfig getDataSourceConfig() {
        DataSourceConfig dsc = new DataSourceConfig();
        dsc.setUrl("jdbc:mysql://localhost:3306/mydb?useUnicode=true&useSSL=false&characterEncoding=utf8");
        dsc.setDriverName("com.mysql.jdbc.Driver");
        dsc.setUsername("root");
        dsc.setPassword("root");
        return dsc;
    }


}