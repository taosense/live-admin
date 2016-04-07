package com.xinhuanet.live.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

public class TimeInterval {
    public static final String HOUR = "hour";
    public static final String DAY = "day";
    public static final String WEEK = "week";
    public static final String MONTH = "month";
    public static final String SEVEN = "SEVEN";

    /**
     * 获取指定时间区间段，按当前时间算最早的一日，时间 hh:0, m:0 s:0
     * 
     * @param date
     * @param timeInterval
     * @return
     */
    public static Date getLastTime(Date date, String timeInterval) {
        Calendar calendar = Calendar.getInstance(Locale.CHINESE);
        calendar.setTime(date);
        if (date == null) {

            calendar.set(Calendar.HOUR, 0);
            calendar.set(Calendar.MINUTE, 0);
            calendar.set(Calendar.SECOND, 0);
        }
        switch (timeInterval) {
        case HOUR:
            // 小时内不做
            break;
        case DAY:
            calendar.set(Calendar.HOUR_OF_DAY, calendar.getActualMinimum(Calendar.HOUR_OF_DAY));
            break;
        case WEEK:
            calendar.set(Calendar.DAY_OF_WEEK, calendar.getFirstDayOfWeek());
            break;
        case MONTH:
            calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMinimum(Calendar.DAY_OF_MONTH));
            break;
        case SEVEN:
            calendar.add(Calendar.DAY_OF_YEAR, -6);
            break;
        default:
            break;
        }
        return calendar.getTime();
    }

    /**
     * 与当前时间间隔 天数
     * 
     * @param date
     * @param day
     * @return
     */
    public static Date getTime(Date date, Integer day) {
        Calendar calendar = Calendar.getInstance(Locale.CHINESE);
        calendar.setTime(date);
        calendar.add(Calendar.DAY_OF_YEAR, day);
        calendar.set(Calendar.HOUR, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        return calendar.getTime();
    }

    /**
     * 凌晨
     * 
     * @param date
     * @flag 0 返回yyyy-MM-dd 00:00:00日期<br>
     *       1 返回yyyy-MM-dd 23:59:59日期
     * @return
     */
    public static Date weeHours(Date date, int flag) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        int hour = cal.get(Calendar.HOUR_OF_DAY);
        int minute = cal.get(Calendar.MINUTE);
        int second = cal.get(Calendar.SECOND);
        // 时分秒（毫秒数）
        long millisecond = hour * 60 * 60 * 1000 + minute * 60 * 1000 + second * 1000;
        // 凌晨00:00:00
        cal.setTimeInMillis(cal.getTimeInMillis() - millisecond);

        if (flag == 0) {
            return cal.getTime();
        } else if (flag == 1) {
            // 凌晨23:59:59
            cal.setTimeInMillis(cal.getTimeInMillis() + 23 * 60 * 60 * 1000 + 59 * 60 * 1000 + 59 * 1000);
        }
        return cal.getTime();
    }

    public static void main(String[] args) {
        // System.out.println(1);
        // System.out.println(getLastTime(new Date(), WEEK));
        Date start = TimeInterval.weeHours(new Date(), 0);
        System.out.println(start);
    }

    /**
     * 将时间转换为MM/dd/yyyy，字符串
     * 
     * @param date
     * @return MM/dd/yyyy eg:02/25/2015
     */
    public static String stringDay(Date date, String formatType) {
        // 02/25/2015

        SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy");
        if (Lang.isNotEmpty(formatType)) {
            format = new SimpleDateFormat(formatType);
        }
        return format.format(date);
    }

    public static String stringDateTime(Date date) {
        // 02/25/2015
        SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
        return format.format(date);
    }

    public static Date getDateByStr(String date) {
        SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy");
        try {
            return format.parse(date);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return new Date();
    }

    public static Date lastTime(String timeInterval) {
        return getLastTime(new Date(), timeInterval);
    }

    public static String lastTimeStr(Date date, String timeInterval, String formatType) {
        return stringDay(getLastTime(date, timeInterval), formatType);
    }
}
