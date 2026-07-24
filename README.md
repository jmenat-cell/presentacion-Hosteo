# presentacion-Hosteo

Material comercial de **Hosteo** (administración de departamentos en alquiler de corta estadía, Perú): presentaciones, cartas y dossiers en PDF para propietarios que evalúan entregar su unidad en administración.

Este repositorio se opera con [Claude Code](https://claude.ai/code). Los flujos principales son slash commands:

| Comando | Qué hace |
|---|---|
| `/prospecto <nombre>` | Registra o actualiza un prospecto y recomienda su nivel de revelación |
| `/presentacion <prospecto> [nivel]` | Genera el deck PDF del nivel correspondiente |
| `/carta <prospecto>` | Genera una carta / one-pager A4 personalizado |
| `/dossier <prospecto>` | Genera el paquete de cierre completo (Nivel 3) |

## Uso diario: cómo ingresar un prospecto nuevo

No hace falta mantener sesiones abiertas — el repositorio es la memoria y cada sesión nueva lo lee completo al arrancar. Una sesión corta por prospecto:

1. **Abrir una sesión nueva** de Claude Code sobre este repositorio.
2. **Adjuntar el chat de WhatsApp exportado** (.zip o .txt: WhatsApp → Exportar chat → Sin archivos) en el primer mensaje, junto con `/prospecto`.
3. Revisar y aprobar la **ficha comercial** que propone la sesión; con eso se crea el perfil y se genera el material del nivel.
4. Enviar el PDF al prospecto por WhatsApp, avisar en la sesión para registrar el envío, y **cerrar la sesión**.

Variante desde el celular: exportar el chat a una carpeta de Google Drive (ej. "Hosteo — prospectos") y en la siguiente sesión pedir "revisa la carpeta de prospectos en Drive y procesa los chats nuevos" (Drive está conectado a Claude).

Cuando el prospecto responda: abrir otra sesión corta y contar qué dijo (o pegar el chat actualizado) — el perfil en `prospectos/` tiene todo el contexto anterior. La automatización completa (reenviar el chat por correo y que la ficha aparezca sola en `prospectos/_bandeja/`) está diseñada en `automatizacion/whatsapp-a-ficha.md`, pendiente de implementar en n8n.

## Idea central: revelación progresiva

Todo material se genera en uno de tres niveles — **N1 Teaser** (curiosos), **N2 Propuesta** (interesados reales), **N3 Cierre** (decididos) — para no regalar el "manual de operación" a quien solo está pescando información. La política completa está en `CLAUDE.md`.

## Estructura

```
contenido/       Fuente única de verdad sobre Hosteo (editar aquí los datos reales)
marca/           Sistema de diseño y activos de marca
plantillas/      Plantillas HTML (deck 16:9 y documento A4)
prospectos/      Un directorio por prospecto: perfil + entregables generados
scripts/         html2pdf.sh (HTML → PDF con Chromium headless)
.claude/skills/  Los flujos de trabajo
```

## Generar un PDF a mano

```bash
scripts/html2pdf.sh plantillas/presentacion.html vista-previa.pdf
```

Requiere Chromium/Chrome instalado (se autodetecta; puedes fijar la ruta con `CHROMIUM_BIN`).
