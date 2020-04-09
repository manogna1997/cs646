import SwiftUI
struct StudentInfoDisplay: View {
    @State var currentStudent: StudentInfo
    @State private var selectedClase : [ClassDetail] = []
    @EnvironmentObject var currentStudentDisplayed : StudentInfo
    var body: some View {
        VStack {
            NavigationLink( destination: DetailView(student: currentStudent,
                                                    editStudent: {
                                                        s in
                                                        print("new name \(s.studentname)")
                                                    }))
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

}
struct DetailView: View {
    @State var student : StudentInfo
    var editStudent : (StudentInfo) -> ()
    @State private var selectedClase : [ClassDetail] = []
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
                        add: { c in self.selectedClase.append(c) },
                        remove:{ c in self.selectedClase.removeAll(where: { $0 == c })}
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
                    Button(action: {
                        let edited = StudentInfo(std: self.student)
                        self.editStudent(edited)
                    }, label: {
                               Spacer()
                               Text("Add")
                               .fontWeight(.bold)
                               .foregroundColor(.blue)
                               .padding(.vertical, 12)
                               Spacer()
                           })
                }
            }
            .navigationBarTitle(student.studentname)
        }
    }
}

