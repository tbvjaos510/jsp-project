<%@page contentType="text/html; charset=utf-8"%>
<%@page import="org.apache.commons.dbcp.*" %>
<%@page import="org.apache.commons.pool.impl.*"%>
<%!
public void jspInit(){
    GenericObjectPool objectPool = new GenericObjectPool();
    DriverManagerConnectionFactory connectionFactory = 
    new DriverManagerConnectionFactory("jdbc:mysql://localhost:3306/webdb?characterEncoding=utf8", "root", "");
    new PoolableConnectionFactory(connectionFactory,objectPool,null,null,false,true);
    PoolingDriver driver = new PoolingDriver();
    driver.registerPool("/dbauto_pool",objectPool);
}
    %>
