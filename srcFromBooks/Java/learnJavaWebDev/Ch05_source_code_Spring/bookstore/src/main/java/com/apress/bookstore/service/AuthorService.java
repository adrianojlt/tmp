package com.apress.bookstore.service;

import java.util.LinkedList;
import java.util.List;
import com.apress.bookstore.model.Author;

public class AuthorService {
	private static List<Author> authorList;

	static {
		Author author1 = new Author();
		author1.setId((long) 1);
		author1.setFirstName("Jeff");
		author1.setLastName(" Brown");


		Author author2 = new Author();
		author2.setFirstName("Seth");
		author2.setLastName("Ladd");

		authorList = new LinkedList<Author>();
		authorList.add(author1);
		authorList.add(author2);
	}

	public List<Author> getAuthorList() {
		return authorList;
	}

	public Author getAuthorById(Long id) {
		for (Author author : authorList) {
			if (author.getId().equals(id))
				return author;
		}
		return null;
	}
}
