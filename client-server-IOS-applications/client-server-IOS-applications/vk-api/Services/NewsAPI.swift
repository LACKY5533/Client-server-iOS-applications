//
//  NewsAPI.swift
//  client-server-IOS-applications
//
//  Created by LACKY on 15.11.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

final class NewsAPI {

    let baseUrl = "https://api.vk.com/method"
    let token = Session.shared.token
    let userId = Session.shared.userId
    let version = "5.81"

    func getNews(completion: @escaping([News])->()) {

        let method = "/newsfeed.get"

        let parameters: Parameters = [
            "user_id": userId,
            "filters": "post",
            "count": 10,
            "access_token": token,
            "v": version
        ]

        let url = baseUrl + method

        AF.request(url, method: .get, parameters: parameters).responseJSON (completionHandler: { response in
            
            //Бинарник всего JSON
            guard let data = response.data else { return }
            //debugPrint(response.data?.prettyJSON as Any)

            do {

                //Подбинарник только items
                let itemsData = try JSON(data)["response"]["items"].rawData()
                let news = try JSONDecoder().decode([News].self, from: itemsData)
                
                completion(news)

            } catch {
                print(error.localizedDescription)
            }
        })
    }

}
