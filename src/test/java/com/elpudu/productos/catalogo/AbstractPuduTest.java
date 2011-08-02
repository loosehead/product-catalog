package com.elpudu.productos.catalogo;

import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:webMVC-servlet.xml",
		"classpath:application-context.xml", "classpath:beans-test.xml"})
public abstract class AbstractPuduTest {

}
