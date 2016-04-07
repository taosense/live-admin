package com.xinhuanet.live.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("error")
public class ErrorAction {

    @RequestMapping("loginError")
    public String loginError() {
        return "error/loginError";
    }

}
