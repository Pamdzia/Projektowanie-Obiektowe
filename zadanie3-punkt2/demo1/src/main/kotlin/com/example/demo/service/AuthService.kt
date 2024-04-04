package com.example.demo.service

import org.springframework.stereotype.Service

@Service
class AuthService {

    init {
        println("AuthService is initialized eagerly")
    }

    fun authenticate(username: String, password: String): Boolean {
        return username == "admin" && password == "admin"
    }
}