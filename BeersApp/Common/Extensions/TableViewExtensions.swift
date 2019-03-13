import UIKit
import RxSwift
import RxCocoa

extension UITableView {
    
    func registerCell<T: ReusableCell>(cellType: T.Type) {
        self.register(UINib(nibName: cellType.identifier, bundle: nil), forCellReuseIdentifier: cellType.identifier)
        self.tableFooterView = UIView() // removes empty rows
    }
    
    func dequeueReusableCell<T: ReusableCell>(cellType: T.Type, for indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as? T
    }
    
    //for rx event when performing a custom swipe action
    @objc func notifyTrailingSwipe(action: String, indexPath: IndexPath) {
        //Do nothing
    }
    
    @objc func notifyLeadingSwipe(action: String, indexPath: IndexPath) {
        //Do nothing
    }
    
    func notifyEditAction(action: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.dataSource?.tableView?(self, commit: .delete, forRowAt: indexPath)
    }

}

extension Reactive where Base: UITableView {
    
    public func itemSwipedTrailing() -> ControlEvent<SwipeEvent> {
        let source = self.methodInvoked(#selector(self.base.notifyTrailingSwipe))
            .map { parameters in
                return SwipeEvent(actionName: parameters[0] as! String, indexPath: parameters[1] as! IndexPath)
            }
        return ControlEvent(events: source)
    }
    
    public func itemSwipedLeading() -> ControlEvent<SwipeEvent> {
        let source = self.methodInvoked(#selector(self.base.notifyLeadingSwipe))
            .map { parameters in
                return SwipeEvent(actionName: parameters[0] as! String, indexPath: parameters[1] as! IndexPath)
            }
        return ControlEvent(events: source)
    }
    
}

