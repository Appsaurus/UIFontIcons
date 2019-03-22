//
//  Icomoon.swift
//  AppsaurusUIKit
//
//  Created by Brian Strobach on 5/16/16.
//  Copyright © 2016 Appsaurus LLC. All rights reserved.
//

import UIKit
import CoreGraphics

public protocol FontIconEnum: CaseIterable, RawRepresentable{
    static func font(size: CGFloat) -> UIFont
    static func name() -> String
    var fontName: String { get }
    var rawValue: String { get }
}

extension FontIconEnum{
    public static func font(size: CGFloat = 20.0) -> UIFont{
        return UIFont(name: name(), size: size)!
    }
    
    public var fontName: String{
        return Self.name()
    }
}
extension FontIconEnum{
    public func attributedString(_ fontSize: CGFloat? = nil, color: UIColor? = nil) -> NSMutableAttributedString{
        return NSMutableAttributedString.attributedString(self, fontSize: fontSize, color: color)
    }
}

public extension FontIconEnum{
    public func getFont(_ iconSize: CGFloat ) -> UIFont{
        let font = UIFont(name: fontName, size: iconSize)
        assert(font != nil, "You have not bundled the icon font named \(fontName)")
        return font!
    }
}

public extension UIFont {
//    public static func iconFont<FontIcon: FontIconEnum>(_ icon: FontIcon, fontSize: CGFloat? = nil) -> UIFont {
//        let font = UIFont(name: icon.fontName, size: fontSize ?? .icon)
//        assert(font != nil, "You have not bundled the icon font named \(icon.fontName)")
//        return font!
//    }
    
    public static func iconFont<FontIcon: FontIconEnum>(_ icon: FontIcon, fontSize: CGFloat) -> UIFont {
        let font = UIFont(name: icon.fontName, size: fontSize)
        assert(font != nil, "You have not bundled the icon font named \(icon.fontName)")
        return font!
    }
}

public extension NSMutableAttributedString{
    
    //public func appendedWithIcon<FontIcon: FontIconEnum>(icon: FontIcon, fontSize: CGFloat? = nil, color: UIColor? = nil) -> NSMutableAttributedString{
    //let iconString: NSMutableAttributedString = attributedStringWithFontIcon(icon, fontSize: fontSize, color: color)
    //let fullString = self + " " + iconString
    //return fullString
    
    //}
    
    //public func prependedWithIcon<FontIcon: FontIconEnum>(icon: FontIcon, fontSize: CGFloat? = nil, color: UIColor? = nil) -> NSMutableAttributedString{
    //let iconString: NSMutableAttributedString = attributedStringWithFontIcon(icon, fontSize: fontSize, color: color)
    //return iconString + " " + self
    //}
    
    public func attributedStringWithFontIcon<FontIcon: FontIconEnum>(_ icon: FontIcon, fontSize: CGFloat? = nil, color: UIColor? = nil) -> NSMutableAttributedString {
        let attributes = self.attributes(at: self.length - 1, effectiveRange: nil)
        let color: UIColor? = color ?? attributes[.foregroundColor] as? UIColor
        let iconString: NSMutableAttributedString = NSMutableAttributedString.attributedString(icon, fontSize: fontSize, color: color)
        return iconString
    }
    
    public class func attributedString<FontIcon: FontIconEnum>(_ icon: FontIcon, fontSize: CGFloat? = nil, color: UIColor? = nil, appendedTitle: String? = nil) -> NSMutableAttributedString{
        var attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.iconFont(icon, fontSize: fontSize ?? FontIconDefaults.fontSize)
        ]
        if let color = color{
            attributes[.foregroundColor] = color
        }
        let attributedString = NSMutableAttributedString(string: icon.rawValue, attributes: attributes)
        if let appendedTitle = appendedTitle{
            attributedString.appendString(appendedTitle)
        }
        return attributedString
    }
    
    @discardableResult
    public func append<FontIcon: FontIconEnum>(with icon: FontIcon, fontSize: CGFloat? = nil, color: UIColor? = nil, includeSpace: Bool = true) -> NSMutableAttributedString{
        let iconString: NSAttributedString = attributedStringWithFontIcon(icon, fontSize: fontSize, color: color)
        if includeSpace { self.appendString(" ") }
        self.append(iconString)
        return self
    }
    
    @discardableResult
    public func prepend<FontIcon: FontIconEnum>(with icon: FontIcon, fontSize: CGFloat? = nil, color: UIColor? = nil, includeSpace: Bool = true) -> NSMutableAttributedString{
        let iconString: NSAttributedString = attributedStringWithFontIcon(icon, fontSize: fontSize, color: color)
        if includeSpace { self.insert(NSAttributedString(string: " "), at: 0) }
        self.insert(iconString, at: 0)
        return self
    }
}


