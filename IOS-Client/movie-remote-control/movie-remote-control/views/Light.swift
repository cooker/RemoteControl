//
//  Light.swift
//  movie-remote-control
//
//  Created by grant on 7/12/2019.
//  Copyright © 2019 grant. All rights reserved.
//

import SwiftUI

struct Light: View {
    var state:Binding<LightEnum>;
    
    var body: some View {
        HStack{
            Image(self.state.wrappedValue == LightEnum.ON ? "lightOn" : "lightOff")
                .shadow(radius: 15)
                .shadow(color: .yellow, radius: .pi, x: .pi, y: .pi)
                
                
        }
    
    }
}

struct Light_Previews: PreviewProvider {
    @State static var sk = LightEnum.ON
    @State static var sk1 = LightEnum.OFF
    
    static var previews: some View {
    
        VStack{
            Light(state: $sk)
            Light(state: $sk1)
        }.background(Color.black)
    }
}
