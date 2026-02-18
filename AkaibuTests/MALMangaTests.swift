//
//  MALMangaTests.swift
//  AkaibuTests
//
//  Created by kite1412 on 18/02/26.
//

import XCTest
@testable import Akaibu

final class MALMangaTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMangaDetail() async throws {
        let dataSource = await MALMangaDataSource()
        let res = try await dataSource.fetchMangaDetail(mangaId: 21)
        
        print(res)
    }
}
