import Foundation

extension Date {
    static func date(fromJSONString date: String?) -> Date? {
        guard let date = date else { return nil }
        return createFormatter().date(from: date)
    }
    
    static func string(from date: Date?) -> String {
        guard let date = date else { return "Unknown" }
        return createFormatter().string(from: date)
    }
    
    private static func createFormatter() -> DateFormatter {
        let dtFormat = DateFormatter()
        dtFormat.dateFormat = "yyyy-MM-dd"
        return dtFormat
    }
}
