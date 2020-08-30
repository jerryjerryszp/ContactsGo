//
//  ContactTableViewCellTests.swift
//  ContactsGoTests
//
//  Created by Jerry Shi on 2020-08-30.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import XCTest
@testable import ContactsGo

class ContactTableViewCellTests: XCTestCase {
    // MARK: Properties
    var viewController: ViewController!
    var contactTableViewCell: ContactTableViewCell!
    let contactModel = ContactModel(givenName: "Test", familyName: "Person", phoneNumber: "1234567890", email: "test@person.com", address: nil, jobTitle: "goodjob", imageData: nil)
    let contactModelWithoutEmailOrPhone = ContactModel(givenName: "Great", familyName: "Guy", phoneNumber: nil, email: nil, address: nil, jobTitle: "greatjob", imageData: nil)

    // MARK: Setup and teardown
    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: Constants.Storyboard.mainStoryboardName, bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier:
            String(describing: ViewController.self)) as? ViewController
        
        let _ = viewController.view
        
        contactTableViewCell = viewController.tableView?.dequeueReusableCell(withIdentifier: "ContactTableViewCell") as? ContactTableViewCell
    }
    
    func testViewDidLoad_ShouldHaveOutlets() {
        // Assertions
        XCTAssertNotNil(contactTableViewCell.imageViewContainer)
        XCTAssertNotNil(contactTableViewCell.avatarImageView)
        XCTAssertNotNil(contactTableViewCell.nameLabel)
        XCTAssertNotNil(contactTableViewCell.detailsLabel)
    }
    
    func testConfigureCell() {
        let contactViewModel = ContactViewModel(contact: contactModel)
        contactTableViewCell.configureCell(contact: contactViewModel)
        
        // Assertions
        XCTAssertEqual(contactTableViewCell.nameLabel.text, "Test Person")
        XCTAssertEqual(contactTableViewCell.detailsLabel.text, "Email: test@person.com")
    }
    
    func testConfigureCell_withoutEmailOrPhone() {
        let contactViewModel = ContactViewModel(contact: contactModelWithoutEmailOrPhone)
        contactTableViewCell.configureCell(contact: contactViewModel)
        
        // Assertions
        XCTAssertEqual(contactTableViewCell.nameLabel.text, "Great Guy")
        XCTAssertEqual(contactTableViewCell.detailsLabel.text, "Phone: none")
    }
}
