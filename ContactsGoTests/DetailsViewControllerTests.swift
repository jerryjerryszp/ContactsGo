//
//  DetailsViewControllerTests.swift
//  ContactsGoTests
//
//  Created by Jerry Shi on 2020-08-30.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import XCTest
@testable import ContactsGo

class DetailsViewControllerTests: XCTestCase {
    // MARK: Properties
    var detailsViewController: DetailsViewController!
    let contactModel = ContactModel(givenName: "Test", familyName: "Person", phoneNumber: "1234567890", email: "test@person.com", address: nil, jobTitle: "goodjob", imageData: nil)

    // MARK: Setup and teardown
    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: Constants.Storyboard.mainStoryboardName, bundle: nil)
        detailsViewController = storyboard.instantiateViewController(withIdentifier:
            String(describing: DetailsViewController.self)) as? DetailsViewController
        
        let _ = detailsViewController.view
    }
    
    func testViewDidLoad_ShouldHaveOutlets() {
        // Assertions
        XCTAssertNotNil(detailsViewController.headerViewHeightConstraint)
        XCTAssertNotNil(detailsViewController.headerView)
        XCTAssertNotNil(detailsViewController.thumbnailImageView)
        XCTAssertNotNil(detailsViewController.fullnameLabel)
        XCTAssertNotNil(detailsViewController.detailsTableView)
    }
    
    func testInitializaton_ShouldHaveProperties() {
        // Assertions
        XCTAssertEqual(detailsViewController.maxHeaderHeight, 180.0)
        XCTAssertEqual(detailsViewController.minHeaderHeight, 80.0)
        XCTAssertEqual(detailsViewController.previousScrollOffset, 0.0)
    }
    
    func testSetupViews_ShouldSetupViews() {
        detailsViewController.contactViewModel = ContactViewModel(contact: contactModel)
        detailsViewController.setupViews()
        
        // Assertions
        XCTAssertEqual(detailsViewController.fullnameLabel.text, "Test Person")
    }
    
    func testSetupTableView_ShouldSetupTableView() {
        detailsViewController.setupTableView()
        
        // Assertions
        XCTAssertFalse(detailsViewController.detailsTableView.allowsSelection)
        XCTAssertEqual(detailsViewController.detailsTableView.separatorStyle, .none)
    }
    
    func testTableViewDataSource_NumberOfSections_ShouldReturnOne() {
        // Assertions
        XCTAssertEqual(detailsViewController.detailsTableView.numberOfSections, 1)
    }
    
    func testTableViewDataSource_NumberOfRows_ShouldReturnFour() {
        let contactViewModel = ContactViewModel(contact: contactModel)
        detailsViewController.contactViewModel = contactViewModel
        
        // Assertions
        XCTAssertEqual(detailsViewController.detailsTableView.numberOfRows(inSection: 0), 4)
    }
}
