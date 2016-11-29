package ua.edu.nau.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;
import java.util.TimeZone;

@WebFilter(urlPatterns = {"/*"})
public class TimeZoneFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        TimeZone.setDefault(TimeZone.getTimeZone("Etc/UTC"));
    }

    @Override
    public void destroy() {

    }
}
