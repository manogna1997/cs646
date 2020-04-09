//
//  ContentView.swift
//  enrole
//
//  Created by Manogna Podishetty on 10/15/19.
//  Copyright © 2019 manogna podishetty. All rights reserved.
//

import SwiftUI



struct ContentView: View {
    @Environment(\.managedObjectContext) var objectContext
    @FetchRequest(entity: StudentPersitance.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \StudentPersitance.studentname, ascending: true)]) var persistedStudents : FetchedResults<StudentPersitance>
    @EnvironmentObject var allStudent : StudentsInv
    @State var addStudent = false
    @State var showAlert = false
    @State var showAlertMsg = ""
    var body: some View {
        NavigationView {
            List{
                if allStudent.students.count > 0 {
                    ForEach(allStudent.students){
                        stud in
                        StudentInfoDisplay(currentStudent: stud,editNewData : { newEdited in self.editExistingStudent(oldStd: newEdited) })
                    }.onDelete(perform: delete)
                }
                else{
                    VStack{
                        HStack{
                            Text("Welcome to enrole v.2").padding().font(.headline)
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
                },label: {Image(systemName: "person.crop.circle.badge.plus")}))
            .sheet(isPresented: $addStudent, content: {
                BuildStudentForm(isPresented: self.$addStudent,
                                 addStudent: {
                                     s in
                                     print("git it in add \(s.email)")
                                     if !s.studentname.isEmpty{

                                         self.allStudent.students.append(s)
                                         self.saveNew(newdtd: s)
                                     }else{
                                         self.showAlert.toggle()
                                     }
                                 })
            })
        }.onAppear {
            print("ContentView appeared!")
            self.pullAllStudents()
            print("ContentView appeared! data size : \(self.persistedStudents.count)")
        }

    }


    //    func deletePersistance() -> String {
    //        for item in self.persistedStudents {
    //            self.deletePersistanStudent(r: item)
    //        }
    //
    //        return "true"
    //    }

    //    func printAllData() -> String {
    //        for item in self.persistedStudents {
    //            print(item.)
    //        }
    //        return "true"
    //    }
    //
    func delete(at offsets: IndexSet) {
        for i in offsets {
            let i : StudentInfo = allStudent.students.enumerated().first(where: {$0.offset == i})!.element
            self.deleteFromPersistance(r: i)
        }
        allStudent.students.remove(atOffsets: offsets)
    }

    func save(std : StudentPersitance)  {
        objectContext.insert(std)
        do {
            try objectContext.save()
        } catch {
            print(error)
        }
    }

    func deleteFromPersistance(r: StudentInfo) {
        for item in self.persistedStudents {
            if item.refid == r.refid{
                self.deletePersistanStudent(r: item)
            }
        }
    }

    func editExistingStudent(oldStd : StudentInfo){
        for std in self.persistedStudents {
            if std.refid == oldStd.refid {
                self.deletePersistanStudent(r: std)
            }
        }
        self.allStudent.students.removeAll(where: { $0 == oldStd })
        self.allStudent.students.append(oldStd)
        self.saveNew(newdtd: oldStd)

    }

    func deletePersistanStudent(r: StudentPersitance){
        do {
            try self.objectContext.delete(r)
            try self.objectContext.save()
        } catch {
            print(error)
        }

    }

    func savedefault() {
        do {
            try self.objectContext.save()
        } catch {
            print(error)
        }
    }

    func saveNew(newdtd:StudentInfo) {
        let  std = StudentPersitance(context: self.objectContext)
        std.email = newdtd.email
        std.redid = newdtd.redid
        std.studentname =  newdtd.studentname
        std.refid = newdtd.refid
        var classInfo : [ClassInfo] = []

        if newdtd.classSelected! == nil {
            let set = NSSet(array: [])
            std.classSelected = set
            return
        }
        for item in newdtd.classSelected! {
            var cls =  ClassInfo(context: self.objectContext)
            cls.id = Int64(item.id)
            cls.number = item.number
            cls.room = item.room
            cls.title = item.title
            classInfo.append(cls)


        }
        let set = NSSet(array: classInfo)
        std.classSelected = set
        self.savedefault()
    }

    func pullAllStudents() {
        if self.persistedStudents.count < 1 {
            print("empty persistance ")
        }
        for newdtd in self.persistedStudents {
            var  std = StudentInfo()
            std.email = newdtd.email!
            std.redid = newdtd.redid!
            std.studentname =  newdtd.studentname!
            std.refid = newdtd.refid
            std.classSelected = []
            for item in newdtd.classSelected!.allObjects {
                var cls =  ClassDetail()!
                cls.id = Int64((item as AnyObject).id!)
                cls.number = (item as AnyObject).number!
                cls.room = (item as AnyObject).room!
                cls.title = (item as AnyObject).title!
                std.classSelected!.append(cls)

            }
            self.allStudent.students.append(std)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


