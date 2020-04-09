//
//  UrlUtil.swift
//  PostSocial
//
//  Created by Manogna Podishetty on 11/16/19.
//  Copyright © 2019 Manogna podishetty. All rights reserved.
//

import Foundation

let serverUpload = "https://bismarck.sdsu.edu/api/instapost-upload";
let serverQuery = "https://bismarck.sdsu.edu/api/instapost-query";
/*
https://bismarck.sdsu.edu/api/instapost-upload/newuser
*/
func newUserUrl() -> String {
    return "\(serverUpload)/newuser"
}
/*
https://bismarck.sdsu.edu/api/instapost-query/authenticate?email=email&password=Rapol
*/
func logInUrl(email: String,pass: String) -> String {
    return "\(serverQuery)/authenticate?email=\(email)&password=\(pass)"
}

func getAllNickNamesUrl() -> String {
    return "\(serverQuery)/nicknames"
}

func getAllHastTagsUrl() -> String {
    return "\(serverQuery)/hashtags"
}

// 'https://bismarck.sdsu.edu/api/instapost-query/hashtags-post-ids?hashtag=%233rdpost'
func getHastTagIDUrl(tag:String) -> String {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "bismarck.sdsu.edu"
    components.path = "/api/instapost-query/hashtags-post-ids"
    components.queryItems = [
        URLQueryItem(name: "hashtag", value: tag),
    ]
    let urls =  components.url?.absoluteString
    return urls!;
}

// https://bismarck.sdsu.edu/api/instapost-query/nickname-post-ids?nickname=Aki
func getNickNameIDUrl(name:String) -> String {
    return "\(serverQuery)/nickname-post-ids?nickname=\(name)"
}

// https://bismarck.sdsu.edu/api/instapost-query/nickname-post-ids?nickname=Aki
func getPosts(id:Int) -> String {
    return "\(serverQuery)/post?post-id=\(id)"
}
// https://bismarck.sdsu.edu/api/instapost-query/image?id=616
func getImageUrl(id:Int) -> String {
    return "\(serverQuery)/image?id=\(id)"
}
// https://bismarck.sdsu.edu/api/instapost-query/image
func postImageUrl() -> String {
    return "\(serverUpload)/image"
}

/*
 https://bismarck.sdsu.edu/api/instapost-upload/post
 */
func addAPost() -> String {
    return "\(serverUpload)/post"
}

func addCommentUrl() -> String {
    return "\(serverUpload)/comment"
}

func addRatingUrl() -> String {
    return "\(serverUpload)/rating"
}

func getHTTPRequestBodyGet(usrStr: String) -> URLRequest{
    let  urlObj = URL(string: usrStr)!
    var request = URLRequest(url: urlObj)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "content-type")
    return request
}
