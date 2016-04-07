package com.xinhuanet.live.utils;

import org.springframework.core.io.ClassPathResource;

import java.io.InputStream;
import java.util.Properties;

/**
 * @author bjzhangyf
 * 获得config.properties中的配置属性
 */
public class Config {

	private static final String CONFIG_FILE = "config.properties";

	private static Config instance = null;

	private Row row = null;

	/**
	 * 私有构造，不能直接new
	 */
	private Config() {
		InputStream in = null;
		try {
			Properties properties = new Properties();
			ClassPathResource res = new ClassPathResource(CONFIG_FILE);
			in = res.getInputStream();
			properties.load(in);
			if (properties.size() != 0) {
				row = new Row(properties);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (in != null) {
					in.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 初始化
	 * 
	 * @return
	 */
	public static Config getInstance() {
		if (instance == null) {
			instance = new Config();
		}
		return instance;
	}

	/**
	 * 获得Row
	 * 
	 * @return
	 */
	public Row getRow() {
		return this.row;
	}

	/**
	 * @param configKey
	 * @return
	 */
	public static String gets(String configKey) {
		Row row = getInstance().getRow();
		if(row != null)
		  return row.gets(configKey);
		
		return null;
	}
	
	public static String gets(String configKey, String defaultValue) {
        Row row = getInstance().getRow();
        if(row != null)
          return row.gets(configKey, defaultValue);
        
        return defaultValue;
    }

	public static int geti(String configKey) {
		Row row = getInstance().getRow();
		if(row != null)
			return row.getInt(configKey, 0);
		
		return 0;
	}
	
	public static int geti(String configKey, int defaultValue) {
		Row row = getInstance().getRow();
		if(row != null)
			return row.getInt(configKey, defaultValue);
		
		return defaultValue;
	}

}
