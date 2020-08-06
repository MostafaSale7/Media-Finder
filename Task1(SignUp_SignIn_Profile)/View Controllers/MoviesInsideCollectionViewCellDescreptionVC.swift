//
//  MoviesInsideCollectionViewCellDescreptionVC.swift
//  Task1(SignUp_SignIn_Profile)
//
//  Created by IDE Academy on 7/13/20.
//  Copyright © 2020 Mostafa Saleh. All rights reserved.
//

import UIKit
import SDWebImage

class MoviesInsideCollectionViewCellDescreptionVC: UIViewController {

    @IBOutlet weak var movieImageViewer: UIImageView!
    
    @IBOutlet weak var movieTitleLable: UILabel!
    @IBOutlet weak var movieRatingLable: UILabel!
    @IBOutlet weak var movieRelaseYearLable: UILabel!
    
    var serverMovie:ServerMovies?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func putDataInFileds(){
        self.movieImageViewer.sd_setImage(with: URL(string: serverMovie?.image ?? ""), placeholderImage: UIImage(named: "placeholder-image"))
        self.movieTitleLable.text = serverMovie?.title
        self.movieRatingLable.text = "\(serverMovie?.rating ?? 0)"
        //self.movieRelaseYearLable.text = "\(serverMovie?.relaseYear ?? 0)"
        
    }
}
