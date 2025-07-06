import Foundation

public struct LocalJSONLoader {
    public init() {}

    public func load<T: Decodable>(
        from fileName: String,
        as type: T.Type,
        bundle: Bundle = .main
    ) throws -> T {
        if let url = bundle.url(forResource: fileName, withExtension: "json") {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } else {
            throw NSError(domain: "LocalJSONLoader", code: 1, userInfo: [NSLocalizedDescriptionKey: "File not found"])
        }
    }
}
