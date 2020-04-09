//
//  NewsApi.swift
//  GoHeadlines
//
//  Created by Manogna podishetty on 12/4/19.
//  Copyright © 2019 Manogna podishetty. All rights reserved.
//
import Foundation
import SwiftUI
import Network
import SystemConfiguration
var size = 0
let  apikey : String = "bcd1e74ab78240bf893436166c438b8d"
let newsApiEverthingUrl : String = "https://newsapi.org/v2/everything"
let newsApiTopNewsUrl : String   = "https://newsapi.org/v2/top-headlines"
let newsApiSourceUrl : String     = "https://newsapi.org/v2/sources"
let category : [String] = ["business", "entertainment", "general","health", "science", "sports", "technology",""]
let language : [String] = ["ar", "de", "en", "es", "fr",
                           "he", "it", "nl", "no", "pt",
                           "ru", "se", "ud" ,"zh"]
let country : [String] = ["ae","ar","at","au","be","bg","br","ca","ch","cn",
                          "co","cu","cz","de","eg","fr","gb","gr","hk","hu",
                          "id","ie","il","in","it","jp","kr","lt","lv","ma",
                          "mx","my","ng","nl","no","nz","ph","pl","pt","ro",
                          "rs","ru","sa","se","sg","si","sk","th","tr","tw",
                          "ua","us","ve","za"]
let sortBy: [String] = [
    "relevancy",
    "popularity",
    "publishedAt"]
let modes: [String] = [
    topHeadlines,
    everything]
let topHeadlines = "top-headlines"
let everything = "everything"
let source = "sources"
func getSourcesURL(usrStr: Settings) -> URLRequest{
    let  urlObj = buildURL(seting: usrStr, urlPath: source)
    print(urlObj.absoluteURL)
    var request = URLRequest(url: urlObj)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "content-type")
    return request
}
func getDatafromNewAPI(usrStr: Settings,mode: String) -> URLRequest{
    let  urlObj = buildURL(seting: usrStr, urlPath: mode)
    print(urlObj.absoluteURL)
    var request = URLRequest(url: urlObj)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "content-type")
    return request
}
func buildURL(seting:Settings, urlPath : String) -> URL {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "newsapi.org"
    components.path = "/v2/\(urlPath)"
    components.queryItems = buildQuerry(set: seting,mode: urlPath)
    let url = components.url
    return url!;
}
func imageRequestURL(usrStr: String) -> URLRequest{
    let  urlObj = URL(string: usrStr)!
    var request = URLRequest(url: urlObj)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "content-type")
    return request
}
func buildQuerry(set:Settings, mode: String) -> [URLQueryItem] {
    var urlParm : [URLQueryItem] = []
    if set.sources.count == 0 {
        if set.country <= country.count && !country[set.country].isEmpty && mode == topHeadlines{
            var count = country[set.country]
            urlParm.append(URLQueryItem(name: "country", value: count))
        }
        if set.category <= category.count && !category[set.category].isEmpty && mode == topHeadlines{
            var count = category[set.category]
            urlParm.append(URLQueryItem(name: "category", value: count))
        }
    }

    if set.pagesize < 100 && set.pagesize >= 25 && mode != source{
        urlParm.append(URLQueryItem(name: "pageSize", value: String(Int(set.pagesize))))
    }

    if !set.search.isEmpty  && mode != source {
        urlParm.append(URLQueryItem(name: "q", value: set.search))
    }

    if set.search.isEmpty && mode == everything {
        urlParm.append(URLQueryItem(name: "q", value: "us"))
    }

    if set.sources.count > 0 && mode != source {
        var sors = set.sources.joined(separator: ",")
        urlParm.append(URLQueryItem(name: "sources", value: sors))
    }

    if set.lang <= language.count && mode == everything{
        urlParm.append(URLQueryItem(name: "language", value: language[set.lang]))
    }

    if set.sort <= sortBy.count && mode == everything {
        urlParm.append(URLQueryItem(name: "sortBy", value: sortBy[set.sort]))
    }

    urlParm.append(URLQueryItem(name: "apiKey", value: apikey))
    return urlParm;
}
func generateImageWithText(text: String) -> UIImage {
    let image = UIImage()
    let imageView = UIImageView(image: image)
    imageView.backgroundColor = UIColor.clear
    imageView.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
    label.backgroundColor = UIColor.clear
    label.textAlignment = .center
    label.textColor = UIColor.white
    label.text = text
    UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0)
    imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
    label.layer.render(in: UIGraphicsGetCurrentContext()!)
    let imageWithText = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return imageWithText!
}
extension UIImage {
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    func resizedTo1MB() -> UIImage? {
        guard let imageData = self.pngData() else {
            return nil
        }
        var resizingImage = self
        var imageSizeKB = Double(imageData.count) / 1000.0 // ! Or devide for 1024 if you need KB but not kB
        while imageSizeKB > 1000 {
            // ! Or use 1024 if you need KB but not kB
            guard let resizedImage = resizingImage.resized(withPercentage: 0.5),
            let imageData = resizedImage.pngData()
            else {
                return nil
            }
            resizingImage = resizedImage
            imageSizeKB = Double(imageData.count) / 5000.0 // ! Or devide for 1024 if you need KB but not kB
        }
        return resizingImage
    }

    func isEquals( image: UIImage) -> Bool {
        guard let data1: Data = self.pngData(),
        let data2: Data = image.pngData() else {
            return false
        }
        return data1.elementsEqual(data2)
    }

}
struct ActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }

}
func getFormattedDate(date: Date) -> String {
    let dateformat = DateFormatter()
    dateformat.dateFormat = "dd-MMM-yyyy"
    return dateformat.string(from: date)
}
func fillUpArticleToPersistance(art:Article,artPer:ArticleEntity) -> ArticleEntity {
    artPer.articleDescription = art.articleDescription;
    artPer.author = art.author;
    artPer.content = art.content;
    artPer.publishedAt = art.publishedAt;
    //    artPer.source = art.source ;
    artPer.title = art.title;
    artPer.url = art.url;
    artPer.urlToImage = art.urlToImage;
    return artPer;
}
func fileUpArticle(art:ArticleEntity) -> Article {
    return Article(source: nil, author:  art.author , title: art.title, articleDescription: art.articleDescription, url:  art.url , urlToImage: art.urlToImage, publishedAt: art.publishedAt, content: art.content);
}
func getTimeOutURL() -> URLSessionConfiguration{
    let sessionConfig = URLSessionConfiguration.default
    sessionConfig.timeoutIntervalForRequest = 10.0
    sessionConfig.timeoutIntervalForResource = 10.0
    return sessionConfig
}
func isConnectedToNetwork() -> Bool {
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
            zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }

    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
    }

    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    return (isReachable && !needsConnection)
}
func getErrorAlert(str:String)->GenearlRes{
    var resMsg = GenearlRes()
    resMsg.errors = str
    resMsg.result = "fail"
    return resMsg;
}

