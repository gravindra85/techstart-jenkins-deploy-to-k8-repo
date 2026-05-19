package org.t246osslab.easybuggy.exceptions;

import java.io.IOException;
import java.lang.reflect.MalformedParameterizedTypeException;
import java.lang.reflect.Type;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.t246osslab.easybuggy.core.servlets.AbstractServlet;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/mpte" })
public class MalformedParameterizedTypeExceptionServlet extends AbstractServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        throw new ServletException(new MalformedParameterizedTypeException());
    }
}
