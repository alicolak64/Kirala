import UIKit

class PinchableImageView: UIImageView {
    
    private var pinchZoomHandler: PinchZoomHandler!
    
    // Configurable properties
    var zoomDelegate: ZoomingDelegate? {
        get { pinchZoomHandler.delegate }
        set { pinchZoomHandler.delegate = newValue }
    }
    
    var minZoomScale: CGFloat {
        get { pinchZoomHandler.minZoomScale }
        set { pinchZoomHandler.minZoomScale = abs(min(1.0, newValue)) }
    }
    
    var maxZoomScale: CGFloat {
        get { pinchZoomHandler.maxZoomScale }
        set { pinchZoomHandler.maxZoomScale = abs(max(1.0, newValue)) }
    }
    
    var resetAnimationDuration: Double {
        get { pinchZoomHandler.resetAnimationDuration }
        set { pinchZoomHandler.resetAnimationDuration = abs(newValue) }
    }
    
    var isZoomingActive: Bool {
        pinchZoomHandler.isZoomingActive
    }
    
    // Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        commonInit()
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        pinchZoomHandler = PinchZoomHandler(usingSourceImageView: self)
    }
}

protocol ZoomingDelegate: AnyObject {
    func pinchZoomHandlerStartPinching()
    func pinchZoomHandlerEndPinching()
}

private struct PinchZoomHandlerConstants {
    static let kMinZoomScaleDefaultValue: CGFloat = 1.0
    static let kMaxZoomScaleDefaultValue: CGFloat = 3.0
    static let kResetAnimationDurationDefaultValue = 0.3
    static let kIsZoomingActiveDefaultValue: Bool = false
}

private class PinchZoomHandler {
    
    // Configurable properties
    var minZoomScale: CGFloat = PinchZoomHandlerConstants.kMinZoomScaleDefaultValue
    var maxZoomScale: CGFloat = PinchZoomHandlerConstants.kMaxZoomScaleDefaultValue
    var resetAnimationDuration = PinchZoomHandlerConstants.kResetAnimationDurationDefaultValue
    var isZoomingActive: Bool = PinchZoomHandlerConstants.kIsZoomingActiveDefaultValue
    weak var delegate: ZoomingDelegate?
    weak var sourceImageView: UIImageView?
    
    private var zoomImageView: UIImageView = UIImageView()
    private var initialRect: CGRect = .zero
    private var zoomImageLastPosition: CGPoint = .zero
    private var lastTouchPoint: CGPoint = .zero
    private var lastNumberOfTouch: Int?
    
    // Initialization
    init(usingSourceImageView sourceImageView: UIImageView) {
        self.sourceImageView = sourceImageView
        setupPinchGesture(on: sourceImageView)
    }
    
    // Setup pinch gesture
    private func setupPinchGesture(on pinchContainer: UIView) {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(pinch:)))
        pinchGesture.cancelsTouchesInView = false
        pinchContainer.isUserInteractionEnabled = true
        pinchContainer.addGestureRecognizer(pinchGesture)
    }
    
    @objc private func handlePinchGesture(pinch: UIPinchGestureRecognizer) {
        guard let pinchableImageView = sourceImageView else { return }
        handlePinchMovement(pinchGesture: pinch, sourceImageView: pinchableImageView)
    }
    
    private func handlePinchMovement(pinchGesture: UIPinchGestureRecognizer, sourceImageView: UIImageView) {
        switch pinchGesture.state {
        case .began:
            guard !isZoomingActive, pinchGesture.scale >= minZoomScale else { return }
            guard let point = sourceImageView.superview?.convert(sourceImageView.frame.origin, to: nil) else { return }
            initialRect = CGRect(x: point.x, y: point.y, width: sourceImageView.frame.width, height: sourceImageView.frame.height)
            lastTouchPoint = pinchGesture.location(in: sourceImageView)
            zoomImageView = UIImageView(image: sourceImageView.image)
            zoomImageView.contentMode = sourceImageView.contentMode
            zoomImageView.frame = initialRect
            let anchorPoint = CGPoint(x: lastTouchPoint.x / initialRect.width, y: lastTouchPoint.y / initialRect.height)
            zoomImageView.layer.anchorPoint = anchorPoint
            zoomImageView.center = lastTouchPoint
            zoomImageView.frame = initialRect
            sourceImageView.alpha = 0.0
            if let window = sourceImageView.window {
                window.addSubview(zoomImageView)
            }
            zoomImageLastPosition = zoomImageView.center
            delegate?.pinchZoomHandlerStartPinching()
            isZoomingActive = true
            lastNumberOfTouch = pinchGesture.numberOfTouches
        case .changed:
            if pinchGesture.numberOfTouches != lastNumberOfTouch {
                lastTouchPoint = pinchGesture.location(in: sourceImageView)
            }
            let scale = zoomImageView.frame.width / initialRect.width
            let newScale = scale * pinchGesture.scale
            if !scale.isNaN && scale != .infinity {
                zoomImageView.frame = CGRect(
                    x: zoomImageView.frame.origin.x,
                    y: zoomImageView.frame.origin.y,
                    width: min(max(initialRect.width * newScale, initialRect.width * minZoomScale), initialRect.width * maxZoomScale),
                    height: min(max(initialRect.height * newScale, initialRect.height * minZoomScale), initialRect.height * maxZoomScale)
                )
                let centerXDif = lastTouchPoint.x - pinchGesture.location(in: sourceImageView).x
                let centerYDif = lastTouchPoint.y - pinchGesture.location(in: sourceImageView).y
                zoomImageView.center = CGPoint(x: zoomImageLastPosition.x - centerXDif, y: zoomImageLastPosition.y - centerYDif)
                pinchGesture.scale = 1.0
                lastNumberOfTouch = pinchGesture.numberOfTouches
                zoomImageLastPosition = zoomImageView.center
                lastTouchPoint = pinchGesture.location(in: sourceImageView)
            }
        case .ended, .cancelled, .failed:
            resetZoom()
        default:
            break
        }
    }
    
    private func resetZoom() {
        UIView.animate(withDuration: resetAnimationDuration, animations: {
            self.zoomImageView.frame = self.initialRect
        }) { _ in
            self.zoomImageView.removeFromSuperview()
            self.sourceImageView?.alpha = 1.0
            self.initialRect = .zero
            self.lastTouchPoint = .zero
            self.isZoomingActive = false
            self.delegate?.pinchZoomHandlerEndPinching()
        }
    }
}
