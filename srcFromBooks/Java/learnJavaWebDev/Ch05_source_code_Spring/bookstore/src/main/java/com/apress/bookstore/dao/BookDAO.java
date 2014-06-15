package com.apress.bookstore.dao;

import java.util.List;

import com.apress.bookstore.model.Book;
import com.apress.bookstore.model.Category;

public interface BookDAO {
	public List<Book> findAllBooks();
	
	public List<Book> searchBooksByKeyword(String keyWord);
	
	public List<Category> findAllCategories();

	public void insert(Book book);

	public void update(Book book);

	public void delete(Long bookId);

}
