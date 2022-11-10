//
//  Account.swift
//  SimpleBank
//
//  Created by Evhen Gruzinov on 08.11.2022.
//

import Foundation
import Alamofire

class Account: ObservableObject {
    let userToken = "PRv7xXESmpRdr8"
}

struct Balance: Codable {
    let accountBalance: Int
    
    private enum CodingKeys: String, CodingKey {
        case accountBalance = "balance"
    }
}

extension Account {
    func getBalance(completion: @escaping (Int) -> Void) {
        let parameters: [String: Any] = [
            "token": userToken
        ]
                
        AF.request("https://jfxfba.deta.dev/getbalance",
                   method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseDecodable(of: Balance.self) { response in
            switch response.result {
            case .success(let value):
                completion(value.accountBalance)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getTransactions(count: Int, completion: @escaping (Array<Transaction>) -> Void) {
        let parameters: [String: Any] = [
            "token": userToken,
            "count": count
        ]
                
        AF.request("https://jfxfba.deta.dev/gettransactions",
                   method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseDecodable(of: [Transaction].self) { response in
            switch response.result {
            case .success(let value):
                completion(value)
            case let .failure(error):
                print(error)
            }
        }
    }
}
