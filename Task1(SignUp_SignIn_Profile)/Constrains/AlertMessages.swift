//
//  AlertMessages.swift
//  Task1(SignUp_SignIn_Profile)
//
//  Created by IDE Academy on 7/6/20.
//  Copyright © 2020 Mostafa Saleh. All rights reserved.
//

import Foundation
struct RequirdFiledAlert{
    static let message = "Missing Requird Fileds"
}
struct Unidentifiable{
    static let message = "Unidentifiable Credentials"
}
struct InvalidCredentials{
    static let message = "Invalid Credentials"
}

struct EmailAlertMessage {
    static let message = "Found Email Filed is Empty, Fill it Please"
    static let InvalidFormat = "Invalid E-mail Format"
    static let RightFormatDescription = "E-mail Filed is Empty or InValid E-mail Format"
    static let EmptyE_mailFiled = "Found Email Filed is Empty, Fill it Please"
    static let DisMatchedE_mail = "E-mail field isn't Match"
    static let UsedE_mail = "You Enterd an Email That is already used before, please use another email else to continue sign Up Process."
     static let NotUniqueE_mail = "An Email is already in use"
    static let UnIdentifiableE_mail = "You have been Entered a non-Registered Email, so Please enate Identifiable Email"
    
}

struct PasswordAlertMessage {
    static let message = "Found Password Filed is Empty, Fill it Please"
    static let InvalidFormat = "Invalid Password Format"
    static let RightFormatDescription = "Password Filed is Empty or Doesn't Contain at least 1 Alphabet, 1 Number and 1 Special Character and Minimum 8 characters."
    static let EmptyPasswordFiled = "Found Password Filed is Empty, Fill it Please"
    static let DisMatchedPassword = "Password field isn't Match"
}
struct PhoneNumberAlertMessage {
    static let Message = "Found Phone Number Filed is Empty, Fill it Please"
    static let InvalidFormat = "Invalid Phone Number Format"
    static let RightFormatDescription = "Phone Number Filed is Empty or The Entered Number Doesn't Start with 010,011,012 or 015 with Max 10 Numbers at All"
}
struct AddressAlertMessage {
    static let Message = "Found Address Filed is Empty, Fill it Please"
    static let InvalidPasswordFormat = "Invalid Password Format"
}
struct ProfileImageAlertMessage {
    static let Message = "Found Image View is Empty, Select Image Please"
    static let InvalidPasswordFormat = "Invalid Password Format"
}

struct APIErrors {
    static let Error:Error = "The internet was disconnected during the information retrieval process" as! Error
}
