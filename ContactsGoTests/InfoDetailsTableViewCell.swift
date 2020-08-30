//
//  InfoDetailsTableViewCell.swift
//  ContactsGoTests
//
//  Created by Jerry Shi on 2020-08-30.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import XCTest
@testable import ContactsGo

class InfoDetailsTableViewCellTests: XCTestCase {
    // MARK: Properties
    var detailsViewController: DetailsViewController!
    var infoDetailsTableViewCell: InfoDetailsTableViewCell!
    let contactModel = ContactModel(givenName: "Test", familyName: "Person", phoneNumber: "1234567890", email: "test@person.com", address: nil, jobTitle: "goodjob", imageData: nil)

    // MARK: Setup and teardown
    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: Constants.Storyboard.mainStoryboardName, bundle: nil)
        detailsViewController = storyboard.instantiateViewController(withIdentifier:
            String(describing: DetailsViewController.self)) as? DetailsViewController
        
        let _ = detailsViewController.view
        
        infoDetailsTableViewCell = detailsViewController.detailsTableView?.dequeueReusableCell(withIdentifier: "InfoDetailsTableViewCell") as? InfoDetailsTableViewCell
    }
    
    func testViewDidLoad_ShouldHaveOutlets() {
        // Assertions
        XCTAssertNotNil(infoDetailsTableViewCell.titleLabel)
        XCTAssertNotNil(infoDetailsTableViewCell.detailLabel)
    }
    
    func testConfigureCell_ScopeIsPhone() {
        let contactViewModel = ContactViewModel(contact: contactModel)
        infoDetailsTableViewCell.configureCell(contact: contactViewModel, scope: "Phone")
        
        // Assertions
        XCTAssertEqual(infoDetailsTableViewCell.titleLabel.text, "Phone")
        XCTAssertEqual(infoDetailsTableViewCell.detailLabel.text, "1234567890")
        XCTAssertEqual(infoDetailsTableViewCell.detailLabel.textColor, UIColor.systemBlue)
    }
    
    func testConfigureCell_ScopeIsEmail() {
        let contactViewModel = ContactViewModel(contact: contactModel)
        infoDetailsTableViewCell.configureCell(contact: contactViewModel, scope: "Email")
        
        // Assertions
        XCTAssertEqual(infoDetailsTableViewCell.titleLabel.text, "Email")
        XCTAssertEqual(infoDetailsTableViewCell.detailLabel.text, "test@person.com")
    }
    
    func testConfigureCell_ScopeIsJobTitle() {
        let contactViewModel = ContactViewModel(contact: contactModel)
        infoDetailsTableViewCell.configureCell(contact: contactViewModel, scope: "Job Title")
        
        // Assertions
        XCTAssertEqual(infoDetailsTableViewCell.titleLabel.text, "Job Title")
        XCTAssertEqual(infoDetailsTableViewCell.detailLabel.text, "goodjob")
    }
}
