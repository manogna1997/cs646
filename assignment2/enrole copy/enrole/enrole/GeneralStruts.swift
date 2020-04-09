//
//  File.swift
//  enrole
//
//  Created by manogna podishettyon 10/9/19.
//  Copyright © 2019 manogna podishetty. All rights reserved.
//

import Foundation


let sampleStudents : [StudentDetail] = loadStudentsJson(_filename: "studentsSample") as! [StudentDetail]
let sampleclasses : [ClassDetail] = loadClassJson(_filename: "clasess") as! [ClassDetail]

struct StudentDetail : Decodable,Identifiable,Equatable{
    private static var idSequence = sequence(first: 205, next: {$0 + 1})
    var id : Int
    var studentname : String
    var email :String
    var redid : String
    var classSelected : [ClassDetail]?
    init?() {
        guard let id = StudentDetail.idSequence.next() else { return nil}
        self.id = id
        self.studentname = ""
        self.email = ""
        self.redid = ""
        self.classSelected = []
    }
    init?(studentname:String ,email: String ,redid: String ,classSelected: [ClassDetail]) {
        guard let id = StudentDetail.idSequence.next() else { return nil}
        self.id = id
        self.studentname = studentname
        self.email = email
        self.redid = redid
        self.classSelected = classSelected
    }
}

extension StudentDetail {
    static func ==(lhs: StudentDetail, rhs: StudentDetail) -> Bool {
        return lhs.id == rhs.id
    }
}
//A course has number (CS 646), a title (iPad/iPhone Application Development), a room number (GC 1504) and a start time (7:00 pm).

struct ClassDetail : Hashable, Codable,Identifiable,Equatable{
    private static var idSequence = sequence(first: 1, next: {$0 + 1})
    var id : Int
    var number : String
    var title :String
    var room : String
    var time : String
    init?() {
        guard let id = ClassDetail.idSequence.next() else { return nil}
        self.number = ""
        self.title = ""
        self.room = ""
        self.time = ""
        self.id = id
    }
}

extension ClassDetail {
    static func ==(lhs: ClassDetail, rhs: ClassDetail) -> Bool {
        return lhs.id == rhs.id
    }
}
func loadClassJson(_filename:String) -> Any {
        guard let fileUrl = Bundle.main.url(forResource: _filename, withExtension: "json") else {
            print("File could not be located at the given url")
            return ""
        }
        do {
            // Get data from file
            let data = try Data(contentsOf: fileUrl)
            let dictionary = try JSONDecoder().decode([ClassDetail].self, from: data)
            return dictionary
        } catch {
            // Print error if something went wrong
            print("Error: \(error)")
        }
       return ""
}

func loadStudentsJson(_filename:String) -> Any {
        guard let fileUrl = Bundle.main.url(forResource: _filename, withExtension: "json") else {
            print("File could not be located at the given url")
            return ""
        }
        do {
            // Get data from file
            let data = try Data(contentsOf: fileUrl)
            let dictionary = try JSONDecoder().decode([StudentDetail].self, from: data)
            return dictionary
        } catch {
            // Print error if something went wrong
            print("Error: \(error)")
        }
       return ""
}
