//
//  Created by Tsimur Asayonak on 12/26/23.
//

import Foundation
import WorldOfPaybackAppModels
import WorldOfPaybackAppTransactionsFeature

extension ApiServiceKey {
    static var testValue: (_ throwError: Bool) -> any ApiServiceProtocol {
        return { throwError in
            throwError ? ApiServiceFailMock() : ApiServiceMock()
        }
    }
}

struct ApiServiceMock: ApiServiceProtocol {
    func getTransactionList() async throws -> [TransactionModel] {
        [TransactionModel.sut()]
    }
}

struct ApiServiceFailMock: ApiServiceProtocol {
    func getTransactionList() async throws -> [TransactionModel] {
        throw ErrorResponse.sut
    }
}
