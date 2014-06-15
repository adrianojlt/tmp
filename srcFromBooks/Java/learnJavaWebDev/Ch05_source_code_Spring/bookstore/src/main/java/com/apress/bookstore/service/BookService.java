package com.apress.bookstore.service;

import java.util.LinkedList;
import java.util.List;

import com.apress.bookstore.dao.BookDAO;
import com.apress.bookstore.dao.BookDAOImpl;
import com.apress.bookstore.model.Author;
import com.apress.bookstore.model.Book;
import com.apress.bookstore.model.Category;

public class BookService {

	private static List<Book> bookList;
	private static List<Category> catList;
	private  BookDAO bookDao ;


	public void setBookDao(BookDAO bookDao) {
		this.bookDao = bookDao;
	}



	
	public List<Book> getAllBooksList() {
           List<Book> allBooks = bookDao.findAllBooks();
		return allBooks;
	}
	public List<Category> getCategoryList() {
        List<Category> catList = bookDao.findAllCategories();

		return catList;
	}
	
	 public Book createBook(Book b) {
			Book book = new Book();
			book.setId((long)bookList.size() + 1);
			book.setBookTitle(b.getBookTitle());
			bookList.add(book);
			return book;
		    }	

}