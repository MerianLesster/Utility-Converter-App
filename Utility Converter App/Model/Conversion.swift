//
//  ConversionItems.swift
//  Utility Converter App
//
//  Created by Damian Ranjit on 2021-03-16.
//

import UIKit
class Conversion {
    //let background: UIView
    let title: String
    let description: String
    let bgImage: UIImage
    let segueID: String
    
    
    init(title: String, description: String, bgImage: UIImage, segueID: String) {
        self.title = title
        self.description = description
        self.bgImage = bgImage
        self.segueID = segueID
    }
    
    func getCardTitle() -> String {
        return title
    }
    
    func getCardDescription() -> String {
        return description
    }
    
    func getBgImage() -> UIImage {
        return bgImage
    }
    
    func getSegueID() -> String {
        return segueID
    }
    
}
