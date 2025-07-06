//
//  Created by Tsimur Asayonak on 12/26/23.
//

import ComposableArchitecture
import WorldOfPaybackAppWelcomeFeature
import XCTest

@MainActor
final class WelcomeStoreTests: XCTestCase {
    func testStore() async {
        let store = TestStore(initialState: WelcomeStore.State()) {
            WelcomeStore()
        }
        
        // this action do nothing for the sate, because will be handled in parent store
        await store.send(.loginTapped)
    }
}
