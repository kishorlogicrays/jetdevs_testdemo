//
//  UserInfo.swift
//  JetDevsHomeWork
//

import Foundation
import UIKit

struct DefaultsKey<ValueType> {
    private let key: String
    private let defaultValue: ValueType

    public init(_ key: String, defaultValue: ValueType) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var value: ValueType {
        get {
            let value = UserDefaults.standard[key]
            return value as? ValueType ?? defaultValue
        }
        set {
            UserDefaults.standard[key] = newValue as AnyObject
            UserDefaults.standard.synchronize()
        }
    }
}

let kAuthKey = "vAuthKey"
let kUserIDKey = "vUserID"
let kUser = "kUser"

class UserInfo {
    static let shared = UserInfo()
    private var _userId = DefaultsKey<Int>(kUserIDKey, defaultValue: 0)
    var userId: Int {
        get { return _userId.value }
        set { _userId.value = newValue }
    }

    var loggedInUser:LoginResponseData?{
        get{
            if let decoded  = UserDefaults.standard.object(LoginResponseData.self, with: kUser) {
                return decoded
            }
            return nil
        }
        set{
            UserDefaults.standard.set(object: newValue!, forKey: kUser)
            UserDefaults.standard.synchronize()
        }
    }
}

extension UserDefaults {

    /// EZSE: Generic getter and setter for UserDefaults.
    public subscript(key: String) -> AnyObject? {
        get {
            //return hasValue(forKey: key) as AnyObject?
            return object(forKey: key) as AnyObject?
        }
        set {
            set(newValue, forKey: key)
        }
    }

    public func object<T: Codable>(_ type: T.Type,
                                   with key: String,
                                   usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = self.value(forKey: key) as? Data else { return nil }

        return try? decoder.decode(type.self, from: data)
    }

    public func set<T: Codable>(object: T,
                                forKey key: String,
                                usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)

        self.set(data, forKey: key)
    }
}
