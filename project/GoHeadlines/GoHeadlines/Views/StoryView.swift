//
//  StoryView.swift
//  GoHeadlines
//
//  Created by Manogna podishetty on 12/10/19.
//  Copyright © 2019 Manogna podishetty. All rights reserved.
//
import SwiftUI
struct StoryView: View {
    @Environment(\.managedObjectContext) var objectContext;
    @FetchRequest(entity: ArticleEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ArticleEntity.title, ascending: true)]) var savedStories : FetchedResults<ArticleEntity>
    var story : Article
    var image : UIImage?
    var imgsiz : CGFloat = 350
    var pad : CGFloat = 5
    var body: some View {
        ZStack{
            GeometryReader {
                geo in
                ScrollView (.vertical){
                    VStack{
                        VStack{
                            Image(uiImage: self.image!).resizable()
                            .frame(width: geo.size.width , height: self.imgsiz)
                            .clipShape(Rectangle())
                        }
                        VStack{
                            VStack(alignment: .trailing){
                                      HStack{
                                Text(self.story.title!).font(.headline).bold()
                                Spacer()
                                }
                            }
                            VStack(){
                                if self.story.author != nil {
                                    HStack{
                                        Spacer()
                                        Text("Author : \(self.story.author!)").font(.subheadline)
                                    }
                                }
                                if self.story.publishedAt != nil {
                                    HStack{
                                        Spacer()
                                        Text(" \(getFormattedDate(date: self.story.publishedAt!))").font(.subheadline)
                                    }
                                }
                            }
                            .padding(.top, 10)
                            Divider()
                            VStack(alignment: .leading){
                                if self.story.content != nil {
                                    HStack{
                                        Text(self.story.content!).font(.body).padding(.top, 20).lineSpacing(8)
                                    }
                                }
                                else if self.story.articleDescription != nil {
                                    HStack{
                                        Text(self.story.articleDescription!).font(.body).padding(.top, 20).lineSpacing(8)
                                    }
                                }else{
                                    HStack{
                                        Text("No content found").font(.footnote).padding(.top, 20)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal,20)
                    }
                    .navigationBarItems(
                        trailing:Button(action: {
                            self.saveArticle(arti: self.story)
                        },label: {
                            if (!self.contains(r: self.story)){
                                Image(systemName: "tray.and.arrow.down.fill")
                                .frame(width: 25, height: 25)
                                .clipShape(Circle())
                            }else{
                                Image(systemName: "trash").foregroundColor(Color.green)
                                .frame(width: 25, height: 25)
                                .clipShape(Circle())
                                
                            }
                        }))
                }
            }
            Spacer()
        }.animation(.spring()).edgesIgnoringSafeArea(.top)
    }

    func savedefault() {
        do {
            try self.objectContext.save()
        }
        catch {
            print(error)
        }
    }

    func saveArticle(arti:Article) {
        if self.contains(r: arti){
            self.deleteExzisting(r: arti)
        }else{
            var  art = ArticleEntity(context: self.objectContext)
            art =  fillUpArticleToPersistance(art: arti, artPer: art)
            print("saving -> \(art.title)")
            self.savedefault()
        }
    }

    func deletePersistan(r: ArticleEntity){
        do {
            try self.objectContext.delete(r)
            try self.objectContext.save()
        }
        catch {
            print(error)
        }
    }

    func deleteExzisting(r: Article) {
        for item in self.savedStories {
            if item.title == r.title{
                self.deletePersistan(r: item)
            }
        }
    }

    func contains(r: Article) -> Bool{
        for item in self.savedStories {
            if item.title == r.title{
                return true
            }
        }
        return false;
    }
}


