本Web專案使用JNDI連線, 使用前請記得修改下方幾個檔案.
1. Eclipse內Servers的context.xml檔案.
2. 專案內web.xml的<resource-ref>標籤.
3. 專案內hibernate.cfg.xml內的 <property name="hibernate.connection.datasource">標籤.
4. 專案內beans.config.xml內的 <bean id="SQLserverJndiDataSource" class="org.springframework.jndi.JndiObjectFactoryBean">標籤.
5. 如果需要的話, 更換專案以及tw.leonchen.util的名字.