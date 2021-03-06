//
//  StudentAddV.swift
//  enrole
//
//  Created by Abhilash Keerthi on 10/9/19.
//  Copyright © 2019 manogna podishetty. All rights reserved.
//

import SwiftUI


struct BuildStudentForm : View {
    
    @State private var name:String = ""
    @State private var email:String = ""
    @State private var redid:String = ""
    @State private var selectedClase : [ClassDetail] = []
    @Binding var isPresented: Bool
    var addStudent : (StudentInfo) -> ()
    
   var body: some View {
    
    NavigationView {
        Form {
            List{
            Section(header: Text("Student Info")) {
                TextField("Enter Students Name", text: $name)
                TextField("Enter Students email ", text: $email)
                TextField("Enter Students RedId", text: $redid)
            }
            Section(header: Text("Select Classes")){
                NavigationLink(destination: SelectClasses(
                    add: { c in self.selectedClase.append(c) },
                    remove:{ c in self.selectedClase.removeAll(where: { $0 == c })}
                )) {
                    HStack {
                        Image(systemName: "person")
                            .font(.body)
                        Text("Added Classes")
                        Spacer()
                        Text("\(selectedClase.count)")
                    }
                }
            }
            Section (){
                HStack{
                Button(action: {
                        print(self.name)
                        let student = StudentInfo(studentname: self.name, email: self.email, redid: self.redid, classSelected:self.selectedClase)
                        self.addStudent(student)
                        print(student)
                        self.name = ""
                        self.email = ""
                        self.redid = ""
                        self.selectedClase  = []
                    }, label: {
                           HStack {
                               Spacer()
                               Text("Add")
                                   .fontWeight(.bold)
                                   .foregroundColor(.white)
                                   .padding(.vertical, 12)
                               
                               Spacer()
                           }
                       })
                        .background(Color.green)
                       .cornerRadius(4)
                    Spacer()
                       Button(action: {
                        self.isPresented = false
                       }, label: {
                           HStack {
                               Spacer()
                               Text("Cancel")
                                   .fontWeight(.bold)
                                   .foregroundColor(.white)
                                   .padding(.vertical, 12)
                               
                               Spacer()
                           }
                       })
                       .background(Color.red)
                       .cornerRadius(4)
                
                }}
            }.padding(.all)
        }
        .navigationBarTitle(Text("Add Student"))
        
    
    }
    }
}

struct SelectClasses: View {
    @State var items: [ClassDetail] = sampleclasses
    @State var selections: [ClassDetail] = []
    var add: (ClassDetail) -> ()
    var remove: (ClassDetail) -> ()
    var body: some View {
        List {
            ForEach(items) { item in
                MultipleSelectionRow(title: item, isSelected: self.selections.contains(item)) {
                    if self.selections.contains(item) {
                        self.selections.removeAll(where: { $0 == item })
                        self.remove(item)
                    }
                    else {
                        print(item)
                        self.selections.append(item)
                        self.add(item)
                    }
                }
            }
        }
        .navigationBarTitle("Select Classes", displayMode: .inline)
    }
}
struct MultipleSelectionRow: View {
    var title: ClassDetail
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                Text("\(self.title.number)")
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}
struct BuildStudentForm_Previews: PreviewProvider {

    static var previews: some View {
//        DetailView(student: sampleStudents[3], addStudent: { p in print(p) })
        BuildStudentForm(isPresented: .constant(false) , addStudent:  { p in print(p)})
    }
}