public extension UIBarButtonItem {
//    class public func barButtonItemWithCustomButtonFontIcon<T: FontIconEnum>(_ icon: T, configuration: FontIconConfiguration? = nil) -> UIBarButtonItem{
//        let configuration = configuration ?? FontIconConfiguration(sizeConfig: FontIconSizeConfiguration(fontSize: .barButtonFontSize))
//        return barButtonItemWithCustomButtonFontIcon(icon, configuration: configuration)
//    }
    
    class public func barButtonItemWithCustomButtonFontIcon<T: FontIconEnum>(_ icon: T, configuration: FontIconConfiguration) -> UIBarButtonItem{
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44.0 , height: 44.0)) //TODO: Change to 66 x 66 for Plus sized iPhones
        button.setImage(UIImage.iconImage(icon, configuration: configuration) as UIImage?, for: .normal)
        button.contentHorizontalAlignment = .left
        return UIBarButtonItem(customView: button)
    }
    
//    class public func barButtonItemWithCustomButtonFontIcon<T: FontIconEnum>(_ icon: T,
//                                                                                     configuration: FontIconConfiguration? = nil,
//                                                                                     onTouchUpInside: @escaping () -> Void) -> UIBarButtonItem{
//        let configuration = configuration ?? FontIconConfiguration(sizeConfig: FontIconSizeConfiguration(fontSize: .barButtonFontSize))
//        return barButtonItemWithCustomButtonFontIcon(icon,
//                                                     configuration: configuration,
//                                                     onTouchUpInside: onTouchUpInside)
//    }
    
//    class public func barButtonItemWithCustomButtonFontIcon<T: FontIconEnum>(_ icon: T,
//                                                                                     configuration: FontIconConfiguration,
//                                                                                     onTouchUpInside: @escaping () -> Void) -> UIBarButtonItem{
//        let bb = barButtonItemWithCustomButtonFontIcon(icon, configuration: configuration)
//        if let button = bb.customView as? UIButton{
//            button.add
//            button.addAction(forControlEvents: .touchUpInside) {
//                onTouchUpInside()
//            }
//        }
//        return bb
//    }
    
    class public func barButtonItemWithFontIcon<FontIcon: FontIconEnum>(_ icon: FontIcon, size: CGFloat = 18.0) -> UIBarButtonItem{
        let barButton: UIBarButtonItem = UIBarButtonItem()
        barButton.setFontIconTitle(icon, for: .normal, size: size)
        return barButton
    }
    
    public func setFontIconTitle<FontIcon: FontIconEnum>(_ icon: FontIcon, for state: UIControl.State = .normal, size: CGFloat = 18.0) {
        let font = icon.getFont(size)
        setTitleTextAttributes([.font: font], for: state)
        title = icon.rawValue
    }
}

public extension UIButton {
    
    public convenience init<FontIcon: FontIconEnum>(icon: FontIcon, fontSize: CGFloat? = nil, color: UIColor? = nil, forState state: UIControl.State = .normal){
        self.init(frame: .zero)
        setFontIconTitle(icon, fontSize: fontSize, color: color, forState: state)
    }
    public func setFontIconTitle<FontIcon: FontIconEnum>(_ icon: FontIcon, fontSize: CGFloat? = nil, color: UIColor? = nil, forState state: UIControl.State = .normal) {
        if let label = titleLabel {
            let pointSize = fontSize ?? label.font.pointSize
            let font = icon.getFont(pointSize)
            label.font = font
            if let titleColor = color{
                setTitleColor(titleColor, for: state)
            }
            setTitle(icon.rawValue, for: state)
        }
    }
    
