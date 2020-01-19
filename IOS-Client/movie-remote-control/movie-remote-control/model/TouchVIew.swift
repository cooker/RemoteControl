//
//  TouchVIew.swift
//  movie-remote-control
//
//  Created by grant on 17/1/2020.
//  Copyright © 2020 grant. All rights reserved.
//

import Foundation
import SwiftUI

struct TouchView : UIViewRepresentable{
    
    var tappedCallback: (() -> Void)
    
    func makeUIView(context: UIViewRepresentableContext<TouchView>) -> TouchView.UIViewType {
        let v = UIView(frame: .zero)
        let gesture = SingleTouchDownGestureRecognizer(target: context.coordinator,
                                                       action: #selector(Coordinator.tapped))
        v.addGestureRecognizer(gesture)
        return v
    }
    
    class Coordinator: NSObject {
        var tappedCallback: (() -> Void)

        init(tappedCallback: @escaping (() -> Void)) {
            self.tappedCallback = tappedCallback
        }

        @objc func tapped(gesture:UITapGestureRecognizer) {
            self.tappedCallback()
        }
    }

    func makeCoordinator() -> TouchView.Coordinator {
        return Coordinator(tappedCallback:self.tappedCallback)
    }

    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<TouchView>) {
    }
}


class SingleTouchDownGestureRecognizer: UIGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if self.state == .possible {
            self.state = .recognized
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        self.state = .failed
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        self.state = .failed
    }
}

