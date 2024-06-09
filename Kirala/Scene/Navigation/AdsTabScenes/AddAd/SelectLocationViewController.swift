import UIKit
import MapKit
import CoreLocation

protocol SelectLocationDelegate: AnyObject {
    func didSelectLocation(coordinate: CLLocationCoordinate2D, address: String)
}

class SelectLocationViewController: UIViewController, BackNavigatable {
    
    weak var delegate: SelectLocationDelegate?
    
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private lazy var selectNavigationButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(selectLocationTapped))
        button.tintColor = ColorPalette.appPrimary.dynamicColor
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorBackground.primary.dynamicColor
        setupNavigationBar()
        setupMapView()
        setupLocationManager()
    }
    
    private func setupMapView() {
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(mapTapped(_:)))
        mapView.addGestureRecognizer(tapGesture)
    }
    
    private func setupNavigationBar() {
        navigationItem.hidesBackButton = true
        addBackButton()
        navigationItem.rightBarButtonItem = selectNavigationButton
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    @objc private func mapTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        
        geocoder.reverseGeocodeLocation(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            if let error = error {
                print("Failed to get address: \(error.localizedDescription)")
            } else if let placemark = placemarks?.first {
                let street = placemark.thoroughfare ?? "Unknown Street"
                let city = placemark.locality ?? "Unknown City"
                annotation.title = "\(street), \(city)"
            }
        }
    }
    
    @objc private func selectLocationTapped() {
        guard let coordinate = mapView.annotations.first?.coordinate else { return }
        let address = mapView.annotations.first?.title ?? "Unknown Address"
        delegate?.didSelectLocation(coordinate: coordinate, address: address ?? "Unknown Address")
        navigationController?.popViewController(animated: true)
    }
    
    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension SelectLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let coordinate = location.coordinate
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            if let error = error {
                print("Failed to get address: \(error.localizedDescription)")
            } else if let placemark = placemarks?.first {
                let street = placemark.thoroughfare ?? "Unknown Street"
                let city = placemark.locality ?? "Unknown City"
                annotation.title = "\(street), \(city)"
            }
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
}
