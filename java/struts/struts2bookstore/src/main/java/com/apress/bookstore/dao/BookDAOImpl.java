package com.apress.bookstore.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.apress.bookstore.model.Author;
import com.apress.bookstore.model.Book;
import com.apress.bookstore.model.Category;
import com.apress.bookstore.model.User;

public class BookDAOImpl implements BookDAO {
	private PreparedStatement statement;
	private ResultSet resultset;

	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException ex) {
		}
	}

	private Connection getConnection() throws SQLException {
		return DriverManager.getConnection("jdbc:mysql://localhost:3306/books",
				"root", "password");
	}

	private void closeConnection(Connection connection) {
		if (connection == null)
			return;
		try {
			connection.close();
		} catch (SQLException ex) {
		}
	}

	public List<Book> findAllBooks() {
		List<Book> result = new ArrayList<Book>();
		List<Author> authorList = new ArrayList<Author>();
		String sql = "select * from book inner join author on book.id = author.book_id";
		Connection connection = null;
		try {

			connection = getConnection();
			statement = connection.prepareStatement(sql);
			statement.clearParameters();
			resultset = statement.executeQuery();
			while (resultset.next()) {
				Book book = new Book();
				Author author = new Author();
				book.setId(resultset.getLong("id"));
				book.setBookTitle(resultset.getString("book_title"));
				book.setCategoryId(resultset.getLong("category_id"));
				author.setBookId(resultset.getLong("book_Id"));
				author.setFirstName(resultset.getString("first_name"));
				author.setLastName(resultset.getString("last_name"));
				authorList.add(author);
				book.setAuthors(authorList);
				book.setPrice(resultset.getDouble("price"));
				result.add(book);
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		} finally {
			closeConnection(connection);
		}
		return result;
	}

	public List<Book> searchBooksByKeyword(String keyWord) {
		List<Book> result = new ArrayList<Book>();
		List<Author> authorList = new ArrayList<Author>();

		String sql = "select * from book inner join author on book.id = author.book_id"
				+ " where book_title like '%"
				+ keyWord.trim()
				+ "%'"
				+ " or first_name like '%"
				+ keyWord.trim()
				+ "%'"
				+ " or last_name like '%" + keyWord.trim() + "%'";

		Connection connection = null;
		try {

			connection = getConnection();
			PreparedStatement statement = connection.prepareStatement(sql);
			ResultSet resultSet = statement.executeQuery();
			while (resultSet.next()) {
				Book book = new Book();
				Author author = new Author();
				book.setId(resultSet.getLong("id"));
				book.setBookTitle(resultSet.getString("book_title"));
				book.setPrice(resultSet.getDouble("price"));
				author.setFirstName(resultSet.getString("first_name"));
				author.setLastName(resultSet.getString("last_name"));
				author.setBookId(resultSet.getLong("book_id"));
				authorList.add(author);
				book.setAuthors(authorList);
				result.add(book);
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		} finally {
			closeConnection(connection);
		}

		return result;
	}

	public List<Category> findAllCategories() {
		List<Category> result = new ArrayList<Category>();
		String sql = "select * from category";

		Connection connection = null;
		try {
			connection = getConnection();
			PreparedStatement statement = connection.prepareStatement(sql);
			ResultSet resultSet = statement.executeQuery();
			while (resultSet.next()) {
				Category category = new Category();
				category.setId(resultSet.getLong("id"));
				category.setCategoryDescription(resultSet
						.getString("category_description"));
				result.add(category);
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		} finally {
			closeConnection(connection);
		}
		return result;
	}

	public void insert(Book book) {
	}

	public void update(Book book) {
	}

	public void delete(Long bookId) {

	}

	public boolean isUserAllowed(User user) {

		String sql = "select * from user where username like ? and password like ?";

		Connection connection = null;
		boolean valid = false;

		try {
			connection = getConnection();
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.clearParameters();
			statement.setString(1, user.getUserName());
			statement.setString(2, user.getPassword());
			ResultSet resultset = statement.executeQuery();
			if (resultset.next()) {
				valid = true;
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		} finally {
			closeConnection(connection);
		}
		return valid;

	}

	public ArrayList<Book> findBooksByCategory(int categoryId) {
		ArrayList<Book> bookList = new ArrayList<Book>();
		List<Author> authorList = new ArrayList<Author>();
		String sql = "select * from book inner join author on book.id = author.book_id"
				+ " where category_id = ?";
		Connection connection = null;
		try {
			connection = getConnection();
			statement = connection.prepareStatement(sql);
			statement.clearParameters();
			statement.setInt(1, categoryId);
			resultset = statement.executeQuery();

			while (resultset.next()) {
				Book book = new Book();
				Author author = new Author();
				book.setId(resultset.getLong("id"));
				book.setBookTitle(resultset.getString("book_title"));
				book.setCategoryId(resultset.getLong("category_id"));
				author.setBookId(resultset.getLong("book_Id"));
				author.setFirstName(resultset.getString("first_name"));
				author.setLastName(resultset.getString("last_name"));
				authorList.add(author);
				book.setAuthors(authorList);
				book.setPrice(resultset.getDouble("price"));
				bookList.add(book);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return bookList;
	}

}