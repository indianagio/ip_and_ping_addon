# Ping and External IP Add-on

This Home Assistant add-on pings 8.8.8.8 and reports:
- Latency (ms)
- External IP

It publishes data as MQTT discovery sensors.

## Configuration options
- `interval` (int): interval in seconds between checks (default: 5)
- `mqtt_host` (str): MQTT broker address
- `mqtt_username` (str): MQTT username
- `mqtt_password` (str): MQTT password
