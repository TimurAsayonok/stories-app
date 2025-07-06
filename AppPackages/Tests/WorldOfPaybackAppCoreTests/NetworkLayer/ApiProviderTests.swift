//
//  Created by Tsimur Asayonak on 12/26/23.
//

import WorldOfPaybackAppCore
import XCTest

final class ApiProviderTests: XCTestCase {
    var sut: ApiProvider!
    var buildConfigurationMock: BuildConfigurationProtocolMock!
    var urlSessionMock: URLSessionMock!
    var headersRequestDecoratorMock: HeadersRequestDecoratorProtocolMock!

    override func setUpWithError() throws {
        buildConfigurationMock = BuildConfigurationProtocolMock()
        urlSessionMock = URLSessionMock()
        headersRequestDecoratorMock = HeadersRequestDecoratorProtocolMock()
        
        sut = ApiProvider(
            buildConfiguration: buildConfigurationMock,
            urlSession: urlSessionMock,
            headersRequestDecorator: headersRequestDecoratorMock
        )
    }
    
    func testMustInit() {
        XCTAssertNotNil(sut)
    }
    
    func testMustReturnBaseUrl() {
        XCTAssertEqual(sut.basedUrl, buildConfigurationMock.apiBasedUrl)
    }
    
    func testMustSuccess() async throws {
        urlSessionMock.data = try? TestResponseMock(id: "id").toData(jsonEncoder: JSONEncoder())
        urlSessionMock.response = HTTPURLResponse.mock(200)
        let request = TestRequestMock(string: "String")
        let result = try await sut.send(apiRequest: request, method: .get)
        
        XCTAssertNoThrow(result)
        XCTAssertEqual(result, TestResponseMock(id: "id"))
    }
    
    func testMustFailWithError() async {
        var thrownError: TestErrorMock?
        let errorHandler = { thrownError = $0 }
        
        urlSessionMock.error = TestRequestMock.Error()
        let request = TestRequestMock(string: "String")
        
        do {
            let result = try await sut.send(apiRequest: request, method: .get)
        } catch {
            errorHandler(error as? TestErrorMock)
        }
        
        if let error = thrownError {
            XCTAssertEqual(error, TestErrorMock())
        }
    }
    
    func testMustFailWithStatusCode401() async {
        var thrownError: TestErrorMock?
        let errorHandler = { thrownError = $0 }
        
        urlSessionMock.data = try? TestRequestMock.Error().toData(jsonEncoder: JSONEncoder())
        urlSessionMock.response = HTTPURLResponse.mock(401)
        let request = TestRequestMock(string: "String")
        
        do {
            let result = try await sut.send(apiRequest: request, method: .get)
        } catch {
            errorHandler(error as? TestErrorMock)
        }

        if let error = thrownError {
            XCTAssertEqual(error, TestErrorMock())
        }
    }
}
