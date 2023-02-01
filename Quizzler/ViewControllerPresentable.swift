//
//  ViewControllerPresentable.swift
//  Quizzler
//
//  Created by Дмитрий on 31.01.2023.
//

import SwiftUI

struct ViewControllerPresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
    }
}


