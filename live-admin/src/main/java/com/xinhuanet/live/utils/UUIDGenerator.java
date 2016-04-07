package com.xinhuanet.live.utils;

import java.util.UUID;

public class UUIDGenerator {

	public static String getUUID() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}

	public static String getUpperUUID() {
		return getUUID().toUpperCase();
	}

	public static void main(String[] args) {
		System.out.println(UUIDGenerator.getUUID());
		System.out.println(UUIDGenerator.getUpperUUID());
	}
}
