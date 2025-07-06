//
//  Created by Tsimur Asayonak on 12/27/23.
//

import XCTest
import WorldOfPaybackAppTransactionsFeature
import WorldOfPaybackAppCore
import WorldOfPaybackAppModels

final class ApiServiceTests: XCTestCase {
    var sut: ApiService!
    var apiProvider: ApiProvider!
    var urlSessionMock: URLSessionMock!

    override func setUp() {
        super.setUp()

        urlSessionMock = URLSessionMock()

        apiProvider = ApiProvider(
            buildConfiguration: BuildConfigurationProtocolMock(),
            urlSession: urlSessionMock,
            headersRequestDecorator: HeadersRequestDecoratorProtocolMock()
        )

        sut = ApiService(apiProvider: apiProvider)
    }

    func testGetTransactionListSuccess() async throws {
        let testDate = Date()

        urlSessionMock.data = try? TransactionListRequest.Response(
            items: [.sut()]
        ).toData(jsonEncoder: TransactionListRequest.getJSONEncoder())
        urlSessionMock.response = HTTPURLResponse.mock(200)

        let request = TransactionListRequest()
        let result = try await sut.apiProvider.get(apiRequest: request)

        XCTAssertEqual(result.items, [TransactionModel.sut()])
    }

    func testGetTransactionListError() async {
        var thrownError: ErrorResponse?
        let errorHandler = { thrownError = $0 }

        urlSessionMock.data = try? TransactionListRequest.Response(
            items: [.sut()]
        ).toData(jsonEncoder: JSONEncoder())
        urlSessionMock.response = HTTPURLResponse.mock(401)

        let request = TransactionListRequest()

        do {
            let result = try await sut.apiProvider.get(apiRequest: request)
        } catch {
            errorHandler(ErrorResponse.sut)
        }

        XCTAssertEqual(thrownError, ErrorResponse.sut)
    }
}

extension ApiService {
    static func sut() -> Self {
        .init(
            apiProvider: ApiProvider(
                buildConfiguration: BuildConfigurationProtocolMock(),
                urlSession: URLSessionMock(),
                headersRequestDecorator: HeadersRequestDecoratorProtocolMock()
            )
        )
    }
}
