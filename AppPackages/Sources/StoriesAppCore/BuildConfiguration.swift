import Foundation

public protocol BuildConfigurationProtocol {
    var apiBasedUrl: URL { get }
}

public class BuildConfiguration: BuildConfigurationProtocol {
    public var apiBasedUrl: URL {
        URL(string: apiBasedURLStringL)! // swiftlint:disable:this force_unwrapping
    }
    
    public static let shared = BuildConfiguration()
    
    public var environment: EnvironmentConfiguration
    
    // Api URL based on Environment
    private var apiBasedURLStringL: String {
        switch environment {
        case .development, .staging:
            "https://api-test.payback.com"
        case .production:
            "https://api.payback.com"
        }
    }
    
    public init() {
        guard
            let currentConfiguration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String,
            let environment = EnvironmentConfiguration(rawValue: currentConfiguration)
        else {
            environment = .development
            
            return
        }
        
        self.environment = environment
    }
}

