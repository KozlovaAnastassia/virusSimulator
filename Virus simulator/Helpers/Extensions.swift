//
//  Extensions.swift
//  Virus simulator
//
//  Created by Анастасия on 10.05.2023.
//

import Foundation
import UIKit

extension UIView {
    func addBackground(forImage name: String) {
    
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height

        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewBackground.image = UIImage(named: name)

        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill

        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }
}
