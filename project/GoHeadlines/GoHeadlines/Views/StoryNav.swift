//
//  Stories.swift
//  GoHeadlines
//
//  Created by Manogna podishetty on 12/10/19.
//  Copyright © 2019 Manogna podishetty. All rights reserved.
//

import SwiftUI

/*
{
-"source": {
"id": null,
"name": "Espn.com"
},
"author": null,
"title": "Louisville latest No. 1 team to fall, this time to Texas Tech - ESPN",
"description": "Top-ranked Louisville lost its first game of the season Tuesday, falling 70-57 to Texas Tech in the Jimmy V Classic at Madison Square Garden. The Cardinals are the fourth No. 1 team to lose this season.",
"url": "https://www.espn.com/mens-college-basketball/story/_/id/28270462/louisville-latest-no-1-team-lose-texas-tech",
"urlToImage": "https://a4.espncdn.com/combiner/i?img=%2Fphoto%2F2019%2F1211%2Fr639953_1296x729_16%2D9.jpg",
"publishedAt": "2019-12-11T02:35:42Z",
"content": "NEW YORK -- The college basketball season is only six weeks old, but it's already headed for the fifth No. 1 team of the season.\r\nThe top-ranked Louisville Cardinals lost their first game of the season Tuesday, falling 70-57 to the Texas Tech Red Raiders in t… [+1018 chars]"
}


*/
struct StoryNav: View {

    var article: Article
    @State var imageRes  : UIImage = UIImage(systemName: "cloud.bolt.fill")!
    
    var imgsiz : CGFloat = 45
    var isSaved :Bool;
    var body: some View {
        VStack {
            GeometryReader {  geo in
            NavigationLink(destination: StoryView(story: self.article, image: self.imageRes)){
                ZStack{
//                    HStack{
                        Image(uiImage: self.imageRes)
                            .resizable()
//                            .renderingMode(.original)
//                            .aspectRatio(contentMode: .fill)
                            
                            .foregroundColor(.red)

                        
                            .frame(width: geo.size.width  , height: geo.size.height )
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding(.horizontal,5)
                        .onAppear(perform: {self.loadImage2()})
                    Rectangle().frame(height: (geo.size.height*0.3)).opacity(0.25).blur(radius: 10)
                    HStack{
                        VStack(alignment: .leading, spacing: 8){
                        Text(self.article.title!)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .font(.title)
                            .lineLimit(2)
                        }.padding(.leading)
                            .padding(.bottom)
                    
                    }
                }
//                        if self.imageRes == UIImage(systemName: "cloud.bolt.fill")!{
//                            Image(uiImage: self.imageRes)
//                                .foregroundColor(.red).onAppear(perform: {self.loadImage2()}) //
//                            .frame(width: self.imgsiz + 20 , height: self.imgsiz)
////                            .clipShape(Rectangle())
////                            .overlay(Rectangle().stroke(Color.blue, lineWidth: CGFloat(1)))
//                            .padding(.horizontal,5)
//                        }else{
//                            Image(uiImage: self.imageRes)
//                                .resizable()
//                                .foregroundColor(.red).onAppear(perform: {self.loadImage2()}) //
//                            .frame(width: self.imgsiz + 20 , height: self.imgsiz)
////                            .clipShape(Rectangle())
////                            .overlay(Rectangle().stroke(Color.blue, lineWidth: CGFloat(1)))
//                            .padding(.horizontal,5)
//                            .cornerRadius(10)
//                        }
//                        if isSaved == false {
//                            Text(self.article.title!).font(.footnote)
//                        }else{
//                            Text(self.article.title!)
//                                .font(.subheadline)
//                                .foregroundColor(Color.green)
//                                .multilineTextAlignment(.leading)
//                                .lineLimit(2)
//                        }
//                        Spacer()
//                    }
                }
            }          
        }
    }

    /*
     Download the URL IMage Data
     */
    func loadImage() -> UIImage{
     if  self.article.urlToImage != nil && !self.article.urlToImage!.isEmpty {

        //   if (self.imageRes.isEquals(image: UIImage(systemName: "shield.slash")!) )  && self.article.urlToImage != nil && !self.article.urlToImage!.isEmpty {
            let url = URL(string: self.article.urlToImage!)
            if url != nil {
                let data = try? Data(contentsOf: url!)  
                if data != nil && data!.base64EncodedData().count > 0{
                    return UIImage(data: data!)!.resizedTo1MB()!
                }
            }
        }
        return self.imageRes;

    }
    func loadImage2() {
     if  self.article.urlToImage != nil && !self.article.urlToImage!.isEmpty {

        guard let url = URL(string: self.article.urlToImage!) else {
            return
        }
        //Fetch image
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //Did we get some data back?
            if let data = data {
                //Yes we did, update the imageview then
                if UIImage(data: data)! != nil {
                    let image = UIImage(data: data)!
                    
                    DispatchQueue.main.async {
                        self.imageRes = image
                    }
                }
            }
        }.resume()
//        }
        
    }

    }

    func convertBase64toString (imageBase64String:String) -> UIImage {
        let dataDecoded : Data = Data(base64Encoded: imageBase64String, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        return decodedimage!
    }
}



