//
//  User.swift
//  Task1(SignUp_SignIn_Profile)
//
//  Created by IDE Academy on 5/12/20.
//  Copyright © 2020 Mostafa Saleh. All rights reserved.
//
import UIKit
struct User: Codable {
    var userName: String
    var email: String
    var phoneNumber: String
    var password: String
    var address: String
    var gender: String
    //var image: Image?
    var imageString: String?
    
//    init(userName:String, email:String, password:String, phoneNumber:String, address:String, gender:String, image:UIImage) {
//        self.userName = userName
//        self.email = email
//        self.password = password
//        self.phoneNumber = phoneNumber
//        self.gender = gender
//        self.address = address
//        self.image = Image(withImage: image)
//    }
}
