package com.silverwork.teplo_tex_stroi.exception_handling;

public class NoSuchOrderDetailsException extends RuntimeException {
    public NoSuchOrderDetailsException(String message) {
        super(message);
    }
}
