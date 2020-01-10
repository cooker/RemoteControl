//
//  MButton.swift
//  movie-remote-control
//
//  Created by grant on 7/12/2019.
//  Copyright © 2019 grant. All rights reserved.
//

import Foundation
import SwiftUI

struct ButtonView: View {
    var btnType:ViewEnum
    @Binding var lightStatus:ViewEnum
    @Binding var ip:String
    
    init(ip:Binding<String>, btnType:ViewEnum, lightStatus:Binding<ViewEnum>) {
        self._ip = ip
        self.btnType = btnType
        self._lightStatus = lightStatus
    }
    
    var body: some View {
        Button(action: {
            callHttp(self.btnType, self.ip)
        }){
            Text("")
                .frame(width: btnType.size(), height: btnType.size())
                .background(
                    Image(systemName: buttonImg()).resizable()
                )
        }.buttonStyle(ButtonViewStyle(btnSelf: self))
    }
    
    func buttonImg() -> String {
        switch self.btnType {
            case .CLOSE:
                return "stop.circle"
            case .FULL_SCREEN:
                return "arrow.up.left.and.arrow.down.right"
            case .PGUP:
                return "backward.end"
            case .PGDN:
                return "forward.end"
            case .PLAY:
                return "play.circle"
            case .UP:
                return "chevron.up.circle.fill"
            case .DOWN:
                return "chevron.down.circle.fill"
            case .LEFT:
                return "chevron.left.circle.fill"
            case .RIGHT:
                return "chevron.right.circle.fill"
            default:
                return "questionmark.circle"
        }
    }
}

struct ButtonViewStyle : ButtonStyle {
    var btnSelf:ButtonView
    
    func makeBody(configuration: Self.Configuration) -> some View {
        if configuration.isPressed {
            btnSelf.lightStatus = .ON
        }else {
            btnSelf.lightStatus = .OFF
        }
        return configuration.label
            .foregroundColor(configuration.isPressed ? .red : .blue)
            .background(Color.clear)
    }
}
