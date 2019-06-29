//
//  Note.swift
//
//
//  Created by Alex Prokudin on 29/06/2019.
//

import Foundation
import UIKit

public struct Note {
    let uid: String
    let title: String
    let content: String
    let color: UIColor
    let importance: Importance
    let selfDestructionDate: Date?
    
    public init(title: String, content: String, importance: Importance,
         uid: String = UUID().uuidString, color: UIColor = UIColor.white, destructionDate: Date? = nil) {
        self.title = title
        self.content = content
        self.importance = importance
        self.uid = uid
        self.color = color
        self.selfDestructionDate = destructionDate
    }
}

public enum Importance {
    case normal
    case high
    case low
}
