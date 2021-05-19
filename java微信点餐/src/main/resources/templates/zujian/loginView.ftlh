<html>
<#include "../zujian/top.ftlh">
<body style=" background: url(/diancan/img/bg.png)
no-repeat center center ; background-size: cover;">
<div class="modal-dialog" style="margin-top: 10%;">
    <div class="modal-content">
        <div class="modal-header">
            <h4 class="modal-title text-center" id="myModalLabel">登录</h4>
        </div>
        <div class="modal-body" id="model-body">
            <div class="form-group">
                <input type="text" name="phoneOrname" class="form-control" placeholder="用户名/手机号">
            </div>
            <div class="form-group">
                <input type="password" name="password" class="form-control" placeholder="密码" autocomplete="off">
            </div>

            <#--图形验证码-->
            <div class="password clearfix">
                <img src="/diancan/happycaptcha/verifyCode" onclick="changeValidateCode(this)">
            </div>


            <div class="password clearfix">
                <input type="text" id="verifyCode" placeholder="请输入验证码" maxlength="6" >
            </div>


        </div>
        <div class="modal-footer">
            <div class="form-group">
                <button type="button" id="loginBtn" class="btn btn-primary form-control">登录</button>
            </div>
            <#--            <div class="form-group">-->
            <#--                <button type="button" class="btn  btn-info form-control">注册</button>-->
            <#--            </div>-->
        </div>
    </div>
</div>

<script>
    /*
    * 登陆页
    * */
    $("#loginBtn").click(function () {
        console.log("点击了登录2")
        login();
    });

    function login() {
        let phoneOrname = $("input[ name='phoneOrname' ] ").val();
        let password = $("input[ name='password' ] ").val();
        if (phoneOrname == undefined || phoneOrname == "") {
            alert("请输入手机号/用户名");
            return;
        }
        if (password == undefined || password == "") {
            alert("请输入密码");
            return;
        }
        if(!$("#verifyCode").val()){
            alert("请输入验证码");
        }


        $.ajax({
            url: "/diancan/loginAdmin",
            data: {
                "phoneOrname": phoneOrname,
                "password": password
            },
            success: function (data) {
                $.post("/diancan/happycaptcha/login",{
                    "verifyCode":$("#verifyCode").val()
                },function(response){
                    if(response){
                        alert("登录验证通过");
                        console.log("登录成功", data)
                        $("#mainContainer").html(data);
                        window.location.href = "/diancan/home/homeList";
                    }else {
                        alert("请输入正确的验证码")
                    }
                })
            },
            error: function (err) {
                console.log("登录失败", err)
                alert("登录失败,账号或者密码不正确");
                // toastr.error("error!");
            }
        });
    }


    function changeValidateCode(obj) {
        //获取当前的时间作为参数，无具体意义
        var timenow = new Date().getTime();
        //每次请求需要一个不同的参数，否则可能会返回同样的验证码
        //这和浏览器的缓存机制有关系，也可以把页面设置为不缓存，这样就不用这个参数了。
        obj.src="/diancan/happycaptcha/verifyCode?d="+timenow;
    }

</script>
</body>
</html>