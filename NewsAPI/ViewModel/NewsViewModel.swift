//
//  NewsViewModel.swift
//  NewsAPI
//
//  Created by ? on 15/04/21.
//

import Foundation
import Combine
import SwiftyJSON

class NewsViewModel: ObservableObject {
    @Published var data = [News]()
    
    init(){
        let url = "-----API KEY-----"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!){ ( data, _, error) in
            // If error......
            if error != nil{
                print((error?.localizedDescription)!)
                return
            }
            
            let json = try! JSON(data : data!)
            let items = json["articles"].array!
            
            for i in items {
                let title = i["title"].stringValue
                let description = i["description"].stringValue
                let image = i["urlToImage"].stringValue
                
                DispatchQueue.main.async {
                    self.data.append(News(title: title, image: image, description: description))
                }
            }
        }.resume()
    }
}
