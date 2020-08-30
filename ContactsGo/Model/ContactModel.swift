//
//  ContactModel.swift
//  ContactsGo
//
//  Created by Jerry Shi on 2020-08-29.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import Foundation
import Contacts

/// This struct implements the contact model
struct ContactModel {
    let givenName: String?
    let familyName: String?
    let phone: String?
    let email: String?
    let address: CNPostalAddress?
    let jobTitle: String?
    let imageData: Data?
    
    /**
     Initializes the contact model
    
     - Parameters:
         -  givenName: The given name of the contact
         - familyName: The family name of the contact
         - phoneNumber: The phone number of the contact
         - email: The email of the contact
         - address: The postal address of the contact
         - jobTitle: The job title of the contact
         - imageData: The thumbnail picture image data
     */
    init(givenName: String?, familyName: String?, phoneNumber: String?, email: String?, address: CNPostalAddress?, jobTitle: String?, imageData: Data?) {
        self.givenName = givenName
        self.familyName = familyName
        self.phone = phoneNumber
        self.email = email
        self.address = address
        self.jobTitle = jobTitle
        self.imageData = imageData
    }
}
