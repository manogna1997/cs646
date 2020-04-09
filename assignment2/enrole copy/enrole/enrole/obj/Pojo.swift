//
//  Pojo.swift
//  enrole
//
//  Created by Abhilash Keerthi on 10/12/19.
//  Copyright © 2019 manogna podishetty. All rights reserved.
//

import Foundation

class StudentInfo : Codable,Identifiable,Equatable,ObservableObject{
    var id = UUID()
     var studentname : String
    var email :String
   var redid : String
    var classSelected : [ClassDetail]?
    init?() {
        self.studentname = ""
        self.email = ""
        self.redid = ""
        self.classSelected = []
    }
    init(studentname:String ,email: String ,redid: String ,classSelected: [ClassDetail]) {
        self.studentname = studentname
        self.email = email
        self.redid = redid
        self.classSelected = classSelected
    }
}

extension StudentInfo {
    static func ==(lhs: StudentInfo, rhs: StudentInfo) -> Bool {
        return lhs.id == rhs.id
    }
}

class ClassInfo : Codable,Identifiable,Equatable,ObservableObject{
    var id = UUID()
    var number : String
    var title :String
    var room : String
    var time : String
    init?() {
        self.number = ""
        self.title = ""
        self.room = ""
        self.time = ""
    }
}

extension ClassInfo {
    static func ==(lhs: ClassInfo, rhs: ClassInfo) -> Bool {
        return lhs.id == rhs.id
    }
}
