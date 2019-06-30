import Foundation

extension String {
    static func random(_ length: Int) -> String {
        guard length >= 0 else {
            return ""
        }
        
        let letters = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890"
        return String((0..<length).map{
            _ in letters.randomElement()!
        })
    }
}

String.random(1)
String.random(10)
String.random(10)
String.random(10)
String.random(10)
String.random(10)


