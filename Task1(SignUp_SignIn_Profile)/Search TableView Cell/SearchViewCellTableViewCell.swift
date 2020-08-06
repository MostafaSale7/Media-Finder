//
//  SearchViewCellTableViewCell.swift
//  Task1(SignUp_SignIn_Profile)
//
//  Created by IDE Academy on 7/19/20.
//  Copyright © 2020 Mostafa Saleh. All rights reserved.
//

import UIKit
import SDWebImage


class SearchViewCellTableViewCell: UITableViewCell {

    @IBOutlet weak var mediaImageViewer: UIImageView!
    @IBOutlet weak var firestMediaLabel: UILabel!
    @IBOutlet weak var secondMediaLabel: UILabel!
    
    var mediaType:Int!
    var randomNum:Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //makeImageViewCirclerShape()

        // Configure the view for the selected state
    }
    func makeImageViewCirclerShape() {
        self.mediaImageViewer.layer.cornerRadius = self.mediaImageViewer.frame.size.width / 2;
        self.mediaImageViewer.clipsToBounds = true;
    }
    
    public func configureCell(mediacell:Media){
        
        self.mediaImageViewer.sd_setImage(with: URL(string: mediacell.artworkUrl100 ?? ""), placeholderImage: UIImage(named: "placeholder-image"))
        if randomNum % 2 == 0{
            makeImageViewCirclerShape()
        }
        
        if mediaType == 1 {
            firestMediaLabel.text = mediacell.artistName
        }else if mediaType == 0 || mediaType == 2 {
            firestMediaLabel.text = mediacell.trackName
        }
        
        if mediaType == 0 {
            secondMediaLabel.text = mediacell.artistName
        }else if mediaType == 1 || mediaType == 2 {
            secondMediaLabel.text = mediacell.longDescription
        }
    }
    func animateImage(){
        UIView.animate(withDuration: 1, animations:{
            self.mediaImageViewer.frame.origin.y -= 5}){_ in
                UIView.animate(withDuration: 1, animations:{
                    self.mediaImageViewer.frame.origin.y += 5})
        }
    }
    
    @IBAction func imageBounceAnimationButtonTapped(_ sender: Any) {
       animateImage()
    }
}
