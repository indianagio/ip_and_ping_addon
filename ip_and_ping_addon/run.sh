#!/usr/bin/with-contenv bashio

INTERVAL=$(bashio::config 'interval')
MQTT_HOST=$(bashio::config 'mqtt_host')
MQTT_USER=$(bashio::config 'mqtt_username')
MQTT_PASS=$(bashio::config 'mqtt_password')

BASE_TOPIC="homeassistant/sensor/ping_external_ip"

# Send discovery config
mosquitto_pub -h "$MQTT_HOST" -u "$MQTT_USER" -P "$MQTT_PASS" \
    -t "$BASE_TOPIC/latency/config" \
    -m '{"name": "Ping Latency", "state_topic": "'$BASE_TOPIC'/latency/state", "unit_of_measurement": "ms", "unique_id": "ping_external_ip_latency"}'

mosquitto_pub -h "$MQTT_HOST" -u "$MQTT_USER" -P "$MQTT_PASS" \
    -t "$BASE_TOPIC/external_ip/config" \
    -m '{"name": "External IP", "state_topic": "'$BASE_TOPIC'/external_ip/state", "unique_id": "ping_external_ip_externalip"}'

while true; do
    LATENCY=$(ping -c 1 8.8.8.8 | grep 'time=' | awk -F'time=' '{print $2}' | awk '{print $1}')
    IP=$(curl -s https://api.ipify.org)

    if [ -z "$LATENCY" ]; then
        LATENCY="unreachable"
    fi

    mosquitto_pub -h "$MQTT_HOST" -u "$MQTT_USER" -P "$MQTT_PASS" \
        -t "$BASE_TOPIC/latency/state" -m "$LATENCY"

    mosquitto_pub -h "$MQTT_HOST" -u "$MQTT_USER" -P "$MQTT_PASS" \
        -t "$BASE_TOPIC/external_ip/state" -m "$IP"

    sleep "$INTERVAL"
done
