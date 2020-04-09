//
//  Util.swift
//  enrole
//
//  Created by Abhilash Keerthi on 10/12/19.
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
