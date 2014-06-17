package com.apress.books.service;

import java.util.List;

import com.apress.books.dao.BookDAO;
import com.apress.books.model.Book;

public class BookServiceImpl implements BookService{

	private  BookDAO bookDao ;


	public void setBookDao(BookDAO bookDao) {
		this.bookDao = bookDao;
	}


	public List<Book> getAllBooks() {
		List<Book> bookList = bookDao.findAllBooks();

		return bookList;
	}
}
