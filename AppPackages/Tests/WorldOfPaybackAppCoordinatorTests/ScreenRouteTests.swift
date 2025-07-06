//
//  Created by Tsimur Asayonak on 12/26/23.
//

import ComposableArchitecture
import WorldOfPaybackAppCoordinator
import WorldOfPaybackAppTransactionsFeature
import WorldOfPaybackAppWelcomeFeature
import XCTest

@MainActor
final class ScreenRouteTests: XCTestCase {
    func testScreenReducer() {
        let screenRoute: [ScreenRoute.State] = [
            .transactionItemDetails(TransactionDetailsStore.State(transaction: .sut())),
            .transactionsList(TransactionListStore.State()),
            .welcome(WelcomeStore.State())
        ]
        
        XCTAssertEqual(screenRoute.count, ScreenRoute.State.allCases.count)
    }
}

extension ScreenRoute.State: CaseIterable {
    public static var allCases: [ScreenRoute.State] = [
        .transactionItemDetails(TransactionDetailsStore.State(transaction: .sut())),
        .transactionsList(TransactionListStore.State()),
        .welcome(WelcomeStore.State())
    ]
}
