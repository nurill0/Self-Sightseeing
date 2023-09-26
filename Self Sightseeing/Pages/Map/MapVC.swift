//
//  MapVC.swift
//  Self Sightseeing
//
//  Created by Nurillo Domlajonov on 14/09/23.
//
import CoreLocation
import MapKit
import UIKit
import Firebase
import FirebaseDatabase

var savedPlaces: [String] = []
var savedLatitude: [Double] = []
var savedLongtitude: [Double] = []



class MapVC: BaseVC,CLLocationManagerDelegate {
    
    var lat  = 0.0
    var long = 0.0
    var regionInMeters: Double = 3900
    let locationManager = CLLocationManager()
    var previousLocation: CLLocation?
    var savelat = 0.0
    var savelong = 0.0
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.tintColor = .red
        map.showsUserLocation = true
        map.isPitchEnabled = true
        map.isRotateEnabled = false
        map.isZoomEnabled = true
        map.isExclusiveTouch = true
        map.mapType = .standard
        map.delegate = self
        
        return map
    }()
    
    lazy var pinImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "pinImage")
        img.contentMode = .scaleAspectFill
        
        
        return img
    }()
    
    lazy var userLocationBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "arrow"), for: .normal)
        btn.layer.cornerRadius = 30
        btn.imageView?.contentMode = .scaleAspectFill
        
        return btn
    }()
    
    lazy var addPinBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "addPin"), for: .normal)
        btn.layer.cornerRadius = 15
        btn.imageView?.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(goToAddPin), for: .touchUpInside)
        
        return btn
    }()
    
    let database = Database.database().reference(fromURL: "https://self-sightseeing-69ab7-default-rtdb.firebaseio.com/")
    var dbLat = 0.0
    var dbLong = 0.0
    var uDManager = UserDefaultsManager.shared
    let dbmanager = DatabaseManager.shared
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationServices()
        fetchAnnotations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAnnotations()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        checkLocationServices()
        userLocationBtn.addTarget(self, action: #selector(getUserLocation), for: .touchUpInside)
        fetchAnnotations()
    }
    
    
}




extension MapVC{
    
    func fetchAnnotations(){
        database.observe(.value) { [self] snap in
            if snap.childrenCount != nil {
                for i in 1...snap.childrenCount {
                    database.child("\(i)").observe(.value) { [self] snap, key  in
                        if let dictionary = snap.value as? [String: Any] {
                            self.dbLat = dictionary["latitude"] as! Double
                            self.dbLong = dictionary["longtitude"] as! Double
                            addAnnoitation(lat: dbLat, long: dbLong, title: "Pins")
                        }
                    }
                }
            }
        }
    }
    
    
    //MARK: Button actions
    @objc func goToAddPin(){
        let vc = AddPinVC()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.latForDB = savelat
        vc.longForDB = savelong
        present(vc, animated: true)
    }
    
    
    @objc func getUserLocation(){
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5 )
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    
    //    MARK: Annotation functions
    func addAnnoitation(lat: Double, long: Double,title: String){
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let pin = MKPointAnnotation()
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5 )
        pin.coordinate = coordinate
        pin.title = "Pinned Places"
        mapView.delegate = self
        mapView.addAnnotation(pin)
        mapView.showAnnotations([pin], animated: true)
    }
    
}



//MARK: UI
extension MapVC{
    
    
    private func initViews(){
        bgImage.isHidden = true
        view.bringSubviewToFront(backBtn)
        mapViewConst()
        pinImageConst()
        addPinBtnConst()
        userLocbtnConst()
    }
    
    
    fileprivate func mapViewConst(){
        view.addSubview(mapView)
        view.sendSubviewToBack(mapView)
        mapView.top(view.topAnchor)
        mapView.bottom(view.bottomAnchor)
        mapView.right(view.rightAnchor)
        mapView.left(view.leftAnchor)
    }
    
    
    fileprivate func pinImageConst(){
        mapView.addSubview(pinImage)
        pinImage.centerY(mapView.centerYAnchor, -20)
        pinImage.centerX(mapView.centerXAnchor)
        pinImage.height(40)
        pinImage.width(40)
    }
    
    
    fileprivate func userLocbtnConst(){
        view.addSubview(userLocationBtn)
        userLocationBtn.bottom(addPinBtn.topAnchor)
        userLocationBtn.right(view.rightAnchor, -20)
        userLocationBtn.height(60)
        userLocationBtn.width(60)
    }
    
    
    fileprivate func addPinBtnConst(){
        view.addSubview(addPinBtn)
        addPinBtn.bottom(view.safeAreaLayoutGuide.bottomAnchor)
        addPinBtn.right(view.rightAnchor, -10)
        addPinBtn.height(90)
        addPinBtn.width(110)
    }
    
}



//MARK: mapview delegate
extension MapVC: MKMapViewDelegate{
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        lat = (locations.last?.coordinate.latitude)!
        long = (locations.last?.coordinate.longitude)!
        guard let previousLocation = self.previousLocation else { return }
        guard center.distance(from: previousLocation) > 100 else { return }
        self.previousLocation = center
        
        geoCoder.reverseGeocodeLocation(center) { [weak self]  (placemarks, error) in
            guard self != nil else {
                return }
            if let _ = error {
                //show alert informing to user
                print(error!)
                return
            }
            guard let placemarks = placemarks?.first else {
                //show alert informing to user
                return
            }
            let coordinates = placemarks.location
            self?.savelat = coordinates?.coordinate.latitude ?? 0.0
            self?.savelong = coordinates?.coordinate.longitude ?? 0.0
        }
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // Handle the tap event here
        if view.annotation != nil {
            let vc = PinVC()
            for i in 1...uDManager.getDataCount() {
                database.child("\(i)").observe(.value) { [self] snap, key  in
                    if let dictionary = snap.value as? [String: Any] {
                        self.dbLat = dictionary["latitude"] as! Double
                        self.dbLong = dictionary["longtitude"] as! Double
                        if view.annotation?.coordinate.latitude == dbLat && view.annotation?.coordinate.longitude == dbLong {
                            uDManager.setIdForDB(count: i)
                            print(uDManager.getIdForDB())
                            vc.modalTransitionStyle = .crossDissolve
                            vc.modalPresentationStyle = .fullScreen
                            present(vc, animated: true)
                        }
                    }
                }
            }
        }
    }
    
    
}



//map functions
extension MapVC {
    
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longtitude = mapView.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longtitude)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    
    func startTackingUserLocation(){
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    func centerViewOnUserLocation(){
        DispatchQueue.main.async { [self] in
            if let location = locationManager.location?.coordinate {
                let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
                mapView.setRegion(region, animated: true)
            }
        }
    }
    
    
    func checkLocationServices() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.setupLocationManager()
                self.checkLocationAuthorization()
            }
        }
    }
    
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTackingUserLocation()
        case .denied:
            // Show alert instructing them how to turn on permissions break
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert letting them know what's up
            break
        case .authorizedAlways:
            //
            break
        default:
            //
            break
        }
    }
    
}
