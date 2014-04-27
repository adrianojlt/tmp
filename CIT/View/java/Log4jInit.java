package ora.pt.cons.igif.sics.servlets;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.MDC;
import org.apache.log4j.PropertyConfigurator;


public class Log4jInit extends HttpServlet {

  public void init() {    
    String prefix =  getServletContext().getRealPath("/");
    String file = getInitParameter("log4j-init-file");
    if(file != null) {
      PropertyConfigurator.configure(prefix+file);
      System.setProperty("sics.property.log4j.fileConfiguration", prefix+file);
    }
  }

  public void doGet(HttpServletRequest req, HttpServletResponse res) {
  }
  
}

