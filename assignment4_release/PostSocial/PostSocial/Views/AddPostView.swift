//
//  AddPost.swift
//  PostSocial
//
//  Created by Manogna Podishetty on 11/18/19.
//  Copyright © 2019 Manogna podishetty. All rights reserved.
//
import SwiftUI
struct AddPostView: View {
    @State var loginUser: NewUser
    @State var postdata: AddPost = AddPost();
    @State var selectedOptions : [String] = [];
    @State var postRes: PostRes?;
    @State var newTag : String = "";
    @State var alertError: Bool = false
    @State var resMsg: GenearlRes?;
    var tags: [String] = []
    let col = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    var postSucCallBack : () -> ()
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack{
                HStack{
                    Text("Add Post").font(.title)
                    Spacer()
                }
                Divider()
                HStack{
                    Text("Email : ").bold().font(.headline)
                    Text("\(self.loginUser.email)").font(.subheadline)
                    Spacer()
                }
                TextField("Post Text", text: self.$postdata.text)
                .keyboardType(.default)
                .padding(.all)
                .background(col)
                HStack{
                    Text("New HashTag : ").font(.headline)
                    Spacer()
                    TextField("New Tag", text: self.$newTag)
                    .keyboardType(.default)
                    .padding(.all)
                    .background(col)
                }
                .padding(.bottom,10)
                HStack{
                    PostOptionsView(
                        selectedName: self.selectedOptions, options: self.tags, hsize: 25, displayName: "Selected Tag  : \(self.selectedOptions.count)", selectedcallBack: {
                            sel in self.updateSelectionTags(tag:sel)
                        })
                }
                .padding(.top,10)
                HStack{
                    Spacer()
                    Button( action: {
                        self.sendNewPost()
                    },label: {
                               Image(systemName: "paperplane").foregroundColor(.white)
                               Text("Post").fontWeight(.bold)
                               .foregroundColor(.white)
                               .padding(.vertical, 12)
                           })
                    Spacer()
                }
                .background(Color.green)
                .padding(.horizontal,25)
            }
            .padding()
        }
        .alert(isPresented: self.$alertError ) {
            Alert(title: Text("Sorry!"), message: Text(self.resMsg!.errors), dismissButton: .default(Text("Ok")))
        }
    }

    func updateSelectionTags(tag : String){
        if !self.selectedOptions.contains(tag){
            self.selectedOptions.append(tag)
        }
        else{
            self.selectedOptions.removeAll(where: {
                $0 == tag
            })
        }
    }

    func sendNewPost() {
        if self.validatePostObj() {
            var res : GenearlRes?;
            let jsonD = self.postdata.getJson();
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonD)
            // create post request
            let url = URL(string: addAPost())!
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
                let responseJSON  = try? JSONDecoder().decode(PostRes.self, from: data)
                if let responseJSON = responseJSON as? PostRes {
                    self.postRes  = responseJSON
                    if self.postRes!.result == "fail" {
                        self.resMsg = GenearlRes()
                        self.resMsg?.errors = "Failed Post New Text for user\(self.postRes!.errors)"
                        self.resMsg?.result = "fail"
                        self.alertError = true;
                    }
                    else{
                        print("complted posting \(self.postRes!.id)")
                        self.postdata = AddPost();
                        self.selectedOptions = []
                        self.postSucCallBack();
                    }
                }
            }
            task.resume()
        }
    }

    func validatePostObj() -> Bool{
        self.postdata.hashtags = []
        self.postdata.email = self.loginUser.email;
        self.postdata.password = self.loginUser.password;
        
        if self.postdata.text == ""{
            self.resMsg = GenearlRes()
            self.resMsg?.errors = "Sorry! please add text message to post : \(self.newTag)"
            self.resMsg?.result = "fail"
            self.alertError = true;
            return false
        }
            
        if self.postdata.text != "" && self.postdata.text.count > 143 {
            self.resMsg = GenearlRes()
            self.resMsg?.errors = "Sorry! post text chars should be  < 144"
            self.resMsg?.result = "fail"
            self.alertError = true;
            return false
        }
        
        if self.newTag != "" {
            let index = self.newTag.index( self.newTag.startIndex, offsetBy: 0)
            if self.newTag[index] != "#"{
                self.resMsg = GenearlRes()
                self.resMsg?.errors = "Sorry! new hash tag should start with '#' : \(self.newTag)"
                self.resMsg?.result = "fail"
                self.alertError = true;
                return false
            }
                self.postdata.hashtags.append(self.newTag)
            
        }

        if self.newTag == "" && self.selectedOptions.count < 1{
            self.resMsg = GenearlRes()
            self.resMsg?.errors = "Sorry! please select or add a new hash tag"
            self.resMsg?.result = "fail"
            self.alertError = true;
            return false
        }
        if self.selectedOptions.count > 0 {
                self.postdata.hashtags.append(contentsOf: self.selectedOptions)
        }
        return true;
    }

}


