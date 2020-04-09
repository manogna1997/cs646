//
//  PostsView.swift
//  PostSocial
//
//  Created by Manogna Podishetty on 11/17/19.
//  Copyright © 2019 Manogna podishetty. All rights reserved.
//
import SwiftUI
struct PostsView: View {
    var ids : [Int] ;
    var user : NewUser = NewUser();
    var name : String = "Select a post" ;
    @Binding var posts : [PostsData];
    var newcomment : String = "";
    var refreahCallBack : () -> ()
    var body: some View {
        VStack{
            HStack{
                Text(self.name).bold().font(.title)
                Spacer()
                Image(systemName: "rectangle.stack.fill")
                Text(" \(self.ids.count)").font(.subheadline)
            }
            Divider().background(Color.gray)
            if self.posts.count > 0 {
                ScrollView(.vertical) {
                    if self.posts != nil{
                        ForEach(0 ..< self.posts.count,id: \.self){
                            index in
                            PostCommentView(post: self.posts[index].post,loginUser: self.user)
                        }
                    }
                }
            }
        }
        .padding(8)
        .background(Color.white)
    }

}

