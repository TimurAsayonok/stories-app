//
//  Created by Tsimur Asayonak on 12/26/23.
//

import XCTest
import WorldOfPaybackAppModels

final class CurrencyTests: XCTestCase {
    func testCurrency() {
        let sut: Currency = .PBP
        
        XCTAssertEqual(sut, .PBP)
    }
}
