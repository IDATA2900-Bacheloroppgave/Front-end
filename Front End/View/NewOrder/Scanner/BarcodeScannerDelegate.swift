//
//  BarcodeScannerDelegate.swift
//  Front End
//
//  Created by Siri Sandnes on 17/05/2024.
//

import SwiftUI
import AVKit


class BarcodeScannerDelegate: NSObject, ObservableObject, AVCaptureMetadataOutputObjectsDelegate {
    @Published var scannedCode: String?

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metaObject = metadataObjects.first {
            guard let readableObject = metaObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let Code = readableObject.stringValue else { return }
                scannedCode = Code
         
            
        }
    }
}



