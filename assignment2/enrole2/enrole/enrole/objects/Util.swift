//
//  Util.swift
//  enrole
//
//  Created by Manogna Podishetty on 10/15/19.
//  Copyright © 2019 manogna podishetty. All rights reserved.
//

import Foundation
import SwiftUI

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
let sampleclasses : [ClassDetail] = loadClassJson(_filename: "classinfo") as! [ClassDetail]




//func loadClassJson(_filename:String) -> Any {
////        @Environment(\.managedObjectContext) var objectContext
//        guard let fileUrl = Bundle.main.url(forResource: _filename, withExtension: "json") else {
//            print("File could not be located at the given url")
//            return ""
//        }
//    print("hello")
//        do {
//            // Get data from file
//            let data = try Data(contentsOf: fileUrl)
//            let dictionary = try JSONDecoder().decode([ClassDetail].self, from: data)
//            let sampleclasses : [ClassInfo] = dictionary as! [ClassInfo]
//
//            var classInfo : [ClassInfo] = []
//
//            for item in sampleclasses {
//
//                var cls =  ClassInfo(context: objectContext)
//                cls.id = item.id
//                cls.number = item.number
//                cls.room = item.room
//                cls.title = item.title
//                classInfo.append(cls)
//            }
//
//            return classInfo
//
//        } catch {
//            // Print error if something went wrong
//            print("Error: \(error)")
//        }
//       return ""
//}


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

