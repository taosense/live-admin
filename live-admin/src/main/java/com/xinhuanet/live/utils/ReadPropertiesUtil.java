package com.xinhuanet.live.utils;

import java.util.ResourceBundle;

public class ReadPropertiesUtil {
    private static ReadPropertiesUtil readPro = null; // 初始化一个单例对象
    private static ResourceBundle resourceBundle = null; // 初始化一个ResourceBundle对象

    // 私有的构造函数
    // private ReadPropertiesUtil(String fileName){
    // resourceBundle = ResourceBundle.getBundle(fileName);
    // }

    // 同步方法。这个方法是共外部调用获得ReadPropertiesUtil类的实力
    public synchronized static ReadPropertiesUtil getInstance() {
        if (null == readPro) {
            resourceBundle = ResourceBundle.getBundle("public");
            readPro = new ReadPropertiesUtil();
        }
        return readPro;
    }

    // 根据key获得值
    public String getValue(String key) {
        String res = null;
        if (resourceBundle.containsKey(key)) {
            res = resourceBundle.getString(key);
        }
        return res;
    }

    public static void main(String[] args) {
        // System.out.println(ServletActionContext.getRequest().getSession().getServletContext().getRealPath("/"));
        ReadPropertiesUtil util = new ReadPropertiesUtil().getInstance();
        System.out.println(util.getValue("ip"));
    }

}
