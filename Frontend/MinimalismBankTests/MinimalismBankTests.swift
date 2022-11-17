//
// Created by Evhen Gruzinov on 16.11.2022.
//

import Foundation

import XCTest
@testable import MinimalismBank

final class NetworkQueriesTests: XCTestCase {
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
        testTransaction = Transaction(id: 4, userId: 1, accountId: 1, amount: 9900, title: "From: Tim Cook", dateStr: "2022-10-23 00:00:00", category: .transfer, type: .income, state: .performed)
    }

    override func tearDownWithError() throws {
        testUserId = nil
        accountBalance = nil
        transaction = nil
        userToken = nil
        try super.tearDownWithError()
    }

    func testCheckAccountToken() throws {
        NetworkManager().checkAccountToken(userToken: userToken!) { userId in
            if let userId = userId {
                self.userId = userId
            }
            self.expectationNetwork.fulfill()
        }
        wait(for: [expectationNetwork], timeout: 10.0)
        XCTAssertEqual(testUserId, userId)
    }

    func testGetAccountDataFromServer() throws {
        NetworkManager().getAccountData(userToken: userToken!, needBalance: true, needTransactions: true, transactionsCount: 1) { data in
            self.userId = data.userId
            self.accountBalance = data.balance
            self.transaction = data.transactions![0]
            self.expectationNetwork.fulfill()
        }
        wait(for: [expectationNetwork], timeout: 10.0)

        XCTAssertEqual(testUserId, userId)
        XCTAssertEqual(testAccountBalance, accountBalance)
        XCTAssertEqual(testTransaction, transaction)
    }
}

final class FormattingTests: XCTestCase {
    var testMoneyValue: Int?
    var testMoneyValueString: String?
    var testDateValueInNowYear: String?
    var testDateValueOutNowYear: String?
    var testDateValueInPastYear: String?
    var testDateValueOutPastYear: String?

    var moneyValueString: String?
    var dateValueOutNowYear: String?
    var dateValueOutPastYear: String?

    override func setUpWithError() throws {
        try super.setUpWithError()
        testMoneyValue = 1234
        testMoneyValueString = "$12.34"
        testDateValueInNowYear = "2022-11-11 12:34:56"
        testDateValueOutNowYear = "11 Nov"
        testDateValueInPastYear = "2011-11-11 12:34:56"
        testDateValueOutPastYear = "11 Nov 2011"
    }

    override func tearDownWithError() throws {
        testMoneyValue = nil
        testMoneyValueString = nil
        testDateValueInNowYear = nil
        testDateValueOutNowYear = nil
        testDateValueInPastYear = nil
        testDateValueOutPastYear = nil
        moneyValueString = nil
        dateValueOutNowYear = nil
        dateValueOutPastYear = nil
        try super.tearDownWithError()
    }

    func testIntToMoneyFormat() throws {
        moneyValueString = Formatting().intToMoneyFormat(from: testMoneyValue!)
        XCTAssertEqual(testMoneyValueString, moneyValueString)
    }
    func testStringToDateFormat() throws {
        dateValueOutNowYear = Formatting().stringToDateFormat(from: testDateValueInNowYear!)
        dateValueOutPastYear = Formatting().stringToDateFormat(from: testDateValueInPastYear!)
        XCTAssertEqual(dateValueOutNowYear, testDateValueOutNowYear)
        XCTAssertEqual(dateValueOutPastYear, testDateValueOutPastYear)
    }
}
