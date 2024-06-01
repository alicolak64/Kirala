//
//  Lottie.swift
//  Kirala
//
//  Created by Ali Çolak on 1.06.2024.
//

import UIKit
import Lottie

protocol Lottiable {
    var animationName: String { get }
    var loopMode: LottieLoopMode { get }
    var speed: CGFloat { get }
    var contentMode: UIView.ContentMode { get }
}

enum Lottie: Lottiable {
    case loginSuccess
    
    var animationName: String {
        switch self {
        case .loginSuccess:
            return "login-success"
        }
    }
    
    var loopMode: LottieLoopMode {
        switch self {
        case .loginSuccess:
            return .playOnce
        }
    }
    
    var speed: CGFloat {
        switch self {
        case .loginSuccess:
            return 1.0
        }
    }
    
    var contentMode: UIView.ContentMode {
        switch self {
        case .loginSuccess:
            return .scaleAspectFit
        }
    }
}
