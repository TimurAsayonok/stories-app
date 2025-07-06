//
//  Created by Tsimur Asayonak on 12/26/23.
//

import XCTest
import SwiftUI
import WorldOfPaybackAppModels

final class ToolbarButtonTests: XCTestCase {
    func testAllValues() {
        let testID = UUID(uuidString: "1111111")
        let sut = ToolbarButton.sut(id: testID, type: .filter)
        
        XCTAssertEqual(sut.uuid, testID)
        XCTAssertEqual(sut.type, .filter)
    }
    
    func testFilterButtonType() {
        let sut = ToolbarButton(type: .filter)
        
        XCTAssertEqual(sut.type, .filter)
        XCTAssertEqual(sut.type?.getIcon(), Image(systemName: "slider.horizontal.3"))
    }
    
    func testRefreshButtonType() {
        let sut = ToolbarButton(type: .refresh)
        
        XCTAssertEqual(sut.type, .refresh)
        XCTAssertEqual(sut.type?.getIcon(), Image(systemName: "arrow.clockwise"))
    }
}

extension ToolbarButton {
    static func sut(id: UUID? = UUID(), type: ButtonType) -> Self {
        .init(uuid: id, type: type)
    }
}
