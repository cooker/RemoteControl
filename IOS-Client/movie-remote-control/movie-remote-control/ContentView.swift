//
//  ContentView.swift
//  movie-remote-control
//
//  Created by grant on 7/12/2019.
//  Copyright © 2019 grant. All rights reserved.
//

import SwiftUI
import RxSwift

struct ContentView: View {
    
    @State var ip:String = ""
    @State var state: ViewEnum = ViewEnum.OFF
    @State var isScan:Bool = false
    
    var body: some View {
        
        NavigationView() {
            VStack() {
                HStack(){
                    Spacer()
                    NavigationLink(destination: OcrScanView(ip: $ip, isScan: $isScan), isActive: self.$isScan) {
                        Image(systemName: "qrcode.viewfinder")
                            .resizable()
                            .frame(width: 36, height: 36, alignment: .center) }.navigationBarTitle(Text("遥控器"), displayMode: .inline)
                    Spacer()
                    TextField("255.255.255.255", text: $ip)
                        .frame(width: 200.0, height: 52.0)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    Spacer()
                    LightView(state: $state).offset().padding(.all, 20.0)
                }
                
                Spacer()
                
                VStack {
                    ButtonView(ip: self.$ip, btnType: .UP, lightStatus: self.$state)
                    HStack{
                        ButtonView(ip: self.$ip, btnType: .LEFT, lightStatus: self.$state)
                        ButtonView(ip: self.$ip, btnType: .PLAY, lightStatus: self.$state).padding([.top, .bottom], 5.0)
                        ButtonView(ip: self.$ip, btnType: .RIGHT, lightStatus: self.$state)
                    }
                    ButtonView(ip: self.$ip, btnType: .DOWN, lightStatus: self.$state)
                }
                Spacer()
                HStack() {
                    Spacer()
                    ButtonView(ip: self.$ip, btnType: .CLOSE, lightStatus: self.$state)
                    Spacer()
                    ButtonView(ip: self.$ip, btnType: .FULL_SCREEN, lightStatus: self.$state)
                    Spacer()
                    ButtonView(ip: self.$ip, btnType: .PGUP, lightStatus: self.$state)
                    Spacer()
                    ButtonView(ip: self.$ip, btnType: .PGDN, lightStatus: self.$state)
                    Spacer()
                }
                Spacer()
            }
        }
    }
    
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
#endif
