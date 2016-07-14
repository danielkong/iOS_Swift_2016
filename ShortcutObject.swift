import Foundation

public class ShortcutObject: NSObject, NSCoding {
    public enum ShortcutType : String {
        case Popular = "com.workday.shortcutobject.type.popular"
        case Exclusion = "com.workday.shortcutobject.type.exclusion"
        case Order = "com.workday.shortcutobject.type.order"
        case None = "com.workday.shortcutobject.type.none"
    }
    
    static let kTitleKey = "com.workday.shortcutobject.title"
    static let kIconName = "com.workday.shortcutobject.iconname"
    static let kUriKey = "com.workday.shortcutobject.uri"
    static let kTypeKey = "com.workday.shortcutobject.type"
    
    public let title : String
    public let iconName : String?
    public let uri : String
    public let type : ShortcutType

    public init(title: String, iconName: String?, uri: String, type: ShortcutType) {
        self.title = title
        self.iconName = iconName
        self.uri = uri
        self.type = type
        super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) { // NS_DESIGNATED_INITIALIZER
        self.title = aDecoder.decodeObjectForKey(ShortcutObject.kTitleKey) as! String
        self.iconName = aDecoder.decodeObjectForKey(ShortcutObject.kIconName) as? String
        self.uri = aDecoder.decodeObjectForKey(ShortcutObject.kUriKey) as! String
        self.type = ShortcutType(rawValue: aDecoder.decodeObjectForKey(ShortcutObject.kTypeKey) as! String)!
        super.init()
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.title, forKey: ShortcutObject.kTitleKey)
        aCoder.encodeObject(self.iconName, forKey: ShortcutObject.kIconName)
        aCoder.encodeObject(self.uri, forKey: ShortcutObject.kUriKey)
        aCoder.encodeObject(self.type.rawValue, forKey: ShortcutObject.kTypeKey)
    }

    @available(iOSApplicationExtension 9.0, *)
    init(item: UIApplicationShortcutItem) {
        self.title = item.localizedTitle
        self.iconName = nil
        self.uri = item.userInfo![ShortcutObject.kUriKey] as! String
        self.type = ShortcutType(rawValue: item.type)!
        super.init()
    }
    
    @available(iOSApplicationExtension 9.0, *)
    public var shortcut : UIApplicationShortcutItem {
        var icon : UIApplicationShortcutIcon? = nil
        if let iconName = iconName {
            icon = UIApplicationShortcutIcon(templateImageName: iconName + "-appShortcut")
        }
        return UIApplicationShortcutItem(type: type.rawValue,
                                         localizedTitle: title,
                                         localizedSubtitle: nil,
                                         icon: icon,
                                         userInfo: [ShortcutObject.kUriKey : uri])
    }
}
