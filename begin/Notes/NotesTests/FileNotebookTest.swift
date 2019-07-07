//
//  FileNotebookTest.swift
//  NotesTests
//
//  Created by Alex Prokudin on 07/07/2019.
//  Copyright © 2019 Alex Prokudin. All rights reserved.
//

import XCTest
@testable import Notes

class FileNotebookTest: XCTestCase {
    var book = FileNotebook()
    
    override func setUp() {
        book.removeAll()
    }

    func testBookSize() {
        XCTAssertNotNil(book)
        book.add(Note(title: "title", content: "content", importance: .normal))
        XCTAssertEqual(1, book.size())
        
        book.removeAll()
        XCTAssertEqual(0, book.size())
    }
    
    func testBookPersistence() {
        XCTAssertNotNil(book)
        book.add(Note(title: "title", content: "content", importance: .normal))
        XCTAssertEqual(1, book.size())
        
        // only one note will be saved
        book.saveToFile()
        
        book.add(Note(title: "title", content: "content", importance: .normal))
        book.add(Note(title: "title", content: "content", importance: .normal))
        book.add(Note(title: "title", content: "content", importance: .normal))

        XCTAssertEqual(4, book.size())
        
        // notes will be overwritten
        book.loadFromFile()
        XCTAssertEqual(1, book.size())
    }
    
    func testRemovalOfNote() {
        let n1 = Note(title: "title 1", content: "content 2", importance: .normal)
        let n2 = Note(title: "title 2", content: "content 2", importance: .normal)

        book.add(n1)
        book.add(n2)
    
        book.remove(with: n1.uid)
        XCTAssertEqual(1, book.size())
        let n2_2 = book.get(with: n2.uid)
        XCTAssertEqual(n2.uid, n2_2?.uid)
    }
    
    func testSameNotes() {
        let n1 = Note(title: "t1", content: "c1", importance: .high, uid: "UUID")
        let n2 = Note(title: "t2", content: "c2", importance: .high, uid: "UUID")
        book.add(n1)
        book.add(n2)
        
        XCTAssertEqual(1, book.size())
        let n2_2 = book.get(with: n2.uid)
        XCTAssertEqual(n2.uid, n2_2?.uid)
    }
}
