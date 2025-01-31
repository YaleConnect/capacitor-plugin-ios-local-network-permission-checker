import Foundation
import Capacitor
import OSLog
import Network

@objc(LocalNetworkPermissionCheckerPlugin)
public class LocalNetworkPermissionCheckerPlugin: CAPPlugin, CAPBridgedPlugin, NetServiceDelegate {
    
    public var identifier = "LocalNetworkPermissionCheckerPlugin"
    public var jsName = "LocalNetworkPermissionChecker"
    public var pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "getLocalNetworkPermissionStatus", returnType: CAPPluginReturnPromise)
    ]

    private var browser: NWBrowser?
    private var service: NetService?
    private var permissionStatus: String = "notDetermined"
    private var encounteredPolicyDeniedError = false

    @objc func getLocalNetworkPermissionStatus(_ call: CAPPluginCall) {
        startService()

        let startTime = Date()
        while permissionStatus == "notDetermined" && Date().timeIntervalSince(startTime) < 1.0 {
            RunLoop.current.run(mode: .default, before: Date().addingTimeInterval(0.1))
        }

        if encounteredPolicyDeniedError {
            permissionStatus = "denied"
        }

        call.resolve(["status": permissionStatus])
    }

    private func startService() {
        self.permissionStatus = "notDetermined"
        self.encounteredPolicyDeniedError = false
        shutdown()

        service = NetService(domain: "local.", type: "_lnp._tcp.", name: "LocalNetworkPermissionChecker", port: 7891)
        service?.delegate = self
        service?.publish()

        let parameters = NWParameters()
        parameters.includePeerToPeer = true
        browser = NWBrowser(for: .bonjour(type: "_bonjour._tcp", domain: nil), using: parameters)

        browser?.stateUpdateHandler = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .failed(let error):
                if error.localizedDescription.contains("PolicyDenied") {
                    self.encounteredPolicyDeniedError = true
                    self.permissionStatus = "denied"
                }
            case .waiting(let error):
                if error.localizedDescription.contains("PolicyDenied") {
                    self.encounteredPolicyDeniedError = true
                    self.permissionStatus = "denied"
                }
            case .ready:
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    if self.encounteredPolicyDeniedError {
                        self.permissionStatus = "denied"
                    } else {
                        self.permissionStatus = "granted"
                    }
                }
            default:
                break
            }
        }

        browser?.start(queue: .main)
    }

    public func netServiceDidPublish(_ sender: NetService) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if !self.encounteredPolicyDeniedError {
                self.permissionStatus = "granted"
            } else {
                self.permissionStatus = "denied"
            }
        }
    }

    public func netService(_ sender: NetService, didNotPublish errorDict: [String: NSNumber]) {
        permissionStatus = "denied"
    }

    private func shutdown() {
        browser?.cancel()
        service?.stop()
        browser = nil
        service = nil
    }
}
