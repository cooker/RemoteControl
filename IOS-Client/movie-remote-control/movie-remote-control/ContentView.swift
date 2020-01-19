//
//  ContentView.swift
//  movie-remote-control
//
//  Created by grant on 7/12/2019.
//  Copyright © 2019 grant. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var ip:String = ""
    @State var state: ViewEnum = ViewEnum.OFF
    @State var isScan:Bool = false
    
    var body: some View {
        NavigationView() {
            VStack() {
                makeHeadUI()
                Spacer()
                makeAimUI()
                Spacer()
                makeFootUI()
                Spacer()
                makeFootUI2()
                Spacer()
            }.background(Image("Image").resizable().blur(radius: 3.0))
        }
        
    }
    
    
    func makeHeadUI() -> some View {
        return HStack(){
            Spacer()
            NavigationLink(destination: OcrScanView(ip: $ip, isScan: $isScan), isActive: self.$isScan) {
                Image(systemName: "qrcode.viewfinder")
                    .resizable()
                .frame(width: 36, height: 36, alignment: .center) }.navigationBarTitle(Text("遥控器"), displayMode: .inline)
            Spacer()
            
            TextField("255.255.255.255", text: $ip)
                .frame(width: 200.0, height: 52.0)
                .border(Color.blue, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            Spacer()
            LightView(state: $state).offset().padding(.all, 20.0)
        }
    }
    
    func makeAimUI() -> some View {
        return VStack {
            ButtonView(ip: self.$ip, btnType: .UP, lightStatus: self.$state)
            HStack{
                ButtonView(ip: self.$ip, btnType: .LEFT, lightStatus: self.$state)
                ButtonView(ip: self.$ip, btnType: .PLAY, lightStatus: self.$state).padding([.top, .bottom], 5.0)
                ButtonView(ip: self.$ip, btnType: .RIGHT, lightStatus: self.$state)
            }
            ButtonView(ip: self.$ip, btnType: .DOWN, lightStatus: self.$state)
        }
    }
    
    func makeFootUI() -> some View {
        return HStack() {
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
    }
    
    func makeFootUI2() -> some View {
        return HStack() {
            Spacer()
            ButtonView(ip: self.$ip, btnType: .FULL2_SCREEN, lightStatus: self.$state)
            Spacer()
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

struct ExtractedView: View {
    var body: some View {
        Spacer()
    }
}
