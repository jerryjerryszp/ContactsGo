//
//  Constants.swift
//  ContactsGo
//
//  Created by Jerry Shi on 2020-08-29.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    struct Storyboard {
        static let mainStoryboardName = "Main"
        static let storyboardPrefixSegueIdentifier = "Show"
        static func createStoryboardSegueIdentifier(forClassName className: String) -> String {
            return storyboardPrefixSegueIdentifier + className
        }
        
        static let showDetailsViewControllerSegue = "ShowDetailsViewController"
    }
    
    struct ContactTableViewCell {
        static let ContactTableViewCellReuseIdentifier = "ContactTableViewCell"
    }
    
    struct InfoDetailsTableViewCell {
        static let InfoDetailsTableViewCellReuseIdentifier = "InfoDetailsTableViewCell"
    }
    
    struct AddressDetailsTableViewCell {
        static let AddressDetailsTableViewCellReuseIdentifier = "AddressDetailsTableViewCell"
    }
    
    struct Color {
        static let lightAvatarBackgroundColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
    }
    
    struct Error {
        static let appDomain = "com.jerryszp6116.ContactsGo"
        
        static let ContactStoreErrorCategory = "Contact Store Error"
        
        static let AccessError = "Contact Store Access Error"
        static let EnumerationError = "Contacts Enumeration Error"
        static let RequestError = "Request Error"
    }
}
