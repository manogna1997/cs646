//
//  Pojo.swift
//  enrole
//
//  Created by Abhilash Keerthi on 10/12/19.
//  Copyright © 2019 manogna podishetty. All rights reserved.
//
import Foundation
class StudentInfo : Identifiable,Equatable,ObservableObject{
    @Published  var id = UUID()
    @Published  var studentname : String
    @Published  var email :String
    @Published  var redid : String
    @Published  var classSelected : [ClassDetail]?
    init() {
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
    init(std:StudentInfo) {
        self.studentname = std.studentname
        self.email = std.email
        self.redid = std.redid
        self.classSelected = std.classSelected
        self.id = std.id
    }

}
extension StudentInfo {
    static func ==(lhs: StudentInfo, rhs: StudentInfo) -> Bool {
        return lhs.id == rhs.id
    }

}

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

