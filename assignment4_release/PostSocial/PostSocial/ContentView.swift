//
//  ContentView.swift
//  PostSocial
//
//  Created by Manogna Podishetty on 11/10/19.
//  Copyright © 2019 Manogna podishetty. All rights reserved.
//
import SwiftUI
struct ContentView: View {
    @EnvironmentObject var user : User
    @State var logOut = false
    var body: some View {
        ZStack{
            if self.logOut == true || self.user.usr.password.isEmpty || !isValidEmail(emailStr: self.user.usr.email) {
                LoginView(loginUser: user.usr,logInComplete: {
                    us in
                    self.user.usr = us
                    self.logOut = false
                })
            }
            else {
                PostSocialView(user: self.user.usr,logout: { print("logout");self.user.usr.password = "";self.logOut = true})
            }
        }
    }

}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }

}

