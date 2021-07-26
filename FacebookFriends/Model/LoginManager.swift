//
//  LoginManager.swift
//  FacebookFriends
//
//  Created by Burhan Alışkan on 23.07.2021.
//

import Foundation

struct LoginManager {
    
    let users: [String] = ["9nd54", "v542w", "17pcy0", "gbf48", "zdah4"]
    let password: String = "1995"
    
    func loginApp(_ userName: String, _ password: String) -> Bool {
        var isLogin = false
        
        for index in 0 ... users.count - 1 {
            if userName == users[index] , password == self.password {
                isLogin = true
                break
            } else {
                isLogin = false
            }
        }
        return isLogin
    }
    
    
}
