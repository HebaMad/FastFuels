//
//  ApiEndPoint.swift
//  FastFual
//
//  Created by macbook on 5/20/21.
//

import Foundation

enum API_KEYS: String {
   case BASE_URL = "http://fastfuel-sa.com/api/"
    case login = "login"
    case validation_code = "verified_code"
    case get_prices = "prices"
    case getSliders = "sliders"
    case postSuppliers = "suppliers"
    case getTrellas = "trellas"
    case postAddToCart = "add_to_cart"
    case getMyCart = "get_my_cart"
    case getDeleteMyCart = "delete_my_cart"
    case getCosts = "costs"
    case postCheckOut = "check_out"
    case postMyOrder = "my_order"
    case getSetting = "setting"
    case postFavorite = "favorite"
    case getMyFavorite = "my_favorite"
    case getProfile = "profile"
    case postUpdateUserProfile = "update_user_profile"
    case postcoupon = "coupon"
    case postRate = "rate"
    case postsearch = "search"
    case getOrderStatus = "order_status"
    case getCancelOrder = "cancel_order"
    case getorder_details = "order_details"
    case getre_order = "re_order"
    case getBanks = "banks"
    case postBankTransfer = "bank_transfer"
    case postChangeLanguage = "changeLanguage"
    case getNotification = "notification"
    case getTanks = "tanks"
    case postSaleCalulator = "sales_calculator"
    case getStationMachine = "station_machine"
    case getHistoryMachine = "history_machine"
    case gettank_sales = "tank_sales"
    case getReadNotification = "read_notification"
    case getLogout = "logout"
    case postOrders = "orders"
    case postUpdateDriverProfile = "update_driver_profile"
    case getOrderAccept = "orders_accept"
    case getOrderDeleviered = "orders_delivering"
    case getOrderCompleted = "orders_completed"
    case getDriverProfile = "driver_profile"
    case getAvaliable = "available"
    

    
    var url: String {
        switch self {
        case .BASE_URL:
            return API_KEYS.BASE_URL.rawValue
 
        default:
            return "\(API_KEYS.BASE_URL.rawValue)\(self.rawValue)"
        }
    }
    func withId(id: Int) -> String {
        switch self {
        case .getStationMachine, .getHistoryMachine,.gettank_sales,.getOrderDeleviered,.getOrderCompleted,.getOrderDeleviered,.getCancelOrder,.getre_order,.getorder_details,.getReadNotification,.getOrderStatus,.getOrderCompleted:
            return "\(API_KEYS.BASE_URL.rawValue)\(self.rawValue)/\(id)"
 
        default:
            return ""
        }
    }

}
