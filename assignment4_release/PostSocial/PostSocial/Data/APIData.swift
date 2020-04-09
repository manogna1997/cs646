//
//  APIData.swift
//  PostSocial
//
//  Created by Manogna Podishetty on 11/10/19.
//  Copyright © 2019 Manogna podishetty. All rights reserved.
//
import Foundation
import CoreData

let apiUrl = "https://bismarck.sdsu.edu/api";
let failed = "fail"

/*
{
"result": "success",
Page 4 of 9
"errors": "none"
}
*/
struct  Msg : Decodable{
    var message : String
}

struct  SResult : Decodable{
    var result : Bool
}

struct  Tags : Decodable{
    var hashtags : [String]
}

struct  NickNames : Decodable{
    var nicknames : [String]
}
//{
//  "result": "string",
//  "id": 0,
//  "errors": "string"
//}
class  PostRes : Decodable{
    var result : String
    var id : Int
    var errors : String
    init() {
        self.result = ""
        self.errors = ""
        self.id = 0
    }
}
struct  PostsIds : Decodable{
    var result : String
    var ids : [Int]
    var errors : String
    
    init() {
        self.result = ""
        self.errors = ""
        self.ids = []
    }
}

struct  PostsData : Decodable{
    var result : String
    var post :   SinglePost
    var errors : String
}

struct  SinglePost : Codable{
    var comments : [String]
    var ratings_count : Float
    var ratings_average : Float
    var id : Int
    var hashtags : [String]
    var image : Int
    var text : String

    enum CodingKeys: String, CodingKey {
        case comments
        case ratings_count = "ratings-count"
        case ratings_average = "ratings-average"
        case hashtags
        case id
        case image
        case text
    }
}

class  PostsBindObj : ObservableObject{
     @Published  var id = UUID()
     @Published var posts : PostsIds
    
    init() {
        self.posts = PostsIds()
    }
}


class User:  ObservableObject{
    @Published  var id = UUID()
    @Published  var usr : NewUser
    
    init(inv:NewUser) {
        self.usr = inv
    }
    
    init() {
        self.usr = NewUser()
    }
}
class NewUser : Codable{
    var firstname : String
    var lastname : String
    var nickname : String
    var email : String
    var password : String
    init(){
        self.email = "";
        self.password = "";
        self.firstname = "";
        self.lastname = "";
        self.nickname = "" ;
    }

    func  getJson() -> Dictionary<String, Any> {
        let jsonObj:Dictionary<String, Any> = [
            "nickname" : nickname,
            "lastname" : lastname,
            "firstname" : firstname,
            "password" : password,
            "email" : email]
        return jsonObj
    }

}
extension NewUser {
    static func ==(lhs: NewUser, rhs: NewUser) -> Bool {
        return lhs.email == rhs.email
    }

}
/*
*/
class  AddPost: Codable{
    var email : String
    var password : String
    var text : String
    var hashtags : [String]
    init(){
        self.email = "";
        self.password = "";
        self.text = "";
        self.hashtags = [];
    }
    func  getJson() -> Dictionary<String, Any> {
        let jsonObj:Dictionary<String, Any> = [
            "email" : self.email,
            "password" : self.password,
            "text" : self.text,
            "hashtags" : self.hashtags]
        return jsonObj
    }

}
extension AddPost {
    static func ==(lhs: AddPost, rhs: AddPost) -> Bool {
        return lhs.email == rhs.email
    }
}
/*
*/
class  AddComment: Codable{
    var email : String
    var password : String
    var comment : String
    var postid : Int
    init(){
        self.email = "";
        self.password = "";
        self.comment = "";
        self.postid = 0;
    }
    func  getJson() -> Dictionary<String, Any> {
        let jsonObj:Dictionary<String, Any> = [
            "email" : self.email,
            "password" : self.password,
            "comment" : self.comment,
            "post-id" : self.postid]
        return jsonObj
    }

}
extension AddComment {
    static func ==(lhs: AddComment, rhs: AddComment) -> Bool {
        return lhs.email == rhs.email
    }
}
/*
{
"email": "STRING",
"password": "STRING",
"image": "BASE64 STRING",
"post-id": INTEGER
}
*/
class  AddImage : Codable {
    var email : String
    var password : String
    var image : String
    var postid : Int
    init(){
        self.email = "";
        self.password = "";
        self.image = "";
        self.postid = 0;
    }
    func  getJson() -> Dictionary<String, Any> {
        let jsonObj:Dictionary<String, Any> = [
            "email" : self.email,
            "password" : self.password,
            "image" : self.image,
            "post-id" : self.postid]
        return jsonObj
    }

}
extension AddImage {
    static func ==(lhs: AddImage, rhs: AddImage) -> Bool {
        return lhs.image == rhs.image
    }
}
/*
{
"email": "STRING",
"password": "STRING",
"rating": INTEGER 1-5, "post-id": INTEGER_OF_POST
}
*/
class  AddRating : Codable {
    var email : String
    var password : String
    var rating : Int
    var postid : Int
    init(){
        self.email = "";
        self.password = "";
        self.rating = 0;
        self.postid = 0;
    }
    func  getJson() -> Dictionary<String, Any> {
        let jsonObj:Dictionary<String, Any> = [
            "email" : self.email,
            "password" : self.password,
            "rating" : self.rating,
            "post-id" : self.postid]
        return jsonObj
    }

}

