//
//  ContactModelTests.swift
//  ContactsGoTests
//
//  Created by Jerry Shi on 2020-08-30.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import XCTest
import Contacts
@testable import ContactsGo

class ContactModelTests: XCTestCase {
    // MARK: Properties
    var contactModel: ContactModel!
    var address = CNMutablePostalAddress()

    // MARK: Setup and teardown
    override func setUp() {
        super.setUp()

        address.street = "165 Davis Street"
        address.city = "Hillsborough"
        address.state = "CA"
        address.postalCode = "94010"
        
        contactModel = ContactModel(givenName: "Test", familyName: "Person", phoneNumber: "1234567890", email: "test@person.com", address: address, jobTitle: "goodjob", imageData: nil)
    }
    
    func testInit() {
        XCTAssertEqual(contactModel.givenName, "Test")
        XCTAssertEqual(contactModel.familyName, "Person")
        XCTAssertEqual(contactModel.phone, "1234567890")
        XCTAssertEqual(contactModel.email, "test@person.com")
        XCTAssertEqual(contactModel.address?.street, "165 Davis Street")
        XCTAssertEqual(contactModel.address?.city, "Hillsborough")
        XCTAssertEqual(contactModel.address?.state, "CA")
        XCTAssertEqual(contactModel.address?.postalCode, "94010")
        XCTAssertEqual(contactModel.jobTitle, "goodjob")
    }
}
