//
//  UIColor.swift
//  TaskMatrix
//
//  Created by Takahito Yamada on 2021/02/09.
//

import UIKit

class RGBAColor: UIColor {
    
    func rgba(red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
}
