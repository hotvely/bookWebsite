# bookWeb
 도서 관리 사이드 세미 프로젝트



#의존성 주입 그래들..
	dependencies 
 {
 	implementation 'org.springframework.boot:spring-boot-starter-data-jdbc'
 	implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
 	implementation 'org.springframework.boot:spring-boot-starter-jdbc'
 	implementation 'org.springframework.boot:spring-boot-starter-web'
 	
 	//JSP파일 사용하기 위해 무조건 필요함;
 	implementation 'org.apache.tomcat.embed:tomcat-embed-jasper:10.0.17'
 	implementation 'javax.servlet:jstl:1.2'
 	
 	compileOnly 'org.projectlombok:lombok'
 	developmentOnly 'org.springframework.boot:spring-boot-devtools'
 	//runtimeOnly 'com.mysql:mysql-connector-j'
 	runtimeOnly 'com.oracle.database.jdbc:ojdbc11'
 	annotationProcessor 'org.projectlombok:lombok'
 	testImplementation 'org.springframework.boot:spring-boot-starter-test'
}



#application.properties
//포트번호;
server.port=9999
spring.boot.open-in-browser=true

// JSP
spring.mvc.view.prefix=/WEB-INF/views/
spring.mvc.view.suffix=.jsp

//인코딩
server.servlet.encoding.charset=UTF-8
server.servlet.encoding.enabled=true
server.servlet.encoding.force=true

// 오라클 db사용하기 위해
spring.datasource.driver-class-name=oracle.jdbc.OracleDriver
spring.datasource.url=jdbc:oracle:thin:@localhost:1521/xe
spring.datasource.username=freepets
spring.datasource.password=freepets
