// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Filterview {
    /// ფასის მიხედვით
    internal static let byPrice = L10n.tr("localized", "filterview.by_price", fallback: "ფასის მიხედვით")
    /// მაღაზიების მიხედვით
    internal static let byStores = L10n.tr("localized", "filterview.by_stores", fallback: "მაღაზიების მიხედვით")
  }
  internal enum Homepage {
    /// აირჩიეთ კატეგორია
    internal static let selectCategory = L10n.tr("localized", "homepage.select_category", fallback: "აირჩიეთ კატეგორია")
  }
  internal enum Listpage {
    /// სიის გასუფთავება
    internal static let clearButton = L10n.tr("localized", "listpage.clear_button", fallback: "სიის გასუფთავება")
    /// პ.ქავთარაძის 40
    internal static let location1 = L10n.tr("localized", "listpage.location1", fallback: "პ.ქავთარაძის 40")
    /// ალ.ყაზბეგის 38
    internal static let location2 = L10n.tr("localized", "listpage.location2", fallback: "ალ.ყაზბეგის 38")
    /// ს.ეულის 10
    internal static let location3 = L10n.tr("localized", "listpage.location3", fallback: "ს.ეულის 10")
    /// ალ.ყაზბეგის 32
    internal static let location4 = L10n.tr("localized", "listpage.location4", fallback: "ალ.ყაზბეგის 32")
    /// სია
    internal static let title = L10n.tr("localized", "listpage.title", fallback: "სია")
    /// Unknown Location
    internal static let unknownLocation = L10n.tr("localized", "listpage.unknown_location", fallback: "Unknown Location")
    /// Unknown Store
    internal static let unknownStore = L10n.tr("localized", "listpage.unknown_store", fallback: "Unknown Store")
  }
  internal enum Onboarding {
    internal enum DescriptionForObPage1 {
      /// მოძებნე სასურველი პროდუქტი, გაფილტრე კატეგორიების ან მაღაზიების მიხედვით
      internal static let text = L10n.tr("localized", "onboarding.description_for_ob_page1.text", fallback: "მოძებნე სასურველი პროდუქტი, გაფილტრე კატეგორიების ან მაღაზიების მიხედვით")
    }
    internal enum DescriptionForObPage2 {
      /// შეადარეთ ფასები და შექმენით პერსონალური პროდუქტების სია მარტივად
      internal static let text = L10n.tr("localized", "onboarding.description_for_ob_page2.text", fallback: "შეადარეთ ფასები და შექმენით პერსონალური პროდუქტების სია მარტივად")
    }
    internal enum DescriptionForObPage3 {
      /// იხილეთ ინფორმაცია მაღაზიების მიმდინარე შეთავაზებების შესახებ
      internal static let text = L10n.tr("localized", "onboarding.description_for_ob_page3.text", fallback: "იხილეთ ინფორმაცია მაღაზიების მიმდინარე შეთავაზებების შესახებ")
    }
    internal enum TitleForObPage1 {
      /// პროდუქტების ძიების მარტივი გზა
      internal static let text = L10n.tr("localized", "onboarding.title_for_ob_page1.text", fallback: "პროდუქტების ძიების მარტივი გზა")
    }
    internal enum TitleForObPage2 {
      /// შექმენი შენი სია
      internal static let text = L10n.tr("localized", "onboarding.title_for_ob_page2.text", fallback: "შექმენი შენი სია")
    }
    internal enum TitleForObPage3 {
      /// დაზოგე ფული და დრო
      internal static let text = L10n.tr("localized", "onboarding.title_for_ob_page3.text", fallback: "დაზოგე ფული და დრო")
    }
  }
  internal enum Productcell {
    internal enum Stockstatus {
      /// მარაგშია
      internal static let inStock = L10n.tr("localized", "productcell.stockstatus.in_stock", fallback: "მარაგშია")
      /// მარაგი იწურება
      internal static let limitedStock = L10n.tr("localized", "productcell.stockstatus.limited_stock", fallback: "მარაგი იწურება")
      /// მარაგი ამოიწურა
      internal static let outOfStock = L10n.tr("localized", "productcell.stockstatus.out_of_stock", fallback: "მარაგი ამოიწურა")
    }
  }
  internal enum ProductsOnSale {
    /// აქცია
    internal static let title = L10n.tr("localized", "products_on_sale.title", fallback: "აქცია")
  }
  internal enum Searchbar {
    internal enum Filterview {
      /// clear
      internal static let clear = L10n.tr("localized", "searchbar.filterview.clear", fallback: "clear")
      /// Localized.strings
      ///  Sia
      ///  
      ///  Created by Sandro Gelashvili on 23.07.24.
      internal static let searchPlaceholder = L10n.tr("localized", "searchbar.filterview.search_placeholder", fallback: "ძებნა")
    }
  }
  internal enum Storecollectionviewcell {
    /// ლოკაციები
    internal static let locations = L10n.tr("localized", "storecollectionviewcell.locations", fallback: "ლოკაციები")
    /// პროდუქტების ნახვა
    internal static let viewProducts = L10n.tr("localized", "storecollectionviewcell.view_products", fallback: "პროდუქტების ნახვა")
  }
  internal enum Storedetailstableviewcell {
    /// რუკაზე ნახვა
    internal static let mapButtonTitle = L10n.tr("localized", "storedetailstableviewcell.map_button_title", fallback: "რუკაზე ნახვა")
  }
  internal enum Tabbar {
    /// მთავარი
    internal static let home = L10n.tr("localized", "tabbar.home", fallback: "მთავარი")
    /// პროდუქტების სია
    internal static let list = L10n.tr("localized", "tabbar.list", fallback: "პროდუქტების სია")
    /// მაღაზიები
    internal static let store = L10n.tr("localized", "tabbar.store", fallback: "მაღაზიები")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
