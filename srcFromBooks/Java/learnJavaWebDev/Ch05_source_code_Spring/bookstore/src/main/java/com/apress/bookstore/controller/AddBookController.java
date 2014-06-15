package com.apress.bookstore.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.request.WebRequest;

import com.apress.bookstore.model.Author;
import com.apress.bookstore.model.Book;
import com.apress.bookstore.service.AuthorService;
import com.apress.bookstore.service.BookService;
import com.apress.bookstore.validator.BookValidator;

@Controller
@RequestMapping("/addBook.html")
public class AddBookController {

    
    @RequestMapping(value="/addBook.html", method = RequestMethod.GET)
    public String initForm(ModelMap model) {
    	Book book = new Book();
    	book.setBookTitle("Add  Book :");
        model.addAttribute("book", book);
    	return "addBook";
    }
    
    @InitBinder
    public void initBinder(WebDataBinder binder, WebRequest request) {    	
    	binder.setDisallowedFields(new String[] {"author"});
        Book book = (Book)binder.getTarget();
    	AuthorService authorService = new AuthorService();    	
    	Long authorId = null;
    	try {
            authorId = Long.parseLong(request.getParameter("author"));
        } catch (Exception e) {}
        if (authorId != null) {
            Author author = authorService.getAuthorById(authorId);
           // book.setAuthor(author);
        }
    }
    
    @ModelAttribute("authorList")
    public List<Author> populateAuthorList() {
    	AuthorService authorService = new AuthorService();
    	return authorService.getAuthorList();
    }

    @RequestMapping(method = RequestMethod.POST)
    public String processSubmit(@ModelAttribute("book") Book book, BindingResult result, SessionStatus status) {
        BookService bookService = new BookService();
        bookService.createBook(book);
        if(result.hasErrors()) {
            return "addBook";
        } else {
        	bookService.createBook(book);
            return "redirect:/list_book.html";
        }
        
    }
}
