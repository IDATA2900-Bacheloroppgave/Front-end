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
    private var isBarcodeScanned = false

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if isBarcodeScanned { return }
        
        if let metaObject = metadataObjects.first {
            guard let readableObject = metaObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let code = readableObject.stringValue else { return }
            isBarcodeScanned = true
            scannedCode = code
            print(code)
        }
    }

    func reset() {
        isBarcodeScanned = false
    }
}
