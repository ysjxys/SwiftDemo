import Foundation

public enum JSON {
    case array([JSON])
    case object([String: JSON])
    case string(String)
    case number(NSNumber)
    case bool(Bool)
    case null
}

public extension JSON {
    init(_ json: Any) {
        switch json {
        case let value as [Any]:
            self = .array(value.map(JSON.init))
        case let value as [String: Any]:
            self = .object(value.map(JSON.init))
        case let value as String:
            self = .string(value)
        case let value as NSNumber:
            if value.isBool() {
                self = .bool(value.boolValue)
            } else {
                self = .number(value)
            }
        default:
            self = .null
        }
    }
}

extension JSON: Equatable {
    public static func == (l: JSON, r: JSON) -> Bool {
        switch (l, r) {
        case let (.array(l), .array(r)): return l == r
        case let (.object(l), .object(r)): return l == r
        case let (.string(l), .string(r)): return l == r
        case let (.number(l), .number(r)): return l == r
        case let (.bool(l), .bool(r)): return l == r
        case (.null, .null): return true
        default: return false
        }
    }
}


internal extension Dictionary {
    func map<T>(_ f: (Value) -> T) -> [Key: T] {
        var acc = Dictionary<Key, T>(minimumCapacity: count)
        
        for (key, value) in self {
            acc[key] = f(value)
        }
        
        return acc
    }
}


extension NSNumber {
    func isBool() -> Bool {
        return type(of: self) == type(of: NSNumber(value: true))
    }
}
