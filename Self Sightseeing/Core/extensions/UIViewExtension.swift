
//
//  UIViewExtension.swift
//
//  Created by Nurillo Domlajonov on 04/01/23.
//

import UIKit

extension UIView{
    
    
    /// Top contraint
    /// - Parameters:
    ///   - equalTo: tenglashtirlayotgan item
    ///   - constant: farq qiluvchi birlik
    func top(_ equalTo: NSLayoutAnchor<NSLayoutYAxisAnchor>, _ constant: CGFloat = 0){
        self.topAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    
    /// Bottom constraint
    /// - Parameters:
    ///   - equalTo: tenglashtirlayotgan item
    ///   - constant: farq qiluvchi birlik
    func bottom(_ equalTo: NSLayoutAnchor<NSLayoutYAxisAnchor>, _ constant: CGFloat = 0){
        self.bottomAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    
    /// Left constraint
    /// - Parameters:
    ///   - equalTo: tenglashtirlayotgan item
    ///   - constant: farq qiluvchi birlik
    func left(_ equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>, _ constant: CGFloat = 0){
        self.leftAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    
    /// Right constraint
    /// - Parameters:
    ///   - equalTo: tenglashtirlayotgan item
    ///   - constant: farq qiluvchi birlik
    func right(_ equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>, _ constant: CGFloat = 0){
        self.rightAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    
    
    /// CenterY constraint
    /// - Parameters:
    ///   - equalTo: tenglashtirlayotgan item
    ///   - constant: farq qiluvchi birlik
    func centerY(_ equalTo: NSLayoutAnchor<NSLayoutYAxisAnchor>, _ constant: CGFloat = 0){
        self.centerYAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    
    
    /// CenterX constraint
    /// - Parameters:
    ///   - equalTo: tenglashtirlayotgan item
    ///   - constant: farq qiluvchi birlik
    func centerX(_ equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>, _ constant: CGFloat = 0){
        self.centerXAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    
    
    /// height constraint
    /// - Parameters:
    ///   - equalTo: tenglashtirlayotgan item
    ///   - constant: farq qiluvchi birlik
    func height(_ constant: CGFloat = 0){
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    
    /// width constraint
    /// - Parameters:
    ///   - equalTo: tenglashtirlayotgan item
    ///   - constant: farq qiluvchi birlik
    func width(_ constant: CGFloat = 0){
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
}


extension UIView {
    @discardableResult
    func addBorders(edges: UIRectEdge,
                    color: UIColor,
                    inset: CGFloat = 0.0,
                    thickness: CGFloat = 1.0) -> [UIView] {

        var borders = [UIView]()

        @discardableResult
        func addBorder(formats: String...) -> UIView {
            let border = UIView(frame: .zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            addSubview(border)
            addConstraints(formats.flatMap {
                NSLayoutConstraint.constraints(withVisualFormat: $0,
                                               options: [],
                                               metrics: ["inset": inset, "thickness": thickness],
                                               views: ["border": border]) })
            borders.append(border)
            return border
        }


        if edges.contains(.top) || edges.contains(.all) {
            addBorder(formats: "V:|-0-[border(==thickness)]", "H:|-inset-[border]-inset-|")
        }

        if edges.contains(.bottom) || edges.contains(.all) {
            addBorder(formats: "V:[border(==thickness)]-0-|", "H:|-inset-[border]-inset-|")
        }

        if edges.contains(.left) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:|-0-[border(==thickness)]")
        }

        if edges.contains(.right) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:[border(==thickness)]-0-|")
        }

        return borders
    }
// Usage:
//       view.addBorder(edges: [.all]) // All with default arguments
//       view.addBorder(edges: [.top], color: .green) // Just Top, green, default thickness
//       view.addBorder(edges: [.left, .right, .bottom], color: .red, thickness: 3) // All except Top, red, thickness 3
}
