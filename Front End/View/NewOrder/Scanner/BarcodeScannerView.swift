//
//  BarcodeScannerView.swift
//  Front End
//
//  Created by Siri Sandnes on 15/05/2024.
//
import AVFoundation
import SwiftUI

struct BarcodeScannerView: View {
    @State private var session: AVCaptureSession = .init()
    @State private var cameraPermission: Permission = .idle
    @State private var barcodeOutput: AVCaptureMetadataOutput = .init()
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    @Binding var showBarcode: Bool
    @Binding var scannedCode: String?
    @Binding var gotBarcode: Bool
    
    @Environment(\.openURL) private var openURL
    
    @StateObject private var barcodeDelegate = BarcodeScannerDelegate()
    
    var body: some View {
        VStack {
            Button {
                showBarcode = false
                resetScanner()
                
            } label: {
                Image(systemName: "xmark")
                    .font(.title)
                    .foregroundStyle(.black)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            Text("Scan barcode to order product")
                .padding(.top, 20)
                .font(.title3)
            Text("Place barcode inside of the square")
                .foregroundStyle(.gray)
                .font(.callout)
            
            Spacer()
            
            GeometryReader { geometry in
                let size = geometry.size
                
                ZStack {
                    CameraView(frameSize: CGSize(width: size.width, height: size.width), session: $session)
                        .scaleEffect(0.97)
                    
                    ForEach(0...4, id: \.self) { index in
                        let rotation = Double(index) * 90
                        
                        RoundedRectangle(cornerRadius: 2, style: .circular)
                            .trim(from: 0.61, to: 0.64)
                            .stroke(Color.solwrYellow, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                            .rotationEffect(.init(degrees: rotation))
                    }
                    .frame(width: size.width, height: size.width)
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .padding(.horizontal, 45)
            
            Spacer()
            
            Button {
                if !session.isRunning && cameraPermission == .approved {
                    reactivateCamera()
                }
            } label: {
                Image(systemName: "qrcode.viewfinder")
                    .font(.title)
                    .foregroundStyle(.solwrGreyText)
            }
            .padding(.bottom, 50)
        }
        .padding(15)
        .onAppear(perform: {
            checkCameraPermission()
        })
        .alert(errorMessage, isPresented: $showError) {
            if cameraPermission == .denied {
                Button("Settings") {
                    let settingsString = UIApplication.openSettingsURLString
                    if let settingsURL = URL(string: settingsString) {
                        openURL(settingsURL)
                    }
                }
            }
        }
        .onChange(of: barcodeDelegate.scannedCode) { oldValue, newValue in
            if let code = newValue {
                scannedCode = code
                gotBarcode = true
                showBarcode = false
                barcodeDelegate.reset()
            }
            if(gotBarcode == true){
                session.stopRunning()
            }
        }
    }
    
    
    
    func reactivateCamera() {
        DispatchQueue.global(qos: .background).async {
            session.startRunning()
            barcodeDelegate.reset()
        }
    }
    
    func checkCameraPermission() {
        Task {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                cameraPermission = .approved
                setUpCamera()
            case .notDetermined:
                if await AVCaptureDevice.requestAccess(for: .video) {
                    cameraPermission = .approved
                    setUpCamera()
                } else {
                    cameraPermission = .denied
                    showError("Please provide Access to Camera for scanning barcode")
                }
            case .denied, .restricted:
                cameraPermission = .denied
                
            default: break
            }
        }
    }
    
    func resetScanner() {
         scannedCode = nil
         gotBarcode = false
         reactivateCamera()
     }
    
    func setUpCamera() {
        do {
            guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [
                .builtInWideAngleCamera,
                .builtInUltraWideCamera,
                .builtInTelephotoCamera,
                .builtInDualCamera,
                .builtInTripleCamera,
                .builtInDualWideCamera,
                .builtInTrueDepthCamera 
            ], mediaType: .video, position: .back).devices.first else {
                showError("No suitable camera found.")
                return
            }
            
            let input = try AVCaptureDeviceInput(device: device)
            
            guard session.canAddInput(input), session.canAddOutput(barcodeOutput) else {
                showError("Cannot add input or output to the session.")
                return
            }
            
            session.beginConfiguration()
            session.addInput(input)
            session.addOutput(barcodeOutput)
            
            barcodeOutput.metadataObjectTypes = [
                .ean8,
                .ean13,
                .upce,
                .code128,
                .code39,
                .code93,
                .pdf417,
                .qr,
                .dataMatrix,
                .aztec
            ]
            barcodeOutput.setMetadataObjectsDelegate(barcodeDelegate, queue: .main)
            
            session.commitConfiguration()
            
            DispatchQueue.global(qos: .background).async {
                session.startRunning()
            }
        } catch {
            showError(error.localizedDescription)
        }
    }
    
    func showError(_ message: String) {
        errorMessage = message
        showError.toggle()
    }
}

#Preview {
    BarcodeScannerView(showBarcode: .constant(false), scannedCode: .constant(nil), gotBarcode: .constant(false))
}
