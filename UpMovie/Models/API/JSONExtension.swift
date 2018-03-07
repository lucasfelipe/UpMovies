import Foundation

public extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any  {
    public func toJsonData() -> Data {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: [])
        } catch {
            return Data()
        }
    }
}

public extension Array where Element: Any {
    public func toJsonData() -> Data {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: [])
        } catch {
            return Data()
        }
    }
}
