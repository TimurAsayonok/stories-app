//
//  Created by Tsimur Asayonak on 12/26/23.
//

import ComposableArchitecture
import XCTest
import WorldOfPaybackAppComponents

@MainActor
final class MainToolbarStoreTests: XCTestCase {
    func testStore() async {
        let store = TestStore(initialState:  MainToolbarStore.State()) {
            MainToolbarStore()
        }
        
        // this action do nothing for the sate, because will be handled in parent store
        await store.send(.toolbarButtonPressed(.init(type: .refresh)))
    }
}
