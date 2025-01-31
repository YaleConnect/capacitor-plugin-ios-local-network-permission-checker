import Foundation

@objc public class LocalNetworkPermissionChecker: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
}
