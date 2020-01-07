//
//  MButton.swift
//  movie-remote-control
//
//  Created by grant on 7/12/2019.
//  Copyright © 2019 grant. All rights reserved.
//

import Foundation
import SwiftUI

struct MButton: View {
    let state:ANEnum;
    let action: ()->Void
    
    init(state:ANEnum, _ action:@escaping ()->Void = {}) {
        self.state = state
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            self.action()
        }){
            Text("")
                .frame(width: state.size(), height: state.size())
                .background(
                    Image(systemName: buttonImg())
                        .resizable()
                )
        }
    }
    
    func buttonImg() -> String {
        switch self.state {
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

struct MButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            VStack {
                MButton(state: .UP)
                HStack{
                    MButton(state: .LEFT)
                    MButton(state: .PLAY).padding([.top, .bottom], 5.0)
                    MButton(state: .RIGHT)
                }
                MButton(state: .DOWN)
            }
        }
        
    }
}
