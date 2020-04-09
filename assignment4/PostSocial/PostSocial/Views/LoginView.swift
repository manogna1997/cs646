//
//  LoginView.swift
//  PostSocial
//
//  Created by Manogna Podishetty on 11/11/19.
//  Copyright © 2019 Manogna podishetty. All rights reserved.
//
import SwiftUI
struct LoginView: View {
    var userCashe : NewUser
    @State var loginUser: NewUser = NewUser()
    @State var loginRes: GenearlRes?;
    @State var isNewUser: Bool = false
    @State var alertError: Bool = false
 
    let col = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0),
    cornerRadius = CGFloat(5.0)
    var logInComplete : (NewUser) -> ()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack{
                HStack{
                    Text("Post Social").font(.largeTitle).bold().italic()
                    
                }.padding(.vertical,30)
                
                HStack{
                    Text("Email").font(.headline)
                    Spacer()
                }
                TextField("Enter email", text: self.$loginUser.email)
                .keyboardType(.default)
                .padding(.all)
                .background(col)
                HStack{
                    Text("Password").font(.headline)
                    Spacer()
                }
                SecureField("Password", text: self.$loginUser.password)
                .keyboardType(.default)
                .padding(.all)
                .background(col)
            }
            if self.isNewUser == true {
                VStack{
                    HStack{
                        Text("First Name").font(.headline)
                        Spacer()
                    }
                    TextField("Enter first name", text: self.$loginUser.firstname)
                    .keyboardType(.default)
                    .padding(.all)
                    .background(col)
                    HStack{
                        Text("Last Name").font(.headline)
                        Spacer()
                    }
                    TextField("Enter last name", text: self.$loginUser.lastname)
                    .keyboardType(.default)
                    .padding(.all)
                    .background(col)
                    HStack{
                        Text("Nick Name").font(.headline)
                        Spacer()
                    }
                    HStack{
                        TextField("Enter nickname", text: self.$loginUser.nickname)
                        .keyboardType(.default)
                        .padding(.all)
                        .background(col)
                    }
                }
                .animation(.easeInOut)
            }
            HStack{
                Button( action: {
                    self.isNewUser.toggle()
                },label: {
                           Toggle(isOn: $isNewUser) {
                               Spacer()
                               Text("New User ?")
                               .fontWeight(.bold)
                               .foregroundColor(.blue)
                               .padding(.vertical, 12)
                           }
                           .padding()
                       })
            }
            HStack{
                Spacer()
                Button( action: {
                    self.logIn()
                }
                       , label: {
                           Image(systemName: "person.crop.circle").foregroundColor(.white)
                           Text(self.newUserButton()).fontWeight(.bold)
                           .foregroundColor(.white)
                           .padding(.vertical, 12)
                       })
                Spacer()
            }
            .background(Color.green)
            .padding(.horizontal,25)
        }.onAppear(perform: {
            print("working on login")
            if self.userCashe == nil {
                return
            }
            if !self.userCashe.email.isEmpty {
                self.loginUser = NewUser()
                self.loginUser.email = self.userCashe.email
            }
            
        })
        .padding(24)
        .alert(isPresented: $alertError ) {
            Alert(title: Text("Sorry!"), message: Text(self.loginRes!.errors), dismissButton: .default(Text("Ok")))
        }
    }

    func newUserButton() -> String{
        let logInText : String;
        if self.isNewUser == false{
            logInText = "Login"
        }
        else{
            logInText = "New User"
        }
        return logInText
    }

    func logIn() {
        self.loginRes = validateUserDate(user: self.loginUser, newUser: self.isNewUser)
        if self.loginRes?.result == "fail"{
            self.alertError = true
        }
        else{
            if self.isNewUser == true {
                self.addNewUser(user: self.loginUser)
            }else{
                self.logIntoServer()
            }
 
        }
    }

    func addNewUser( user: NewUser){
        var res : GenearlRes?;
        let jsonD = user.getJson();
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonD)
        // create post request
        let url = URL(string: newUserUrl())!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        // insert json data to the request
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON  = try? JSONDecoder().decode(GenearlRes.self, from: data)
            if let responseJSON = responseJSON as? GenearlRes {
                self.loginRes = responseJSON
                if self.loginRes!.result == "fail" {
                    print("result \( self.loginRes!.result)")
                    print("error \( self.loginRes!.errors)")
                    self.alertError = true;
                } else{
                    self.logInComplete(self.loginUser)
                }
            }
        }
        task.resume()
    }
    
    func logIntoServer(){
        var res : GenearlRes?;
        // create post request
        let url = URL(string: logInUrl(email: self.loginUser.email, pass: self.loginUser.password))!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        // insert json data to the request
//        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON  = try? JSONDecoder().decode(SResult.self, from: data)
            if let responseJSON = responseJSON as? SResult {
                let login : SResult = responseJSON
                if login.result == false {
                    self.loginRes = GenearlRes()
                    self.loginRes?.errors = "Failed to Login wrong credetials"
                    self.loginRes?.result = "fail"
                    self.alertError = true;
                }else{
                    self.logInComplete(self.loginUser)
                }
            }
        }
        task.resume()
    }

}
//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//          LoginView(loginUser: NewUser(), logInComplete: { usr in print(usr) })
//    }
//
//}

