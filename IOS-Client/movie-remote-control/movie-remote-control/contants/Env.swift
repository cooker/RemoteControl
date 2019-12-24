//
//  Env.swift
//  movie-remote-control
//
//  Created by grant on 8/12/2019.
//  Copyright © 2019 grant. All rights reserved.
//

import Foundation

struct Ports {
    static var port:Int{
        return 63788;
    }
}

extension String {
    // base64编码
    func toBase64() -> String {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return "IA=="
    }

    // base64解码
    func fromBase64() -> String {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8) ?? " "
        }
        return " "
    }
}

