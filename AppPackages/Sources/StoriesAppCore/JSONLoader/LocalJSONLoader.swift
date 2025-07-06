import Foundation

public struct LocalJSONLoader {
    public init() {}

    public func load<T: Decodable>(from fileName: String, as type: T.Type) -> T? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
        }
        return decoded
    }
}
