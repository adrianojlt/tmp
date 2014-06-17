package com.apress.books.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.ResultSetExtractor;

import com.apress.books.model.Author;
import com.apress.books.model.Book;


public class BookExtractor implements ResultSetExtractor<Book> {  
	  
	 public Book extractData(ResultSet resultSet) throws SQLException,  
	   DataAccessException {  
	    
	  Book book = new Book();  
	  Author author = new Author();
		List<Author> authorList = new ArrayList<>();

	  book.setId(resultSet.getLong(1));  
	  book.setCategoryId(resultSet.getLong(2)); 
	  book.setBookTitle(resultSet.getString(3)); 
	  book.setPublisherName(resultSet.getString(4));
	  book.setId(resultSet.getLong(5));  
	  author.setBookId(resultSet.getLong(6));
	  author.setFirstName(resultSet.getString(7));
	  author.setLastName(resultSet.getString(8));
	  authorList.add(author);
	  book.setAuthors(authorList);

	  return book;  
	 }  
	  
	}  

