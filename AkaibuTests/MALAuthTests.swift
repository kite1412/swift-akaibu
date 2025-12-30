//
//  MALAuthTests.swift
//  AkaibuTests
//
//  Created by kite1412 on 28/12/25.
//

import XCTest
@testable import Akaibu

final class MALAuthTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExchangeCode() async {
        let client = await MALAuthDataSource()
        
        do {
            _ = try await client.exchangeCode("no code")
        } catch is URLError {
            print("Failed succesfully")
            XCTAssert(true, "Failed successfully")
        } catch {
            XCTAssert(false)
        }
    }

}
