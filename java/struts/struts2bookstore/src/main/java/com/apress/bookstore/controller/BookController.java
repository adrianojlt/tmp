package com.apress.bookstore.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.struts2.util.ServletContextAware;

import com.apress.bookstore.dao.BookDAO;
import com.apress.bookstore.dao.BookDAOImpl;
import com.apress.bookstore.model.Book;
import com.apress.bookstore.model.Category;
import com.apress.bookstore.model.User;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class BookController extends ActionSupport  {

	private static final long serialVersionUID = 1L;
	private int category;
	private String keyword;
	private BookDAO dao;
	private List<Book> bookList;
	private String username;
	private String password;
	private Map<String, Object> session;
	private User user;
	private List<Category> categoryList;
	private String imageUrl;
	
	public String login() {
		return "login";
	}

	public String executelogin() {
		String executelogin = "failed";
		session = ActionContext.getContext().getSession();
		dao = new BookDAOImpl();
		user = new User();
		user.setUserName(getUsername());
		user.setPassword(getPassword());
		setUser(user);
		if (dao.isUserAllowed(user)) {

			setCategoryList(dao.findAllCategories());
			session.put("username", username);
			session.put("categoryList", getCategoryList());
			executelogin = "success";
		}
		/*
		 * if (this.username.equals("vishal") &&
		 * this.password.equals("password")) { return "success"; }
		 */else {
			addActionError(getText("error.login"));
			return "error";
		}
		// return result;
		return "executelogin";
	}

	public String error() {
		return "error";
	}

	public String allBooks() {
		dao = new BookDAOImpl();
		setBookList(dao.findAllBooks());
		return "allBooks";
	}

	public String booksByCategory() {
		dao = new BookDAOImpl();
		setBookList(dao.findBooksByCategory(category));
		return "booksByCategory";
	}

	public String searchByKeyword() {
		dao = new BookDAOImpl();
		setBookList(dao.searchBooksByKeyword(keyword));
		return "allBooks";
	}

	public String home() {
		return "home";
	}
	
	public String selectedBooks()
	{
		return "selectedBooks";
	}
	
	public String logout() {
		session = ActionContext.getContext().getSession();
		session.remove("username");
		return "logout";
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public List<Book> getBookList() {
		return bookList;
	}

	public void setBookList(List<Book> bookList) {
		this.bookList = bookList;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public List<Category> getCategoryList() {
		return categoryList;
	}

	public void setCategoryList(List<Category> categoryList) {
		this.categoryList = categoryList;
	}

	public BookDAO getDao() {
		return dao;
	}

	public void setDao(BookDAO dao) {
		this.dao = dao;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	
}
