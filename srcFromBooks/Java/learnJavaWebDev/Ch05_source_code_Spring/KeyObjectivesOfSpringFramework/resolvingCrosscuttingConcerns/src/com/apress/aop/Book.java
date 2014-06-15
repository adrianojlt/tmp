package com.apress.aop;

public class Book {
	private Long id;
	private String bookTitle;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getBookTitle() {
		return bookTitle;
	}

	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}

	public String toString() {
		return "Book - Id: " + id + ", Book Title: " + bookTitle;
	}

}
