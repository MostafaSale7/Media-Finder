//
//  SeverMovies.swift
//  Task1(SignUp_SignIn_Profile)
//
//  Created by IDE Academy on 7/13/20.
//  Copyright © 2020 Mostafa Saleh. All rights reserved.
//

import Foundation
struct ServerMovies:Decodable {
    var title:String
    var image:String
    var rating:Double
}
enum CodingKeys: String, CodingKey {
    case title = "title"
    case image = "image"
    case rating = "rating"
  
}
