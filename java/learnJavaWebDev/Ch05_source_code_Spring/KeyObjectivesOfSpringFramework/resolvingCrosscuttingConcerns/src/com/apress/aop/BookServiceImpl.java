package com.apress.aop;

import java.util.ArrayList;
import java.util.List;

public class BookServiceImpl implements BookService{
    private static List<Book> bookList;
    static {
        
        Book book1 = new Book();
        book1.setId((long)1);
        book1.setBookTitle("Modern Java");

        Book book2 = new Book();
        book2.setId((long)2);
        book2.setBookTitle("Beginning Groovy");

        Book book3 = new Book();
        book3.setId((long)2);
        book3.setBookTitle("Beginning Scala");

        bookList = new ArrayList<Book>();
        bookList.add(book1);
        bookList.add(book2);
        bookList.add(book3);
    }


	public List<Book> getAllBooks() {
		for(Book b: bookList){
			System.out.println("Books:"+b.getBookTitle());
		}
		return bookList;
	}
}
