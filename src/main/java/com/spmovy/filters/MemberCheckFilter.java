package com.spmovy.filters;

import com.spmovy.beans.UserJB;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class MemberCheckFilter implements Filter {
    @Override
    public void init(FilterConfig fc) {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain fc) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        UserJB user = (UserJB) req.getSession().getAttribute("user");
        if (user == null) {
            res.sendRedirect("/Login");
        } else {
            if (!user.getRole().equals("member")){ //check if user type is not member
                res.sendRedirect("/Login");
            }
            fc.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
    }
}
