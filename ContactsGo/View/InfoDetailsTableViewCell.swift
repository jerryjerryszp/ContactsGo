//
//  InfoDetailsTableViewCell.swift
//  ContactsGo
//
//  Created by Jerry Shi on 2020-08-30.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import UIKit

/// This class implements the cell that represents the info section of the contact details
class InfoDetailsTableViewCell: UITableViewCell {
    // MARK: IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Public
    /**
     Configure contact info table view cell
    
     - Parameters:
         -  contact: The contact view model to be populated to the cell
         - scope: The scope of the cell
     */
    func configureCell(contact: ContactViewModel, scope: String) {
        if scope == "Phone" {
            titleLabel.text = scope
            
            if contact.phone != "" {
                detailLabel.text = contact.phone
                detailLabel.textColor = UIColor.systemBlue
            } else {
                detailLabel.text = "Not specified"
            }
        } else if scope == "Email" {
            titleLabel.text = scope
            detailLabel.text = contact.email != "" ? contact.email : "Not specified"
        } else if scope == "Job Title" {
            titleLabel.text = scope
            detailLabel.text = contact.jobTitle != "" ? contact.jobTitle : "Not specified"
        }
    }
}
