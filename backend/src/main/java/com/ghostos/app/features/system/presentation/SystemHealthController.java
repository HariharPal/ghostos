package com.ghostos.app.features.system.presentation;

import java.time.Instant;
import java.util.Map;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/system")
public class SystemHealthController {

    @GetMapping("/health")
    public Map<String, Object> health() {
        return Map.of(
            "service", "ghostos-backend",
            "status", "UP",
            "timestamp", Instant.now().toString()
        );
    }
}
