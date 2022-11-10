//
//  Transaction.swift
//  SimpleBank
//
//  Created by Evhen Gruzinov on 09.11.2022.
//

import Foundation

struct Transaction: Codable, Identifiable, Equatable {
    let id: Int
    let userId: Int
    let accountId: Int
    let amount: Int
    let title: String
    let dateStr: String
    let category: TransactionCategory?
    let type: TransactionType?
    let state: TransactionState?
    

    private enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case accountId = "account_id"
        case amount
        case title
        case dateStr = "date"
        case category
        case type
        case state
    }
}


enum TransactionCategory: String, Codable {
    case shoping = "shoping"
    case grocery = "grocery"
    case restaurants = "restaurants"
    case electronic = "electronic"
    case household = "household"
    case cellular = "cellular"
    case beauty = "beauty"
    case health = "health"
    case auto = "auto"
    
    case salary = "salary"
    case transfer = "transfer"
    case unknown = "unknown"
}

enum TransactionType: String, Codable {
    case income = "income"
    case outcome = "outcome"
}
enum TransactionState: String, Codable {
    case inprogress = "inprogress"
    case performed = "performed"
    case rejected = "rejected"
}
