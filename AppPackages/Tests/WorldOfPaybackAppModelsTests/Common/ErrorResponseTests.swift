//
//  Created by Tsimur Asayonak on 12/26/23.
//

import XCTest
import WorldOfPaybackAppModels

final class ErrorResponseTests: XCTestCase {
    func testMustInitWithAllValues() {
        let sut = ErrorResponse.sut
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut.message)
    }
}
