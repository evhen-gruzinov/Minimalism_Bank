//
//  Account.swift
//  SimpleBank
//
//  Created by Evhen Gruzinov on 08.11.2022.
//

import Foundation
import Alamofire

struct Account: Codable {
    var userId: Int?
    var balance: Int?
    var transactions: [Transaction]?
    
    private enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case balance = "balance"
        case transactions = "transactions"
    }
}

extension Account {
    func checkToken(userToken: String, completion: @escaping(Int?) -> Void) { //,,
        let parameters: [String: Any] = [ "token": userToken ]
        AF.request("https://jfxfba.deta.dev/checkToken", method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseDecodable(of: Account.self) { response in
            if let value = response.value {
                completion(value.userId)
            }
        }
    }
    
    func getData(userToken: String, needBalance: Bool, needTransactions: Bool, transactionsCount: Int, completion: @escaping(Account)  -> Void) {
        
        let parameters: [String: Any] = [
            "token": userToken,
            "need_balance": needBalance,
            "need_transactions": needTransactions,
            "transactions_count": transactionsCount
        ]
        
        AF.request("https://jfxfba.deta.dev/getBalanceInfo", method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseDecodable(of: Account.self) { response in
            if let value = response.value {
                completion(value)
            }
        }
    }
}
