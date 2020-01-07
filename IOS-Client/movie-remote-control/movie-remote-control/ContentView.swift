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
    @State var state: ANEnum = ANEnum.OFF
    @State var isScan:Bool = false
    
    var body: some View {
        NavigationView() {
            VStack() {
                HStack{
                    Spacer()
                    NavigationLink(destination: OcrScanView(ip: $ip, isScan: $isScan), isActive: self.$isScan) {
                        
                        Image(systemName: "qrcode.viewfinder")
                            .resizable()
                            .frame(width: 36, height: 36, alignment: .center)
                    }
                    Spacer()
                    TextField("255.255.255.255", text: $ip)
                        .frame(width: 200.0, height: 52.0)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    Spacer()
                    Light(state: $state).offset().padding(.all, 20.0)
                }
                
                Spacer()
                
                VStack {
                    MButton(state: .UP) {
                        self.callPc(.UP)
                    }
                    HStack{
                        MButton(state: .LEFT){
                            self.callPc(.LEFT)
                            
                        }
                        MButton(state: .PLAY){
                           self.callPc(.PLAY)
                            
                        }.padding([.top, .bottom], 5.0)
                        MButton(state: .RIGHT){
                           self.callPc(.RIGHT)
                        }
                    }
                    MButton(state: .DOWN){
                        self.callPc(.DOWN)
                    }
                }
                Spacer()
                HStack {
                    MButton(state: .CLOSE){
                        self.callPc(.CLOSE)
                    }
                    MButton(state: .FULL_SCREEN){
                        self.callPc(.FULL_SCREEN)
                    }
                    MButton(state: .PGUP){
                        self.callPc(.PGUP)
                    }
                    MButton(state: .PGDN){
                        self.callPc(.PGDN)
                    }
                }
                Spacer()
            }
        }.background(Color.clear)
        
    }
    
    public func callPc(_ m:ANEnum) {
        self.state = .ON
        callHttp(m, self.ip)
        //延迟1秒执行
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.state = .OFF
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
