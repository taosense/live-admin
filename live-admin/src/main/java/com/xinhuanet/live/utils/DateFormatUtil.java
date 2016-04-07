package com.xinhuanet.live.utils;

import org.springframework.util.StringUtils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class DateFormatUtil {
    public static final String FOR_STRING = "yyyy-MM-dd HH:mm:ss";
    public static final String FOR_DAY = "MM/dd/yyyy";
    public static final String FOR_STR_YYYYMMDD = "yyyyMMdd";
    public static final String FOR_STRING3 = "";
    public static final String FOR_DAY_MM = "MM/dd/yyyy HH:mm";
    public static final String FOR_DAY_MM_00 = "MM/dd/yyyy 00:00";

    public static String toString(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat(FOR_STRING);
        return sdf.format(date);
    }

    public static Date toDate(String time) {
        try {
            SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy");
            if (!StringUtils.isEmpty(time)) {
                Date date = format.parse(time);
                return date;
            }
        } catch (ParseException e) {
        }
        return null;
    }

    public static Date toDate(String time, String farmat) {
        try {
            SimpleDateFormat format = new SimpleDateFormat(farmat);
            if (!StringUtils.isEmpty(time)) {
                Date date = format.parse(time);
                return date;
            }
        } catch (ParseException e) {
        }
        return null;
    }

    public static String toString(Date date, String format) {
        // 02/25/2015
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        return sdf.format(date);
    }

    /**
     * 
     * @param date
     * @param format
     * @return yyyymmdd
     */
    public static String toDayStr(Date date) {
        // 02/25/2015
        SimpleDateFormat sdf = new SimpleDateFormat(DateFormatUtil.FOR_STR_YYYYMMDD);
        return sdf.format(date);
    }

    public static Date dealDay(Date date, Integer num) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.DAY_OF_MONTH, num);
        return calendar.getTime();
    }

    public static Date yesterday(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.DAY_OF_MONTH, -1);
        return calendar.getTime();
    }

    /**
     * 
     * <p>
     * 计算时间 按天分隔
     * </p>
     * 
     * @param startTime
     *            起始天
     * @param endTime
     *            终止 天
     * @param start
     *            起止时间
     * @param end
     *            终止时间
     * @return
     * @author lvwei
     */
    public static List<Map<String, Date>> getStatisDateList(Date start, Date end, String startTime, String endTime) {
        List<Map<String, Date>> list = new ArrayList<Map<String, Date>>();

        Date sTime = start;
        Date eTime = DateFormatUtil.dealDay(sTime, 1);
        if (startTime != null && !startTime.isEmpty() && endTime != null && !endTime.isEmpty()) {

            String startStr = DateFormatUtil.toString(start, DateFormatUtil.FOR_DAY) + " " + startTime;
            sTime = DateFormatUtil.toDate(startStr, DateFormatUtil.FOR_DAY_MM);
            String endStr = DateFormatUtil.toString(start, DateFormatUtil.FOR_DAY) + " " + endTime;
            eTime = DateFormatUtil.toDate(endStr, DateFormatUtil.FOR_DAY_MM);
            end = DateFormatUtil.toDate(DateFormatUtil.toString(end, DateFormatUtil.FOR_DAY) + " " + endTime,
                    DateFormatUtil.FOR_DAY_MM);
        } else {
            end = DateFormatUtil.dealDay(end, 1);
        }

        Map<String, Date> map = new HashMap<String, Date>();
        while (end.after(sTime)) {
            map = new HashMap<String, Date>();
            map.put("start", sTime);
            map.put("end", eTime);
            list.add(map);
            sTime = DateFormatUtil.dealDay(sTime, 1);
            eTime = DateFormatUtil.dealDay(eTime, 1);
        }

        return list;
    }
}
