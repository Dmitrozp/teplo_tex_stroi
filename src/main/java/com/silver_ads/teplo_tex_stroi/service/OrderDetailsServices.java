package com.silver_ads.teplo_tex_stroi.service;

import com.silver_ads.teplo_tex_stroi.entity.OrderDetails;

public interface OrderDetailsServices {

    public OrderDetails save(OrderDetails orderDetails);
    public OrderDetails createOrderDetails(OrderDetails orderDetailsExternal);
}
