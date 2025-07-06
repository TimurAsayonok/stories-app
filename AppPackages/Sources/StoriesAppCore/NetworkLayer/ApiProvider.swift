import Foundation
import WorldOfPaybackAppModels

public protocol ApiProviderProtocol {
    var basedUrl: URL { get }
    
    func send<T: RequestProtocol>(apiRequest: T, method: HTTPMethod) async throws -> T.Response
}

// realization of the main HTTP requests
public extension ApiProviderProtocol {
    func get<T: RequestProtocol>(apiRequest: T) async throws -> T.Response {
        return try await send(apiRequest: apiRequest, method: .get)
    }
    
    func post<T: RequestProtocol>(apiRequest: T) async throws -> T.Response {
        return try await send(apiRequest: apiRequest, method: .post)
    }
    
    func put<T: RequestProtocol>(apiRequest: T) async throws -> T.Response {
        return try await send(apiRequest: apiRequest, method: .put)
    }
    
    func delete<T: RequestProtocol>(apiRequest: T) async throws -> T.Response {
        return try await send(apiRequest: apiRequest, method: .delete)
    }
}

public class ApiProvider: ApiProviderProtocol {
    public var basedUrl: URL {
        buildConfiguration.apiBasedUrl
    }
    
    private let buildConfiguration: BuildConfigurationProtocol
    private let urlSession: URLSession
    private let headersRequestDecorator: HeadersRequestDecoratorProtocol
    
    public init(
        buildConfiguration: BuildConfigurationProtocol = BuildConfiguration.shared,
        urlSession: URLSession = URLSession(configuration: .default),
        headersRequestDecorator: HeadersRequestDecoratorProtocol = HeadersRequestDecorator()
    ) {
        self.buildConfiguration = buildConfiguration
        self.urlSession = urlSession
        self.headersRequestDecorator = headersRequestDecorator
    }
    
    /// Sends Api request to the server and returns data
    public func send<T: RequestProtocol>(apiRequest: T, method: HTTPMethod) async throws -> T.Response {
        var urlRequest: URLRequest
        
        do {
            urlRequest = try apiRequest.buildRequest(with: basedUrl, method: method)
            headersRequestDecorator.decorate(urlRequest: &urlRequest)
        } catch {
            print("🐞", type(of: self), "->", error)
            throw error
        }
        
        let session = urlSession
        return try await withCheckedThrowingContinuation { continuation in
            let dataTask = session.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    if let urlError = error as? URLError {
                        continuation.resume(with: .failure(ErrorResponse(message: urlError.localizedDescription)))
                    } else {
                        continuation.resume(with: .failure(error))
                    }
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    do {
                        if 200..<300 ~= httpResponse.statusCode {
                            let model = try T.getJSONDecoder().decode(T.Response.self, from: data ?? Data())
                            
                            continuation.resume(with: .success(model))
                        } else {
                            let errorMessage = try T.getJSONDecoder().decode(T.Error.self, from: data ?? Data())
                            
                            continuation.resume(with: .failure(errorMessage))
                        }
                    } catch {
                        continuation.resume(with: .failure(error))
                    }
                }
            }
            
            dataTask.resume()
        }
    }
}
