package com.apress.books.client;
import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.apress.books.model.Book;
import com.apress.books.service.BookService;

public class BookApp {

	public static void main(String[] args) {
		 ApplicationContext context = new ClassPathXmlApplicationContext("beans.xml");
		 BookService bookService = (BookService)context.getBean("service");
		// List all books
		System.err.println("Listing all Books:");
		List<Book> bookList= bookService.getAllBooks();
		for(Book b: bookList){
			System.out.println(b.getId()+"--"+b.getBookTitle());

		}
		// search book by keyword
		System.err.println("Search book by keyword  in book title : Groovy:");

		//searchBooks("Groovy");
		System.out.println();

		System.err.println("Search book by keyword  in author's name  : Josh:");

		//searchBooks("Josh");
		

	}

	/*	private static void searchBooks(String keyWord) {
		List<Book> books = bookDao.searchBooksByKeyword(keyWord);
		for (Book book : books) {
			System.out.println(book);
		}
	}*/
}