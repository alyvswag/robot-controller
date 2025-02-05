#include <WiFi.h>
#include <WebSocketsClient.h>
#include <ArduinoJson.h>

const char* ssid = "BANM_Hostel";
const char* password = "W1f1St4#nT8"; 
const char* ws_server = "socket-js-cgcrfegefvcuebfd.canadacentral-01.azurewebsites.net";
const int ws_port = 443;
const char* robot_name = "robot1";  // ESP32 üçün robotun adı

WebSocketsClient webSocket;
bool isConnected = false;

void registerRobot() {
    DynamicJsonDocument doc(256);
    doc["type"] = "register";
    doc["robotName"] = robot_name;

    String jsonStr;
    serializeJson(doc, jsonStr);
    webSocket.sendTXT(jsonStr);

    Serial.println("📡 Robot qeydiyyat mesajı göndərildi!");
}

void onWebSocketEvent(WStype_t type, uint8_t *payload, size_t length) {
    switch (type) {
        case WStype_CONNECTED:
            Serial.println("✅ WebSocket Qoşuldu!");
            isConnected = true;
            registerRobot();  // Qoşulduqdan sonra robotu qeydiyyata al
            break;

        case WStype_TEXT: {
            String message = (char*)payload;
            Serial.print("📩 Yeni mesaj alındı: ");
            Serial.println(message);

            // JSON mesajı emal et
            DynamicJsonDocument doc(256);
            DeserializationError error = deserializeJson(doc, message);
            if (error) {
                Serial.print("❌ JSON xətası: ");
                Serial.println(error.c_str());
                return;
            }

            if (doc["type"] == "command") {
                const char* command = doc["command"];
                Serial.print("➡ Robot üçün komanda: ");
                Serial.println(command);
                // Burada mühərrikləri idarə etmək üçün kod əlavə et
            }
            break;
        }

        case WStype_DISCONNECTED:
            Serial.println("❌ WebSocket Bağlantısı Kəsildi! Yenidən qoşulmağa çalışılır...");
            isConnected = false;
            break;
    }
}

void setup() {
    Serial.begin(115200);
    WiFi.begin(ssid, password);
    Serial.print("🔄 WiFi qoşulur...");
    
    while (WiFi.status() != WL_CONNECTED) {
        delay(1000);
        Serial.print(".");
    }
    Serial.println("\n✅ WiFi Qoşuldu!");

    webSocket.beginSSL(ws_server, ws_port, "/");  // SSL ilə bağlantı
    webSocket.onEvent(onWebSocketEvent);
    webSocket.setReconnectInterval(5000);  // 5 saniyədən bir yenidən qoşulmağa çalış
}

void loop() {
    webSocket.loop();
}