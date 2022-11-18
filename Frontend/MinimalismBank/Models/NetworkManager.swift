//
//  NetworkManager.swift
//  SimpleBank
//
//  Created by Evhen Gruzinov on 17.11.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    func checkAccountToken(userToken: String, completion: @escaping(Int?) -> Void) { //,,
        let parameters: [String: Any] = [ "token": userToken ]
        AF.request("https://jfxfba.deta.dev/checkToken", method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseDecodable(of: Account.self) { response in
            if let value = response.value {
                completion(value.userId)
            }
        }
    }
    
    func getAccountData(userToken: String, needBalance: Bool, needTransactions: Bool, transactionsCount: Int, completion: @escaping(Account)  -> Void) {
        
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
