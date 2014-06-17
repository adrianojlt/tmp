package org.me.webapps.bookstore;

import java.io.*;
import java.util.*;

// Java extension packages
import javax.servlet.*;
import javax.servlet.http.*;

public class ListBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(true);

		try {
			TitlesBean titlesBean = new TitlesBean();
			List<BookBean> titles = titlesBean.getTitles();

			// store titles in session for further use
			session.setAttribute("titles", titles);
		} catch (Exception e) {
			e.printStackTrace();
		}

		RequestDispatcher dispatcher = request
				.getRequestDispatcher("/books.jsp");

		dispatcher.forward(request, response);

	}
}
