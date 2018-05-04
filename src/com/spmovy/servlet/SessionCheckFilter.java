package com.spmovy.servlet;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class SessionCheckFilter implements Filter {

    @Override
    public void init(FilterConfig fc) {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain fc) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        if (req.getSession().getAttribute("role") == null) {
            res.sendRedirect("/admin.jsp?login=Not");
        } else {
            String role = (String) req.getSession().getAttribute("role");
            if (!role.equals("admin")){ //check if user type is not admin
                res.sendRedirect("/admin.jsp?login=Not");
            }
            fc.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
    }
}
