//
//  FontBrand.swift
//  eidos
//
//  Created by Tony Kieu on 24/08/2023.
//

import UIKit

class FontBrand {
    
    class var dashboardTitleFont: UIFont {
        return UIFont.systemFont(ofSize: 15.0, weight: .bold)
    }

    class var smallStatusFont: UIFont {
        return UIFont.systemFont(ofSize: 11.0, weight: .bold)
    }

    class var statusBarTitleFont: UIFont {
        return UIFont.systemFont(ofSize: 12.0, weight: .bold)
    }

    class var navBarTitleFont: UIFont {
        return UIFont.systemFont(ofSize: 18.0, weight: .bold)
    }

    class var navBarSubtitleFont: UIFont {
        return UIFont.systemFont(ofSize: 12.0, weight: .medium)
    }

    class var largeNavBarTitleFont: UIFont {
        return UIFont.systemFont(ofSize: 34.0, weight: .bold)
    }

    class var tabbarTitleFont: UIFont {
        return UIFont.systemFont(ofSize: 13.0, weight: .medium)
    }

    class var tabbarSelectedTitleFont: UIFont {
        return UIFont.systemFont(ofSize: 12.0, weight: .medium)
    }

    class var toolBarTitleFont: UIFont {
        return UIFont.systemFont(ofSize: 15.0, weight: .medium)
    }

    class var toolBarSelectedTitleFont: UIFont {
        return UIFont.systemFont(ofSize: 15.0, weight: .bold)
    }

    class var segmentTitleFont: UIFont {
        return UIFont.systemFont(ofSize: 16.0, weight: .medium)
    }

    class var tableHeaderFooterFont: UIFont {
        return UIFont.systemFont(ofSize: 15.0, weight: .bold)
    }

    class var buttonTitleFont: UIFont {
        return UIFont.systemFont(ofSize: 15.0, weight: .bold)
    }

    class var smallButtonTitleFont: UIFont {
        return UIFont.systemFont(ofSize: 12.0, weight: .bold)
    }

    class var textFieldFont: UIFont {
        return UIFont.systemFont(ofSize: 15.0, weight: .medium)
    }

    class var textViewFont: UIFont {
        return UIFont.systemFont(ofSize: 15.0, weight: .medium)
    }

    class var alertTitleFont: UIFont {
        return UIFont.systemFont(ofSize: 17.0, weight: .bold)
    }

    class var alertMessageFont: UIFont {
        return UIFont.systemFont(ofSize: 15.0, weight: .medium)
    }

    class var titleLabelFont: UIFont {
        return UIFont.systemFont(ofSize: 15.0, weight: .medium)
    }

    class var labelFont: UIFont {
        return UIFont.systemFont(ofSize: 15.0, weight: .medium)
    }

    class var labelBoldFont: UIFont {
        return UIFont.systemFont(ofSize: 15.0, weight: .bold)
    }

    class var notificationFont: UIFont {
        return UIFont.systemFont(ofSize: 11.0, weight: .medium)
    }

    class var statusFont: UIFont {
        return UIFont.systemFont(ofSize: 12.0, weight: .medium)
    }

    class var calendarTitleFont: UIFont {
        return UIFont.systemFont(ofSize: 13.5, weight: .medium)
    }

    class var calendarSubtitleFont: UIFont {
        return UIFont.systemFont(ofSize: 10.0, weight: .medium)
    }

    class var calendarWeekdayFont: UIFont {
        return UIFont.systemFont(ofSize: 14.0, weight: .medium)
    }

    class var calendarHeaderFont: UIFont {
        return UIFont.systemFont(ofSize: 16.0, weight: .medium)
    }

    class var formTitleFont: UIFont {
        return UIFont.systemFont(ofSize: 15.0, weight: .bold)
    }

    class var formDetailFont: UIFont {
        return UIFont.systemFont(ofSize: 15.0, weight: .medium)
    }

    class var pieChartFont: UIFont {
        return UIFont.systemFont(ofSize: 12.0, weight: .medium)
    }

    class func font(name: String, size: CGFloat) -> UIFont {
        return UIFont(name: name, size: size)!
    }
    
    class func bookFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    class func mediumFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }

    class func boldFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }
}
