package com.silverwork.teplo_tex_stroi.exception_handling;

public class NoSuchOrderException extends RuntimeException{
    public NoSuchOrderException(String message) {
        super(message);
    }
}
