//
//  RadioButton.swift
//  Kirala
//
//  Created by Ali Çolak on 25.05.2024.
//

import UIKit

enum RadioButtonState {
    case checked
    case unchecked
    
    var isChecked: Bool {
        switch self {
        case .checked:
            return true
        case .unchecked:
            return false
        }
    }
    
    mutating func toggle() {
        self = self == .checked ? .unchecked : .checked
    }
    
}

enum RadioButtonStyle {
    case circle
    case checkmark
}

protocol RadioButtonDelegate: AnyObject {
    func didTapRadioButton()
}

protocol RadioButtonProtocol {
    var delegate: RadioButtonDelegate? { get set }
    var style: RadioButtonStyle { get set }
    var symbolSize: CGFloat { get set }
    func configure(with style: RadioButtonStyle)
    func setCheckedImage()
    func setUncheckedImage()
    func setSymbolSize(_ size: CGFloat)
}

final class RadioButton: UIButton, RadioButtonProtocol {
    
    weak var delegate: RadioButtonDelegate?
    var symbolSize: CGFloat = 12
        
    private lazy var checkedImage: UIImage = {
        let image = Symbols.checkmarkCircleFill.symbol(size: symbolSize)
        return image.withTintColor(ColorPalette.appPrimary.dynamicColor, renderingMode: .alwaysOriginal)
    }()
    
    private lazy var uncheckedImage: UIImage = {
        let image = Symbols.circle.symbol(size: symbolSize)
        return image.withTintColor(ColorPalette.gray.dynamicColor, renderingMode: .alwaysOriginal)
    }()
    
    var style: RadioButtonStyle = .checkmark {
        didSet {
            switch style {
            case .circle:
                checkedImage = Symbols.circleInsetFilled.symbol(size: symbolSize).withTintColor(ColorPalette.appPrimary.dynamicColor, renderingMode: .alwaysOriginal)
                uncheckedImage = Symbols.circle.symbol(size: symbolSize).withTintColor(.systemGray, renderingMode: .alwaysOriginal)
            case .checkmark:
                checkedImage = Symbols.checkmarkCircleFill.symbol(size: symbolSize).withTintColor(ColorPalette.appPrimary.dynamicColor, renderingMode: .alwaysOriginal)
                uncheckedImage = Symbols.circle.symbol(size: symbolSize).withTintColor(.systemGray, renderingMode: .alwaysOriginal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }

    private func commonInit() {
        self.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    func setCheckedImage() {
        self.setImage(checkedImage, for: .normal)
    }
    
    func setUncheckedImage() {
        self.setImage(uncheckedImage, for: .normal)
    }
    
    func configure(with style: RadioButtonStyle = .checkmark) {
        self.style = style
    }
    
    func setSymbolSize(_ size: CGFloat) {
        self.symbolSize = size
    }

    @objc func buttonClicked() {
        guard let delegate = delegate else {
            
            if self.imageView?.image == uncheckedImage {
                setCheckedImage()
            } else {
                setUncheckedImage()
            }
            
            return
        }
        delegate.didTapRadioButton()
    }
    
}

