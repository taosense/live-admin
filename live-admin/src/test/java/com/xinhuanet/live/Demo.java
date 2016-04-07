package com.xinhuanet.live;


import java.io.IOException;
import java.net.InetAddress;

public class Demo {
    public static void main(String[] args) throws IOException {
        System.out.println("hello world");
        InetAddress ia = InetAddress.getLocalHost();
        System.out.println(ia);

        String regex = "[\\u4e00-\\u9fa5_a-zA-Z0-9_]{1}|[a-zA-Z0-9_]{31,}";
        String regex1 = "[\\W\\w]{1}";
        String content = "ssd";
        System.out.println("regex ------- :"+content.matches(regex1));
    }
}
