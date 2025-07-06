//
//  Created by Tsimur Asayonak on 12/26/23.
//

import WorldOfPaybackAppCore
import XCTest

final class HeadersRequestDecoratorTests: XCTestCase {
    var sut: HeadersRequestDecoratorProtocolMock!
    
    override func setUp() {
        super.setUp()
        
        sut = HeadersRequestDecoratorProtocolMock()
    }
    
    func testInit() {
        XCTAssertNotNil(sut)
    }
    
    func testMustDecorateWithHeaders() {
        let url = URL.mock
        var urlRequest = URLRequest(url: url)
        
        XCTAssertNil(urlRequest.allHTTPHeaderFields)
        
        sut.decorate(urlRequest: &urlRequest)
        
        let headers = urlRequest.allHTTPHeaderFields
        if let headers {
            XCTAssertEqual(Array(headers.keys), [HeaderRequestKey.xAuthorization.rawValue])
            XCTAssertEqual(headers[HeaderRequestKey.xAuthorization.rawValue], "Bearer Token")
        }
    }
}
