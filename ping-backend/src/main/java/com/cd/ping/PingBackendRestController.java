package com.cd.ping;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.net.InetAddress;
import java.net.UnknownHostException;

@RestController
@CrossOrigin(origins = "*")
public class PingBackendRestController {

    @GetMapping(value = "/ping")
    public ResponseEntity<String> ping() {
        return ResponseEntity.ok("pong from " + getHostName());
    }

    private String getHostName() {
        try {
            return InetAddress.getLocalHost().getHostName();
        } catch (UnknownHostException e) {
            return "Unknown Host";
        }
    }
}