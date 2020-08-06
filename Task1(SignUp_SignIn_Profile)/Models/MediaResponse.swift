//
//  MediaResponse.swift
//  Task1(SignUp_SignIn_Profile)
//
//  Created by IDE Academy on 7/19/20.
//  Copyright © 2020 Mostafa Saleh. All rights reserved.
//

import Foundation
struct MediaResponse:Decodable {
    var resultCount:Int
    var results:[Media]
}
