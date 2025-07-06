//
//  Created by Tsimur Asayonak on 12/26/23.
//

import WorldOfPaybackAppCore
import XCTest

final class HTTPMethodTests: XCTestCase {
    func testAllCase() {
        let sut: [HTTPMethod] = [.get, .post, .put, .delete]
        
        sut.forEach {
            XCTAssertEqual($0, HTTPMethod(rawValue: $0.rawValue))
        }
    }
}
