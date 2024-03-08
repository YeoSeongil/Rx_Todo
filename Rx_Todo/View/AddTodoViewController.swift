//
//  AddTodoViewController.swift
//  Rx_Todo
//
//  Created by 여성일 on 3/8/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class AddTodoViewController: UIViewController {

    private let viewModel: ViewModelType
    let disposeBag = DisposeBag()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .black
        textView.addSubview(UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)))
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 5
        return textView
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemBlue
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
        setView()
        setConstraint()
        bind()
    }
    
    private func setView() {
        [titleTextField, contentTextView, submitButton].forEach {
            view.addSubview($0)
        }
        view.backgroundColor = .white
    }
    
    private func setConstraint() {
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.height.equalTo(50)
        }
        
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(15)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.height.equalTo(300)
        }
        
        submitButton.snp.makeConstraints {
            $0.top.equalTo(contentTextView.snp.bottom).offset(20)
            $0.directionalHorizontalEdges.equalToSuperview().inset(10)
            $0.height.equalTo(100)
        }
    }
    
    private func bind() {
        // Input
        titleTextField.rx.text.orEmpty
            .asObservable()
            .bind(to: viewModel.whichTitle)
            .disposed(by: disposeBag)
        
        contentTextView.rx.text.orEmpty
            .asObservable()
            .bind(to: viewModel.whichContenst)
            .disposed(by: disposeBag)
        
        submitButton.rx.tap
            .asObservable()
            .bind(to: viewModel.whichButtonTapped)
            .disposed(by: disposeBag)
        
        submitButton.rx.tap
            .bind { _ in
                self.dismiss(animated: true)
            }.disposed(by: disposeBag)
    }
}
