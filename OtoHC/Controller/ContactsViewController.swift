//
//  ContactsViewController.swift
//  
//
//  Created by NguyenDinhPhu on 05/07/2018.
//

import UIKit

class ContactsViewController: UIViewController ,UISearchBarDelegate ,UITableViewDataSource ,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBarContact: UISearchBar!
    var contacts: [Contact] = []
    var searchContact : [Contact] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBarContact.delegate = self
        searchBarContact.returnKeyType = UIReturnKeyType.done
        
        DataSerVice.share.getDataContact {[unowned self] contacts in
            self.contacts = contacts
            self.tableView.reloadData()
            
        }
        // Do any additional setup after loading the view.
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var number : Int?
        if (searchBarContact.text?.isEmpty)! {
            number = contacts.count
            
        }else{
            number = searchContact.count
            
        }
        return number!
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ConTactCell
        if (searchBarContact.text?.isEmpty)! {
            cell.nameMember.text = contacts[indexPath.row].FullName
            cell.numberphoneMember.text = contacts[indexPath.row].PhoneNumber
            cell.adressMember.text = contacts[indexPath.row].Address
        }else {
            cell.nameMember.text = searchContact[indexPath.row].FullName
            cell.numberphoneMember.text = searchContact[indexPath.row].PhoneNumber
            cell.adressMember.text = searchContact[indexPath.row].Address
        }
        
        cell.photoMember.layer.cornerRadius = cell.photoMember.frame.size.width/2
        cell.photoMember.layer.masksToBounds = true
        
        
        // Configure the cell   ...
        
        return cell
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == false {
            searchContact = contacts.filter({ contacts -> Bool in
                (contacts.FullName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil)
            })
        }
        tableView.reloadData()
    }
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let contactViewController = segue.destination as? ContactViewController
        
        let selectedCell = sender as? ConTactCell
        
        if let indexPath = tableView.indexPath(for: selectedCell!) {
            if searchContact.count != 0 {
                let selectedContact = searchContact[indexPath.row]
                contactViewController?.contact = selectedContact
            }else{
                let selectedContact = contacts[indexPath.row]
                contactViewController?.contact = selectedContact
            }
        }
    }

}
