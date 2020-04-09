import SwiftUI
struct StudentInfoDisplay: View {
    
    @EnvironmentObject var allStudent : StudentsInv
    @State var currentStudent: StudentInfo

    var body: some View {
        VStack {
            NavigationLink(destination: DetailView(student: currentStudent, editStudent: {
                s in
                print("new name \(s.studentname) class \(s.classSelected!.count)")
                self.replaceOldStudent(newstd:s)
            }, selectedClase: currentStudent.classSelected!))
            {
                VStack{
                    HStack{
                        Image(systemName: "person.crop.circle")
                        Text(currentStudent.studentname).font(.headline)
                        Spacer()
                        Text("\(currentStudent.redid)")
                    }
                    HStack{
                        if currentStudent.classSelected != nil && !currentStudent.classSelected!.isEmpty {
                            Text("Classes enrolled").font(.subheadline)
                            Spacer()
                            ForEach(currentStudent.classSelected!){
                                cls in
                                Text(" \(cls.number) ").font(.subheadline)
                            }
                        }
                        else{
                            Text("no classes enrolled").font(.subheadline)
                            Spacer()
                        }
                    }
                }
            }
        }
    }
    
    func replaceOldStudent(newstd: StudentInfo) -> Void {
        self.allStudent.students.removeAll(where: { $0 == newstd })
        self.allStudent.students.append(newstd)
    }

}
struct DetailView: View {
    @State var student : StudentInfo
    @Environment(\.presentationMode) var presentation
    var editStudent : (StudentInfo) -> ()
    @State var selectedClase : [ClassDetail] = []
    var body: some View {
        Group {
            List{
                HStack{
                    Text("Student name")
                    
                    TextField("Enter Students RedId", text: $student.studentname).textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack{
                    Text("Student email")
                
                    TextField("Student RedId", text: $student.email).textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack{
                    Text("Student redid")
                    
                    TextField("Enter Students RedId", text: $student.redid).textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    NavigationLink(destination: SelectClasses(
                        selections: self.student.classSelected!,
                        add: { c in self.student.classSelected!.append(c) },
                        remove:{ c in self.student.classSelected!.removeAll(where: { $0 == c })}
                    )) {
                        HStack {
                            Image(systemName: "plus.rectangle.on.rectangle")
                                 .font(.body)
                             Text("Added Classes")
                             Spacer()
                             Text("\(student.classSelected!.count)")
                        }
                    }

                 }
                HStack{
                    Spacer()
                    Button(action: {
                        print(self.student.refid)
                        let edited = StudentInfo(std: self.student)
                        print(edited.refid)
                        self.editStudent(self.student)
                        self.presentation.wrappedValue.dismiss()
                    }, label: {
                         
                               Text("Save Changes")
                               .fontWeight(.bold)
                               .foregroundColor(.blue)
                               .padding(.vertical, 12)
                             
                    })
                    Spacer()
                }
            }
            .navigationBarTitle(student.studentname)
        }
    }
}

