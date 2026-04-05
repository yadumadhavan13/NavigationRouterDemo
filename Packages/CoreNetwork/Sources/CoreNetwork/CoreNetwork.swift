import Foundation

public actor APIClient {
    public init () {}
    public func request<T: Decodable & Sendable>(url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try await MainActor.run {
            try JSONDecoder().decode(T.self, from: data)
        }
    }
}
