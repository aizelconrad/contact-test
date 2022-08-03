//
//  ViewController.swift
//  Contacts New
//
//  Created by Aizel  on 03/08/22.
//

import UIKit
import Contacts
import ContactsUI

struct abc {
    let name: String
    let id: String
    let source: CNContact
}

class ViewController: UIViewController,UITableViewDataSource, CNContactPickerDelegate, UITableViewDelegate   {
    
    private let table: UITableView = {
        let table = UITableView()
        table.register( UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    var models = [abc]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(table)
        table.frame = view.bounds
        table.dataSource = self
        table.delegate = self
         
        // Do any additional setup after loading the view.
   
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    
    }
   @objc func didTapAdd(){
        let vc = CNContactPickerViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
 
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let name = contact.givenName + " " + contact.familyName
        let identifier = contact.identifier
        let view = abc(name: name, id: identifier, source: contact)
        
        models.append(view)
        table.reloadData()
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
        
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)
        
        let contact = models[indexPath.row].source
        let vc = CNContactViewController(for: contact)
        present(UINavigationController(rootViewController: vc), animated: true)
    }
     
    
}

