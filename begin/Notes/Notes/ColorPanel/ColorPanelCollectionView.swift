//
//  ColorPanelCollectionView.swift
//  Notes
//
//  Created by Alex Prokudin on 14/07/2019.
//  Copyright © 2019 Alex Prokudin. All rights reserved.
//

import UIKit

@IBDesignable
class ColorPanelCollectionView: UICollectionView {
    let colorsCout: Int = 4
    let colorSquareSize: Int = 50
    let colorSpacing: CGFloat = 10.0
    
    let defaultColors: [UIColor?] = [.white, .red, .green, nil]
}
