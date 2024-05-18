//
//  ScannerView.swift
//  Front End
//
//  Created by Siri Sandnes on 17/05/2024.
//

import Foundation
import AVKit
import UIKit
import SwiftUI

struct CameraView: UIViewRepresentable{
    var frameSize : CGSize
    
    @Binding var session: AVCaptureSession
    func makeUIView(context: Context) -> UIView {
        let view = UIViewType(frame: CGRect(origin: .zero, size: frameSize))
        view.backgroundColor = .clear
        
        let cameraLayer = AVCaptureVideoPreviewLayer(session: session)
        cameraLayer.frame = .init(origin: .zero, size: frameSize)
        cameraLayer.videoGravity = .resizeAspectFill
        cameraLayer.masksToBounds = true
        view.layer.addSublayer(cameraLayer)
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let layer = uiView.layer.sublayers?.first as? AVCaptureVideoPreviewLayer {
                   layer.frame = CGRect(origin: .zero, size: frameSize)
               }
    }
}
