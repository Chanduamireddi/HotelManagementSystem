<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Set a logout message
    String logoutMessage = "See you soon!";
    
    // Invalidate the session
    if (session != null) {
        session.invalidate();
    }

    // Redirect to homepage with a logout message
    response.sendRedirect("homePageGuest.jsp?message=" + java.net.URLEncoder.encode(logoutMessage, "UTF-8"));
%>
