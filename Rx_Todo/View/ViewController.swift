//
//  ViewController.swift
//  Rx_Todo
//
//  Created by 여성일 on 3/8/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ViewController: UIViewController {
    
    private let viewModel: ViewModelType
    let disposeBag = DisposeBag()
    
    private let todoTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.id)
        return tableView
    }()
    
    private let addTodoButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "추가"
        return button
    }()
    
    init(viewModel: ViewModelType = ViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setView()
        setConstraint()
        bind()
    }
    
    private func setView() {
        view.backgroundColor = .white
        title = "Rx Todo"
        [todoTableView].forEach {
            view.addSubview($0
            )
        }
        self.navigationItem.rightBarButtonItem = addTodoButton
    }
    
    private func setConstraint() {
        todoTableView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(5)
            $0.verticalEdges.equalTo(view.safeAreaLayoutGuide.snp.verticalEdges).inset(5)
        }
    }
    
    private func bind() {
        // Input
        addTodoButton.rx.tap
            .subscribe { [weak self] _ in
                guard let self = self else {return}
                let addTodoVC = AddTodoViewController(viewModel: viewModel)
                self.present(addTodoVC, animated: true)
            }.disposed(by: disposeBag)
        
        todoTableView.rx.itemDeleted
            .subscribe { [weak self] indexPath in
                guard let self = self else { return }
                self.viewModel.removeTodo(at: indexPath.row)
            }.disposed(by: disposeBag)

        // Output
        viewModel.todoData
            .drive(todoTableView.rx.items(cellIdentifier: TodoTableViewCell.id, cellType: TodoTableViewCell.self)) { row, item, cell in
                cell.configuration(item: item)
            }.disposed(by: disposeBag)
    }
    
}
