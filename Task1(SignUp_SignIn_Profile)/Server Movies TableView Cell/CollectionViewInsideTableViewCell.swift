//
//  CollectionViewInsideCollectionViewCell.swift
//  Task1(SignUp_SignIn_Profile)
//
//  Created by IDE Academy on 7/13/20.
//  Copyright © 2020 Mostafa Saleh. All rights reserved.
//

import UIKit
import SDWebImage

class CollectionViewInsideTableViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    
    public func configureCell(movie:ServerMovies){
        self.posterImageView.sd_setImage(with: URL(string: movie.image), placeholderImage: UIImage(named: "placeholder-image"))
        self.movieName.text = movie.title
        self.movieRating.text = "\(movie.rating)"
    }
}
