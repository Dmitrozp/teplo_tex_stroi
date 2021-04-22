package com.silver_ads.teplo_tex_stroi.exception_handling;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class OrderExceptionHandler {

    @ExceptionHandler
    public ResponseEntity<OrderIncorrectDate> handleException(NoSuchOrderDetailsException exception) {
        OrderIncorrectDate orderIncorrectDate = new OrderIncorrectDate();
        orderIncorrectDate.setMessage(exception.getMessage());

        return new ResponseEntity<>(orderIncorrectDate, HttpStatus.NOT_FOUND);
    }
}
