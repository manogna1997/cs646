//
//  StudentAddV.swift
//  enrole
//
//  Created by manogna podishetty on 10/9/19.
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
                Section(header: Text("Student Info").font(.headline)) {
                TextField("Enter Students Name", text: $name) .keyboardType(.default)
                TextField("Enter Students email", text: $email).keyboardType(.emailAddress)
                TextField("Enter Students RedId", text: $redid).keyboardType(.numberPad)
//                                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0), cornerRadius: 5.0)
                    
            }
                Section(header: Text("Select Classes").font(.headline)){
                NavigationLink(destination: SelectClasses(
                    add: { c in self.selectedClase.append(c) },
                    remove:{ c in self.selectedClase.removeAll(where: { $0 == c })}
                )) {
                    HStack {
                        Image(systemName: "plus.rectangle.on.rectangle")
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
                VStack{
                    HStack{
                        Text("\(self.title.title)").font(.headline)
                        Spacer()
                        Text("\(self.title.number)").font(.subheadline)
                    }
                    HStack{

                        Text("room: \(self.title.room)").font(.subheadline)
                        Spacer()
                        Text("at : \(self.title.time)").font(.subheadline)
                        if self.isSelected {
                        
                            Image(systemName: "checkmark")
                        }
                    }
                }

            }
        }
    }
}
struct BuildStudentForm_Previews: PreviewProvider {

    static var previews: some View {
        BuildStudentForm(isPresented: .constant(false) , addStudent:  { p in print(p)})
    }
}
