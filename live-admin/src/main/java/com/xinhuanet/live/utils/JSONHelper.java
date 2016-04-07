package com.xinhuanet.live.utils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;

import java.util.HashMap;
import java.util.Map;

/**
 * json与数据化对象转换类
 * 
 * @author liuyifei 使用fasterJSON作为JSON生成
 */
public class JSONHelper {

    /***
     * 基本用法 对象直接转json字符串，根据code转换成文字描述
     * 
     * @param obj
     * @return
     */
    public static String object2Json(int code, Object obj) {
        Map<String, Object> jsonMap = new HashMap<String, Object>();
        jsonMap.put("code", code);
        jsonMap.put("content", obj);
        String desc = ReadPropertiesUtil.getInstance().getValue("json_key_" + code);
        jsonMap.put("description", desc);
        String returnStr = null;
        returnStr = JSON.toJSONString(jsonMap);
        return returnStr;
    }

    /***
     * 基本用法 对象直接转json字符串，根据code转换成文字描述,加入当前页和总页
     * 
     * @param obj
     * @return
     */
    public static String object2Json(int code, int curPage, Long totalNum, Object obj) {
        Map<String, Object> jsonMap = new HashMap<String, Object>();
        jsonMap.put("currentPage", curPage);
        jsonMap.put("totalPage", totalNum);
        jsonMap.put("code", code);
        jsonMap.put("content", obj);
        String desc = ReadPropertiesUtil.getInstance().getValue("json_key_" + code);
        jsonMap.put("description", desc);
        String returnStr = null;
        returnStr = JSON.toJSONString(jsonMap);
        return returnStr;
    }

    /***
     * 基本用法 对象直接转json字符串，根据code转换成文字描述
     * 
     * @param obj
     * @return
     */
    public static String object2JsonP(int code, Object obj, String callback) {
        Map<String, Object> jsonMap = new HashMap<String, Object>();
        jsonMap.put("code", code);
        jsonMap.put("content", obj);
        String desc = ReadPropertiesUtil.getInstance().getValue("json_key_" + code);
        jsonMap.put("description", desc);
        String returnStr = null;
        returnStr = JSON.toJSONString(jsonMap);
        if (callback != null && !"".equals(callback)) {
            returnStr = callback + "(" + returnStr + ");";
        }
        return returnStr;
    }

    /**
     * 对象转成json串
     * 
     * @param obj
     * @return
     * @throws Exception
     */
    public static String object2Json(Object obj) {
        SerializerFeature[] features = { SerializerFeature.WriteMapNullValue, SerializerFeature.WriteNullStringAsEmpty };
        return JSON.toJSONString(obj, features);
    }

    /**
     * json串转换对象
     * 
     * @param json
     * @param cls
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public static Object json2Object(String json, Class cls) {
        return JSON.parseObject(json, cls);
    }
}
