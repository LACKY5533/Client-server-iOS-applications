//
//  PhotoAPI.swift
//  lesson-2
//
//  Created by LACKY on 20.10.2021.
//

import Foundation
import Alamofire

struct Photo {

}

final class PhotosAPI {

    let baseUrl = "https://api.vk.com/method"
    let token = Session.shared.token
    let userId = Session.shared.userID
    let version = "5.81"

    func getPhotos(completion: @escaping([Photo])->()) {

        let method = "/photos.get"

        let parameters: Parameters = [
            "owner_id": userId,
            "album_id": "profile",
            "extended": 1,
            "photos_sizes": 1,
            "count": 10,
            "access_token": token,
            "v": version
        ]

        let url = baseUrl + method

        AF.request(url, method: .get, parameters: parameters).responseJSON { response in

            print(response.value!)
        }
    }
}
