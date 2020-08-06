//
//  SlideShowCollectionViewCell.swift
//  Task1(SignUp_SignIn_Profile)
//
//  Created by IDE Academy on 7/12/20.
//  Copyright © 2020 Mostafa Saleh. All rights reserved.
//

import UIKit

class SlideShowCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieSlideShowImageView: UIImageView!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieNameLable: UILabel!
    @IBOutlet weak var releaseYearLable: UILabel!
    
    
    public func configureSlideShowCell(movie:Movie){
        let slideShowImage = UIImage(named: movie.slideShowImage)
        self.movieSlideShowImageView.image = slideShowImage
        let posterImage = UIImage(named: movie.postarImage)
        self.moviePosterImageView.image = posterImage
        self.movieNameLable.text = movie.name
        self.releaseYearLable.text = "\(movie.relaseDate)"
    }
}
