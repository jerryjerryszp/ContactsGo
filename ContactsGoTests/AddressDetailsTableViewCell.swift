//
//  AddressDetailsTableViewCell.swift
//  ContactsGoTests
//
//  Created by Jerry Shi on 2020-08-30.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import XCTest
import Contacts
import MapKit
@testable import ContactsGo

class AddressDetailsTableViewCellTests: XCTestCase {
    // MARK: Properties
    var detailsViewController: DetailsViewController!
    var addressDetailsTableViewCell: AddressDetailsTableViewCell!
    var address = CNMutablePostalAddress()

    // MARK: Setup and teardown
    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: Constants.Storyboard.mainStoryboardName, bundle: nil)
        detailsViewController = storyboard.instantiateViewController(withIdentifier:
            String(describing: DetailsViewController.self)) as? DetailsViewController
        
        let _ = detailsViewController.view
        
        addressDetailsTableViewCell = detailsViewController.detailsTableView?.dequeueReusableCell(withIdentifier: "AddressDetailsTableViewCell") as? AddressDetailsTableViewCell
    }
    
    func testViewDidLoad_ShouldHaveOutlets() {
        // Assertions
        XCTAssertNotNil(addressDetailsTableViewCell.addressContainerView)
        XCTAssertNotNil(addressDetailsTableViewCell.addressLabel)
        XCTAssertNotNil(addressDetailsTableViewCell.mapView)
    }
    
    func testConfigureCell() {
        address.street = "165 Davis Street"
        address.city = "Hillsborough"
        address.state = "CA"
        address.postalCode = "94010"
        
        let contactModel = ContactModel(givenName: "Test", familyName: "Person", phoneNumber: "1234567890", email: "test@person.com", address: address, jobTitle: "goodjob", imageData: nil)
        let contactViewModel = ContactViewModel(contact: contactModel)
        
        addressDetailsTableViewCell.configureCell(contact: contactViewModel)
        
        // Assertions
        XCTAssertEqual(addressDetailsTableViewCell.addressLabel.text, "165 Davis Street\nHillsborough CA 94010")
    }
    
    func testCoordinates() {
        let addressString = "165 Davis Street\nHillsborough CA 94010"
        
        addressDetailsTableViewCell.coordinates(forAddress: addressString) { (location) in
            guard let location = location else {
                XCTFail()
                return
            }
            
            // Assertions
            let lat = round(CGFloat(location.latitude) * 1000) / 1000
            let long = round(CGFloat(location.longitude) * 1000) / 1000
            XCTAssertEqual(lat, 37.595)
            XCTAssertEqual(long, -122.37)
        }
    }
}
