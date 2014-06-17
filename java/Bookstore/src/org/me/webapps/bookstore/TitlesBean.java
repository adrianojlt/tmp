// TitlesBean.java
// Class TitlesBean makes a database connection and retrieves
// the books from the database.
package org.me.webapps.bookstore;

// Java core packages
import java.io.*;
import java.sql.*;
import java.util.*;

public class TitlesBean implements Serializable {
	private static final long serialVersionUID = 1L;
	private Connection connection;
	private PreparedStatement titlesQuery;

	// construct TitlesBean object
	public TitlesBean() throws Exception {
		// attempt database connection and setup SQL statements
		Class.forName("com.mysql.jdbc.Driver");
		connection = DriverManager
				.getConnection("jdbc:mysql://localhost:3306/bookstoredb",
						"javux", "javuxpass");

		titlesQuery = connection
				.prepareStatement("SELECT isbn, title, editionNumber, "
						+ "copyright, publisherID, imageFile, price "
						+ "FROM titles ORDER BY title");
	}

	// return a List of BookBeans
	public List<BookBean> getTitles() {
		List<BookBean> titlesList = new ArrayList<BookBean>();

		// obtain list of titles
		try {
			ResultSet results = titlesQuery.executeQuery();

			// get row data
			while (results.next()) {
				BookBean book = new BookBean();

				book.setISBN(results.getString("isbn"));
				book.setTitle(results.getString("title"));
				book.setEditionNumber(results.getInt("editionNumber"));
				book.setCopyright(results.getString("copyright"));
				book.setPublisherID(results.getInt("publisherID"));
				book.setImageFile(results.getString("imageFile"));
				book.setPrice(results.getDouble("price"));

				titlesList.add(book);
			}
		} catch (SQLException exception) {
			exception.printStackTrace();
		}

		return titlesList;
	}

	// close statements and terminate database connection
	protected void finalize() {
		// attempt to close database connection
		try {
			titlesQuery.close();
			connection.close();
		}

		// process SQLException on close operation
		catch (SQLException sqlException) {
			sqlException.printStackTrace();
		}
	}
}