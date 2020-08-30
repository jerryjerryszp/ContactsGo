//
//  ContactTableViewCell.swift
//  ContactsGo
//
//  Created by Jerry Shi on 2020-08-29.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import Foundation
import UIKit
import LetterAvatarKit

/// This class implements the contact table view cell
class ContactTableViewCell: UITableViewCell {
    // MARK: IBOutlets
    @IBOutlet weak var imageViewContainer: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Public
    /**
     Configure contact table view cell
    
     - Parameters:
         -  contact: The contact view model to be populated to the cell
     */
    func configureCell(contact: ContactViewModel) {
        nameLabel.text = contact.fullName
        
        if contact.email == "" {
            let number = contact.phone == "" ? "none" : contact.phone
            detailsLabel.text = "Phone: " + number
        } else {
            detailsLabel.text = "Email: " + contact.email
        }
        
        if let imageData = contact.imageData {
            let thumbnailImage = UIImage(data: imageData)
            avatarImageView.image = thumbnailImage
        } else {
            let avatarImage = LetterAvatarMaker()
                .setCircle(true).setLettersFont(UIFont(name: "Arial", size: 30))
                .setUsername(contact.fullName).setLettersColor(.white)
                .setBackgroundColors([Constants.Color.lightAvatarBackgroundColor])
                .build()
            avatarImageView.image = avatarImage
        }
    }
}
