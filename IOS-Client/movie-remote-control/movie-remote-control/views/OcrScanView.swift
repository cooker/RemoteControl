//
//  OcrScanView.swift
//  movie-remote-control
//
//  Created by grant on 28/12/2019.
//  Copyright © 2019 grant. All rights reserved.
//

import SwiftUI
import AVFoundation
import UIKit

class OcrScanUIController : UIViewController {
    public var ip:Binding<String>?
    public var isScan:Binding<Bool>?
    //相机展示区域
    var cameraView:UIView?
    //二维码区域
    var qrCodeFrameView: UIView?
    //相机预览
    var previewLayer:AVCaptureVideoPreviewLayer?
    var tempSession:AVCaptureSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        cameraView = UIView(frame: view.frame);
        view.addSubview(cameraView!)
        
        let avDevice: AVCaptureDevice?
        
        if let tavDevice = AVCaptureDevice.default(for: .video) {
            avDevice = tavDevice
        }else {
            let alert = UIAlertController(title: "提示", message: "请开启相机权限", preferredStyle: .alert)
            self.present(alert, animated: true) {
                
            }
            return
        }
    
        do {
            let input = try AVCaptureDeviceInput(device: avDevice!)
            let session = AVCaptureSession()
            tempSession = session
            session.addInput(input)
            let captureMetadataOutput = AVCaptureMetadataOutput()
            session.addOutput(captureMetadataOutput)
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [.qr]
            
            previewLayer = AVCaptureVideoPreviewLayer(session: session)
            previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            previewLayer?.frame = view.layer.bounds
            
            cameraView?.layer.addSublayer(previewLayer!)
            
            //Initialize QR Code Frame to highlight the QR code
            qrCodeFrameView = UIView()
            
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubviewToFront(qrCodeFrameView)
            }
            
            session.startRunning()
        } catch {
            print(error)
            return
        }
    }
    
}


extension OcrScanUIController : AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput,
                       didOutput metadataObjects: [AVMetadataObject],
                       from connection: AVCaptureConnection) {
        //没有数据
        if metadataObjects.count == 0 {
            return
        }
        
        //获取数据
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            let barCodeObject = previewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if let str = metadataObj.stringValue {
                self.ip?.wrappedValue = str
                self.isScan?.wrappedValue = false
                print("二维码：\(str)")
            }
        }
    }
}

struct OcrScanView: UIViewControllerRepresentable {
    
    @Binding var ip:String
    @Binding var isScan:Bool
    
    init(ip:Binding<String>, isScan:Binding<Bool>) {
        self._ip = ip
        self._isScan = isScan
    }
    
    func updateUIViewController(_ uiViewController: OcrScanUIController, context: UIViewControllerRepresentableContext<OcrScanView>) {
        
    }
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<OcrScanView>) -> OcrScanUIController {
        let ret = OcrScanUIController()
        ret.ip = self.$ip
        ret.isScan = self.$isScan
        return ret
    }
}


struct OcrScanView_Preview : PreviewProvider {
    @State static var ip:String = "aa"
    @State static var isScan:Bool = false
    
    static var previews: some View {
        OcrScanView(ip: $ip, isScan: $isScan)
    }
}
