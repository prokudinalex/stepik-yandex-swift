//
//  ColorPanelControllerExtension.swift
//  Notes
//
//  Created by Alex Prokudin on 14/07/2019.
//  Copyright © 2019 Alex Prokudin. All rights reserved.
//

import UIKit

// create cells
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.colorPanelCollectionView.colorsCout
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorPanelCell", for: indexPath)
        if let colorPanelCell = cell as? ColorPanelCell {
            // setup cell
            colorPanelCell.color = self.colorPanelCollectionView.defaultColors[indexPath.row]
            //colorPanelCell.setNeedsDisplay()
        }
        return cell
    }
}

// setup cell sizes
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = self.colorPanelCollectionView.colorSquareSize
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let size = self.colorPanelCollectionView.colorSquareSize
        let cellCount = self.colorPanelCollectionView.colorsCout
        
        let totalCellWidth = size * cellCount
        let totalSpacingWidth = Int(self.colorPanelCollectionView.colorSpacing) * (cellCount + 1)
        
        let leftInset = (self.view.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset

        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.colorPanelCollectionView.colorSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.colorPanelCollectionView.colorSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        if let colorPanelCell = cell as? ColorPanelCell {
            // setup cell
            colorPanelCell.color = self.colorPanelCollectionView.defaultColors[indexPath.row]
            //colorPanelCell.setNeedsDisplay()
        }
    }
}
