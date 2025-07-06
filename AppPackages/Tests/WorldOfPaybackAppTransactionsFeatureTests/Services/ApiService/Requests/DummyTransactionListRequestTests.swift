//
//  Created by Tsimur Asayonak on 12/26/23.
//

import XCTest
import WorldOfPaybackAppTransactionsFeature
import WorldOfPaybackAppModels

final class DummyTransactionListRequestTests: XCTestCase {
    var sut: DummyTransactionListRequest!
    
    override func setUp() {
        super.setUp()
        
        sut = DummyTransactionListRequest()
    }
    
    func testMustInit() {
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.path, "/")
    }
    
    func testMustHaveCorrectResponse() {
        XCTAssertEqual("\(type(of: sut).Response.self)", "\([TransactionModel].self)")
    }
    
    func testMustHaveCorrectError() {
        XCTAssertEqual("\(type(of: sut).Error.self)", "\(ErrorResponse.self)")
    }
}
