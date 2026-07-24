# Plan v1: implementación de la automatización WhatsApp → ficha (n8n)

Diseño cerrado el 17 Jul 2026 (sesión Fable). Metodología acordada con Javier: **Fable diseña → una sesión ejecutora (Opus) hace las tareas mecánicas T1–T4 → Fable audita** (sección "Auditoría"). La sesión ejecutora NO toma decisiones de diseño: si algo es ambiguo, lo anota en "Dudas de la ejecución" (al final) y continúa con el resto.

Contexto de negocio: `automatizacion/whatsapp-a-ficha.md`. Prompt canónico: `automatizacion/prompt-ficha.md`.

## Decisiones tomadas (no re-decidir)

| Tema | Decisión | Razón |
|---|---|---|
| Entrada | Correo: Javier reenvía el chat exportado (.txt/.zip) a su Gmail con etiqueta `hosteo-prospectos` | Cero fricción y cero riesgo para el número de WhatsApp; la Cloud API queda como upgrade v2 |
| Modelo API | `claude-opus-5` (exacto, sin sufijos) | Estándar vigente; la ficha requiere criterio (pesca vs. interés), no solo extracción; costo por ficha ~centavos |
| Parámetros API | `max_tokens: 8000`; SIN `thinking`, SIN `temperature`/`top_p`/`top_k` (devuelven 400 en este modelo); thinking viene activado por defecto | Referencia oficial claude-api (Jul 2026) |
| Salida | Archivo en `prospectos/_bandeja/AAAA-MM-DD-<slug>.md`, rama `claude/claude-md-documentation-h11p97` | Revisión humana obligatoria antes de crear perfiles |
| Procesamiento en lote | Una sesión de Claude Code procesa TODA la bandeja (skill `/prospecto`, "Modo bandeja") | Amortiza el contexto entre prospectos (decisión de economía de tokens) |
| Privacidad | El chat completo NO se guarda en el repo ni en logs de n8n; solo la ficha | Regla de `CLAUDE.md` |

## Arquitectura del flujo n8n (spec nodo a nodo)

Un workflow principal ("Hosteo — WhatsApp a ficha") y un workflow de errores ("Hosteo — error de ficha").

**N1 · Gmail Trigger** (`n8n-nodes-base.gmailTrigger`) — poll cada 5 min; filtro por etiqueta `hosteo-prospectos`; descargar adjuntos: sí. (Alternativa self-hosted sin Gmail: `emailReadImap` con las mismas condiciones.)

**N2 · IF "es un chat"** — pasa si hay adjunto `.txt`/`.zip` O el asunto contiene "Chat de WhatsApp". Si no pasa: termina (NoOp).

**N3 · Extracción del texto** — dos ramas según extensión del adjunto:
- `.zip` → nodo Compression (descomprimir) → Extract From File (texto) sobre `_chat.txt`
- `.txt` → Extract From File (texto) directo

**N4 · Code "preparación"** (JS, por ítem) — construye `chat`: primeras ~30 líneas (ahí está la presentación/origen) + `[...]` + últimos ~12,000 caracteres si excede (el final es lo comercialmente vigente). Sanea el texto para JSON (el nodo HTTP con body JSON ya escapa; no doble-escapar).

**N5 · HTTP Request → Anthropic** (`n8n-nodes-base.httpRequest`):
- POST `https://api.anthropic.com/v1/messages`
- Headers: `x-api-key` (desde credencial n8n tipo Header Auth, nombre "Anthropic API"), `anthropic-version: 2023-06-01`, `content-type: application/json`
- Body JSON:
```json
{
  "model": "claude-opus-5",
  "max_tokens": 8000,
  "system": "<CONTENIDO VERBATIM DE automatizacion/prompt-ficha.md, desde 'Eres el asistente' hasta el final>",
  "messages": [{"role": "user", "content": "Conversación exportada de WhatsApp:\n\n{{ $json.chat }}"}]
}
```

**N6 · Code "validación y parseo"** (JS) — reglas exactas:
- Si `stop_reason === "refusal"` → lanzar error (va a la rama de errores).
- El texto de la ficha se arma **filtrando** los bloques: `content.filter(b => b.type === 'text').map(b => b.text).join('')` — NUNCA `content[0].text` (el primer bloque puede ser `thinking`).
- Validar que contiene `# Ficha —` y `## Recomendación`; si no → error.
- Extraer `nombre` del título (`# Ficha — (.+?) \(SIN REVISAR\)`); slug kebab-case sin tildes; `ruta = prospectos/_bandeja/AAAA-MM-DD-<slug>.md` (fecha de hoy).

**N7 · GitHub crear archivo** (`n8n-nodes-base.github`) — File:Create; owner `jmenat-cell`; repo `presentacion-Hosteo`; rama `claude/claude-md-documentation-h11p97`; path `{{ $json.ruta }}`; contenido = la ficha; mensaje de commit `Bandeja: ficha de <nombre> (sin revisar)`. Credencial: fine-grained PAT (ver seguridad).

**N8 · Gmail notificación** — correo a Javier: asunto `Ficha nueva en bandeja: <nombre>`; cuerpo = la ficha + línea final "Revísala y di 'procesa la bandeja' en una sesión de Claude Code."

**Workflow de errores** — Error Trigger → Gmail a Javier con el nombre del workflow, el error y el asunto del correo original, cerrando con "Procesa este chat manualmente con /prospecto".

