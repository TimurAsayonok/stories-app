//
//  Created by Tsimur Asayonak on 12/26/23.
//

import XCTest
import WorldOfPaybackAppModels

final class TransactionResponseTests: XCTestCase {
    func testAllValues() {
        let sut = TransactionResponse.sut()
        
        XCTAssertNotNil(sut.items)
        XCTAssertEqual(sut.items?.count, 2)
        
        sut.items?.forEach({
            XCTAssertEqual($0, TransactionModel.sut())
        })
    }
}

extension TransactionResponse {
    static func sut() -> Self {
        .init(
            items: [.sut(), .sut()]
        )
    }
}

