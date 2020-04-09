//
//  ContentView.swift
//  enrole
//
//  Created by manogna podishetty on 10/8/19.
//  Copyright © 2019 manogna podishetty. All rights reserved.
//
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var objectContext
    @FetchRequest(entity: StudentPersitance.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \StudentPersitance.studentname, ascending: true)]) var students: FetchedResults<StudentPersitance>
    @EnvironmentObject var allStudent : StudentsInv
    @State var addStudent = false
    var i : Int = 0
    var body: some View {
        NavigationView {
            List{
                if allStudent.students.count > 0 {
                    ForEach(allStudent.students){
                        stud in
                        StudentInfoDisplay(currentStudent: stud)
                    }.onDelete(perform: delete)
                }
                else{
                    VStack{
                        HStack{
                            Text("Welcome to enrole").padding().font(.headline)
                            Spacer()
                        }
                        HStack{
                             Spacer()
                            Text(" - podishetty manogna").padding(.trailing).font(.subheadline).foregroundColor(.pink)
                        }
                    }
                    VStack{
                        HStack{
                            Spacer()
                            Text("Please Press the Add new student icon to add new SDSU students").padding()
                            Spacer()
                        }
                    }
                }
            }
            .navigationBarTitle(Text("SDSU Students"))
            .navigationBarItems(
                trailing:Button(action: {
                    self.addStudent.toggle()
                }
                                , label: {
                                    Image(systemName: "person.crop.circle.badge.plus")
                                    //                        Text("Add")
                                }))
            .sheet(isPresented: $addStudent, content: {
                BuildStudentForm(isPresented: self.$addStudent,
                                 addStudent: {
                                     s in
                                     print("git it in add \(s.email)")
                                    if !s.studentname.isEmpty{
                                        self.allStudent.students.append(s)
                                    }
                                 })
            })
        }
    }
    
    func delete(at offsets: IndexSet) {
        allStudent.students.remove(atOffsets: offsets)
    }

}
struct NavigationImageItem: View {
    var body: some View {
        Button(action: {
        }
               , label: {
                   Text("Add")
               })
    }

}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //        let sample = sampleStudents
        ContentView()
    }

}

