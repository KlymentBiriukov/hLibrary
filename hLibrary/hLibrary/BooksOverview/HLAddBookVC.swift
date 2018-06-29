//
//  HLAddBookVC.swift
//  hLibrary
//
//  Created by Kliment Biriukov on 6/27/18.
//  Copyright © 2018 Biriukovs. All rights reserved.
//

import UIKit

class HLAddBookVC: UIViewController {

    @IBOutlet weak var bookTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        bookTableView.register(UINib(nibName: "HLTextFieldCell", bundle: nil), forCellReuseIdentifier: "HLTextFieldCell")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


