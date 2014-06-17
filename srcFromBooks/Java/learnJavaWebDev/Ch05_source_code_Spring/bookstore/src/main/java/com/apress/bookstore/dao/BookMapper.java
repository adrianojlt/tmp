package com.apress.bookstore.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.jdbc.core.RowMapper;

import com.apress.bookstore.model.Author;
import com.apress.bookstore.model.Book;

public class BookMapper implements RowMapper<Book> {

	 @Override  
	 public Book mapRow(ResultSet resultSet, int line) throws SQLException {  
	  BookExtractor bookExtractor = new BookExtractor();  
	  return bookExtractor.extractData(resultSet);  
	 }  
	  
	}  

