//
//  EditProfileViewController.swift
//  Instagram
//
//  Created by Андрей Худик on 12.02.23.
//

import UIKit

struct EditProfileFormModel {
    let label: String
    let placeholder: String
    var value: String?
}

class EditProfileViewController: UIViewController {

    let tableView: UITableView = {
        let table = UITableView()
        table.register(FormTableViewCell.self,
                       forCellReuseIdentifier: FormTableViewCell.identifier)
        return table
    }()
    
    private var models = [[EditProfileFormModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.tableHeaderView = createTableViewHeader()
        configureModels()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didTapCancel))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        // name, username, website, bio
        let section1Labels = ["Name", "Username", "Website", "Bio"]
        var section1 = [EditProfileFormModel]()
        for label in section1Labels {
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)...", value: nil)
            section1.append(model)
        }
        models.append(section1)
        // email, phone, gender
        let section2Labels = ["Email", "Phone", "Gender"]
        var section2 = [EditProfileFormModel]()
        for label in section2Labels {
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)...", value: nil)
            section2.append(model)
        }
        models.append(section2)
    }

    //MARK: Action
    
    @objc private func didTapSave() {
        dismiss(animated: true)
    }
    
    @objc private func didTapCancel() {
        dismiss(animated: true)
    }
    
    @objc private func didTapChangeProfilePicture() {
        let actionSheet = UIAlertController(title: "Profile Picture",
                                            message: "Change profile picture",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Take Picture", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { _ in
       
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        present(actionSheet, animated: true)
    }
}

// MARK: TableView
extension EditProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier,
                                                 for: indexPath) as! FormTableViewCell
        cell.delegate = self
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else { return nil }
        return "Private Information"
    }
    
    func createTableViewHeader() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height / 4.0).integral)
        let size = header.width / 2.0
        let profilePhotoButton = UIButton(frame: CGRect(x: (view.width - size) / 2,
                                                        y: (header.height - size) / 2,
                                                        width: size,
                                                        height: size))
        profilePhotoButton.clipsToBounds = true
        profilePhotoButton.layer.cornerRadius = size / 2
        profilePhotoButton.tintColor = .label
        profilePhotoButton.addTarget(self,
                                     action: #selector(didTapChangeProfilePicture),
                                     for: .touchUpInside)
        profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        profilePhotoButton.layer.borderWidth = 1.0
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        header.addSubview(profilePhotoButton)
        return header
    }
}

extension EditProfileViewController: FormTableViewCellDelegate {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel) {
        // Update the model
        print(updatedModel.value)
    }
}