**Ajustes del workflow (settings)**: guardar datos de ejecución solo en error; timezone `America/Lima`; el workflow principal referencia al de errores como Error Workflow.

## Seguridad (innegociable)

- API key de Anthropic: en credencial de n8n, con límite de gasto configurado en console.anthropic.com. Nunca en el JSON del workflow ni en el repo.
- GitHub: fine-grained PAT restringido a `jmenat-cell/presentacion-Hosteo`, permiso Contents: Read and write, expiración ≤ 1 año. Nunca en el repo.
- n8n: no loggear cuerpos de chats (settings de ejecución arriba); podar ejecuciones antiguas.

## Tareas para la sesión ejecutora (T1–T4)

Prohibido en esta fase: modificar `CLAUDE.md`, los skills, las plantillas, `prompt-ficha.md`, `whatsapp-a-ficha.md` o cualquier archivo de `contenido/`/`marca/`/`prospectos/` (salvo lo listado). Solo crear los archivos de abajo, commit y push a la rama actual.

- **T1 — `automatizacion/n8n/configuracion.md`** (entregable principal): guía paso a paso para que Javier monte el flujo en la interfaz de n8n siguiendo la spec nodo a nodo de arriba, SIN decidir nada nuevo. Debe incluir: prerequisitos (instancia n8n, credencial Gmail OAuth, credencial Header Auth con la API key, credencial GitHub PAT, etiqueta+filtro de Gmail `hosteo-prospectos`), creación de cada nodo N1–N8 con sus parámetros exactos, el código JS completo de N4 y N6 (escribirlo conforme a las reglas exactas de la spec), instrucción de pegar `prompt-ficha.md` verbatim en el body de N5, el workflow de errores, los settings, y cómo activar. Criterio de aceptación: una persona sin contexto puede montarlo solo con ese documento.
- **T2 — `automatizacion/n8n/flujo-whatsapp-ficha.json`**: el workflow principal exportable/importable en n8n (best effort; las credenciales van como referencias por nombre, jamás valores). Incluir nota al inicio de configuracion.md: "si el import falla por versiones de n8n, montar a mano con esta guía — el JSON es un atajo, no el camino crítico".
- **T3 — fixtures de prueba**: `automatizacion/n8n/prueba-chat.txt` — una conversación FICTICIA estilo export de WhatsApp (formato `[9/07/26, 1:26:27 p. m.] ~Nombre: mensaje`), prospecto inventado "Carla Prueba" con unidad inventada en Surco, marcada al inicio con una línea `[ARCHIVO DE PRUEBA — DATOS FICTICIOS]`; y `automatizacion/n8n/prueba-ficha-esperada.md` — la ficha que debería salir aproximadamente (para comparar en la prueba E2E). No usar datos de personas reales.
- **T4 — verificación mecánica**: `python3 -m json.tool` sobre el JSON de T2 sin errores; revisar que configuracion.md cubre los 8 nodos + errores + settings; commit y push con mensaje claro. Registrar cualquier ambigüedad encontrada en "Dudas de la ejecución" (abajo), sin resolverla por su cuenta.

## Configuración que solo Javier puede hacer

1. Crear la API key en console.anthropic.com (con límite de gasto) y el fine-grained PAT en GitHub.
2. Crear en Gmail la etiqueta `hosteo-prospectos` y un filtro que la aplique (ej. asunto contiene "Chat de WhatsApp").
3. Montar el flujo en su n8n siguiendo `automatizacion/n8n/configuracion.md` (o importar el JSON) y cargar las 3 credenciales.
4. Ejecutar la prueba E2E de abajo.

## Prueba end-to-end (con Javier)

1. Enviarse a sí mismo por correo `prueba-chat.txt` con la etiqueta `hosteo-prospectos`.
2. Ver la ejecución en n8n → debe aparecer `prospectos/_bandeja/AAAA-MM-DD-carla-prueba.md` en el repo y llegar el correo de notificación.
3. En una sesión de Claude Code: "procesa la bandeja" → revisar la ficha contra `prueba-ficha-esperada.md` → aprobar → verificar que se crea `prospectos/carla-prueba/perfil.md` y la bandeja queda vacía.
4. **Limpieza**: borrar el perfil de prueba (`git rm -r prospectos/carla-prueba`) — es el único caso en que se borra un prospecto.

## Auditoría (fase Fable, tras la ejecución)

- [ ] T1–T4 existen; nada fuera de `automatizacion/n8n/` fue tocado.
- [ ] configuracion.md refleja la spec nodo a nodo sin desviaciones ni decisiones nuevas.
- [ ] El prompt en N5 es idéntico a `prompt-ficha.md` (verbatim).
- [ ] Modelo `claude-opus-5` exacto; sin `thinking`/`temperature`/`top_p`/`top_k` en el body.
- [ ] N6 filtra bloques `type === "text"` (no `content[0]`), maneja `refusal`, valida formato, slug sin tildes.
- [ ] Rama, owner, repo y ruta de bandeja correctos; commit message correcto.
- [ ] Cero credenciales o valores sensibles en el repo; JSON con credenciales por referencia.
- [ ] Fixtures claramente ficticios y marcados.
- [ ] Prueba E2E ejecutada con Javier; artefactos de prueba eliminados.
- [ ] Actualizar `whatsapp-a-ficha.md` (estado v1 → implementada) y `CLAUDE.md` (pendientes).

## Dudas de la ejecución

(La sesión ejecutora anota aquí lo ambiguo, sin resolverlo.)

- —
