//
//  UserData.swift
//  SimpleBank
//
//  Created by Evhen Gruzinov on 08.11.2022.
//

import Foundation
import Alamofire

struct UserData {
    let userToken = "PRv7xXESmpRdr8"
    //let userId = 1
    
    func getAccountBalance(completion: @escaping (Int) -> Void) {
        let parameters: [String: Any] = [
            "token": userToken
        ]
                
        AF.request("https://3qm4q3.deta.dev/getbalance",
                   method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseDecodable(of: Balance.self) { response in
            switch response.result {
            case .success(let value):
                completion(value.accountBalance)
            case let .failure(error):
                print(error)
            }
        }
    }
}

struct Balance: Codable {
    let accountBalance: Int
    
    enum CodingKeys: String, CodingKey {
        case accountBalance = "balance"
    }
}
