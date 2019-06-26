package com.cdut.Bean;


import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.util.Date;

@Table(name = "tb_user")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull(message = "用户名不能为空！")
    @Size(max = 16,min = 4,message = "用户名长度在4到16个字符之间！")
    private String name;

    @NotNull(message = "密码不能为空！")
    @Size(max = 16,min = 4,message = "密码长度在4到16个字符之间！")
    private String password;

    @NotNull(message = "电话号码不能为空！")
    @Pattern(regexp = "^1(3|4|5|7|8)\\d{9}$", message = "请输入正确的电话号码！")
    private String phone;

    @NotNull(message = "邮箱不能为空！")
    @Pattern(regexp = "^[A-Za-z\\d]+([-_.][A-Za-z\\d]+)*@([A-Za-z\\d]+[-.])+[A-Za-z\\d]{2,4}$", message = "请输入正确的邮箱！")
    private String email;


    private Date created;

    private Date updated;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email.trim();
    }

    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }

    public Date getUpdated() {
        return updated;
    }

    public void setUpdated(Date updated) {
        this.updated = updated;
    }
}