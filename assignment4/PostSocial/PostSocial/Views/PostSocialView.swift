//
//  PostSocialView.swift
//  PostSocial
//
//  Created by Manogna Podishetty on 11/16/19.
//  Copyright © 2019 Manogna podishetty. All rights reserved.
//
import SwiftUI
struct PostSocialView: View {
    @State var user : NewUser;
    @State var hasTags : Tags?;
    @State var selectedOption : String = "";
    @State var searchText: String = "";
    @State var selectedPost : PostsIds = PostsIds();
    @State var nickName : NickNames?;
    @State var alertError: Bool = false
    @State var showSheet: Bool = false
    @State var resMsg: GenearlRes?;
    @State var postdatas : [PostsData] = [];
    @State var logout : () -> ();
    @State var offlineMode : Bool = true;
        @Environment(\.managedObjectContext) var objectContext
    @FetchRequest(entity: AppTagData.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \AppTagData.email, ascending: true)]) var userdata: FetchedResults<AppTagData>
    @State private var persistantData : AppTagData?
    var body: some View {
        GeometryReader{
            geometry in
            VStack{
                VStack{
                    HStack{
                        Image(systemName: "person.crop.circle")
                        Text(self.user.email).font(.title)
                        Spacer()
                        Button( action: {
                            self.logout();
                        },label: {
                                   Image(systemName: "person.badge.minus.fill").padding()
                               })
                    }
                }
                .padding(.bottom, 10)
                if self.hasTags != nil  {
                AddPostView(loginUser: self.user,tags: self.hasTags!.hashtags, postSucCallBack: {
                    self.refreshList()
                })
                }
                if self.hasTags != nil {
                    PostOptionsView(
                        selectedName: [self.selectedOption], options: self.hasTags!.hashtags, hsize: geometry.size.height/25, displayName: "Tags : \(self.hasTags!.hashtags.count)", selectedcallBack: {
                            sel in self.userViewSelect(select:sel)
                    }).padding(.top,10)
                }
                if self.nickName != nil {
                    PostOptionsView(
                        selectedName: [self.selectedOption], options: self.nickName!.nicknames, hsize: geometry.size.height/25, displayName: "Nick Names : \(self.nickName!.nicknames.count)", selectedcallBack: {
                            sel in self.userViewSelect(select:sel)
                        })
                }
                Spacer()
            }
            .padding()
            .alert(isPresented: self.$alertError ) {
                Alert(title: Text("Sorry!"), message: Text(self.resMsg!.errors), dismissButton: .default(Text("Ok")))
            }.sheet(isPresented: self.$showSheet, content: {
                if self.postdatas.count > 0{
                    VStack{
                        PostsView(ids: self.selectedPost.ids,user: self.user, name: self.selectedOption,posts: self.$postdatas, refreahCallBack: { self.showSheet = false; self.userViewSelect(select: self.selectedOption) })
                        }
                }
                }
            )

        }
        .onAppear(perform: {
            self.ping()
            self.refreshList()
        }).onDisappear(perform: {
            self.save(std: self.persistantData!)
        })
    }
    /**
    save selection and get the postid for the tag/name selected
    */
    func userViewSelect(select: String){
        
        for hash in self.hasTags!.hashtags {
            if select == hash {
                print("self.selectedTag \(self.selectedOption)")
                self.getPostId(urlString: getHastTagIDUrl(tag:  select),name: select)
                break
            }
        }

        for name in self.nickName!.nicknames {
            if select == name {
                print("self.selectedName \(self.selectedOption)")
                self.getPostId(urlString: getNickNameIDUrl(name: select),name: select)
                break
            }
        }
    }
    /**
    get tags and name
    */
    func refreshList()  {
        for usr in self.userdata {
            if usr.email == self.user.email{
                self.persistantData = usr;
            }
        }
        if !self.offlineMode {
            self.getAllHasTage()
            self.getAllNickName()
        }else{
            if  self.persistantData?.hashTags != nil {
                self.hasTags = Tags()
                self.hasTags?.hashtags = self.persistantData?.hashTags as! [String]
            }
            if  self.persistantData?.nickNames != nil {
                self.nickName = NickNames()
                self.nickName?.nicknames = self.persistantData?.nickNames as! [String]
            }
        }
    }
    /**
    get all hasgtags from server
    */
    func getAllHasTage() {
        let request = getHTTPRequestBodyGet(usrStr: getAllHastTagsUrl())
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON  = try? JSONDecoder().decode(Tags.self, from: data)
            if let responseJSON = responseJSON as? Tags {
                self.hasTags = responseJSON
                self.hasTags?.hashtags.sort()
                self.persistantData?.hashTags = self.hasTags?.hashtags as NSObject?;
                self.save(std: self.persistantData!)
            }
        }
        task.resume()
    }
    func ping(){

        let urlstr = "\(apiUrl)/ping"
        let urld = URL(string: urlstr)!
        var request = URLRequest(url: urld)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "server offline moving to offline mode ")
                self.offlineMode = true
                return
            }
            let responseJSON  = try? JSONDecoder().decode(Msg.self, from: data)
            if responseJSON!.message != "pong"{
                print("server available")
                self.offlineMode = true
            }else{
                   self.offlineMode = false
                self.refreshList()
            }
        }
        task.resume()

    }
    /**
    get all nicknames
    */
    func getAllNickName() {
        let request = getHTTPRequestBodyGet(usrStr: getAllNickNamesUrl())
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON  = try? JSONDecoder().decode(NickNames.self, from: data)
            if let responseJSON = responseJSON as? NickNames {
                self.nickName = responseJSON
                self.nickName?.nicknames.sort()
                self.persistantData?.nickNames = self.nickName?.nicknames as NSObject?;
   
            }
        }
        task.resume()
    }
    /**
    get the post id for tag or nickname
    */
    func getPostId(urlString:String,name : String) {
        self.selectedPost = PostsIds()

        self.selectedOption = name
        let request = getHTTPRequestBodyGet(usrStr: urlString)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON  = try? JSONDecoder().decode(PostsIds.self, from: data)
            if let responseJSON = responseJSON as? PostsIds {
                if responseJSON.ids != nil && !responseJSON.ids.isEmpty {
                    self.selectedPost = responseJSON
                    self.gatherPostData()
                }else{
                    self.resMsg = GenearlRes()
                    self.resMsg?.errors = "No data found for : \(name)"
                    self.resMsg?.result = "fail"
                    self.alertError = true;
                }
            }
        }
        task.resume()

    }
    /**
    get Post data
    */
    func gatherPostData()  {
        if !self.selectedPost.ids.isEmpty {
            var index = 0;
                    self.postdatas = []
            for  i in self.selectedPost.ids {
                let request = getHTTPRequestBodyGet(usrStr: getPosts(id: i))
                let task = URLSession.shared.dataTask(with: request) {
                    data, response, error in
                    guard let data = data, error == nil else {
                        print(error?.localizedDescription ?? "No data")
                        return
                    }
                    let responseJSON  = try? JSONDecoder().decode(PostsData.self, from: data)
                    if let responseJSON = responseJSON as? PostsData {
                        self.postdatas.append(responseJSON)
                        
                    }
                    else {
                        self.resMsg = GenearlRes()
                        self.resMsg?.errors = "Sorry! cannot retrive data : \(self.selectedOption)"
                        self.resMsg?.result = "fail"
                        self.alertError = true;
                    }
                    index+=1;
                    self.activatesheet(ind: index)
                }
                task.resume()
            }
        }
    }
    func save(std : AppTagData)  {
        objectContext.delete(std)
        objectContext.insert(std)
        do {
            try objectContext.save()
        } catch {
            print(error)
        }
    }
    func activatesheet(ind:Int) {
        if ind == self.selectedPost.ids.count{
            self.showSheet = true
        }
    }
}
struct PostSocialView_Previews: PreviewProvider {
    static var previews: some View {
        PostSocialView(user: loggedInUser(),logout: {print("logout")})
    }

}

