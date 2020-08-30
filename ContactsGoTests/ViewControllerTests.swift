//
//  ViewControllerTests.swift
//  ContactsGoTests
//
//  Created by Jerry Shi on 2020-08-30.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import XCTest
@testable import ContactsGo

class ViewControllerTests: XCTestCase {
    // MARK: Properties
    var viewController: ViewController!
    let contactModel1 = ContactModel(givenName: "one", familyName: "lastone", phoneNumber: "1234567890", email: "contact@one.com", address: nil, jobTitle: "jobone", imageData: nil)
    let contactModel2 = ContactModel(givenName: "two", familyName: "lasttwo", phoneNumber: "1234567890", email: "contact@two.com", address: nil, jobTitle: "jobtwo", imageData: nil)

    // MARK: Setup and teardown
    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: Constants.Storyboard.mainStoryboardName, bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier:
            String(describing: ViewController.self)) as? ViewController
        
        let _ = viewController.view
    }
    
    func testViewDidLoad_ShouldHaveOutlets() {
        // Assertions
        XCTAssertNotNil(viewController.tableView)
        XCTAssertNotNil(viewController.searchBar)
    }
    
    func testInitializaton_ShouldHaveProperties() {
        // Assertions
        XCTAssertNotNil(viewController.contactViewModels)
        XCTAssertNotNil(viewController.filteredContactViewModels)
    }
    
    func testSetupTableView_ShouldSetupTableView() {
        viewController.setupTableView()
        
        // Assertions
        XCTAssertTrue(viewController.tableView.allowsSelection)
        XCTAssertEqual(viewController.tableView.separatorStyle, .none)
        XCTAssertEqual(viewController.searchBar.barTintColor, UIColor.white)
    }
    
    func testTableViewDataSource_NumberOfSections_ShouldReturnOne() {
        // Assertions
        XCTAssertEqual(viewController.tableView.numberOfSections, 1)
    }
    
    func testTableViewDataSource_NumberOfRows_ShouldReturnTwo() {
        let contactViewModel1 = ContactViewModel(contact: contactModel1)
        let contactViewModel2 = ContactViewModel(contact: contactModel2)
        viewController.contactViewModels = [contactViewModel1, contactViewModel2]
        
        // Assertions
        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), 2)
    }
    
    func testStrippedToOnlyNumbers() {
        let string = "666asdf-()* 777"
        let newString = string.strippedToOnlyNumbers
        
        // Assertions
        XCTAssertEqual(newString, "666777")
    }
}
