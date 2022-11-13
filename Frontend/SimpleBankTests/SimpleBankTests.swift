//
//  SimpleBankTests.swift
//  SimpleBankTests
//
//  Created by Evhen Gruzinov on 10.11.2022.
//

import XCTest
@testable import SimpleBank

final class SimpleBankTests: XCTestCase {
    let expectationNetwork = XCTestExpectation(description: "Getting data from server.")
    var userToken: String?
    
    var testUserId: Int?
    var testAccountBalance: Int?
    var testTransaction: Transaction?
    
    var userId: Int?
    var accountBalance: Int?
    var transaction: Transaction?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        userToken = "PRv7xXESmpRdr8"
        testUserId = 1
        testAccountBalance = 567855
        testTransaction = Transaction(id: 4, userId: 1, accountId: 1, amount: 9900, title: "From: Tim Cook", dateStr: "2022-10-23", category: .transfer, type: .income, state: .performed)
    }
    override func tearDownWithError() throws {
        testUserId = nil
        accountBalance = nil
        transaction = nil
        userToken = nil
        try super.tearDownWithError()
    }
    func testCheckAccountToken() throws {
        Account().checkToken(userToken: userToken!) { userId in
            if let userId = userId {
                self.userId = userId
            }
            self.expectationNetwork.fulfill()
        }
        wait(for: [self.expectationNetwork], timeout: 10.0)
        XCTAssertEqual(self.testUserId, self.userId)
    }
    func testGetAccountDataFromServer() throws {
        Account().getData(userToken: userToken!, needBalance: true, needTransactions: true, transactionsCount: 1) { data in
            self.userId = data.userId
            self.accountBalance = data.balance
            self.transaction = data.transactions![0]
            self.expectationNetwork.fulfill()
        }
        wait(for: [self.expectationNetwork], timeout: 10.0)
        XCTAssertEqual(self.testUserId, self.userId)
        XCTAssertEqual(self.testAccountBalance, self.accountBalance)
        XCTAssertEqual(self.testTransaction, self.transaction)
    }
}
