package com.example.demo.controller

import com.example.demo.model.User
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class UserController {

    private val users = listOf(
        User(1, "janek", "janek@example.com"),
        User(2, "anna", "anna@example.com"),
        User(3, "tomek", "tomek@example.com")
    )

    @GetMapping("/users")
    fun getUsers(): List<User> {
        return users
    }
}
