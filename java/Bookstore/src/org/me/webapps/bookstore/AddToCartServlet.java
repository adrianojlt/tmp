// AddToCartServlet.java
// Servlet to add a book to the shopping cart.
package org.me.webapps.bookstore;

// Java core packages
import java.io.*;
import java.text.DecimalFormat;
import java.util.*;

// Java extension packages
import javax.servlet.*;
import javax.servlet.http.*;

public class AddToCartServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
	
   protected void doPost( HttpServletRequest request,
      HttpServletResponse response )
      throws ServletException, IOException
   {
      HttpSession session = request.getSession( false );
      RequestDispatcher dispatcher;
      
      // if session does not exist, forward to index.html
      if ( session == null ) {
         dispatcher = 
            request.getRequestDispatcher( "/index.html" );
         dispatcher.forward( request, response );
      }
      
      // session exists, get cart HashMap and book to add
      Map<String,CartItemBean> cart =  (Map<String,CartItemBean>) session.getAttribute( "cart" );
      
      BookBean book = 
         ( BookBean ) session.getAttribute( "bookToAdd" );
      
      String total = (String) session.getAttribute( "total" );
      Double dtotal;
      
      if ( total != null ) {
    	  dtotal = Double.parseDouble(total);
      } else {
    	  dtotal = 0.0;
      }
      
      // if cart does not exist, create it
      if ( cart == null ) {
         cart = new HashMap<String,CartItemBean>();
         
         // set session attribute "cart"
         session.setAttribute( "cart", cart );
         session.setAttribute("total", "0.0");
      }
      
      dtotal = dtotal + Double.parseDouble(book.getFmprice());
      session.setAttribute("total", "" +  new DecimalFormat("0.00").format( dtotal ) );
      session.setAttribute("notempty", "1");
      
      // determine if book is in cart
      CartItemBean cartItem = 
         ( CartItemBean ) cart.get( book.getISBN() );
      
      // If book is already in cart, update its quantity.
      // Otherwise, create an entry in the cart.
      if ( cartItem != null ) {
         cartItem.setQuantity( cartItem.getQuantity() + 1 );
         Double subtotal = cartItem.getQuantity() * cartItem.getBook().getPrice();
         cartItem.setSubtotal( new DecimalFormat("0.00").format( subtotal ) );
      }
      else {
    	 CartItemBean cibean = new CartItemBean( book, 1 );
    	 cibean.setSubtotal( new DecimalFormat("0.00").format( book.getPrice() ) );
         cart.put( book.getISBN(), cibean );
      }
      
      // send the user to viewCart.jsp
      dispatcher = 
         request.getRequestDispatcher( "/viewCart.jsp" );
      dispatcher.forward( request, response );
   }   
}