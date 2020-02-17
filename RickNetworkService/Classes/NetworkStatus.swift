//
//  NetworkStatus.swift
//  Alamofire
//
//  Created by Rick on 2020/2/17.
//

import Foundation
import CoreTelephony
import Alamofire

@objcMembers public class NetWorkStatus: NSObject {
    
    private static let `default`: NetWorkStatus = NetWorkStatus()
    private var isContineMake: Bool = false
    private let net: NetworkReachabilityManager? = NetworkReachabilityManager()
    
    public class func currentNetwork() -> String {
        
        let reachability: Reachability = Reachability.init(hostName: "www.apple.com")
        let internetStatus: NetworkStatus = reachability.currentReachabilityStatus()
        
        switch internetStatus {
        case ReachableViaWiFi:
            return "WiFi"
        case ReachableViaWWAN:
            
            let info: CTTelephonyNetworkInfo = CTTelephonyNetworkInfo()
            
            switch info.currentRadioAccessTechnology {
                
            case CTRadioAccessTechnologyGPRS:
                return "GPRS"
            case CTRadioAccessTechnologyeHRPD:
                return "HRPD"
            case CTRadioAccessTechnologyCDMA1x:
                return "2G"
            case CTRadioAccessTechnologyEdge:
                return "2.75G EDGE"
            case CTRadioAccessTechnologyWCDMA,
                 CTRadioAccessTechnologyCDMAEVDORev0,
                 CTRadioAccessTechnologyCDMAEVDORevA,
                 CTRadioAccessTechnologyCDMAEVDORevB:
                return "3G"
            case CTRadioAccessTechnologyHSDPA:
                return "3.5G HSDPA"
            case CTRadioAccessTechnologyLTE:
                return "4G"
            default: return "unknow"
                
            }
        case NotReachable:
            return "NONE"
        default:
            return "unknow"
        }
    }
    
    public class func isContinueMake() -> Bool {
        return self.default.isContineMake
    }
    
    public class func continueMake() {
        self.default.isContineMake = true
    }
    
    public class func stopListening() {
        self.default.net?.stopListening()
    }
    
    public class func startListening() {
        self.default.net?.startListening()
    }
    
    public class func observeReachability(complete: ((_ isReachable: Bool) -> Void)?) {

        self.default.net?.startListening()
        self.default.net?.listener = { status in
            
            guard complete != nil else { return }
            complete!(status != .notReachable)
        }
    }
    
    deinit {
        self.net?.stopListening()
    }
}
