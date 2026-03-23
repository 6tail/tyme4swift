import Foundation

/// 事件管理器
public class EventManager {
    public static let CHARS: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTU_VWXYZabcdefghijklmnopqrstuvwxyz")
    public static var DATA: String = ""

    static func formatRegex(_ name: String) -> String {
        return "(@[0-9A-Za-z_]{8})(\(name))"
    }

    public static func remove(_ name: String) {
        guard let regex: NSRegularExpression = try? NSRegularExpression(pattern: formatRegex(name)) else { return }
        DATA = regex.stringByReplacingMatches(in: DATA, options: [], range: NSRange(location: 0, length: DATA.utf16.count), withTemplate: "")
    }

    private static func saveOrUpdate(_ name: String, _ data: String) {
        guard let regex: NSRegularExpression = try? NSRegularExpression(pattern: formatRegex(name)) else { return }
        if regex.firstMatch(in: DATA, range: NSRange(location: 0, length: DATA.utf16.count)) != nil {
            DATA = regex.stringByReplacingMatches(in: DATA, options: [], range: NSRange(location: 0, length: DATA.utf16.count), withTemplate: data)
        } else {
            DATA += data
        }
    }

    public static func update(_ name: String, _ event: Event) {
        saveOrUpdate(name, event.data + (event.name.isEmpty ? name : event.name))
    }

    public static func updateData(_ name: String, _ data: String) throws {
        try Event.validate(data)
        saveOrUpdate(name, data)
    }
}
