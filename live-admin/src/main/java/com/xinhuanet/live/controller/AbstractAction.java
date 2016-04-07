package com.xinhuanet.live.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.xinhuanet.live.utils.JSONHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public abstract class AbstractAction {
    private static final Logger LOGGER = LoggerFactory.getLogger(AbstractAction.class);
    private String message;

    protected Object get(String name, HttpServletRequest request, HttpServletResponse response) {
        return null;
    }

    /**
     * Put an object in the WebWork user session
     */
    protected void set(String name, Object value, HttpServletRequest request, HttpServletResponse response) {
    }

    /**
     * Put an object in the WebWork user session
     */
    protected void remove(Object key, HttpServletRequest request, HttpServletResponse response) {
    }

    /**
     * @return Returns the sMessage.
     */
    public String getMessage() {
        return message;
    }

    /**
     * @param message
     *            The sMessage to set.
     */
    public void setMessage(String message, HttpServletRequest request, HttpServletResponse response) {
        this.message = message;
    }

    protected String returnForAjax(HttpServletRequest request, HttpServletResponse response, Integer result, Object obj) {
        response.setContentType("text/json;charset=UTF-8");
        PrintWriter writer;
        try {
            writer = response.getWriter();
            writer.write(JSONHelper.object2Json(result, obj));
            writer.flush();
        } catch (IOException e) {
            LOGGER.error("异常" + e);
        }
        return null;
    }

    protected String returnForAjax(HttpServletRequest request, HttpServletResponse response, int curPage,
            Long totalNum, Integer result, Object obj) throws Exception {
        response.setContentType("text/json;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.write(JSONHelper.object2Json(result, curPage, totalNum, obj));
        writer.flush();
        return null;
    }

    protected String returnForAjax(HttpServletRequest request, HttpServletResponse response, Object obj) {
        response.setContentType("text/json;charset=UTF-8");
        PrintWriter writer;
        try {
            writer = response.getWriter();
            writer.write(JSONHelper.object2Json(obj));
            writer.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    protected String returnJsonP(HttpServletRequest request, HttpServletResponse response, Object obj, String callback) {
        response.setContentType("text/json;charset=UTF-8");
        PrintWriter writer;
        try {
            writer = response.getWriter();
            writer.append(callback + "(");
            writer.write(JSONHelper.object2Json(obj));
            writer.append(");");
            writer.flush();
        } catch (IOException e) {
            LOGGER.error("异常" + e);
        }
        return null;
    }

    protected String returnJsonP(HttpServletRequest request, HttpServletResponse response, Integer code, Object obj,
            String callback) {
        response.setContentType("text/json;charset=UTF-8");
        PrintWriter writer;
        try {
            writer = response.getWriter();
            writer.write(JSONHelper.object2JsonP(code, obj, callback));
            writer.flush();
        } catch (IOException e) {
            LOGGER.error("异常" + e);
        }
        return null;
    }

    protected boolean isNull(String str) {
        return str == null || str.trim().length() == 0;
    }

    public String colorInvalid(String regexStr, String content, String prefix, String ending) {
        if (!isNull(regexStr) && !isNull(content)) {
            Pattern p = null;
            Matcher m = null;
            String sRegex = "(" + regexStr + ")";
            p = Pattern.compile(sRegex, Pattern.CASE_INSENSITIVE);
            m = p.matcher(content);
            String s = null, sTmp = null;
            StringBuffer sb = new StringBuffer();
            while (m.find()) {
                sTmp = m.group();
                s = prefix + sTmp + ending;
                m.appendReplacement(sb, s);
            }
            m.appendTail(sb);
            return sb.toString();
        } else {
            return content;
        }
    }

    /**
     * 获取用户IP
     * 
     * @param request
     * @return
     * @throws Exception
     */
    protected String getUserIp(HttpServletRequest request) throws Exception {
        String userIp = "";
//        if (sysConfigService.getValue(Constant.SYS_EXTRANT_IP_TYPE).equals("1")) {
//            userIp = request.getRemoteAddr();
//        } else if (sysConfigService.getValue(Constant.SYS_EXTRANT_IP_TYPE).equals("2")) {
//            userIp = request.getHeader("X-Real-IP");
//        }

        if (userIp != null && userIp.trim().length() != 0) {
            String[] commArray = userIp.split(",");
            userIp = commArray.length > 1 ? commArray[1].trim() : commArray[0].trim();
        }
        return userIp;
    }
}