extension AddRating {
    static func ==(lhs: AddRating, rhs: AddRating) -> Bool {
        return lhs.email == rhs.email
    }
}
/*
{
"result": "success",
Page 4 of 9
"errors": "none"
}
*/
class  GenearlRes :Decodable{
    var result : String
    var errors : String
    init() {
        self.result = ""
        self.errors = ""
    }
}

class  ImageRes :Decodable{
    var result : String
    var errors : String
    var image : String
    
    init() {
        self.result = ""
        self.errors = ""
        self.image = ""
    }
}
/*
{
"email": "STRING",
"password": "STRING",
"rating": INTEGER 1-5, "post-id": INTEGER_OF_POST
}
*/

func ping() -> String{
    var resMsg = "";
    let urlstr = "\(apiUrl)/ping"
    let urld = URL(string: urlstr)!
    var request = URLRequest(url: urld)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "content-type")
    let task = URLSession.shared.dataTask(with: request) {
        (data, response, error) in
        guard let data = data, error == nil else {
            print(error?.localizedDescription ?? "No data")
            return
        }
        let responseJSON  = try? JSONDecoder().decode(Msg.self, from: data)
        resMsg = responseJSON!.message;
    }

    task.resume()
    return resMsg
}

func loggedInUser() -> NewUser {
    var usr = NewUser();
    usr.email = "mp6@gmail.com"
    usr.password = "Rapol"
    return usr;
}


func validateUserDate(user: NewUser, newUser: Bool) -> GenearlRes{
    let responce = GenearlRes();
    responce.result = "passed"
    if isValidEmail(emailStr: user.email) == false{
        responce.errors = "Invalid email : \(user.email)"
        responce.result = "fail"
        return responce
    }

    if user.password.isEmpty || user.password.count < 4 {
        responce.errors = "Invalid password , password should have lenght of 3+"
        responce.result = "fail"
        return responce
    }

    if newUser == true {
        if user.firstname.isEmpty || user.firstname.count < 4 {
            responce.errors = "Invalid firstname , firstname should have lenght of 3+"
            responce.result = "fail"
            return responce
        }
        if user.lastname.isEmpty || user.lastname.count < 4 {
            responce.errors = "Invalid lastname , lastname should have lenght of 3+"
            responce.result = "fail"
            return responce
        }
        if user.nickname.isEmpty || user.nickname.count < 4 {
            responce.errors = "Invalid nickname , nickname should have lenght of 3+"
            responce.result = "fail"
            return responce
        }
    }

    return responce
}

class  AppTagData: NSManagedObject,Identifiable{
    @NSManaged  var id : UUID?
    @NSManaged  var hashTags : [String]?
    @NSManaged  var nickNames : [String]?
}

extension AppTagData {
    static func allIStudentPersitance() -> NSFetchRequest<AppTagData> {
        let request: NSFetchRequest<AppTagData> = AppTagData.fetchRequest() as! NSFetchRequest<AppTagData>
        request.sortDescriptors = [NSSortDescriptor(key: "studentname", ascending: true)]

        return request
    }
}

func isValidEmail(emailStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: emailStr)
}
func genearteRandomString() -> String {
    let length = 32
    let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let randomCharacters = (0..<length).map{
        _ in characters.randomElement()!
    }

    return String(randomCharacters)
}

func roundOf(cf : Float) -> String{
   let roundedValue = String(format: "%.2f", cf)
//    let roundedValue = round(cf * 10) / 10
    return roundedValue
}

func roundOfInt(cf : Float) -> Int{
   return Int(floor(cf))
}
