package com.xinhuanet.live.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.ResourceBundle;

public class ResourceUtil {

    private static ResourceBundle resourceBundle = null;             //初始化一个ResourceBundle对象


    public static String dateToString(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String strDate = null;
        try {
            strDate = sdf.format(date);
        } catch (Exception e) {
            strDate = "";
        }
        return strDate;
    }

    // 配置文件名 和 key获得值
    public static String getPropertiesByName(String propertiesName, String key) {
        try {
            if (null == resourceBundle) {
                resourceBundle = ResourceBundle.getBundle(propertiesName);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return resourceBundle.getString(key);
    }

    public static void main(String[] args){
        int threadnum = Integer.valueOf(ResourceUtil.getPropertiesByName("config", "thread.number"));
        System.out.println("----------------------"+threadnum);

    }
}
