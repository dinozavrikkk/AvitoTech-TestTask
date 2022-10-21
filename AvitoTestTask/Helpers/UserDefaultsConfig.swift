//
//  UserDefaults + config.swift
//  AvitoTestTask
//
//  Created by admin on 20.10.2022.
//

import Foundation

class UserDefaultsConfig: NSObject {
    static var defaults: UserDefaultsConfig {
        return UserDefaultsConfig()
    }

    @UserDefault("cacheEmployee", defaultValue: nil, encodeAsJSON: true)
    public var cacheEmployee: EmployeeListModel?
    
    @UserDefault("timeTracker", defaultValue: Date())
    public var timeTracker: Date
}

@propertyWrapper
public struct UserDefault<T> {
    let key: String
    let defaultValue: T
    let notificationName: Notification.Name?
    let encodeAsJSON: Bool
    let userDefaults = UserDefaults.standard

    public init(_ key: String, defaultValue: T, notificationName: Notification.Name? = nil, encodeAsJSON: Bool = false) {
        self.key = key
        self.defaultValue = defaultValue
        self.notificationName = notificationName
        self.encodeAsJSON = encodeAsJSON
    }

    public var wrappedValue: T {
        get {
            if self.encodeAsJSON,
                let data = self.userDefaults.object(forKey: self.key) as? Data,
                T.self is Codable.Type {

                let value = T.self as! Decodable.Type

                if let object = value.object(from: data) as? T {
                    return object
                }

                return self.defaultValue

            } else {
                return self.userDefaults.object(forKey: self.key) as? T ?? self.defaultValue
            }
        }
        set {
            defer {
                if let notificationName = self.notificationName {
                    NotificationCenter.default.post(name: notificationName, object: UserDefaults.standard)
                }
            }

            if let value = newValue as? OptionalProtocol, value.isNil() {
                UserDefaults.standard.removeObject(forKey: key)
                return
            }

            if self.encodeAsJSON, let value = newValue as? Codable {
                let data = value.jsonData()
                self.userDefaults.set(data, forKey: key)
            } else {
                self.userDefaults.set(newValue, forKey: key)
            }
        }
    }
}

private protocol OptionalProtocol {
    func isNil() -> Bool
}

extension Optional: OptionalProtocol {
    func isNil() -> Bool {
        return self == nil
    }
}

extension Decodable {
    static func object(from string: String?) -> Self? {
        guard let data = string?.data(using: .utf8) else { return nil }
        return Self.object(from: data)
    }
    static func object(from data: Data) -> Self? { try? JSONDecoder().decode(Self.self, from: data) }
}

extension Encodable {
    func jsonData() -> Data? { try? JSONEncoder().encode(self) }
}
