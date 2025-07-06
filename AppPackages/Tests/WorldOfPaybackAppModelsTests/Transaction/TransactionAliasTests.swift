//
//  Created by Tsimur Asayonak on 12/26/23.
//

import XCTest
import WorldOfPaybackAppModels

final class TransactionAliasTests: XCTestCase {
    func testAllValues() {
        let sut = TransactionAlias(reference: "reference")
        
        XCTAssertEqual(sut.reference, "reference")
    }
}
