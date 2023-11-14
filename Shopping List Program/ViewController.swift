//
//  ViewController.swift
//  Shopping List Program
//
//  Created by ANNAHLU RACLAWSKI on 11/1/23.
//

import UIKit

class ViewController: UIViewController, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var defaults = UserDefaults.standard
    
    var items = [String]()
    
    var selectedIndex: IndexPath? = nil
    
    var idk = ""
    
    var count = 0
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    
    @IBOutlet weak var textFieldOutlet: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        items.append("Billy")
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        
        idk = defaults.string(forKey: "theName") ?? ""
        
        if let blah = UserDefaults.standard.data(forKey: "theName") {
                        let decoder = JSONDecoder()
                        if let decoded = try? decoder.decode([String].self, from: blah) {
                            items = decoded
                        }
                }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
        cell.textLabel?.text = items[indexPath.row]
        cell.selectionStyle = .none
                if
                    let selectedRows = tableView.indexPathsForSelectedRows,
                    selectedRows.contains(indexPath)
                {
                    cell.accessoryType = .checkmark

                } else {
                    cell.accessoryType = .none
                }
        return cell
    }
    
    @IBAction func addButtonAction(_ sender: UIBarButtonItem) {
        let item = textFieldOutlet.text!
        for n in items {
            if item == n {
                //Alert Button
                let alert = UIAlertController(title: "Error!", message: "Added This Item Already", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
                count = count + 1
            }
        }
        if count == 0 {
            items.append(item)
        }
        //defaults.set(item, forKey: "theItem")
        self.tableViewOutlet.reloadData()
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    @IBAction func saveButtonAction(_ sender: UIBarButtonItem) {
        let encoder = JSONEncoder()
           if let encoded = try? encoder.encode(items) {
                            UserDefaults.standard.set(encoded, forKey: "theName")
                        }
    }
    
    @IBAction func sortButtonAction(_ sender: UIBarButtonItem) {
        for _ in items {
            items.sort()
        }
        self.tableViewOutlet.reloadData()
    }
    
    
    
}

