//
//  ProgressUpdateTableViewController.swift
//  Progress Journal
//
//  Created by Aleksander Waage on 24/06/2020.
//  Copyright © 2020 Waageweb. All rights reserved.
//

import UIKit

class ProgressUpdateTableViewController: UITableViewController {
    
    var progressUpdateItems: [ProgressUpdate] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
        
    func loadData(){
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let progressUpdateItemsFromCD = try? context.fetch(ProgressUpdate.fetchRequest()) as? [ProgressUpdate]{
                progressUpdateItems = progressUpdateItemsFromCD
            }
        }
        tableView.reloadData()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return progressUpdateItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "progressUpdateCellId", for: indexPath)
        
        let progressUpdateItem = progressUpdateItems[indexPath.row]
        if let imageData = progressUpdateItem.image {
            cell.imageView?.image = UIImage(data: imageData)
        }
        
        cell.textLabel?.text = progressUpdateItem.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProgressUpdate = progressUpdateItems[indexPath.row]
        performSegue(withIdentifier: "goToCreateProgressUpdate", sender: selectedProgressUpdate)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                context.delete(progressUpdateItems[indexPath.row])
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                loadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if let createProgressUpdateVC = segue.destination as? CreateProgressUpdateViewController {
            if let selectedProgressUpdateItem = sender as? ProgressUpdate {
                createProgressUpdateVC.progressUpdateItem = selectedProgressUpdateItem
            }
            
            
        }
    }
    

}