    //public func setFontIconTitle<FontIcon: FontIconEnum>(title: String, titleFont: UIFont? = nil, prependedBy icon: FontIcon, fontSize: CGFloat? = nil, color: UIColor? = nil, forState: UIControlState = .Normal, verticallyCenter: Bool = true){
    //let attributedTitle: NSMutableAttributedString = NSMutableAttributedString.attributedString(title, font: titleFont ?? titleLabel?.font, color: color)
    //attributedTitle.prependIcon(icon, fontSize: fontSize ?? titleLabel?.font.pointSize, color: color)
    //if verticallyCenter{
    //attributedTitle.verticallyCenterAllCharacters()
    //}
    //setAttributedTitle(attributedTitle, forState: forState)
    //}
    
}

public extension UILabel {
    
    func setFontIconText<FontIcon: FontIconEnum>(_ icon: FontIcon, size: CGFloat? = nil) {
        let size = size ?? self.font.pointSize
        font = icon.getFont(size)
        text = icon.rawValue
    }
    
    func setFontIconText<FontIcon: FontIconEnum>(_ text: String, prependedBy icon: FontIcon){
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.prepend(with: icon)
        self.attributedText = attributedText
    }
}

public extension UIImageView {
    
    public func setFontIconImage<FontIcon: FontIconEnum>(_ icon: FontIcon, style: FontIconStyle = FontIconStyle(), fillPercentOfFrame: CGFloat = 1.0) {
        self.image = iconImageThatFits(icon, style: style, fillPercentOfFrame: fillPercentOfFrame)
    }
    
    public func iconImageThatFits<FontIcon: FontIconEnum>(_ icon: FontIcon, style: FontIconStyle = FontIconStyle(), fillPercentOfFrame: CGFloat = 1.0) -> UIImage{
        setNeedsLayout()
        layoutIfNeeded()
        let fontSize: CGFloat = (frame.width > 0.0 && frame.height > 0.0) ? frame.maxSideLength * fillPercentOfFrame : 50
        let configuration = FontIconConfiguration(style: style, sizeConfig: FontIconSizeConfiguration(fontSize: fontSize))
        return UIImage(icon: icon, configuration: configuration)
    }
}


public extension UITabBarItem {

    public func setFontIconImage<FontIcon: FontIconEnum>(_ icon: FontIcon) {
        image = UIImage(icon: icon)
    }
}


public extension UISegmentedControl {
    
    //TODO: Figure out default title size
    //public func setFontIcon<FontIcon: FontIconEnum>(icon: FontIcon, forSegmentAtIndex segment: Int) {
    
    
    //let font = FontLoader.getFont(icon, iconSize: defaultSize)
    
    //setTitleTextAttributes([.font: font], forState: .Normal)
    //setTitle(icon.rawValue, forSegmentAtIndex: segment)
    //}
}


public enum FontIconImageSizePriority{
    case width, height
}

public class FontIconDefaults{
    public static var color: UIColor = .white
    public static var backgroundColor: UIColor = .clear
    public static var borderWidth: CGFloat = 0
    public static var borderColor: UIColor = .clear
    
    public static var fontSize: CGFloat =  50.0
}

public class FontIconConfiguration{
    open var style: FontIconStyle
    open var sizeConfig: FontIconSizeConfiguration
    public init(style: FontIconStyle = FontIconStyle(), sizeConfig: FontIconSizeConfiguration = FontIconSizeConfiguration()) {
        self.style = style
        self.sizeConfig = sizeConfig
    }
}

public class FontIconSizeConfiguration{
    open var size: CGSize
    open var fontSize: CGFloat
    public init(size: CGSize? = nil, fontSize: CGFloat? = nil) {
        let fontSize = fontSize ?? size?.height ?? FontIconDefaults.fontSize
        self.fontSize = fontSize
        self.size = size ?? CGSize(width: fontSize, height: fontSize)
    }
}

