//
//  Constrains.swift
//  Task1(SignUp_SignIn_Profile)
//
//  Created by IDE Academy on 6/28/20.
//  Copyright © 2020 Mostafa Saleh. All rights reserved.
//

import Foundation
struct VCs{
    static let signUpVC = "SignUpVC"
    static let signInVC = "SignInVC"
    static let profileVC = "ProfileVC"
    static let mapVC = "MapVC"
    static let moviesVC = "MoviesVC"
    static let moviesDescriptionVC = "MovieDescriptionVC"
    static let mainTabBarVC = "mainTabBarVC"
}
struct Urls {
     static let base = "https://api.androidhive.info/json/movies.json"
     static let ituensApi = "https://itunes.apple.com/search"
}

struct Storyboard {
    static let mainStoryBoard = "Main"
}

struct UserDefaultsKeys {
    static let isLoggedIn = "isLoggedIn"
    static let user = "User"
}

struct MovieCell {
    static let moviesCell = "MoviesCell"
}
struct SearchResultCell {
    static let searchCell = "SearchViewCellTableViewCell"
}
