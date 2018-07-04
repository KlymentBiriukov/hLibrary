//
//  HLBooksListVC.swift
//  hLibrary
//
//  Created by Kliment Biriukov on 6/7/18.
//  Copyright © 2018 Biriukovs. All rights reserved.
//

import UIKit
import CoreData


class HLBooksListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var booksListTableView: UITableView!
    var books: [NSManagedObject] = []
    var managedContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        managedContext = HLDataManager.dataManager.persistentContainer.viewContext
        
        booksListTableView.register(UINib(nibName: "HLBooksOverviewCell", bundle: nil), forCellReuseIdentifier: "HLBooksOverviewCell")
        booksListTableView.tableFooterView = UIView.init(frame: CGRect.zero)
        booksListTableView.rowHeight = UITableViewAutomaticDimension
        booksListTableView.estimatedRowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let fetchRequest : NSFetchRequest<Book> = Book.fetchRequest()
        
        do {
            books = try managedContext.fetch(fetchRequest)
            booksListTableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    @IBAction func addNewBookAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "New book",
                                      message: "Enter book title and author",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            
            guard let titleTextField = alert.textFields?.first,
                let titleToSave = titleTextField.text else {
                    return
            }
            
            let authorTextField = alert.textFields?.last
            let authorToSave = authorTextField?.text
            
            self.saveBook(title: titleToSave, author: authorToSave)
            self.booksListTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Book title"
        }
        alert.addTextField{ (textField) in
            textField.placeholder = "Book author"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func saveBook(title: String, author: String?){
        
        let entity = NSEntityDescription.entity(forEntityName: "Book", in: managedContext)!
        let book = NSManagedObject(entity: entity, insertInto: managedContext) as! Book
        
        book.bookTitle = title
        book.author = author
        
        do {
            try managedContext.save()
            books.append(book)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let book = books[indexPath.row] as! Book
        let cell = tableView.dequeueReusableCell(withIdentifier: "HLBooksOverviewCell",
                                                 for: indexPath) as! HLBooksOverviewCell
        cell.titleLabel?.text = book.bookTitle
        cell.authorLabel?.text = book.author
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}

