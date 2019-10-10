import UIKit

extension UIView {

    func configureForAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    func autoPinEdgesToSuperviewEdges() {
        guard let superview = superview else { return }
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }

    func autoCenterInSuperview() {
        guard let superview = superview else { return }
        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
    }
}
