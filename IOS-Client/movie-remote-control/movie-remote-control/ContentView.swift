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
    @State var state: LightEnum = LightEnum.OFF
    
    var body: some View {
        VStack() {
            Spacer()
                .frame(height: 42.0)
            HStack{
                Spacer()
                TextField("255.255.255.255", text: $ip)
                    .frame(width: 200.0, height: 42.0)
                    .shadow(radius: 1.0)
                    .cornerRadius(5.0)
                    .background(Color.white)
                    .border(Color.black, width: 1)
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
        .background(Color(red: 119, green: 237, blue: 204))
        .edgesIgnoringSafeArea([.top, .bottom])
        
    }
    
    public func callPc(_ m:MButtonEnum) {
        self.state = .ON
        callHttp(m, self.ip)
        //延迟1秒执行
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.state = .OFF
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
