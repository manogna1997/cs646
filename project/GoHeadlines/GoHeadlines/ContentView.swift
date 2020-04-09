//
//  ContentView.swift
//  GoHeadlines
//
//  Created by Manogna podishetty on 12/3/19.
//  Copyright © 2019 Manogna podishetty. All rights reserved.
//
import SwiftUI
import Network
let monitor = NWPathMonitor()
struct ContentView: View {
    @Environment(\.managedObjectContext) var objectContext;
    @FetchRequest(entity: ArticleEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ArticleEntity.title, ascending: true)]) var savedStories : FetchedResults<ArticleEntity>
    @State var addStudent = false
    @State var isLoading = true
    @State var stories : NewStories?
    @State private var name: String = ""
    @State private var offline: Bool = false
    @State private var settings: Settings = Settings()
    @State var resMsg: GenearlRes?;
    @State var alertError: Bool = false
    var body: some View {
        return   GeometryReader {
            geometry in ZStack {
                VStack {
//                    List{
                        HStack{
                            TextField("Search for a news", text: self.getSearchBinding(),onCommit: {
                                print(self.settings.search)
                            })
                            .textFieldStyle(RoundedBorderTextFieldStyle()).keyboardType(.default)
                        }

//                    }
                    ScrollView {
                    if self.stories != nil && !self.isLoading {
                        List{
                        ForEach(0 ..< self.stories!.articles!.count,  id: \.self){
                            art in
                            StoryNav(article: self.stories!.articles![art],isSaved: self.contains(r: self.stories!.articles![art])).animation(.easeIn)
                        }
                        .disabled(self.isLoading)
                        .blur(radius: self.isLoading ? 5 : 0)
                        }
                    }
                    }
                }
                    .navigationBarTitle(Text("Rapid News"))
                    .navigationBarItems(
                        trailing:
                        HStack{
                            Button(action: {
                                self.addStudent.toggle()
                            }
                                   , label: {
                                       Text("\(self.savedStories.count)")
                                   })
                            Spacer()
                            Button(action: {
                                if  self.offline {
                                    self.loadNewsFromAPI(modestr: modes[self.settings.mode])
                                }
                                else{
                                    self.pullAllArticles()
                                }
                                self.offline.toggle()
                            }
                                   , label: {
                                       if self.offline {
                                           Image(systemName: "tray.and.arrow.down.fill").foregroundColor(Color.green)
                                       }
                                       else{
                                           Image(systemName: "tray.and.arrow.down.fill")
                                       }
                                   })
                            Spacer()
                            Button(action: {
                                self.addStudent.toggle()
                            }
                                   , label: {
                                       Image(systemName: "gear")
                                   })
                            .padding(.horizontal,10)
                        })
                }
                .alert(isPresented: self.$alertError ) {
                    Alert(title: Text("Sorry!"), message: Text(self.resMsg!.errors), dismissButton: .default(Text("Ok")))
                }
                .sheet(isPresented: self.$addStudent, content: {
                    SettingView(setting: self.settings, mode: self.settings.mode, refreahCallBack : {
                        s in
                        self.settings = s;
                        self.loadNewsFromAPI(modestr: modes[self.settings.mode])
                    })
                })
                .onAppear(perform: {
                    self.loadNewsFromAPI(modestr:  modes[self.settings.mode]);
                })
                if self.isLoading && !self.offline {
                    HStack{
                        Spacer()
                        VStack {
                            Text("Loading...").bold()
                            ActivityIndicator(isAnimating: .constant(true), style: .large)
                        }
                        .frame(width: geometry.size.width / 2,
                               height: geometry.size.height / 5)
                        .cornerRadius(20)
                        .opacity(self.isLoading ? 1 : 0)
                        Spacer()
                    }
                }
            }
        
    }

    func getSearchBinding() -> Binding<String> {
        let bindingSearch = Binding<String>(get: {
            return self.settings.search
        }
                                            , set: {
                                                self.settings.search = $0
                                                if $0.count >= 3 {
                                                    self.loadNewsFromAPI(modestr:  everything)
                                                }
                                                if  $0.count == 0{
                                                    self.loadNewsFromAPI(modestr:  modes[self.settings.mode])
                                                }
                                            })
        return bindingSearch;
    }

    func loadNewsFromAPI(modestr:String){
        self.isLoading = true
        self.stories = nil
        let  request = getDatafromNewAPI(usrStr: self.settings, mode: modestr)
        if !isConnectedToNetwork() {
            self.resMsg = getErrorAlert(str: "Sorry! cannot connect to internet https://newsapi.org")
            self.alertError = true;
            return
        }
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
            var  responseJSON =   try? decoder.decode(NewStories.self, from: data)
            if let responseJSON = responseJSON as? NewStories {
                print("got data : \(responseJSON.articles?.count)")
                if responseJSON.articles != nil {
                    self.stories = responseJSON
                }
                else{
                    self.resMsg = getErrorAlert(str: "Sorry! new cannot load data from https://newsapi.org")
                    self.alertError = true;
                }
                self.isLoading = false
            }
        }
        task.resume()
    }

    func contains(r: Article) -> Bool{
        for item in self.savedStories {
            if item.title == r.title{
                return true
            }
        }
        return false;
    }

    func pullAllArticles() {
        if self.savedStories.count < 1 {
            print("empty data ")
            return
        }
        self.stories = NewStories(status: "offline", totalResults: self.savedStories.count, articles: [])
        for newdtd in self.savedStories {
            var arti =  fileUpArticle(art: newdtd);
            print("pulling dat \(arti.title)")
            stories?.articles?.append(arti)
        }
    }

}

