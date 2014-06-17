package com.apress.aop;

public class LoggingAspect {
	long startTime;
	long endTime;
	public void logBefore() {
		 
		System.out.println("Before calling getAllBooks");
	}

	public void logAfter() {
		System.out.println("After calling getAllBooks");
	}
}
