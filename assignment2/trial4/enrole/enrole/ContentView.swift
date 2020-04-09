//
//  ContentView.swift
//  enrole
//
//  Created by manogna podishetty on 10/8/19.
//  Copyright © 2019 manogna podishetty. All rights reserved.
//

import SwiftUI



struct ContentView: View {
    
    @EnvironmentObject var allStudent : StudentsInv
    @State var addStudent = false
    var i : Int = 0
    var body: some View {
        
            NavigationView {
                List{
                    if allStudent.students.count > 1 {
                        ForEach(allStudent.students){ stud in
                            StudentInfoDisplay(currentStudent: stud,
                                               updateEditedStudent: {
                                                editedstd in
                                                print(editedstd)
                            }
                            )
                        
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
                                     addStudent: { s in
                                        print("git it in add \(s.email)")
                                        self.allStudent.students.append(s)
//                                        if self.allStudent.students.count < 1 {
//                                            let new = [s]
//                                            self.allStudent = StudentsInv(inv: new)
//                                        }
                                        }
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
