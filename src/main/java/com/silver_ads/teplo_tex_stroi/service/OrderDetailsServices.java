package com.silver_ads.teplo_tex_stroi.service;

import com.silver_ads.teplo_tex_stroi.entity.OrderDetails;

public interface OrderDetailsServices {

    OrderDetails save(OrderDetails orderDetails);
    OrderDetails createOrderDetails(OrderDetails orderDetailsExternal);
}
