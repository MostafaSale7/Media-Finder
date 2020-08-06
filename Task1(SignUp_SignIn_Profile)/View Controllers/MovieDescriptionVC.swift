//
//  MovieDescription.swift
//  Task1(SignUp_SignIn_Profile)
//
//  Created by IDE Academy on 6/28/20.
//  Copyright © 2020 Mostafa Saleh. All rights reserved.
//

import UIKit

class MovieDescriptionVC: UIViewController {

    
    @IBOutlet weak var movieDescriptionTextArea: UITextView!
    @IBOutlet weak var movieImageView: UIImageView!
    var movie: Movie!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard self.movie != nil else {
            print("No Movie has been sent")
            return
        }
        
        putDataInFileds()
        movieDescriptionTextArea.layer.cornerRadius = (movieDescriptionTextArea.frame.size.width / 2) - 160;
        movieDescriptionTextArea.clipsToBounds = true;
        // Do any additional setup after loading the view.
    }
    func putDataInFileds() {
        guard let image = UIImage(named: movie.slideShowImage) else {
            movieImageView.image = UIImage(named: "exclamation-mark-question-mark-clip-art-exclamation-mark-png")
            return
        }
        movieImageView.image = image
        movieDescriptionTextArea.text = movie.Descreption
    }

}
