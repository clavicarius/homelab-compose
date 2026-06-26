# Automatische Versionierung

## Ziel

Nach jedem erfolgreichen Release soll automatisch ein neuer Git-Tag nach dem Schema `vMAJOR.MINOR.PATCH` erstellt und in das Repository gepusht werden.

Die Versionierung erfolgt ausschließlich auf Basis bereits vorhandener Git-Tags.

## Versionsschema

Es wird das Semantic-Versioning-Format verwendet:

```text
vMAJOR.MINOR.PATCH
```

Beispiele:

```text
v1.0.0
v1.0.1
v1.0.2
v1.1.0
v2.0.0
```

## Ermittlung der nächsten Version

Die Automatisierung durchsucht alle vorhandenen Git-Tags, die dem Schema `vMAJOR.MINOR.PATCH` entsprechen.

Anschließend erfolgt folgendes Vorgehen:

1. Alle gültigen Versions-Tags ermitteln.
2. Die höchste Kombination aus `MAJOR.MINOR` bestimmen.
3. Innerhalb dieser Versionslinie den höchsten `PATCH` ermitteln.
4. Den `PATCH`-Wert um eins erhöhen.
5. Einen neuen Tag erzeugen.

### Beispiel

Vorhandene Tags:

```text
v1.0.0
v1.0.3
v1.1.0
v1.1.5
v2.0.0
v2.0.4
v2.1.0
v2.1.7
```

Ergebnis:

```text
v2.1.8
```

Ein weiterer Fall:

Vorhandene Tags:

```text
v1.5.2
v2.0.9
v3.0.0
```

Ergebnis:

```text
v3.0.1
```

## Voraussetzungen

Die Versionierung wird ausschließlich ausgeführt, wenn:

- alle Verifizierungs-Jobs erfolgreich abgeschlossen wurden,
- der Workflow auf dem Standard-Branch ausgeführt wird,
- kein Release-Tag für den aktuellen Commit existiert.

## Ablauf

1. Repository inklusive aller Tags auschecken.
2. Alle Versions-Tags laden.
3. Höchste `MAJOR.MINOR`-Version bestimmen.
4. Höchsten `PATCH` innerhalb dieser Versionslinie bestimmen.
5. Neuen Versions-Tag erzeugen.
6. Tag in das Remote-Repository pushen.
7. Optional einen GitHub Release auf Basis des neuen Tags erstellen.

## Hinweise

- Es werden ausschließlich Tags berücksichtigt, die dem Muster `vMAJOR.MINOR.PATCH` entsprechen.
- Andere Tags (z. B. `latest`, `beta`, `test`) werden ignoriert.
- Die Versionierung erfolgt vollständig automatisiert und benötigt keine manuelle Pflege.
- Die Erhöhung von `MAJOR` oder `MINOR` erfolgt bewusst nicht automatisch. Neue Haupt- oder Nebenversionen werden durch einen manuellen Tag (z. B. `v3.0.0` oder `v3.1.0`) initiiert. Ab diesem Zeitpunkt erhöht die Automatisierung ausschließlich den `PATCH`-Wert innerhalb der jeweils höchsten `MAJOR.MINOR`-Versionslinie.
