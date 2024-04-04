package com.example.demo.controller
import com.example.demo.service.AuthService

import com.example.demo.model.User
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.http.ResponseEntity
import org.springframework.beans.factory.annotation.Autowired

@RestController
class UserController @Autowired constructor(private val authService: AuthService) {

    private val users = listOf(
        User(1, "janek", "janek@example.com"),
        User(2, "anna", "anna@example.com"),
        User(3, "tomek", "tomek@example.com")
    )

    @GetMapping("/users")
    fun getUsers(): List<User> {
        return users
    }

    @PostMapping("/login")
    fun login(@RequestBody loginData: LoginData): ResponseEntity<String> {
        return if (authService.authenticate(loginData.username, loginData.password)) {
            ResponseEntity.ok("User authenticated successfully")
        } else {
            ResponseEntity.status(401).body("Authentication failed")
        }
    }
}

data class LoginData(val username: String, val password: String)
