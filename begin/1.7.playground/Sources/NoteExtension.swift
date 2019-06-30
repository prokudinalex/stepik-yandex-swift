import Foundation
import UIKit

extension Note {
    public static func parse(json: [String: Any]) -> Note? {
        guard let title = json["title"] as? String,
            let content = json["content"] as? String,
            let uid = json["uid"] as? String else {
                return nil
        }
        
        var selfDestructionDate : Date?
        if let timeSince1970 = json["selfDestructionDate"] as? TimeInterval {
            selfDestructionDate = Date(timeIntervalSince1970: timeSince1970)
        }
        
        var importance : Importance = .normal
        if let importanceRaw = json["importance"] as? String {
            importance = Importance(rawValue: importanceRaw) ?? .normal
        }
        
        var color = UIColor.white
        if let hex = json["color"] as? String, let parsed = UIColor(hex: hex) {
            color = parsed
        }
        
        return Note(title: title, content: content, importance: importance,
                    uid: uid, color: color,
                    selfDestructionDate: selfDestructionDate)
    }
    
    public var json: [String: Any] {
        get {
            var result: [String: Any] = [:]
            result["uid"] = self.uid
            result["title"] = self.title
            result["content"] = self.content
            if self.importance != .normal {
                result["importance"] = self.importance.rawValue
            }
            if self.color != UIColor.white {
                result["color"] = self.color.toHex
            }
            result["selfDestructionDate"] = self.selfDestructionDate?.timeIntervalSince1970
            return result
        }
    }
}

extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt32 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt32(&rgb) else { return nil }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    var toHex: String? {
        return toHex()
    }
    
    func toHex(alpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if alpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
}
