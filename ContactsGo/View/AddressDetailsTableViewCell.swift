//
//  AddressDetailsTableViewCell.swift
//  ContactsGo
//
//  Created by Jerry Shi on 2020-08-30.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import UIKit
import MapKit

/// This class implements the cell that represents the address details of the contact
class AddressDetailsTableViewCell: UITableViewCell {
    // MARK: IBOutlets
    @IBOutlet weak var addressContainerView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Public
    /**
     Configure address details table view cell
    
     - Parameters:
         -  contact: The contact view model to be populated to the cell
     */
    func configureCell(contact: ContactViewModel) {
        mapView.isUserInteractionEnabled = false
        
        if contact.address != "" {
            addressLabel.text = contact.address
            
            if let geoAddress = contact.address {
                drawOnMapView(address: geoAddress)
            }
        } else {
            addressContainerView.isHidden = true
        }
    }
    
    // MARK: Helpers
    /**
     Generate location with the provided address string
    
     - Parameters:
         - address: The address string to be used to create the location
         -  completion: The completion handler
     */
    func coordinates(forAddress address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard error == nil else {
                print("Geocoding error: \(error!)")
                completion(nil)
                return
            }
            
            completion(placemarks?.first?.location?.coordinate)
        }
    }
    
    /**
     Draw on map with the address string provided
    
     - Parameters:
         -  address: The address string to be used to draw the map
     */
    func drawOnMapView(address: String) {
        coordinates(forAddress: address) { [weak self] (location) in
            guard let strongSelf = self,
                let location = location else {
                print("Location Error")
                
                return
            }
            
            let center = CLLocationCoordinate2D(
                latitude: location.latitude,
                longitude: location.longitude
            )
            let span = MKCoordinateSpan(
                latitudeDelta: 0.01,
                longitudeDelta: 0.01
            )
            let region = MKCoordinateRegion(center: center, span: span)
            strongSelf.mapView.setRegion(region, animated: false)
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = location
            strongSelf.mapView.setRegion(region, animated: false)
            strongSelf.mapView.addAnnotation(annotation)
        }
    }
}
