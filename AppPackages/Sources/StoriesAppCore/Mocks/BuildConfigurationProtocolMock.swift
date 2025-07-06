import Foundation

#if DEBUG
public class BuildConfigurationProtocolMock: BuildConfigurationProtocol {
    public var apiBasedUrl: URL {
        URL(string: "")!
    }
    
    public init() {}
}
#endif
