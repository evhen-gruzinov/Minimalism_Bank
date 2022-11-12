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
    
    var testAccountBalance: Int?
    var testTransaction: Transaction?
    
    var accountBalance: Int?
    var transaction: Transaction?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        userToken = "PRv7xXESmpRdr8"
        testAccountBalance = 567855
        testTransaction = Transaction(id: 4, userId: 1, accountId: 1, amount: 9900, title: "From: Tim Cook", dateStr: "2022-10-23", category: .transfer, type: .income, state: .performed)
    }

    override func tearDownWithError() throws {
        accountBalance = nil
        transaction = nil
        userToken = nil
        try super.tearDownWithError()
    }

    func testGetAccountDataFromServer() throws {
        Account().getData(userToken: userToken!, needBalance: true, needTransactions: true, transactionsCount: 1) { data in
            self.accountBalance = data.balance
            self.transaction = data.transactions![0]
            self.expectationNetwork.fulfill()
        }
        wait(for: [self.expectationNetwork], timeout: 10.0)
        
        XCTAssertEqual(self.testAccountBalance, self.accountBalance)
        XCTAssertEqual(self.testTransaction, self.transaction)
    }
}
