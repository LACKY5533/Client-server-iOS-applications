//
//  GroupsApi.swift
//  lesson-2
//
//  Created by LACKY on 20.10.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

final class GroupsAPI {

    let baseUrl = "https://api.vk.com/method"
    let token = Session.shared.token
    let userId = Session.shared.userId
    let version = "5.81"

    func getGroups(completion: @escaping([Group])->()) {

        let method = "/groups.get"

        let parameters: Parameters = [
            "user_id": userId,
            "extended": 1,
            "count": 100,
            "access_token": token,
            "v": version
        ]

        let url = baseUrl + method

        AF.request(url, method: .get, parameters: parameters).responseJSON { response in

            guard let data = response.data else { return }
            //debugPrint(response.data?.prettyJSON as Any)

            do {

                let itemsData = try JSON(data)["response"]["items"].rawData()
                let groups = try JSONDecoder().decode([Group].self, from: itemsData)
                
                completion(groups)

            } catch {
                print(error)
            }
        }
    }
}
