import Foundation

public protocol INetworkService {
    func perform<T: Codable>(
        _ request: INetworkRequest
    ) async throws -> T
    func perform(
        _ request: INetworkRequest
    ) async throws -> Data
    func perform(
        urlRequest: URLRequest
    ) async throws -> Data?
}

public final class NetworkService: INetworkService {
    private let session: URLSession
    private let requestBuilder: URLRequestBuilder

    public init(session: URLSession, baseURL: URL) {
        self.session = session
        requestBuilder = URLRequestBuilder(baseURL: baseURL)
    }

    public func perform<T: Codable>(_ request: INetworkRequest) async throws -> T {
        let urlRequest = requestBuilder.build(forReuqest: request)
        let data = try await perform(urlRequest: urlRequest)

        guard let data = data else {
            throw HTTPNetworkServiceError.noData
        }
        do {
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        } catch {
            throw HTTPNetworkServiceError.failedToDecodeResponse(error)
        }
    }

    public func perform(_ request: INetworkRequest) async throws -> Data {
        let urlRequest = requestBuilder.build(forReuqest: request)
        let data = try await perform(urlRequest: urlRequest)

        guard let data = data else {
            throw HTTPNetworkServiceError.noData
        }
        return data
    }

    public func perform(urlRequest: URLRequest) async throws -> Data? {
        let (data, response) = try await session.data(for: urlRequest)
        let networkResponse = try NetworkResponse(data: data, urlResponse: response)
        return try networkResponse.getData()
    }
}
