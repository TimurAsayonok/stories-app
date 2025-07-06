//
//  Created by Tsimur Asayonak on 12/27/23.
//

import ComposableArchitecture
import TCACoordinators
import WorldOfPaybackAppCoordinator
import WorldOfPaybackAppModelsTests
import WorldOfPaybackAppTransactionsFeature
import WorldOfPaybackAppWelcomeFeature
import XCTest

@MainActor
final class CoordinatorTests: XCTestCase {
    
    func testCoordinatorReducer() async {
        let store = TestStore(
            initialState: Coordinator.State(
                routes: [.root(.welcome(.init()), embedInNavigationView: true)]
            )
        ) {
            Coordinator()
        }
        
        // to test properly we need first to change Parent State and after call Action from Parent to the child
        var storeRoutes = store.state.routes
        storeRoutes.append(.push(.transactionsList(TransactionListStore.State())))
        await store.send(.updateRoutes(storeRoutes)) {
            $0.routes = storeRoutes
        }
        storeRoutes.append(.push(.transactionItemDetails(TransactionDetailsStore.State(transaction: .sut()))))
        await store.send(.routeAction(1, action: .transactionsList(.transactionItemTapped(.sut())))) {
            $0.routes = storeRoutes
        }
    }
}
