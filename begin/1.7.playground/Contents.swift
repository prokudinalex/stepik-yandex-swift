import Foundation
import UIKit

let n1 = Note(title: "1", content: "1", importance: .high, color: UIColor.green, selfDestructionDate: Date())
let json1 = n1.json
let n1_1 = Note.parse(json: json1)!
let json1_1 = n1_1.json
assert(NSDictionary(dictionary: json1).isEqual(to: json1_1))

let n2 = Note(title: "2", content: "2", importance: .normal, color: UIColor.green)
let json2 = n2.json
assert(json2["importance"] == nil && json2["color"] != nil)

let n3 = Note(title: "3", content: "3", importance: .high)
let json3 = n3.json
assert(json3["importance"] as! String == "high")

let n4 = Note(title: "4", content: "4", importance: .high, color: UIColor.green)
let json4 = n4.json
assert(json4["selfDestructionDate"] == nil)

let notebook = FileNotebook()
notebook.add(n1)
notebook.add(n2)
notebook.add(n3)
notebook.add(n4)
notebook.saveToFile()
print()
notebook.loadFromFile()
