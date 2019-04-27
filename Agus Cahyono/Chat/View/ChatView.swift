//  
//  ChatView.swift
//  Agus Cahyono
//
//  Created by Agus Cahyono on 27/04/19.
//  Copyright © 2019 Agus Cahyono. All rights reserved.
//

import UIKit

class ChatView: UIViewController {

    // OUTLETS HERE

    // VARIABLES HERE
    var viewModel = ChatViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
    }
    
    fileprivate func setupViewModel() {

        self.viewModel.showAlertClosure = {
            let alert = self.viewModel.alertMessage ?? ""
            print(alert)
        }
        
        self.viewModel.updateLoadingStatus = {
            if self.viewModel.isLoading {
                print("LOADING...")
            } else {
                 print("DATA READY")
            }
        }

        self.viewModel.internetConnectionStatus = {
            print("Internet disconnected")
            // show UI Internet is disconnected
        }

        self.viewModel.serverErrorStatus = {
            print("Server Error / Unknown Error")
            // show UI Server is Error
        }

        self.viewModel.didGetData = {
            // update UI after get data
        }

    }
    
}


