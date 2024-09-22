//
//  LiveTextView.swift
//  NihonGo
//
//  Created by Medhansh Singla on 4/8/24.
//

import SwiftUI
import VisionKit

@MainActor
struct LiveTextView: UIViewControllerRepresentable {
    
    @EnvironmentObject var manager: Manager
    
    static let textDataTpe: DataScannerViewController.RecognizedDataType = .text(languages: ["ja_JP"])
    
    var liveTextController: DataScannerViewController = DataScannerViewController(
        recognizedDataTypes: [LiveTextView.textDataTpe],
        qualityLevel: .balanced,
        recognizesMultipleItems: false,
        isHighFrameRateTrackingEnabled: true,
        isPinchToZoomEnabled: true,
        isHighlightingEnabled: true
    )
    
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        
        liveTextController.delegate = context.coordinator
        
        let scanButton = UIButton(type: .system)
        scanButton.backgroundColor = UIColor(red: 0.918, green: 0.467, blue: 0.467, alpha: 1)
        scanButton.setTitle("Start Translating", for: .normal)
        scanButton.setTitleColor(.white, for: .normal)
        
        var config = UIButton.Configuration.plain()
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        scanButton.configuration = config
        
        scanButton.addTarget(context.coordinator, action: #selector(Coordinator.startScanning(_:)), for: .touchUpInside)
        scanButton.layer.cornerRadius = 15.0
        liveTextController.view.addSubview(scanButton)
        
        scanButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scanButton.centerXAnchor.constraint(equalTo: liveTextController.view.centerXAnchor),
            scanButton.bottomAnchor.constraint(equalTo: liveTextController.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        return liveTextController
        
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {

    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}
    
class Coordinator: NSObject, DataScannerViewControllerDelegate {
    
    var parent: LiveTextView
    
    init(_ parent: LiveTextView) {
        self.parent = parent
    }
    
    func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
        
        switch item {
        case .text(let text):
            parent.manager.liveText = text.transcript
            parent.manager.showTranslation = true
        case .barcode(_):
            break
        @unknown default:
            break
        }
        
    }
    
    @objc
    func startScanning(_ sender: UIButton) {
        if sender.title(for: .normal) == "Start Translating" {
            try? parent.liveTextController.startScanning()
            sender.setTitle("Stop Translating", for: .normal)
        } else {
            parent.liveTextController.stopScanning()
            sender.setTitle("Start Translating", for: .normal)
        }
    }
    
}

#Preview {
    LiveTextView()
        .environmentObject(Manager())
}
