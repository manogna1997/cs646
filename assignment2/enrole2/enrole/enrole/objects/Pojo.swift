//
//  Pojo.swift
//  enrole
//
//  Created by Manogna Podishetty on 10/15/19.
//  Copyright © 2019 manogna podishetty. All rights reserved.
//

import Foundation
import CoreData


class StudentInfo : Identifiable,Equatable,ObservableObject{

    @Published  var id = UUID()
    @Published  var studentname : String
    @Published  var refid : Int64 = getRef()
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
        self.refid = std.refid
    }
    static func getRef() -> Int64{
        guard let id = ClassDetail.idSequence.next() else { return 125}
        let someDate = Date()
        let timeInterval = someDate.timeIntervalSince1970
        return (Int64(timeInterval) + Int64(id))
    }

}
extension StudentInfo {
    static func ==(lhs: StudentInfo, rhs: StudentInfo) -> Bool {
        return lhs.id == rhs.id
    }
}


class StudentsInv:  ObservableObject{
    @Published  var id = UUID()
    @Published  var students : [StudentInfo]
    
    init(inv:[StudentInfo]) {
        self.students = inv
    }

    init() {
        self.students = []
    }
}
struct ClassDetail : Hashable, Codable,Identifiable,Equatable{
    static var idSequence = sequence(first: 1, next: {$0 + 1})
    var id : Int64
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
        self.id = Int64(id)
    }
}

extension ClassDetail {
    static func ==(lhs: ClassDetail, rhs: ClassDetail) -> Bool {
        return lhs.id == rhs.id
    }
}
