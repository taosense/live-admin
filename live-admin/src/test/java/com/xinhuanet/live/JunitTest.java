package com.xinhuanet.live;

import org.apache.commons.codec.digest.DigestUtils;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

/**
 * Created by chenweichao on 15-8-7.
 */
public class JunitTest {

    private static ClassPathXmlApplicationContext context;

    @BeforeClass
    public static void setUpBeforeClass() throws Exception {
        context = new ClassPathXmlApplicationContext("context-test.xml");
        System.out.println("******************test start***********************");
    }

    @AfterClass
    public static void setAfterClass() throws Exception {
        context.close();
        System.out.println("******************test end***********************");
    }

    @Test
    public void test() throws IOException {
        long start = System.currentTimeMillis();
//        for (int i = 0; i < 1000; i++) {

            System.out.println(DigestUtils.md5Hex(new FileInputStream(new File("/home/maximus/tmp/2538183_c.html"))));
//        }
        long end = System.currentTimeMillis();
        System.out.println("平均MD5耗时：" + (end - start) );
    }
}
