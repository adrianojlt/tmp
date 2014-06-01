package com.apress.books.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.apress.books.model.Book;


public class BookRowMapper implements RowMapper<Book> {  
	  
	 @Override  
	 public Book mapRow(ResultSet resultSet, int line) throws SQLException {  
	  BookExtractor bookExtractor = new BookExtractor();  
	  return bookExtractor.extractData(resultSet);  
	 }  
	  
	}  