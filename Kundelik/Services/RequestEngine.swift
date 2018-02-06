//
//  RequestEngine.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 1/16/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import Alamofire

class RequestEngine {
    
    static let shared = RequestEngine()
    
    func getToken() {
        let url = "https://login.kundelik.kz/oauth2?response_type=token&client_id=<client_id>&scope=<scope>&redirect_uri=<redirect_uri>&state=<state>"
    }
    
}
