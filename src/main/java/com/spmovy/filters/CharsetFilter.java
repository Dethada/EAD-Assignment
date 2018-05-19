package com.spmovy.filters;

import javax.servlet.*;
import java.io.IOException;

public class CharsetFilter implements Filter {

    @Override
    public void init(FilterConfig fc) {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain fc) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        fc.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}