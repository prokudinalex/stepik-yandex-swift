//
//  ColorPanelView.swift
//  Notes
//
//  Created by Alex Prokudin on 14/07/2019.
//  Copyright © 2019 Alex Prokudin. All rights reserved.
//

import UIKit

@IBDesignable
class ColorPanelView : UIView {
    var shapeColor: UIColor = .red
    var shapePosition: CGPoint = CGPoint(x: 1, y: 1)
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        shapeColor.setFill()
        
        let shapeSize = CGSize(width: self.bounds.height - 2, height: self.bounds.height - 2)
        let path = getSquarePath(in: CGRect(origin: shapePosition, size: shapeSize))
        path.fill()
    }
    
    private func getSquarePath(in rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        path.lineWidth = 1.0
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.close()
        path.stroke()
        return path
    }
}
