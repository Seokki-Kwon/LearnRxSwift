import UIKit
import RxSwift

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// Filtering Operator

// skip - 특정 요소를 무시
Observable.from(numbers)
    .skip(3) // 숫자만큼 방출되는 요소를 무시 1, 2, 3 무시
    .subscribe { print($0) }
    .disposed(by: disposeBag)

// skipWhile
Observable.from(numbers)
    .skipWhile { !$0.isMultiple(of: 2) } // false를 리턴한 이후에는 방출하지않는다.
    .subscribe { print("skipWhile",$0) }
    .disposed(by: disposeBag)
// true를 리턴하는 경우 전달x
// false를 리턴하는 경우 전달됨
// 그이후 따로 필터링을 거치지않고 모두전달

// skipUntil

let subject = PublishSubject<Int>()
let trigger = PublishSubject<Int>()

// trigger가 이벤트를 방출하고나서야 subject가 이벤트를 방출한다.
subject.skipUntil(trigger)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

subject.onNext(1) // 방출되지 않는다

trigger.onNext(0) // 방출되지 않는다

subject.onNext(2) // 2가 방출된다
