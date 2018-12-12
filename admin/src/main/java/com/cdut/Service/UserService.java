package com.cdut.Service;

import com.cdut.Bean.User;

public interface UserService {
    User queryUserByName(String name);

    User queryUserByPhone(String phone);

    User queryUserByEmail(String email);

    Boolean addUser(User user);
}
