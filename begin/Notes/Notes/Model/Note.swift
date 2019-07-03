import Foundation
import UIKit

public struct Note {
    public let uid: String
    public let title: String
    public let content: String
    public let color: UIColor
    public let importance: Importance
    public let selfDestructionDate: Date?
    
    public init(title: String, content: String, importance: Importance,
         uid: String = UUID().uuidString, color: UIColor = UIColor.white, selfDestructionDate: Date? = nil) {
        self.title = title
        self.content = content
        self.importance = importance
        self.uid = uid
        self.color = color
        self.selfDestructionDate = selfDestructionDate
    }
}

public enum Importance : String {
    case normal
    case high
    case low
}
