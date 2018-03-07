import Foundation

protocol InitWithDataProtocol {
    init(data: Data?) throws
}

protocol InitWithJSONProtocol {
    init(json: Dictionary<String, Any>) throws
}

struct NetworkRequestError: Error {
    let error: Error?
    
    var localizedDescription: String {
        return error?.localizedDescription ?? "Request Error"
    }
}

struct ApiError: Error {
    let data: Data?
    let httpUrlResponse: HTTPURLResponse
}

struct ApiParseError: Error {
    static let code = 999
    
    let error: Error
    let httpUrlResponse: HTTPURLResponse
    let data: Data?
    
    var localizedDescription: String {
        return error.localizedDescription
    }
}

struct ApiResponse<T: InitWithDataProtocol> {
    let entity: T
    let httpUrlResponse: HTTPURLResponse
    let data: Data?
    
    init(data: Data?, httpUrlResponse: HTTPURLResponse) throws {
        do {
            self.entity = try T(data: data)
            self.httpUrlResponse = httpUrlResponse
            self.data = data
        } catch {
            throw ApiParseError(error: error, httpUrlResponse: httpUrlResponse, data: data)
        }
    }
}

extension Array: InitWithDataProtocol {
    init(data: Data?) throws {
        guard let data = data,
            let jsonObject = try? JSONSerialization.jsonObject(with: data),
            let jsonArray = jsonObject as? [[String: Any]] else {
                throw NSError.createPraseError()
        }
        
        guard let element = Element.self as? InitWithJSONProtocol.Type else {
            throw NSError.createPraseError()
        }
        
        self = try jsonArray.map( { return try element.init(json: $0) as! Element } )
    }
}

extension NSError {
    static func createPraseError() -> NSError {
        return NSError(domain: "com.lucas.UpMovie",
                       code: ApiParseError.code,
                       userInfo: [NSLocalizedDescriptionKey: "Error in Parser"])
    }
}

