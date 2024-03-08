//
//  TodoTableViewCell.swift
//  Rx_Todo
//
//  Created by 여성일 on 3/8/24.
//

import UIKit
import SnapKit

class TodoTableViewCell: UITableViewCell {

    static let id: String = "TodoTableViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCell()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setCell() {
        self.addSubview(titleLabel)
    }
    
    private func setConstraint() {
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(30)
        }
    }
    
    func configuration(item: Todo) {
        print("item:\(item)")
        titleLabel.text = item.title
    }

}
