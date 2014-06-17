package com.apress.bookstore.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import com.apress.bookstore.model.Author;
import com.apress.bookstore.model.Book;
import com.apress.bookstore.model.Category;

public class BookDAOImpl implements BookDAO{
	
	 DataSource dataSource;  
	  
	 
		public void setDataSource(DataSource dataSource) {
			this.dataSource = dataSource;
		}

		public List<Book> findAllBooks() {  
			  List<Book> bookList = new ArrayList<Book>();  
			  
				String sql = "select * from book inner join author on book.id = author.book_id";
			  
			  JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);  
			  bookList = jdbcTemplate.query(sql, new BookRowMapper());  
			  return bookList;  
			 }  


	@Override
	public List<Book> searchBooksByKeyword(String keyWord) {
		  List<Book> bookList = new ArrayList<Book>();  

		String sql = "select * from book inner join author on book.id = author.book_id"
				+ " where book_title like '%"
				+ keyWord.trim()
				+ "%'"
				+ " or first_name like '%"
				+ keyWord.trim()
				+ "%'"
				+ " or last_name like '%" + keyWord.trim() + "%'";		
				  JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);  
				  bookList = jdbcTemplate.query(sql, new BookRowMapper());  
				  return bookList;  


	}

	@Override
	public List<Category> findAllCategories() {
		List<Category> result = new ArrayList<Category>();
		String sql = "select * from category";		
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);  
		result = jdbcTemplate.query(sql, new CategoryRowMapper());  
		  return result;  
	}
	

	
	
	
	
	
	
	@Override
	public void insert(Book book) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(Book book) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(Long bookId) {
		// TODO Auto-generated method stub
		
	}

}
