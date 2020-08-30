//
//  ContactViewModel.swift
//  ContactsGo
//
//  Created by Jerry Shi on 2020-08-29.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import Foundation
import UIKit
import Contacts

/// This struct implements the contact view model
struct ContactViewModel {
    let givenName: String
    let familyName: String
    let fullName: String
    let phone: String
    let email: String
    let address: String?
    let jobTitle: String?
    let imageData: Data?
    
    // Dependency Injection
    /**
     Initialize the contact view model
    
     - Parameters:
         -  contact: The contact model to be used to initialize the contact view model
     */
    init(contact: ContactModel) {
        self.givenName = contact.givenName ?? ""
        self.familyName = contact.familyName ?? ""
        self.fullName = [self.givenName, self.familyName]
            .compactMap{$0}
            .joined(separator: " ")
        self.phone = contact.phone ?? ""
        self.email = contact.email ?? ""
        
        if let address = contact.address {
            self.address = CNPostalAddressFormatter.string(from: address, style: .mailingAddress)
        } else {
            self.address = ""
        }
        
        self.jobTitle = contact.jobTitle ?? ""
        self.imageData = contact.imageData ?? nil
    }
}
