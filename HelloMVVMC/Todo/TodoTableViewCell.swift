//
//  TodoTableViewCell.swift
//  HelloMVVMC
//
//  Created by roy on 2019/5/10.
//  Copyright © 2019 roy. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    let doneButton = UIButton()
    let nameLabel = UILabel()

    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - setup views
    func setupViews() {
        addSubview(doneButton)
        addSubview(nameLabel)

        let margin = 20
        doneButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(margin)
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.centerY.equalToSuperview()
        }

        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(doneButton.snp.right).offset(margin)
            make.centerY.equalTo(doneButton)
        }
    }

    // MARK: - update cell
    func update(model: TodoModel) {
        nameLabel.text = model.name

        if model.isDone {
            doneButton.setImage(UIImage(named: "ic_checkbox_active"), for: .normal)
        } else {
            doneButton.setImage(UIImage(named: "ic_checkbox_inactive"), for: .normal)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
