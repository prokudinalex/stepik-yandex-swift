//
//  ColorPanelCell.swift
//  Notes
//
//  Created by Alex Prokudin on 14/07/2019.
//  Copyright © 2019 Alex Prokudin. All rights reserved.
//

import UIKit

class ColorPanelCell: UICollectionViewCell {
    var color: UIColor?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.backgroundColor = UIColor.black
    }
    
    override var isSelected: Bool {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        if let color = self.color {
            color.setFill()
            let path = getRectPath(in: rect.insetBy(dx: 1.0, dy: 1.0))
            path.fill()
        } else {
            drawPalette(rect)
        }
        
        if isSelected {
            let circleRect = CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.width)
            drawCircle(frame: circleRect)
        }
    }
    
    private func drawPalette(_ rect: CGRect) {
        let elementSize: CGFloat = 1.0
        let saturationExponentTop: Float = 2.0
        let saturationExponentBottom: Float = 1.3
        
        let context = UIGraphicsGetCurrentContext()
        for y : CGFloat in stride(from: 0.0 ,to: rect.height, by: elementSize) {
            var saturation = y < rect.height / 2.0 ? CGFloat(2 * y) / rect.height : 2.0 * CGFloat(rect.height - y) / rect.height
            saturation = CGFloat(powf(Float(saturation), y < rect.height / 2.0 ? saturationExponentTop : saturationExponentBottom))
            let brightness = y < rect.height / 2.0 ? CGFloat(1.0) : 2.0 * CGFloat(rect.height - y) / rect.height
            for x : CGFloat in stride(from: 0.0 ,to: rect.width, by: elementSize) {
                let hue = x / rect.width
                let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
                context!.setFillColor(color.cgColor)
                context!.fill(CGRect(x:x, y:y, width:elementSize,height:elementSize))
            }
        }
    }
    
    private func getRectPath(in rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        path.lineWidth = 1
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minY, y: rect.maxY))
        path.close()
        path.stroke()
        path.fill()
        return path
    }
    
    private func drawCircle(frame: CGRect) {
        // setup circle
        let lineWidth = CGFloat(2.0)
        let center = CGPoint(x: 3 * frame.size.width / 4.0, y: frame.size.width / 4.0)
        let radius = CGFloat(frame.size.width / 4) - lineWidth
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0.0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        circlePath.lineWidth = lineWidth
        circlePath.stroke()
        
        let tickPath = UIBezierPath()
        tickPath.move(to: CGPoint(x: center.x - radius / 2, y: center.y))
        tickPath.addLine(to: CGPoint(x: center.x, y: center.y + radius - 1))
        tickPath.addLine(to: CGPoint(x: center.x + radius / 2, y: center.y - radius + 1))
        tickPath.lineWidth = lineWidth
        tickPath.stroke()
    }
}
