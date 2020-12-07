package com.edu.tjdz.geng.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * MyController
 *
 * @author wangdong on 2020/12/7 20:10
 * @version 2.0
 */
@Controller
@SessionAttributes(value = {"message1","message2"})
public class MyController
{
    @RequestMapping(value="/student", method = RequestMethod.GET)

    public ModelAndView get(@CookieValue(value = "JSESSIONID", required = false)String jid, @CookieValue(value = "username", required = false)String username,
            @CookieValue(value = "password", required = false)String password) {
        System.out.println("session id 是：" + jid);
        System.out.println("当前登录用户名为：" + username + "，密码为： " + password );
        ModelAndView modelAndView = new ModelAndView();
        //modelAndView中的键值对也可以放在session中
        //放置方法是把modelAndView中的键添加到Controller头部中注解@SessionAttributes中

        modelAndView.addObject("message1", "ABCDEF");
        modelAndView.addObject("message2", 123456);
        modelAndView.setViewName("getSuccess");
        return modelAndView;
    }

    @RequestMapping(value="/student", method = RequestMethod.PUT)
    public String update(HttpSession session) {
        System.out.println("更新个人信息");
        String message1 = (String) session.getAttribute("message1");
        int message2 = (int) session.getAttribute("message2");
        System.out.println("messaget1 是：" + message1 + " messaget2 是：" + message2 );

        return "updateSuccess";
    }

    @RequestMapping(value="/login", method = RequestMethod.GET )
    public String login() {
        return "login";
    }

    @RequestMapping(value="/login", method = RequestMethod.POST )
    public String login(String username, String password, HttpServletResponse response) {
        System.out.println("登录用户名为：" + username + "，密码为： " + password );
        Cookie userCookie = new Cookie("username", username);
        Cookie pwdCookie = new Cookie("password", password);
        response.addCookie(userCookie);
        response.addCookie(pwdCookie);
        return "loginSuccess";
    }
}
