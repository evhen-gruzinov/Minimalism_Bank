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
    var transactionsCount: Int = 0
    
    private enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case balance = "balance"
        case transactions = "transactions"
        case transactionsCount = "transactions_count"
    }
}
