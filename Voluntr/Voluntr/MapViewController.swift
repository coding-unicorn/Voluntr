//
//  MapViewController.swift
//  Voluntr
//
//  Created by Admin on 2/11/23.
//

import MapKit
import CoreLocation


class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    let screenView = UIView()
    let header = Header()
    var mapView = MKMapView()
    let footer = Footer()
    
    let locationManager = CLLocationManager()
    var pinPointDispatchGroups: [DispatchGroup] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        view.backgroundColor = backgroundColors
        
        setUpScreenView(screenView: screenView, parentViewController: self)
        setUpHeader(header: header, titleText: "map", parentView: screenView)
        setUpFooter(footer: footer, parentViewController: self, parentView: self.view)
        
        addPins()
        
        self.view.bringSubviewToFront(self.footer)
    }
    
    
    func setUpMapDisplay() {
        mapView.delegate = self
        mapView.mapType = .hybrid // Dark Mode
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: header.bottomAnchor),
            mapView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            mapView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            mapView.bottomAnchor.constraint(equalTo: footer.topAnchor)
        ])
        
        startTracking()
    }
    
    func startTracking() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // Uses most battery life but is more accurate
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            render(location)
        }
    }
    func render(_ location: CLLocation) {
        // Zooming
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
        
        // Adding user's location
        let userLocation = mapPin(title: "me", subtitle: "my location", coordinate: coordinate, row: 1)
        let pinImage = mapUserLocationImage
        let imageWidth = CGFloat(40)
        let imageHeight = imageWidth * ((pinImage?.size.height)! / (pinImage?.size.width)!)
        let imageSize = CGSize(width: imageWidth, height: imageHeight)
        UIGraphicsBeginImageContext(imageSize)
        pinImage!.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        userLocation.image = resizedImage
        mapView.addAnnotation(userLocation)
        mapView.selectAnnotation(userLocation, animated: true)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? mapPin {
            let identifier = "identifier"
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.image = annotation.image
            annotationView.canShowCallout = true
            annotationView.calloutOffset = CGPoint(x: -5, y: 5)
            annotationView.leftCalloutAccessoryView = UIImageView(image: annotation.image)
            
            // Adding a button if it is not the user's location
            //if annotation.row != 2 {
                let shareButton = UIButton(type: .system)
                annotationView.rightCalloutAccessoryView = shareButton
                shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
                shareButton.setTitle("share", for: .normal)
                shareButton.tag = annotation.row
                shareButton.titleLabel?.font = UIFont(name: mainFont, size: CGFloat(buttonFontSize))
                shareButton.setBackgroundColor(buttonColor, forState: .normal)
                shareButton.setBackgroundColor(buttonSelectedColor, forState: .selected)
                shareButton.setTitleColor(buttonTextColor, for: .normal)
                shareButton.setTitleColor(buttonTextColor, for: .selected)
                shareButton.layer.cornerRadius = CGFloat(buttonCornerRadius - 10);
                shareButton.clipsToBounds = true
                shareButton.translatesAutoresizingMaskIntoConstraints = false
                shareButton.frame = CGRect(x: 0, y: 0, width: 70, height: 25)
            //}
            
            return annotationView
        }
        
        return nil
    }
    
    func addPins() {
        for row in 0..<allGroups.count {
            // Setting the description / text
            let coordinate = CLLocationCoordinate2D(latitude: Double(allGroups[row]["latitude"]!)!, longitude: Double(allGroups[row]["longitude"]!)!)
            let pinLocation = mapPin(title: allGroups[row]["groupname"]!, subtitle: allGroups[row]["description"]!, coordinate: coordinate, row: row)
            
            // Image
            let imageWidth = CGFloat(40)
            let imageHeight = imageWidth * ((mapPinImage?.size.height)! / (mapPinImage?.size.width)!)
            let imageSize = CGSize(width: imageWidth, height: imageHeight)
            UIGraphicsBeginImageContext(imageSize)
            mapPinImage!.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            pinLocation.image = resizedImage
            
            // Adding the point to the map
            mapView.addAnnotation(pinLocation)
            self.mapView.deselectAnnotation(pinLocation, animated: false)
        }
        
        setUpMapDisplay()
    }
    
    // Sharing
    @objc func share(sender: UIButton) {
        let row = sender.tag
        let subjectText = "\(allGroups[row]["groupname"]!)"
        let readMoreText = "\n\n\nFind more oppurtunites on the Voluntr app!"
        let descriptionText = "\n\n\(allGroups[row]["description"]!)"
        
        var shareViewController = UIActivityViewController(activityItems: [subjectText, readMoreText], applicationActivities: nil)
        
        let image = logo
        shareViewController = UIActivityViewController(activityItems: [image!, subjectText, descriptionText, readMoreText], applicationActivities: nil)
        if descriptionText == "\n\n" {
            shareViewController = UIActivityViewController(activityItems: [image!, subjectText, readMoreText], applicationActivities: nil)
        }
        
        // Pre-configuring activity items
        shareViewController.activityItemsConfiguration = [UIActivity.ActivityType.message] as? UIActivityItemsConfigurationReading
        
        // Anything you want to exclude
        shareViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo
        ]
        
        shareViewController.popoverPresentationController?.sourceView = self.view
        self.present(shareViewController, animated: true, completion: nil)
    }
}


class mapPin: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    let row: Int
    var image: UIImage? = nil
    
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D, row: Int) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.row = row
        super.init()
    }
}
