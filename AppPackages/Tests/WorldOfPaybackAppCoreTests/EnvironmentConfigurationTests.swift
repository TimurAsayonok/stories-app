//
//  Created by Tsimur Asayonak on 12/26/23.
//

import XCTest
import WorldOfPaybackAppCore

final class EnvironmentConfigurationTests: XCTestCase {
    func testDevelopmentEnvironment() {
        let sut: EnvironmentConfiguration = .development
        
        XCTAssertEqual(sut, EnvironmentConfiguration(rawValue: sut.rawValue))
    }
    
    func testStagingEnvironment() {
        let sut: EnvironmentConfiguration = .staging
        
        XCTAssertEqual(sut, EnvironmentConfiguration(rawValue: sut.rawValue))
    }
    
    func testProductionEnvironment() {
        let sut: EnvironmentConfiguration = .production
        
        XCTAssertEqual(sut, EnvironmentConfiguration(rawValue: sut.rawValue))
    }
}
