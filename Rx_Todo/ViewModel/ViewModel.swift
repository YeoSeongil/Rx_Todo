//
//  ViewMoel.swift
//  Rx_Todo
//
//  Created by 여성일 on 3/8/24.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelType {
    // Input
    var whichTitle: AnyObserver<String> { get }
    var whichContenst: AnyObserver<String> { get }
    var whichButtonTapped: AnyObserver<Void> { get }
    
    // Output
    var todoData: Driver<[Todo]> { get }
    
    // Method
    func removeTodo(at index: Int)
}

class ViewModel {
    let disposeBag = DisposeBag()
    // Input
    private let inputTitle = BehaviorSubject<String>(value: "")
    private let inputContents = BehaviorSubject<String>(value: "")
    private let inputButtonTapped = PublishSubject<Void>()
    
    // Output
    private let outputDate = BehaviorRelay<Date>(value: Date())
    private let outputTodo = BehaviorRelay<[Todo]>(value: [])
    
    init() {
        tryAddTodo()
    }

    private func tryAddTodo() {
        // ✏️ withLatestFrom을 사용한 이유 : inputButtonTapped의 Tapped 이벤트를 전달 받았을 때, 최근의 inputTitle과 inputContents를 받아와 새로운 Todo를 생성하기 위해서.
        // ✏️ combineLatest를 사용한 이유 : inputTitle과 inputContents을 둘 다 사용하기 위해서. combineLatest는 Observable 중 어느 하나라도 새로운 이벤트가 발생하면 Observable의 최신 값을 결합하기 때문
        // ✏️ scan을 사용한 이유 : 새로운 Todo가 추가될 때마다 배열을 누적시켜 누적 값을 받아오기 위해서 (이전까지의 상태를 유지하면서 새로운 변화를 추적하기 위해?)
        let data = inputButtonTapped
            .withLatestFrom(Observable.combineLatest(inputTitle, inputContents)) { _, item in
                Todo(title: item.0, contents: item.1, date: Date())
            }
            .scan([]) { (todos: [Todo], newTodo: Todo) -> [Todo] in
                todos + [newTodo]
            }
        
        data
            .bind(to: outputTodo)
            .disposed(by: disposeBag)
    }
}

extension ViewModel: ViewModelType {
    // Input
    var whichTitle: AnyObserver<String> {
        inputTitle.asObserver()
    }
    
    var whichContenst: AnyObserver<String> {
        inputContents.asObserver()
    }
    
    var whichButtonTapped: AnyObserver<Void> {
        inputButtonTapped.asObserver()
    }

    // Output
    var todoData: Driver<[Todo]> {
        outputTodo.asDriver(onErrorJustReturn: [])
    }
    
    // Method
    func removeTodo(at index: Int) {
        var currentTodos = outputTodo.value
        currentTodos.remove(at: index)
        outputTodo.accept(currentTodos)
    }
}
