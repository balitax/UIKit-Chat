//  
//  ChatViewModel.swift
//  Agus Cahyono
//
//  Created by Agus Cahyono on 27/04/19.
//  Copyright © 2019 Agus Cahyono. All rights reserved.
//

import Foundation

class ChatViewModel {

    private let service: ChatServiceProtocol

    private var model: [ChatModel] = [ChatModel]() {
        didSet {
            self.count = self.model.count
        }
    }

    /// Count your data in model
    var count: Int = 0

    //MARK: -- Network checking

    /// Define networkStatus for check network connection
    var networkStatus = Reach().connectionStatus()

    /// Define boolean for internet status, call when network disconnected
    var isDisconnected: Bool = false {
        didSet {
            self.alertMessage = "No network connection. Please connect to the internet"
            self.internetConnectionStatus?()
        }
    }

    //MARK: -- UI Status

    /// Update the loading status, use HUD or Activity Indicator UI
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }

    /// Showing alert message, use UIAlertController or other Library
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }

    /// Define selected model
    var selectedObject: ChatModel?

    //MARK: -- Closure Collection
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var internetConnectionStatus: (() -> ())?
    var serverErrorStatus: (() -> ())?
    var didGetData: (() -> ())?

    init(withChat serviceProtocol: ChatServiceProtocol = ChatService() ) {
        self.service = serviceProtocol

        NotificationCenter.default.addObserver(self, selector: #selector(self.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reach().monitorReachabilityChanges()

    }

    //MARK: Internet monitor status
    @objc func networkStatusChanged(_ notification: Notification) {
        self.networkStatus = Reach().connectionStatus()
    }

    //MARK: -- Example Func
    func exampleBind() {
        switch networkStatus {
        case .offline:
            self.isDisconnected = true
            self.internetConnectionStatus?()
        case .online:
            // call your service here
            self.service.removeThisFuncName(success: { data in
                
                self.isLoading = false
                // self.model = data
                self.didGetData?()
                
            }) { errorMsg, errorCode in
                if errorCode == 0 {
                    self.serverErrorStatus?()
                } else {
                    self.isLoading = false
                    self.alertMessage = errorMsg
                }
            }
        default:
            break
        }
    }

}

extension ChatViewModel {

}
