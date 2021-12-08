# SwiftyTraceableValue

![Author](https://img.shields.io/badge/author-LinXunFeng-blue.svg?style=flat-square)
[![CI Status](https://img.shields.io/travis/LinXunFeng/SwiftyTraceableValue.svg?style=flat)](https://travis-ci.org/LinXunFeng/SwiftyTraceableValue)
[![Version](https://img.shields.io/cocoapods/v/SwiftyTraceableValue.svg?style=flat)](https://cocoapods.org/pods/SwiftyTraceableValue)
[![License](https://img.shields.io/cocoapods/l/SwiftyTraceableValue.svg?style=flat)](https://cocoapods.org/pods/SwiftyTraceableValue)
[![Platform](https://img.shields.io/cocoapods/p/SwiftyTraceableValue.svg?style=flat)](https://cocoapods.org/pods/SwiftyTraceableValue)
![visitors](https://visitor-badge.glitch.me/badge?page_id=LinXunFeng.SwiftyTraceableValue)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 9.0+
- Xcode 11+
- Swift 5+

## Installation

SwiftyTraceableValue is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwiftyTraceableValue'
```



## Usage



1、使用属性包装器 `SwiftyTraceableValue` 对需要比较属性进行修饰

```swift
// Reactor

struct State {
    @SwiftyTraceableValue var sections : [LXFSection] = []
    ...
}
```



2、使用 `mapDistinctUntilTraceableValueChanged` 方法，并在对应属性前加上 `$` 

```swift
// View

reactor.state.mapDistinctUntilTraceableValueChanged { $0.$sections }
    .bind(to: tableView.rx.items(dataSource: dataSource))
    .disposed(by: disposeBag)
```



## License

SwiftyFitsize is available under the MIT license. See the LICENSE file for more info.



## Author

- LinXunFeng
- email: [linxunfeng@yeah.net](mailto:linxunfeng@yeah.net)
- Blogs: [全栈行动](https://fullstackaction.com/) | [LinXunFeng‘s Blog](http://linxunfeng.top/)  | [掘金](https://juejin.im/user/58f8065e61ff4b006646c72d/posts) 


<img height="267.5" width="481.5" src="https://github.com/LinXunFeng/LinXunFeng/blob/master/static/img/FSAQR.png" />


## Other

| <img width="252" height="294" src="https://github.com/LinXunFeng/site/raw/master/source/images/others/pay/alipay_tip.png" /> | <img width="252" height="294"  src="https://github.com/LinXunFeng/site/raw/master/source/images/others/pay/wechat_tip.png" /> |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
|                                                              |                                                              |

