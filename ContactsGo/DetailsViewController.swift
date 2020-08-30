//
//  DetailsViewController.swift
//  ContactsGo
//
//  Created by Jerry Shi on 2020-08-30.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import UIKit
import LetterAvatarKit

/// This class implements the details view controller
class DetailsViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var detailsTableView: UITableView!
    
    // MARK: Properties
    var contactViewModel: ContactViewModel?
    let maxHeaderHeight: CGFloat = 180.0
    let minHeaderHeight: CGFloat = 80.0
    var previousScrollOffset: CGFloat = 0.0
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        setupViews()
        setupTableView()
    }
    
    // MARK: Helpers
    /**
     Sets up views
     */
    func setupViews() {
        guard let contact = contactViewModel else {
            return
        }
        
        fullnameLabel.text = contact.fullName
        
        if let imageData = contact.imageData {
            let thumbnailImage = UIImage(data: imageData)
            thumbnailImageView.image = thumbnailImage
        } else {
            let avatarImage = LetterAvatarMaker()
                .setCircle(true)
                .setLettersFont(UIFont(name: "Arial", size: 30))
                .setUsername(contact.fullName).setLettersColor(.white)
                .setBackgroundColors([Constants.Color.lightAvatarBackgroundColor])
                .build()
            
            thumbnailImageView.image = avatarImage
        }
    }
    
    /**
     Sets up the table view
     */
    func setupTableView() {
        detailsTableView.register(
            UINib(nibName: String(describing: InfoDetailsTableViewCell.self), bundle: nil),
            forCellReuseIdentifier: String(describing: InfoDetailsTableViewCell.self)
        )
        detailsTableView.register(
            UINib(nibName: String(describing: AddressDetailsTableViewCell.self), bundle: nil),
            forCellReuseIdentifier: String(describing: AddressDetailsTableViewCell.self)
        )
        
        detailsTableView.rowHeight = UITableView.automaticDimension
        detailsTableView.separatorStyle = .none
        detailsTableView.allowsSelection = false
    }
    
    /**
     Set current scroll position
     */
    func setScrollPosition() {
        detailsTableView.contentOffset = CGPoint(x: 0, y: 0)
    }
}

/// This implements UITableViewDataSource protocol.
extension DetailsViewController: UITableViewDataSource {
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < 3 {
            return 68.0
        } else {
            guard let contact = contactViewModel else {
                return 0.0
            }
            
            if contact.address == "" {
                return 0.0
            } else {
                return 120.0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let scopes = ["Job Title", "Phone", "Email"]
        
        if indexPath.row < 3 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.InfoDetailsTableViewCell.InfoDetailsTableViewCellReuseIdentifier,
                for: indexPath) as! InfoDetailsTableViewCell
            
            guard let contact = contactViewModel else {
                return cell
            }
            
            cell.configureCell(contact: contact, scope: scopes[indexPath.row])
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.AddressDetailsTableViewCell.AddressDetailsTableViewCellReuseIdentifier,
                for: indexPath) as! AddressDetailsTableViewCell
            
            guard let contact = contactViewModel else {
                return cell
            }
            
            cell.configureCell(contact: contact)
            
            return cell
        }
    }
}

/// This implements UISearchBarDelegate protocol.
extension DetailsViewController: UITableViewDelegate {
    // MARK: UITableViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollDiff = (scrollView.contentOffset.y - previousScrollOffset)
        let isScrollingDown = scrollDiff > 0
        let isScrollingUp = scrollDiff < 0
        var newHeight = headerViewHeightConstraint.constant
        
        if isScrollingDown {
            newHeight = max(
                minHeaderHeight,
                headerViewHeightConstraint.constant - abs(scrollDiff)
            )
        } else if isScrollingUp {
            newHeight = min(
                maxHeaderHeight,
                headerViewHeightConstraint.constant + abs(scrollDiff)
            )
        }
        
        if newHeight != headerViewHeightConstraint.constant {
            headerViewHeightConstraint.constant = newHeight
            setScrollPosition()
            previousScrollOffset = scrollView.contentOffset.y
            
            if newHeight < maxHeaderHeight {
                let offset = minHeaderHeight + newHeight - maxHeaderHeight
                let alpha = offset/minHeaderHeight
                thumbnailImageView.alpha = alpha
            }
        }
    }
}
