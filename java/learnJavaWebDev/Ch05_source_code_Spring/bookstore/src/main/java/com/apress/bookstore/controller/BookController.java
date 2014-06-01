package com.apress.bookstore.controller;

import com.apress.bookstore.model.Book;
import com.apress.bookstore.service.BookService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class BookController {
	
	  private BookService bookService ;

	 public BookService getBookService() {
	  		return bookService;
	  	}

	  	public void setBookService(BookService bookService) {
	  		this.bookService = bookService;
	  	}

	@RequestMapping("/list_book.html")
    public ModelAndView bookListController() {
        ModelAndView modelAndView = new ModelAndView("bookList");
        modelAndView.addObject("bookList", bookService.getCategoryList());
        return modelAndView;
    }
	@RequestMapping("/allBooks.html")
    public ModelAndView allBooksController() {
        ModelAndView modelAndView = new ModelAndView("allBooks");
        modelAndView.addObject("allBooks", bookService.getAllBooksList());
        return modelAndView;
    }
   
}
