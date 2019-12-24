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
    let state:MButtonEnum;
    let action: ()->Void
    
    init(state:MButtonEnum, _ action:@escaping ()->Void = {}) {
        self.state = state
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            self.action()
        }){
            Text(self.state.text())
                .frame(width: state.size(), height: state.size())
                .background(state.color())
                .foregroundColor(.white)
                .clipShape(Circle())
        }
    }
}

struct MButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            VStack {
                MButton(state: .LEFT)
                HStack{
                    MButton(state: .UP)
                    MButton(state: .PLAY).padding([.top, .bottom], 5.0)
                    MButton(state: .RIGHT)
                }
                MButton(state: .DOWN)
            }
        }
        
    }
}
