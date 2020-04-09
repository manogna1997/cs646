//
//  ContentView.swift
//  enrole
//
//  Created by manogna podishetty on 10/8/19.
//  Copyright © 2019 manogna podishetty. All rights reserved.
//

import SwiftUI



struct ContentView: View {
    
    @State var studentsdata : [StudentInfo] = sampleStudents
    @State var addStudent = false
    var body: some View {
        
            NavigationView {
                List{
                    if studentsdata.count > 1 {
                        ForEach(studentsdata){ stud in
                            StudentInfoDisplay(currentStudent: stud)
                        }
               
                    }else{
                        Spacer()
                        Text("Please Press the Add button to add new students").padding()
                        Spacer()
                    }
                }
                .navigationBarTitle(Text("SDSU Students"))
                .navigationBarItems(
                      trailing:Button(action: {
                        self.addStudent.toggle()
                      }, label: {
                        Image(systemName: "person.crop.circle.badge.plus")
//                        Text("Add")
                        
                      })
                ).sheet(isPresented: $addStudent, content: {
                    BuildStudentForm(isPresented: self.$addStudent,
                                     addStudent: { s in self.studentsdata.append(s)}
                    )
                })
            }
          }
    
}


struct NavigationImageItem: View {
    var body: some View {
        Button(action: {
        }, label: { Text("Add") })
    }
}


struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
//        let sample = sampleStudents
      ContentView()
      
    }
}
