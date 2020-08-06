//
//  Image.swift
//  Task1(SignUp_SignIn_Profile)
//
//  Created by IDE Academy on 5/19/20.
//  Copyright © 2020 Mostafa Saleh. All rights reserved.
//

import Foundation
import UIKit

struct Image: Codable{
    let imageData: Data?
    
    init(withImage image: UIImage) {
        self.imageData = image.pngData()
    }
    
    func getImage() -> UIImage? {
        guard let imageData = self.imageData else {
            return nil
        }
        let image = UIImage(data: imageData)
        
        return image
    }
}
