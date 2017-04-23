//
//  ReachabilityManager.swift
//  Reachability
//
//  Created by iOS Developer on 4/23/17.
//  Copyright © 2017 Ashley Mills. All rights reserved.
//

import ReachabilitySwift

public protocol NetworkStatusListener: class {
    func networkStatusDidChange(status: Reachability.NetworkStatus)
}

final class ReachabilityManager {
    
    fileprivate var hostName = "www.google.com"
    open var reachability: Reachability?
    weak var listener: NetworkStatusListener?
    
    private(set) open lazy var isReachable: Bool = {
        return ReachabilityManager.shared.reachability!.isReachable
    }()
    
    private(set) open lazy var unReachable: Bool = {
        return !ReachabilityManager.shared.reachability!.isReachable
    }()
    
    // Previous function
//    static func isReachable() -> Bool {
//        return ReachabilityManager.shared.reachability!.isReachable
//    }
    
    private init() {
        reachability = Reachability(hostname: hostName)
        NotificationCenter.default.addObserver(self, selector:#selector(ReachabilityManager.reachabilityDidChanged(notification:)) , name: ReachabilityChangedNotification, object: reachability)
        do {
            try reachability?.startNotifier()
        } catch {
            print("-- Cannot start notifier --")
            return
        }
    }
    
    //MARK: Shared Instance
    static let shared: ReachabilityManager = ReachabilityManager()
    
    @objc func reachabilityDidChanged(notification: NSNotification) {
        let reachability = notification.object as! Reachability
        listener?.networkStatusDidChange(status: reachability.currentReachabilityStatus)
    }
    
    fileprivate func stopNotifier() {
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: nil)
        reachability = nil
    }
    
    deinit {
        stopNotifier()
    }
}
