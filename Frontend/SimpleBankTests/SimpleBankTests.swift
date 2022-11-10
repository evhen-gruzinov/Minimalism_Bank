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
    var testAccountBalance: Int?
    var testTransaction: Transaction?
    
    var accountBalance: Int?
    var transaction: Transaction?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        testAccountBalance = 567855
        testTransaction = Transaction(id: 4, userId: 1, accountId: 1, amount: 9900, title: "From: Tim Cook", dateStr: "2022-10-23", category: .transfer, type: .income, state: .performed)
    }

    override func tearDownWithError() throws {
        accountBalance = nil
        transaction = nil
        try super.tearDownWithError()
    }

    func testGetAccountBalanceFromServer() throws {
        Account().getBalance { balance in
            self.accountBalance = balance
            self.expectationNetwork.fulfill()
        }
        wait(for: [self.expectationNetwork], timeout: 10.0)
        XCTAssertEqual(self.testAccountBalance, self.accountBalance)
    }
    func testGetAccounTransactionFromServer() throws {
        Account().getTransactions(count: 1, completion: { transactions in
            self.transaction = transactions[0]
            self.expectationNetwork.fulfill()
        })
        wait(for: [self.expectationNetwork], timeout: 10.0)
        XCTAssertEqual(self.testTransaction, self.transaction)
    }

}
