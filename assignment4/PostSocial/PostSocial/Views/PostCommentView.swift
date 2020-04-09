//
//  PostCommentView.swift
//  PostSocial
//
//  Created by Manogna Podishetty on 11/20/19.
//  Copyright © 2019 Manogna podishetty. All rights reserved.
//
import SwiftUI
struct PostCommentView: View {
    @State var post : SinglePost
    var loginUser: NewUser
    @State var resError: GenearlRes?;
    @State var alertError: Bool = false
    @State var newcomment : String = "";
    @State var rating : Int = 0;
    @State var imageRes  : ImageRes?;
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image?
    @State private var showCmt = false
    var imgsiz : CGFloat = 60
    var body: some View {
        VStack{
            HStack {
                if self.post.image > 0 && self.imageRes != nil {
                    Image(uiImage: self.convertBase64toString(imageBase64String: self.imageRes!.image))
                    .resizable()
                    .frame(width: self.imgsiz, height: self.imgsiz)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.blue, lineWidth: 1))
                    .padding(.horizontal,10)
                }
                if  self.imageRes == nil && self.post.image > 0 {
                    Circle()
                    .fill(Color.white)
                    .frame(width: self.imgsiz, height: self.imgsiz)
                    .overlay(Circle().stroke(Color.blue, lineWidth: 1))
                    .padding(.horizontal,10)
                }
                Spacer()
                Text( self.post.text).font(.headline).padding(15)
            }
            HStack {
                TextField("New comment", text: self.$newcomment)
                .padding(5)
                .overlay(RoundedRectangle(cornerRadius: 10)
                         .stroke(Color.black, lineWidth: 2))
                Spacer()
                Button(action: {
                    self.submitComment()
                }
                       ,label:{
                           Image(systemName: "message.fill")
                       })
                Button(action: {
                    print("image")
                    self.showingImagePicker = true
                },label:{Image(systemName: "paperclip")})
            }
            HStack {
                Text("Rating ").font(.subheadline).padding(.vertical,10)
                ForEach(0 ..<  roundOfInt(cf:  self.post.ratings_count) ,id: \.self){
                    _ in
                    Image(systemName: "star.fill").foregroundColor(Color.blue)
                }
                Spacer()
                Text("image id: \(self.post.image)").font(.subheadline).padding(.vertical,10)
                Spacer()
                Text("Avg: \(roundOf(cf:  self.post.ratings_average))").font(.subheadline).padding(.vertical,10)
            }
            HStack {
                Button(action: {
                    if self.rating >= 0 && self.rating < 5{
                        self.rating+=1
                        print(self.rating)
                    }
                }
                       ,label:{
                           Image(systemName: "hand.thumbsup.fill")
                       })
                .padding(.horizontal,10)
                Button(action: {
                    if self.rating > 0 && self.rating < 6{
                        self.rating = self.rating - 1
                        print(self.rating)
                    }
                },label:{Image(systemName: "hand.thumbsdown.fill")})
                ForEach(0 ..< self.rating,id: \.self){
                    _ in
                    Image(systemName: "star.fill")
                }
                ForEach(0 ..<  (5 - self.rating),id: \.self){
                    _ in
                    Image(systemName: "star")
                }
                Spacer()
                Button(action: {
                    self.submitRating()
                },label:{ Text("submit rating")
                
                    Image(systemName: "play.fill") })
            }
            HStack {
                Text("Comment : ").font(.subheadline).padding(.vertical,10)
                Spacer()
                if  self.post.comments.count < 1{
                    Text("NONE").font(.subheadline)
                }
                else{
                    Spacer()
                    Toggle(isOn: $showCmt) {
                        Text("\(self.post.comments.count)").font(.subheadline)
                    }.padding()
                }
            }
            if  self.post.comments.count > 0 && self.showCmt{
                ScrollView (.vertical){
                    ForEach(0 ..<  self.post.comments.count,id: \.self){
                        cind in
                        HStack {
                            Spacer();
                            Text( self.post.comments[cind]).font(.subheadline)
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 1))
                        }
                        .padding(.bottom,4)
                    }
                }
            }
            Divider().background(Color.gray)
        }
        .onAppear(perform: {
            if self.post.image > 0 {
                self.getImage(idnum: self.post.image)
            }
        })
        .alert(isPresented: $alertError ) {
            Alert(title: Text(self.resError!.result), message: Text(self.resError!.errors), dismissButton: .default(Text("Ok")))
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }

    func submitComment()  {
        if self.newcomment == ""{
            self.resError = GenearlRes()
            self.resError?.errors = "Add a commnet before submit"
            self.resError?.result = "fail"
            self.alertError = true;
        }
        else if self.newcomment.count > 144 {
            self.resError = GenearlRes()
            self.resError?.errors = "comment size should be less then 144 char"
            self.resError?.result = "fail"
            self.alertError = true;
        }
        else{
            self.postComment();
        }
    }

    func submitRating()  {
        if self.rating <=  0 || self.rating > 5  {
            self.resError = GenearlRes()
            self.resError?.errors = "rating should be within range of 1-5"
            self.resError?.result = "fail"
            self.alertError = true;
        }
        else{
            self.postRating();
        }
    }

    func postComment()  {
        var res : GenearlRes?;
        let  commentData = AddComment()
        commentData.comment = self.newcomment;
        commentData.email = self.loginUser.email;
        commentData.password = self.loginUser.password;
        commentData.postid = self.post.id
        let jsonD = commentData.getJson();
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonD)
        // create post request
        let url = URL(string: addCommentUrl())!
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
                self.resError = responseJSON
                if self.resError!.result == "fail" {
                    print("failed to add a comment \( self.resError!.result)")
                    self.alertError = true;
                }
                else{
                    self.newcomment = ""
                }
                self.refreshPostData()
            }
        }
        task.resume()
    }

    func postRating()  {
     
        let  commentData = AddRating()
        commentData.rating = self.rating;
        commentData.email = self.loginUser.email;
        commentData.password = self.loginUser.password;
        commentData.postid = self.post.id
        let jsonD = commentData.getJson();
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonD)
        // create post request
        let url = URL(string: addRatingUrl())!
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
                self.resError = responseJSON
                if self.resError!.result == "fail" {
                    print("failed to add a comment \( self.resError!.result)")
                }else{
                    self.resError!.errors = "completed rating image \(self.rating)"
                    self.rating = 0;
                }
                self.refreshPostData()
                self.alertError = true;
            }
        }
        task.resume()
    }

    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        self.postImage(imgStr:self.convertImageToBase64(inputImage) )
    }

    func convertBase64toString (imageBase64String:String) -> UIImage {
        let dataDecoded : Data = Data(base64Encoded: imageBase64String, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        return decodedimage!
    }

    func convertImageToBase64(_ image: UIImage) -> String {
        let imageData:NSData = image.jpegData(compressionQuality: 0.4)! as NSData
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        return strBase64
    }

    func getImage(idnum : Int) {
        print("loading image id \(idnum)")
        let request = getHTTPRequestBodyGet(usrStr: getImageUrl(id: idnum))
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON  = try? JSONDecoder().decode(ImageRes.self, from: data)
            if let responseJSON = responseJSON as? ImageRes {
                self.imageRes = responseJSON
                if self.imageRes!.result == "fail" {
                    self.resError = GenearlRes()
                    self.resError?.errors = "failed to get image id \(self.post.image) \(self.imageRes!.errors)"
                    self.resError?.result = "fail"
                    self.alertError = true;
                }
            }
        }
        task.resume()
    }

    func postImage(imgStr:String )  {
        let  imgData = AddImage()
        imgData.image = imgStr;
        imgData.email = self.loginUser.email;
        imgData.password = self.loginUser.password;
        imgData.postid = self.post.id
        let jsonD = imgData.getJson();
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonD)
        // create post request
        let url = URL(string: postImageUrl())!
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
                self.resError = responseJSON
                if self.resError!.result == "fail" {
                    print("failed to add image \( self.resError!.errors)")
                }
                else{
                    self.resError!.errors = "completed uploading image"
                }
//                self.alertError = true;
                self.refreshPostData()
            }
        }
        task.resume()
    }

    func refreshPostData() {
        let request = getHTTPRequestBodyGet(usrStr: getPosts(id: self.post.id))
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON  = try? JSONDecoder().decode(PostsData.self, from: data)
            if let responseJSON = responseJSON as? PostsData {
                self.post =  responseJSON.post
                
            }
            else {
                self.resError = GenearlRes()
                self.resError?.errors = "Sorry! cannot refresh post data"
                self.resError?.result = "fail"
                self.alertError = true;
            }
        }
        task.resume()
    }
}

