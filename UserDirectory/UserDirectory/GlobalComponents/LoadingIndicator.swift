//
//  LoadingIndicator.swift
//  UserDirectory
//
//  Created by Md. Faysal Ahmed on 13/9/25.
//

import UIKit

class LoadingIndicator {
    private var activityIndicator: UIActivityIndicatorView?
    private var overlayView: UIView?

    static let shared = LoadingIndicator()

    private init() {}

    func startAnimating(on view: UIView) {
        let overlay = UIView(frame: view.bounds)
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        overlay.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(overlay)

        UIView.animate(withDuration: 0.3) {
            overlay.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }

        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .black
        indicator.backgroundColor = .white
        indicator.layer.cornerRadius = 8.0
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        overlay.addSubview(indicator)

        // Constraints
        NSLayoutConstraint.activate([
            overlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlay.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlay.topAnchor.constraint(equalTo: view.topAnchor),
            overlay.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            indicator.centerXAnchor.constraint(equalTo: overlay.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: overlay.centerYAnchor),
            indicator.heightAnchor.constraint(equalToConstant: 80),
            indicator.widthAnchor.constraint(equalToConstant: 80)
        ])

        self.overlayView = overlay
        self.activityIndicator = indicator
    }

    func stopAnimating() {
        activityIndicator?.stopAnimating()
        overlayView?.removeFromSuperview()

        activityIndicator = nil
        overlayView = nil
    }
    
}
