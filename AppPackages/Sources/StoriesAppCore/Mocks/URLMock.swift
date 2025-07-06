import Foundation

#if DEBUG
public extension URL {
    static var mock: Self {
        URL(string: "www://url.com")!
    }
}
#endif
