//
//  HLTextFieldCell.swift
//  hLibrary
//
//  Created by Kliment Biriukov on 6/27/18.
//  Copyright © 2018 Biriukovs. All rights reserved.
//

import UIKit

protocol HLtextFieldCellDelegate {
    func textFieldDidStartEditing(_ sender : HLTextFieldCell)
    func textFieldDidEndEditing(text : String, _ sender : HLTextFieldCell)
}

class HLTextFieldCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    
    var delegate : HLtextFieldCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(title : String, placeholder : String) {
        titleLabel.text = title
        valueTextField.text = placeholder
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldDidStartEditing(self)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.textFieldDidEndEditing(text: textField.text!, self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
}
