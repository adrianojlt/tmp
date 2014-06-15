package com.apress.books.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import com.apress.books.model.Author;
import com.apress.books.model.Book;
import com.apress.books.model.Category;

public class BookDAOImpl implements BookDAO {

	
	 DataSource dataSource;  
	  
 
	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public List<Book> findAllBooks() {  
	  List<Book> bookList = new ArrayList<>();  
	  
		String sql = "select * from book inner join author on book.id = author.book_id";
	  
	  JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);  
	  bookList = jdbcTemplate.query(sql, new BookRowMapper());  
	  return bookList;  
	 }  
	
}