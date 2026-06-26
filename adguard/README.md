# AdGuard Home

Docker-Compose-Projekt für den Betrieb von **AdGuard Home** im Homelab.

## Voraussetzungen

* Docker Engine
* Docker Compose
* Netzwerk mit statischer IP-Konfiguration
* `.env`-Datei im Projektverzeichnis

## Projektstruktur

```text
adguard/
├── compose.yml
├── .env
├── conf/
├── work/
└── README.md
```

## Umgebungsvariablen

Alle projektspezifischen Einstellungen befinden sich in der `.env`.

### Benutzer

```env
PUID=1000
PGID=1000
TZ=Europe/Berlin
```

### Netzwerk

```env
SUBNET=192.168.178.0/24
GATEWAY=192.168.178.1
```

### Homelab

```env
HOMELAB_DOMAIN=homelab.local
HOMELAB_EMAIL=admin@homelab.local
```

### AdGuard

```env
ADGUARD_HOST=adguard
ADGUARD_IP=192.168.178.252
ADGUARD_PORT=8252
```

## Verzeichnisse

| Verzeichnis | Beschreibung                  |
| ----------- | ----------------------------- |
| `./conf`    | Konfiguration                 |
| `./work`    | Datenbank, Filterlisten, Logs |

Die Daten bleiben dadurch auch nach einem Container-Update erhalten.

## Ports

| Port              | Beschreibung                          |
| ----------------- | ------------------------------------- |
| 53/tcp            | DNS                                   |
| 53/udp            | DNS                                   |
| 9080              | Weboberfläche im Container            |
| `${ADGUARD_PORT}` | veröffentlichter Webport auf dem Host |

Die Weboberfläche ist anschließend erreichbar unter

```
http://<Docker-Host>:${ADGUARD_PORT}
```

beispielsweise

```
http://192.168.178.10:8252
```

## Netzwerk

Der Container erhält eine feste IP-Adresse aus der `.env`.

```text
${ADGUARD_IP}
```

Das Docker-Netzwerk wird mit folgenden Parametern erstellt:

```text
Subnet : ${SUBNET}
Gateway: ${GATEWAY}
```

## Container starten

```bash
docker compose pull
docker compose up -d
```

Containerstatus prüfen

```bash
docker compose ps
```

Logs anzeigen

```bash
docker compose logs -f
```

Container stoppen

```bash
docker compose down
```

## Ersteinrichtung

Nach dem ersten Start den Einrichtungsassistenten öffnen:

```
http://<Docker-Host>:${ADGUARD_PORT}
```

Empfohlene Einstellungen:

* DNS-Port: 53
* Webinterface: 9080
* Admin-Benutzer anlegen
* Upstream-DNS konfigurieren (z. B. Quad9, Cloudflare oder Unbound)

## Updates

Container aktualisieren:

```bash
docker compose pull
docker compose up -d
```

Nicht benötigte Images entfernen:

```bash
docker image prune
```

## Backup

Folgende Verzeichnisse sichern:

```text
conf/
work/
```

Diese enthalten:

* Konfiguration
* Benutzer
* DNS-Einstellungen
* Filterlisten
* Statistiken

## Wiederherstellung

1. Container stoppen.
2. `conf/` und `work/` zurückkopieren.
3. Container erneut starten.

## Healthcheck

Der Container prüft alle 30 Sekunden die Erreichbarkeit des Webinterfaces.

## Geplante Traefik-Integration

Die `.env` enthält bereits alle benötigten Variablen.

```env
HOMELAB_DOMAIN=homelab.local
ADGUARD_HOST=adguard
```

Später kann AdGuard beispielsweise unter

```
https://adguard.homelab.local
```

über Traefik veröffentlicht werden.

## Hinweise

* Das offizielle AdGuard-Image verwendet `PUID` und `PGID` derzeit nicht aktiv. Die Variablen sind dennoch bereits vorbereitet und können für zukünftige Images oder einen Wechsel auf ein anderes Image beibehalten werden.
* Alle projektspezifischen Einstellungen (Ports, IP-Adressen, Domains und Benutzerinformationen) werden zentral über die `.env` verwaltet.
