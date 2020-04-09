//
//  ContentView.swift
//  PostSocial
//
//  Created by Manogna Podishetty on 11/10/19.
//  Copyright © 2019 Manogna podishetty. All rights reserved.
//
import SwiftUI
struct ContentView: View {
    @State var user : User
    @Environment(\.managedObjectContext) var objectContext
    @FetchRequest(entity: AppTagData.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \AppTagData.email, ascending: true)]) var userdata: FetchedResults<AppTagData>
    @State var logOut = false
    var body: some View {
        ZStack{
            if self.logOut == true || self.user.usr.password.isEmpty || !isValidEmail(emailStr: self.user.usr.email) {
                LoginView(userCashe: self.user.usr,logInComplete: {
                    us in
                    self.user.usr = us
                    self.logOut = false
                    self.saveUserData()
                })
            }
            else {
                PostSocialView(user: self.user.usr,logout: { print("logout");self.user.usr.password = "";self.logOut = true;self.saveUserData()})
            }
        }.onAppear {
            print("ContentView appeared!")
            self.loadCacheData()

        }
    }
    
    func saveUserData() {
      for usr in self.userdata {
        if usr.email == self.user.usr.email{
              self.deletePersistanStudent(r: usr)
          }
      }
      let  usrdata = AppTagData(context: self.objectContext)
      usrdata.email = self.user.usr.email
      usrdata.password = self.user.usr.password
      self.savedefault()
    }
    
    func deletePersistanStudent(r: AppTagData){
        do {
            try self.objectContext.delete(r)
            try self.objectContext.save()
        } catch {
            print(error)
        }

    }
    
    func loadCacheData()  {
        if self.userdata.count < 1 {
            print("empty persistance ")
            return
        }
        for puser in self.userdata{
            print(self.user.usr.getJson())
            self.user = User()
            self.user.usr.email = puser.email!
            self.user.usr.password = puser.password!
            print(self.user.usr.getJson())
        }
    }
    
    func savedefault() {
        do {
            try self.objectContext.save()
        } catch {
            print(error)
        }
    }

}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(user: User())
    }
}

