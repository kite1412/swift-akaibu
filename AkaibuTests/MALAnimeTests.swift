//
//  MALAnimeTests.swift
//  AkaibuTests
//
//  Created by kite1412 on 02/01/26.
//

import XCTest
@testable import Akaibu

final class MALAnimeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // the device running this test must be logged in
    func testAnimeRankingPagination() async throws {
        let dataSource = await MALAnimeDataSource()
        let res = try await dataSource.fetchAnimeBases(title: "One")
        
        XCTAssertNotNil {
            await res.next
        }
        
        if let next = await res.next {
            XCTAssertNoThrow {
                try await next()
            }
        }
        let res2 = try await res.next!()
        
        XCTAssertNotNil(res2)
        
        let res3 = try await res2!.next!()
        
        XCTAssertNotNil(res3)
        
        let first = await res.data.first!.title
        let second = await res2!.data.first!.title
        let third = await res3!.data.first!.title
        
        print(first, second, third)
        XCTAssert(first != second)
        XCTAssert(first != third)
        XCTAssert(second != third)
    }
}
