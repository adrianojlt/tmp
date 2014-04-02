package ora.pt.cons.igif.sics.controller.misc;

public class LoggerPrinting {
    
    public static String getStackStrace (Exception e) {
        StringBuffer stackTraceBuffer = new StringBuffer();
        
        StackTraceElement[] trace = e.getStackTrace();
        for (int i=0; i < trace.length; i++){
            stackTraceBuffer.append(trace[i]);
            stackTraceBuffer.append("\n");
        }
        
        return stackTraceBuffer.toString();
    }
    
}