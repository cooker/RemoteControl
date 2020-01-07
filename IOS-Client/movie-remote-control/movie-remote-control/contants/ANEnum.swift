//
//  MButtonEnum.swift
//  movie-remote-control
//
//  Created by grant on 7/12/2019.
//  Copyright © 2019 grant. All rights reserved.
//

import Foundation
import SwiftUI

enum ANEnum {
    case ON, OFF;
    case PLAY, UP, DOWN, LEFT, RIGHT, CLOSE, PGDN, PGUP, FULL_SCREEN;
    static var w:CGFloat? = 50
    
    public func toString() -> String {
        switch self {
            case .PLAY:
                return " ".toBase64();
            case .UP:
                return "{UP}".toBase64();
            case .DOWN:
                return "{DOWN}".toBase64();
            case .LEFT:
                return "{LEFT}".toBase64();
            case .RIGHT:
                return "{RIGHT}".toBase64();
            case .CLOSE:
                return "{F4}".toBase64();
            case .PGDN:
                return "{PGDN}".toBase64();
            case .PGUP:
                return "{PGUP}".toBase64();
            case .FULL_SCREEN:
                return "^%{ENTER}".toBase64();
            default:
                return "";
        }
    }
    
    public func size() -> CGFloat? {
        return ANEnum.w
    }
}
