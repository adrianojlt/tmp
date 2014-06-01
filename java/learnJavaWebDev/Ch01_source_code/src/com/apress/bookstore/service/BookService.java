package com.apress.bookstore.service;

import java.util.List;

import com.apress.bookstore.model.Book;
import com.apress.bookstore.model.Category;

public interface BookService {
	public List<Book> findAll();
	public List<Category> findAllCategories();
	
	public List<Book> searchBooksByKeyword(String keyWord);
	

}
