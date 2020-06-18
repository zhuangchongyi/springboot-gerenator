## mybatis gerenator代码生成
```
idea Run>Edit configreactions > command line 
添加 mybatis-generator:generator


banner 修改
http://patorjk.com/software/taag/

打包时指定yml文件
java -jar demo.jar --spring.profiles.active=dev


mybatis-plus 转换不了mysql datetime/timesteam转换不了LocalDateTime
需加这两个依赖
<!-- mybatis数据库字段类型映射，此处是重点 -->
<dependency>
    <groupId>org.mybatis</groupId>
    <artifactId>mybatis-typehandlers-jsr310</artifactId>
    <version>1.0.1</version>
</dependency>
<dependency>
    <groupId>org.mybatis</groupId>
    <artifactId>mybatis</artifactId>
    <version>3.5.3</version>
</dependency>
```
