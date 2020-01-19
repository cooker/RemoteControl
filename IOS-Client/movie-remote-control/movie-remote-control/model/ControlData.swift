//
//  ControlData.swift
//  movie-remote-control
//
//  Created by grant on 17/1/2020.
//  Copyright © 2020 grant. All rights reserved.
//

import Foundation

/**
 * 数据类
 */
class ControlData : ObservableObject{
    @Published var ip:String = ""
    @Published var state: ViewEnum = ViewEnum.OFF
    @Published var isScan:Bool = false
}
