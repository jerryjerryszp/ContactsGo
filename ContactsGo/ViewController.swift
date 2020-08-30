//
//  ViewController.swift
//  ContactsGo
//
//  Created by Jerry Shi on 2020-08-28.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import UIKit
import Contacts
import JGProgressHUD
import os.log

/// This class implements the view controller that contains the table view
class ViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: Properties
    var contactViewModels = [ContactViewModel]() {
        didSet {
            filteredContactViewModels = contactViewModels
            tableView.reloadData()
        }
    }
    var filteredContactViewModels = [ContactViewModel]()
    lazy var loadingProgressHUD: JGProgressHUD = {
        let loadingProgressHUD = JGProgressHUD(style: .dark)
        if let indicatorView = loadingProgressHUD.indicatorView as? JGProgressHUDIndeterminateIndicatorView {
            indicatorView.setColor(UIColor.lightText)
        }
        
        return loadingProgressHUD
    }()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupTableView()
        loadContactsIfNeeded()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Storyboard.createStoryboardSegueIdentifier(
            forClassName: String(describing: DetailsViewController.self)) {
            let detailsViewController = segue.destination as! DetailsViewController
            detailsViewController.contactViewModel = sender as? ContactViewModel
        }
    }
    
    // MARK: Helpers
    /**
     Sets up the table view
     */
    func setupTableView() {
        tableView.register(
            UINib(nibName: String(describing: ContactTableViewCell.self), bundle: nil),
            forCellReuseIdentifier: String(describing: ContactTableViewCell.self)
        )
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        searchBar.barTintColor = UIColor.white
        // This is a trick to remove the separator
        // between the search bar and the table view cells :)
        searchBar.setBackgroundImage(UIImage.init(), for: .any, barMetrics: .default)
    }
    
    /**
     Load the fetched contacts to the contact view models
     */
    func loadContactsIfNeeded() {
        loadingProgressHUD.show(in: view)

        fetchContacts { [weak self] (contacts) in
            guard let strongSelf = self else {
                return
            }
            
            contacts.forEach { (contact) in
                var primaryPhone = ""
                var primaryEmail = ""
                var primaryAddress: CNPostalAddress? = nil
                var imageData: Data? = nil
                
                if let phoneNumber = contact.phoneNumbers.first?.value {
                    primaryPhone = phoneNumber.stringValue
                }
                
                if let emailAddress = contact.emailAddresses.first?.value {
                    primaryEmail = emailAddress as String
                }
                
                if let thumbnailImageData = contact.thumbnailImageData {
                    imageData = thumbnailImageData
                }
                
                if let postalAddress = contact.postalAddresses.first {
                    primaryAddress = postalAddress.value
                }
                
                let contactModel = ContactModel(
                    givenName: contact.givenName,
                    familyName: contact.familyName,
                    phoneNumber: primaryPhone,
                    email: primaryEmail,
                    address: primaryAddress,
                    jobTitle: contact.jobTitle,
                    imageData: imageData ?? nil
                )
                
                strongSelf.contactViewModels.append(ContactViewModel(contact: contactModel))
            }
            
            if contacts.count > 0 {
                strongSelf.tableView.reloadData()
            }
        }
    }
    
    /**
     Fetch contacts from the contact store async
    
     - Parameters:
         -  completion: The completion handler
     */
    func fetchContacts(completion: @escaping (_ result: [CNContact]) -> Void) {
        let customLog = OSLog(
            subsystem: Constants.Error.appDomain,
            category: Constants.Error.ContactStoreErrorCategory
        )
        
        DispatchQueue.main.async {
            var results = [CNContact]()
            let keys = [
                CNContactGivenNameKey,
                CNContactFamilyNameKey,
                CNContactPhoneNumbersKey,
                CNContactEmailAddressesKey,
                CNContactPostalAddressesKey,
                CNContactJobTitleKey,
                CNContactThumbnailImageDataKey
            ] as [CNKeyDescriptor]

            let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
            fetchRequest.sortOrder = .userDefault
            
            let store = CNContactStore()
            
            store.requestAccess(for: .contacts) { [weak self] (granted, error) in
                guard let strongSelf = self else {
                    return
                }
                
                if let error = error {
                    strongSelf.loadingProgressHUD.dismiss()
                    print("Failed to request access", error)
                    os_log("%@", log: customLog, type: .debug, Constants.Error.AccessError)
                }
                
                if granted {
                    do {
                        try store.enumerateContacts(with: fetchRequest, usingBlock: { (contact, stop) -> Void in
                            results.append(contact)
                        })
                        
                        strongSelf.loadingProgressHUD.dismiss()
                    } catch let error {
                        strongSelf.loadingProgressHUD.dismiss()
                        print(error.localizedDescription)
                        os_log("%@", log: customLog, type: .debug, Constants.Error.EnumerationError)
                    }
                    
                    completion(results)
                } else {
                    strongSelf.loadingProgressHUD.dismiss()
                    print("Error \(error?.localizedDescription ?? "")")
                    os_log("%@", log: customLog, type: .debug, Constants.Error.RequestError)
                }
            }
        }
    }
}

/// This implements UITableViewDelegate protocol.
extension ViewController: UITableViewDelegate {
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let contactViewModel = filteredContactViewModels[indexPath.row]
        performSegue(withIdentifier: Constants.Storyboard.showDetailsViewControllerSegue, sender: contactViewModel)
    }
}

/// This implements UITableViewDataSource protocol.
extension ViewController: UITableViewDataSource {
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContactViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.ContactTableViewCell.ContactTableViewCellReuseIdentifier,
            for: indexPath
            ) as! ContactTableViewCell
        
        let contact = filteredContactViewModels[indexPath.row]
        cell.configureCell(contact: contact)
        
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}

/// This implements UISearchBarDelegate protocol.
extension ViewController: UISearchBarDelegate {
    // MARK: UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredContactViewModels = contactViewModels
            tableView.reloadData()
            
            return
        }
        
        filteredContactViewModels = contactViewModels.filter({ (contactViewModel) -> Bool in
            return contactViewModel.fullName.lowercased().contains(searchText.lowercased())
                || contactViewModel.phone.strippedToOnlyNumbers.contains(searchText)
        })
        
        tableView.reloadData()
    }
}

extension String {
    var strippedToOnlyNumbers: String {
        let okayChars = Set("1234567890")
        return self.filter {
            okayChars.contains($0)
        }
    }
}
