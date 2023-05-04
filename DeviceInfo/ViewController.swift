
//
//  ViewController.swift
//  DeviceInfo
//
//  Created by Mekala Vamsi Krishna on 29/04/23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let deviceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "iPhone")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let screenView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let header: UILabel = {
        let label = UILabel()
        label.text = "Device Info"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let deviceModelLabel: UILabel = {
        let label = UILabel()
        label.text = "Device Model: \(UIDevice.current.model)"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let iOSVersionLabel: UILabel = {
        let label = UILabel()
        label.text = "iOS Version: \(UIDevice.current.systemVersion)"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let batteryHealthLabel: UILabel = {
        let label = UILabel()
        label.text = "Battery Health: \(UIDevice.current.batteryState.rawValue)"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let batteryLevelLabel: UILabel = {
        let label = UILabel()
        label.text = "Battery Level: \(UIDevice.current.batteryLevel)"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalSpaceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let availableSpaceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let processorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Processor: \(ProcessInfo.processInfo.processorCount)"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        view.addSubview(deviceImageView)
        deviceImageView.addSubview(screenView)
        screenView.addSubview(header)
        screenView.addSubview(stackView)
        stackView.addArrangedSubview(deviceModelLabel)
        stackView.addArrangedSubview(iOSVersionLabel)
        stackView.addArrangedSubview(batteryHealthLabel)
        stackView.addArrangedSubview(batteryLevelLabel)
        stackView.addArrangedSubview(totalSpaceLabel)
        stackView.addArrangedSubview(availableSpaceLabel)
        stackView.addArrangedSubview(processorLabel)
        
        NSLayoutConstraint.activate([
            deviceImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deviceImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            deviceImageView.widthAnchor.constraint(equalToConstant: 320),
            deviceImageView.heightAnchor.constraint(equalToConstant: 576),
            
            screenView.topAnchor.constraint(equalTo: deviceImageView.topAnchor, constant: 120),
            screenView.leadingAnchor.constraint(equalTo: deviceImageView.leadingAnchor, constant: 30),
            screenView.trailingAnchor.constraint(equalTo: deviceImageView.trailingAnchor, constant: -30),
            screenView.bottomAnchor.constraint(equalTo: deviceImageView.bottomAnchor, constant: -160),
            
            header.centerXAnchor.constraint(equalTo: screenView.centerXAnchor),
            header.topAnchor.constraint(equalTo: screenView.topAnchor, constant: 10),
            
            stackView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: screenView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: screenView.trailingAnchor, constant: -20),
        ])
        
        let fileManager = FileManager.default
        do {
            let attributes = try fileManager.attributesOfFileSystem(forPath: NSHomeDirectory())
            let totalSize = attributes[.systemSize] as? Int64 ?? 0
            let availableSize = attributes[.systemFreeSize] as? Int64 ?? 0
            totalSpaceLabel.text = "Total Size: \(totalSize / (1024 * 1024 * 1024)) GB"
            availableSpaceLabel.text = "Available Size: \(availableSize / (1024 * 1024 * 1024)) GB"
        } catch {
            print(error.localizedDescription)
        }
        
        let captureDevices = AVCaptureDevice.devices(for: AVMediaType.video)
        guard let backCamera = captureDevices.first(where: { $0.position == .back }) else { return }
        let megapixels = backCamera.activeFormat.videoMaxZoomFactor // megapixels
        if let device = AVCaptureDevice.default(for: .video) {
            let aperture = device.activeFormat.videoMaxZoomFactor
            print("Aperture: \(aperture)")
        }
        print("Mega Pixels: \(megapixels)")
    }


}

