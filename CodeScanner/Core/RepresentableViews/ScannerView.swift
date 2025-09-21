//
//  ScannerController.swift
//  QRScanner
//
//  Created by Uliana Gritchina on 20.09.2025.
//

import AVFoundation
import SwiftUI

class ScannerController: UIViewController {
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
    private let types: [AVMetadataObject.ObjectType] = [
        .qr,
        .ean8,
        .ean13,
        .upce,
        .code39,
        .code39Mod43,
        .code93,
        .code128,
        .pdf417,
        .aztec,
        .itf14,
        .dataMatrix
    ]
    var delegate: AVCaptureMetadataOutputObjectsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("Failed to get the camera device")
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: captureDevice)
            
        } catch {
            print(error)
            return
        }
        
        captureSession.addInput(videoInput)
        
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(captureMetadataOutput)
        
        captureMetadataOutput.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = types
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
    }
}

struct ScannerView: UIViewControllerRepresentable {
    @Binding var scanResult: CodeInfo?
    
    func makeUIViewController(context: Context) -> ScannerController {
        let controller = ScannerController()
        controller.delegate = context.coordinator
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: ScannerController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator($scanResult)
    }
}

class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    
    @Binding var scanResult: CodeInfo?
    
    private let types: [AVMetadataObject.ObjectType] = [
        .qr,
        .ean8,
        .ean13,
        .upce,
        .code39,
        .code39Mod43,
        .code93,
        .code128,
        .pdf417,
        .aztec,
        .itf14,
        .dataMatrix
    ]
    
    init(_ scanResult: Binding<CodeInfo?>) {
        self._scanResult = scanResult
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard !metadataObjects.isEmpty,
              let metadataObject = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else { return }
        
        if types.contains(metadataObject.type), let stringValue = metadataObject.stringValue {
            scanResult = CodeInfo(
                type: metadataObject.type == .qr ? CodeType.qr : CodeType.barcode,
                stringValue: stringValue,
                dateCreated: Date()
            )
        }
    }
}
