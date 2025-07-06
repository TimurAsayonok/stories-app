//
//  Created by Tsimur Asayonak on 12/26/23.
//

import XCTest
import WorldOfPaybackAppModels

final class TransactionDetailTests: XCTestCase {
    func testAllValues() {
        let sut = TransactionDetail.sut()
        
        XCTAssertEqual(sut.description, "description")
        XCTAssertNotNil(sut.bookingDate)
        XCTAssertEqual(sut.value, TransactionValue.sut)
    }
}