public class FontIconStyle{
    open var color: UIColor
    open var backgroundColor: UIColor
    open var borderWidth: CGFloat
    open var borderColor: UIColor
    
    public init(color: UIColor = FontIconDefaults.color,
                backgroundColor: UIColor = FontIconDefaults.backgroundColor,
                borderWidth: CGFloat = FontIconDefaults.borderWidth,
                borderColor: UIColor = FontIconDefaults.borderColor) {
        self.color = color
        self.backgroundColor = backgroundColor
        self.borderWidth = borderWidth
        self.borderColor = borderColor
    }
}
public extension UIImage {
    
    public convenience init<FontIcon: FontIconEnum>(icon: FontIcon,
                                                            configuration: FontIconConfiguration = FontIconConfiguration()) {
        let image = UIImage.iconImage(icon, configuration: configuration)
        self.init(cgImage: image.cgImage!, scale: image.scale, orientation: image.imageOrientation)
    }
    
    public static func iconImage<FontIcon: FontIconEnum>(_ icon: FontIcon,
                                                                 color: UIColor? = nil,
                                                                 fontSize: CGFloat? = nil) -> UIImage {
        let config = FontIconConfiguration()
        config.sizeConfig = FontIconSizeConfiguration(fontSize: fontSize)
        if let color = color { config.style.color = color }
        return iconImage(icon, configuration: config)
    }
    
    public static func iconImage<FontIcon: FontIconEnum>(_ icon: FontIcon,
                                                                 configuration: FontIconConfiguration = FontIconConfiguration()) -> UIImage {
        var size = configuration.sizeConfig.size
        let style = configuration.style
        
        guard size.width > 0 && size.height > 0 else {
            print("Attempted to create image with zero height or width.")
            return UIImage()
        }
        
        let fontSize = configuration.sizeConfig.fontSize
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = NSTextAlignment.center
        
        // stroke width expects a whole number percentage of the font size
        let strokeWidth: CGFloat = fontSize == 0 ? 0 : (-100 * style.borderWidth / fontSize)
        
        let attributedString = icon.attributedString(fontSize)
        let attrSize = sizeOfAttributeString(attributedString)
        size.width = max(attrSize.width, size.width)
        size.height = max(attrSize.height, size.height)
        
        attributedString.addAttributes([
            .foregroundColor: style.color,
            .backgroundColor: style.backgroundColor,
            .paragraphStyle: paragraph,
            .strokeWidth: strokeWidth as NSNumber,
            .strokeColor: style.borderColor
            ])
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        var drawRect: CGRect = CGRect(origin: .zero, size: size)
        
        if size.width > size.height{ //Vertically center
            drawRect.origin.y = (size.height - fontSize) / 2
        }
        else if size.height > size.width{ //Horizonatally center
            drawRect.origin.x = (size.width - fontSize) / 2
        }

        attributedString.draw(in: drawRect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    
}

#if !os(tvOS)
public extension UISlider {
    
    private func defaultFontIconConfiguration() -> FontIconConfiguration{
        let side = 25.0
        return FontIconConfiguration(sizeConfig: FontIconSizeConfiguration(size: CGSize(width: side, height: side)))
    }
    func setFontIconMaximumValueImage<FontIcon: FontIconEnum>(_ icon: FontIcon, configuration: FontIconConfiguration? = nil) {
        maximumValueImage = UIImage(icon: icon, configuration:  configuration ?? defaultFontIconConfiguration())
    }
    
    
    func setFontIconMinimumValueImage<FontIcon: FontIconEnum>(_ icon: FontIcon, configuration: FontIconConfiguration? = nil) {
        minimumValueImage = UIImage(icon: icon, configuration: configuration ?? defaultFontIconConfiguration())
    }
}
#endif

private func sizeOfAttributeString(_ str: NSAttributedString) -> CGSize {
    return str.boundingRect(with: CGSize(width: 10000, height: 10000), options:(NSStringDrawingOptions.usesLineFragmentOrigin), context:nil).size
}
