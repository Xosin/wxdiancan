package com.qcl.loginyz;


import com.qcl.meiju.ResultEnum;
import com.qcl.yichang.DianCanException;
import com.ramostear.captcha.HappyCaptcha;
import com.ramostear.captcha.support.CaptchaStyle;
import com.ramostear.captcha.support.CaptchaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


//https://gitee.com/ramostear/Happy-Captcha   在线二维码接口
@RestController
@RequestMapping("/happycaptcha")
public class HappyCaptchaController{

    //二维码验证接口
    @PostMapping("/login")
    public Object login(String verifyCode,HttpServletRequest request){

        final boolean result = HappyCaptcha.verification(request,verifyCode,true);
        if(result){
            return "登录成功";
        }else{
            throw new DianCanException(ResultEnum.LOGIN_FAIL);
        }
    }

    //生成二维码接口
    @GetMapping("/verifyCode")
    public void generateImg(HttpServletRequest request,HttpServletResponse response) throws IOException {
        HappyCaptcha.require(request,response)
                .style(CaptchaStyle.ANIM)
                .type(CaptchaType.ARITHMETIC_ZH)//可以指定中文
                .build().finish();
    }
}
