//
//  Util.swift
//  enrole
//
//  Created by manogna podishetty on 10/12/19.
//  Copyright © 2019 manogna podishetty. All rights reserved.
//

import Foundation

func loadSampleStudents() -> [StudentInfo] {

    let sampledata : [StudentInfo] =  [
        StudentInfo(studentname: "student1", email: "student1@sdsu.com", redid: "1234", classSelected: [sampleclasses[0],sampleclasses[1],sampleclasses[2]]),
        StudentInfo(studentname: "student2", email: "student2@sdsu.com", redid: "12342", classSelected: [sampleclasses[0],sampleclasses[2]]),
        StudentInfo(studentname: "student3", email: "student3@sdsu.com", redid: "12343", classSelected: [sampleclasses[0],sampleclasses[1]]),
        StudentInfo(studentname: "student4", email: "student4@sdsu.com", redid: "12344", classSelected: []),
    ]
    return sampledata
    
}



let sampleStudents : [StudentInfo] = loadSampleStudents()
let sampleclasses : [ClassDetail] = loadClassJson(_filename: "clasess") as! [ClassDetail]

//struct StudentDetail : Decodable,Identifiable,Equatable{
//    private static var idSequence = sequence(first: 205, next: {$0 + 1})
//    var id : Int
//    var studentname : String
//    var email :String
//    var redid : String
//    var classSelected : [ClassDetail]?
//    init?() {
//        guard let id = StudentDetail.idSequence.next() else { return nil}
//        self.id = id
//        self.studentname = ""
//        self.email = ""
//        self.redid = ""
//        self.classSelected = []
//    }
//    init?(studentname:String ,email: String ,redid: String ,classSelected: [ClassDetail]) {
//        guard let id = StudentDetail.idSequence.next() else { return nil}
//        self.id = id
//        self.studentname = studentname
//        self.email = email
//        self.redid = redid
//        self.classSelected = classSelected
//    }
//}
//
//extension StudentDetail {
//    static func ==(lhs: StudentDetail, rhs: StudentDetail) -> Bool {
//        return lhs.id == rhs.id
//    }
//}
//A course has number (CS 646), a title (iPad/iPhone Application Development), a room number (GC 1504) and a start time (7:00 pm).


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

