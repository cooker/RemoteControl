//
//  HttpHelper.swift
//  movie-remote-control
//
//  Created by grant on 11/12/2019.
//  Copyright © 2019 grant. All rights reserved.
//

import Foundation
import SwiftHTTP

func callHttp(_ action: ANEnum, _ ip:String = "127.0.0.1"){
    HTTP.GET("http://" + ip + ":8099?action=" + action.toString()) { response in
        if let err = response.error {
            print("error: \(err.localizedDescription)")
            return //also notify app of failure as needed
        }
        print("opt finished: \(response.description)")
        //print("data is: \(response.data)") access the response of the data with response.data
    }
}
