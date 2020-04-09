import SwiftUI
struct StudentInfoDisplay: View {
    
    @EnvironmentObject var allStudent : StudentsInv
    @State var currentStudent: StudentInfo
    var updateEditedStudent : (StudentInfo) -> ()
//    @EnvironmentObject var currentStudentDisplayed : StudentInfo
    var body: some View {
        VStack {
            NavigationLink( destination: DetailView(student: currentStudent, editStudent: {
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
                        Text(currentStudent.redid)
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
        var i : Int = 0
        for item in allStudent.students{
            if(item.refid == newstd.refid){
                self.allStudent.students[i] = newstd

                return
            }else{
                i += i
            }
        }
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
                    Spacer()
                    TextField("Enter Students RedId", text: $student.studentname)
                }
                HStack{
                    Text("Student email")
                    Spacer()
                    TextField("Student RedId", text: $student.email)
                }
                HStack{
                    Text("Student redid")
                    Spacer()
                    TextField("Enter Students RedId", text: $student.redid)
                }
                
                HStack {
                    NavigationLink(destination: SelectClasses(
                        selections: self.student.classSelected!,
                        add: { c in self.student.classSelected!.append(c) },
                        remove:{ c in self.student.classSelected!.removeAll(where: { $0 == c })}
                    )) {
                        HStack {
                             Image(systemName: "person")
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

