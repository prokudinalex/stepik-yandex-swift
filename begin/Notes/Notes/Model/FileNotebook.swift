import Foundation

public class FileNotebook {
    private(set) var notes: [String: Note] = [:]
    
    public init() {}
    
    public func add(_ note: Note) {
        // dictionary will prevent from duplicates based on uid
        notes[note.uid] = note
    }
    
    public func remove(with uid: String) {
        notes[uid] = nil
    }
    
    public func saveToFile() {
        let jsons = notes.values.compactMap{ $0.json }
        do {
            print("Saving \(notes.count) notes")
            let jsonData = try JSONSerialization.data(withJSONObject: jsons, options: [])
            saveDataToFile(data: jsonData)
        } catch {
            print("cannot convert notes into json")
        }
    }
    
    public func loadFromFile() {
        guard let data = loadDataFromFile() else {
            return
        }
        
        notes.removeAll()
        do {
            let jsons = try JSONSerialization.jsonObject(with: data, options: []) as! Array<Dictionary<String, Any>>
            for jsonItem in jsons {
                if let note = Note.parse(json: jsonItem) {
                    self.add(note)
                } else {
                    print("cannot parse note: \(jsonItem)")
                }
            }
        } catch {
            print("Cannot parse data")
        }
        print("Loaded \(notes.count) notes")
    }
    
    private func loadDataFromFile() -> Data? {
        guard let url = getFilePath() else {
            return nil
        }
        
        print("Trying to load data from file on \(url.path)")
        var data: Data? = nil
        do {
            data = try Data(contentsOf: url)
            print(String(data: data!, encoding: .utf8)!)
        } catch {
            print("Cannot read data")
        }
        return data
    }
    
    private func saveDataToFile(data: Data) {
        guard let url = getFilePath() else {
            return
        }
        
        print("Trying to create file on \(url.path)")
        if FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil) {
            print("File created")
        } else {
            print("Cannot create file")
        }
        print(String(data: data, encoding: .utf8)!)
    }
    
    private func getFilePath() -> URL? {
        guard let cachesPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let notesPath = cachesPath.appendingPathComponent("Notebooks")
        var isDir: ObjCBool = false
        if !FileManager.default.fileExists(atPath: notesPath.path, isDirectory: &isDir) {
            do {
                try FileManager.default.createDirectory(at: notesPath, withIntermediateDirectories: true,
                                                        attributes: nil)
            } catch {}
            print("Notebooks directory created")
        }
        return notesPath.appendingPathComponent("notes.sav")
    }
}
