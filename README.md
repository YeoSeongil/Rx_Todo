# Rx_Todo : RxSwift 공부를 위한 정말정말 간단한 Todo 앱
![Mar-08-2024 23-13-25](https://github.com/YeoSeongil/Rx_Todo/assets/75207506/990bd945-8959-4b17-b5ce-cfff4d487da5)

## 기술
- UIKit
- RxSwift
- RxCocoa
- MVVM
- DI
- DIP

## 개발환경
- Swift
- Xcode
- iOS 16 (키보드 이슈로 인해 16으로 Down)

## 느낀점
1. RxSwift의 런닝커브가 높다는 것을 정말 정말 정말 뼈저리게 느낌. (UIKit으로 구현했다면 쉽게 구현했을 것 같음.)</br>
✅ 대신 비동기 처리에 있어서 코드의 간결성이나 가독성이 좋아진 것은 엄청나게 체감이 됨.</br>
✅ Rx의 Observable과 Observer는 정말 강력한 기능임을 느낌.</br>
✅ 특히 연산자 부분이 정말 어렵다고 느낌. 약 100개 이상의 연산자를 언제 어떻게 어떤 연산자를 써야할지 정말 감이 오지 않았음. 이번 TodoApp에서는 withLatestFrom, combineLatest, scan 연산자를 사용했는데, 너무 생소하고 어려웠음.</br>
하지만 이렇게 하나하나 알아가면서 공부하니 Rx가 얼마나 강력하고 매력적인지 알게 됨.</br>
</br>
2. 의존성 주입에 대해 이해하게 됨.</br>
<img width="744" alt="스크린샷 2024-03-08 오후 11 23 36" src="https://github.com/YeoSeongil/Rx_Todo/assets/75207506/a77d53b8-7035-48a7-9c0a-5fc2864315cc"></br>
✅ 해당 프로젝트의 ViewModel에서는 ViewModelType 프로토콜을 정의하고, ViewModel이 ViewModelType 프로토콜을 채택함으로서 외부에서 ViewModelType 프로토콜을 준수하는 객체를 주입하여 사용할 수 있게 구현했다.</br>
</br>
<img width="1110" alt="스크린샷 2024-03-08 오후 11 25 18" src="https://github.com/YeoSeongil/Rx_Todo/assets/75207506/04a166ef-08d4-45cc-9cc3-ffa876c46b1a"></br>
✅ tryAddTodo 메서드에서 외부에서 주입받은 inputButtonTapped, inputTitle 등 의존성이 주입되어 사용된다.</br>
</br>

![image](https://github.com/YeoSeongil/Rx_Todo/assets/75207506/5c5fa834-b340-4ba2-95d7-c8d32b2f7ffc)</br>
AddTodoViewController와 ViewController가 동일한 ViewModel 인스턴스를 공유하게 하기 위해, AddTodoViewController의 생성자에 ViewController의 ViewModel을 주입했다.
이렇게 구현하면 AddTodoViewController는 ViewModelType 프로토콜에만 의존하게 되어, 두 뷰 컨트롤러 사이에서 동일한 데이터를 공유하게 된다. 또, 나중에 다른 ViewController에서도 동일한 ViewModel 인스턴스를 재사용하거나 다른 ViewModel 인스턴스를 주입해서 사용할 수 있다는 장점이 있다.



