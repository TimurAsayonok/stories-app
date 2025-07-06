//
//  Created by Tsimur Asayonak on 12/26/23.
//

import ComposableArchitecture
import WorldOfPaybackAppTransactionsFeature
import WorldOfPaybackAppModels
import XCTest

@MainActor
final class TransactionDetailsStoreTests: XCTestCase {
    func testStore() async {
        let state = TransactionDetailsStore.State(transaction: TransactionModel.sut())
        let store = TestStore(initialState: state) {
            TransactionDetailsStore()
        }
        
        XCTAssertNotNil(store.state.transaction)
    }
}
