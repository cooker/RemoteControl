//
//  Light.swift
//  movie-remote-control
//
//  Created by grant on 7/12/2019.
//  Copyright © 2019 grant. All rights reserved.
//

import SwiftUI

struct LightView: View {
    var state:Binding<ViewEnum>;
    
    var body: some View {
        let img = buildImage()
        if self.state.wrappedValue == .ON {
            return img.foregroundColor(.yellow)
                .shadow(color: .yellow, radius: 3, x: 0, y: 5)
        }else {
            return img.foregroundColor(.black)
                .shadow(color: .black, radius: 0, x: 0, y: 0)
        }
    }
    
    func buildImage() -> some View {
        let img = Image(systemName: "sun.min")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 36, height: 48, alignment: .center)
        return img
    }
}

#if DEBUG
struct Light_Previews: PreviewProvider {
    @State static var sk = ViewEnum.ON
    
    static var previews: some View {
    
        LightView(state: $sk)
    }
}
#endif
