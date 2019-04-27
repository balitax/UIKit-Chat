//  
//  ChatService.swift
//  Agus Cahyono
//
//  Created by Agus Cahyono on 27/04/19.
//  Copyright © 2019 Agus Cahyono. All rights reserved.
//

import Foundation
import Alamofire

class ChatService: ChatServiceProtocol {
    // Call protocol function

    func removeThisFuncName(success: @escaping(_ data: ChatModel) -> (), failure: @escaping() -> ()) {

        let url = ""

        APIManager.request(
            url,
            method: .get,
            parameters: [:],
            encoding: URLEncoding.default,
            headers: [:],
            completion: { data in
                
                // mapping data
                do {
                    let decoded = try JSONDecoder().decode(ChatModel.self, from: data)
                    success()
                } catch _ {
                    failure()
                }
                
        }) { errorMsg, errorCode in
            failure()
        }

    }

}
