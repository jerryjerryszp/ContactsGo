//
//  ContactViewModelTests.swift
//  ContactsGoTests
//
//  Created by Jerry Shi on 2020-08-30.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import XCTest
import Contacts
@testable import ContactsGo

class ContactViewModelTests: XCTestCase {
    // MARK: Properties
    var contactModel: ContactModel!
    var contactViewModel: ContactViewModel!
    var address = CNMutablePostalAddress()

    // MARK: Setup and teardown
    override func setUp() {
        super.setUp()

        address.street = "165 Davis Street"
        address.city = "Hillsborough"
        address.state = "CA"
        address.postalCode = "94010"
        
        contactModel = ContactModel(givenName: "Test", familyName: "Person", phoneNumber: "1234567890", email: "test@person.com", address: address, jobTitle: "goodjob", imageData: nil)
        contactViewModel = ContactViewModel(contact: contactModel)
    }
    
    func testInit() {
        XCTAssertEqual(contactViewModel.givenName, "Test")
        XCTAssertEqual(contactViewModel.familyName, "Person")
        XCTAssertEqual(contactViewModel.fullName, "Test Person")
        XCTAssertEqual(contactViewModel.phone, "1234567890")
        XCTAssertEqual(contactViewModel.email, "test@person.com")
        XCTAssertEqual(contactViewModel.address, "165 Davis Street\nHillsborough CA 94010")
        XCTAssertEqual(contactViewModel.jobTitle, "goodjob")
    }
}
