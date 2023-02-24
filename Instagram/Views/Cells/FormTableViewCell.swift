//
//  FormTableViewCell.swift
//  Instagram
//
//  Created by Андрей Худик on 22.02.23.
//

import UIKit

protocol FormTableViewCellDelegate: AnyObject {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel)
}

class FormTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    static let identifier = "FormTableViewCell"
    public weak var delegate: FormTableViewCellDelegate?
    private var model: EditProfileFormModel?
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        return textField
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        textField.delegate = self
        contentView.addSubview(label)
        contentView.addSubview(textField)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: EditProfileFormModel) {
        label.text = model.label
        textField.placeholder = model.placeholder
        textField.text = model.value
        self.model = model
    }
    
    override func prepareForReuse() {
        label.text = nil
        textField.placeholder = nil
        textField.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Assign frames
        label.frame = CGRect(x: 5,
                             y: 0,
                             width: contentView.width / 3,
                             height: contentView.height)
        textField.frame = CGRect(x: label.rigth + 5,
                                 y: 0,
                                 width: contentView.width - 10 - label.width,
                                 height: contentView.height)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard var model = model else { return true }
        model.value = textField.text
        delegate?.formTableViewCell(self, didUpdateField: model)
        textField.resignFirstResponder()
        return true
    }
}
