//
//  Created by Tsimur Asayonak on 12/26/23.
//

import XCTest
import WorldOfPaybackAppModels

final class FilterTypeTests: XCTestCase {
    func testDateDescending() {
        let sut: FilterType = .byDate(.descending)
        
        XCTAssertEqual(sut, .byDate(.descending))
    }
    
    func testDateAscending() {
        let sut: FilterType = .byDate(.ascending)
        
        XCTAssertEqual(sut, .byDate(.ascending))
    }
    
    func testCategory() {
        let sut: FilterType = .category(1)
        
        XCTAssertEqual(sut, .category(1))
    }
}
