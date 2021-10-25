//
//  GroupsApi.swift
//  lesson-2
//
//  Created by LACKY on 20.10.2021.
//

import Foundation
import Alamofire


final class GroupsAPI {

    let baseUrl = "https://api.vk.com/method"
    let token = Session.shared.token
    let userId = Session.shared.userID
    let version = "5.81"

    func getGroups(completion: @escaping([Group])->()) {

        let method = "/groups.get"

        let parameters: Parameters = [
            "user_id": userId,
            "extended": 1,
            "count": 10,
            "access_token": token,
            "v": version
        ]

        let url = baseUrl + method

        AF.request(url, method: .get, parameters: parameters).responseJSON { response in

            guard let data = response.data else { return }
            debugPrint(response.data?.prettyJSON as Any)

            do {

                let groupsJSON = try JSONDecoder().decode(GroupsJSON.self, from: data)
                let groups: [Group] = groupsJSON.response.items
                completion(groups)

            } catch {
                print(error)
            }
        }
    }
}
