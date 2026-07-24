# Automatización: conversación de WhatsApp → ficha comercial → propuesta

Idea del usuario (17 Jul 2026), refinada. Objetivo: que las conversaciones de WhatsApp con potenciales propietarios se conviertan en una **ficha comercial estructurada**, el usuario la revise, y de ahí salga el perfil del prospecto y su material — sin tipear datos a mano.

## Estado

- **v0 (funciona HOY, sin infraestructura)**: exportar el chat desde WhatsApp (Ajustes del chat → Exportar chat → Sin archivos) o copiar/pegar los mensajes, y entregarlo en una sesión de Claude Code con `/prospecto`. El skill produce la ficha, el usuario la aprueba y se crea el perfil. Ver "Modo conversación de WhatsApp" en `.claude/skills/prospecto/SKILL.md`.
- **v1 (n8n, por implementar)**: pipeline automático descrito abajo. n8n NO está conectado por MCP a Claude actualmente; la integración v1 ni siquiera lo necesita (usa nodos nativos de n8n). Si además se quiere invocar flujos de n8n desde Claude, n8n ofrece el nodo "MCP Server Trigger" que expone el flujo como servidor MCP — se agrega en claude.ai → Configuración → Conectores como conector personalizado.

## Arquitectura v1 (n8n)

```
WhatsApp ──(a/b/c)──▶ n8n ──▶ Claude API (extracción) ──▶ GitHub: prospectos/_bandeja/
                                                                    │
   usuario revisa/corrige la ficha ◀────────────────────────────────┘
                                                                    │ aprobada
   sesión de Claude Code: /prospecto procesa la bandeja ──▶ perfil.md + material
```

**(a) Entrada recomendada — sin fricción**: reenviar el chat exportado (.txt) al correo de un buzón dedicado (ej. prospectos@hosteo.pe) que n8n vigila (nodo IMAP/Gmail). Cero infraestructura de WhatsApp.
**(b) Entrada automática — WhatsApp Business Cloud API**: webhook oficial de Meta → n8n. Requiere migrar el número (o uno secundario) a la API; más setup, tiempo real.
**(c) Entrada no oficial (Evolution API/WAHA)**: se conecta al WhatsApp personal, pero infringe términos de servicio de WhatsApp y arriesga el número comercial. **No recomendada** para el número principal de Hosteo.

**Nodos n8n del flujo**: Trigger (correo o webhook) → filtro "es un prospecto" → HTTP Request a `https://api.anthropic.com/v1/messages` (modelo `claude-sonnet-5`, económico y suficiente para extracción) con el prompt de abajo → validación JSON → nodo GitHub: crear archivo `prospectos/_bandeja/AAAA-MM-DD-<slug>.md` en este repo → (opcional) notificación al usuario por correo/Telegram con el resumen.

## Formato de la ficha comercial (el contrato entre automatización y repo)

```markdown
# Ficha — ⟦Nombre⟧ (SIN REVISAR)

- Fecha de la conversación: AAAA-MM-DD · Canal: WhatsApp
- Contacto: ⟦teléfono/correo⟧
- Origen: ⟦referido / web / Instagram / edificio / desconocido⟧

## Unidad
- Edificio/dirección: · Distrito: · Tipología: · m²: · Amoblado:

## La conversación en 3 líneas
⟦qué pidió, en qué tono, con qué urgencia⟧

## Objeciones o dudas planteadas
- ⟦objeción⟧ → ⟦ángulo en contenido/objeciones.md⟧

## Señales
- Interés real: ⟦preguntó números/condiciones/plazos/disponibilidad…⟧
- Señales de pesca: ⟦preguntas por el "cómo" operativo, evasivas a reunión, es del rubro…⟧

## Recomendación
- Nivel: ⟦1/2/3⟧ — ⟦justificación en una línea⟧
- Siguiente paso: ⟦ej. carta N1 + propuesta de reunión⟧
```

Regla dura heredada de CLAUDE.md: la ficha solo contiene lo que la conversación evidencia. Campo sin dato = `desconocido`, nunca un valor plausible.

## Prompt listo para el nodo de n8n (system prompt)

> Eres el asistente comercial de Hosteo, empresa peruana que administra departamentos en alquiler de corta estadía en Lima por cuenta de sus propietarios. Recibirás una conversación de WhatsApp entre Hosteo y un potencial cliente (propietario de departamento). Devuelve ÚNICAMENTE la ficha comercial en el formato markdown acordado (sin comentarios adicionales). Extrae solo lo que la conversación evidencia; si un dato no aparece, escribe "desconocido" — nunca inventes ni infieras valores plausibles. Clasifica las señales: interés real (pregunta por números, condiciones, plazos, disponibilidad, agenda reunión) vs. pesca de información (pregunta por el cómo operativo — herramientas, proveedores, tarifas internas —, evita reunirse, parece del rubro). Recomienda nivel de revelación: 1 teaser (primer contacto o señales de pesca), 2 propuesta (interés real sobre SU unidad), 3 cierre (listo para firmar). El formato de la ficha es: [pegar aquí el bloque "Formato de la ficha comercial"].

## Revisión y procesamiento (human-in-the-loop, innegociable)

1. La ficha llega a `prospectos/_bandeja/` marcada **(SIN REVISAR)**. Nada se genera desde una ficha sin revisar.
2. El usuario la corrige/aprueba (basta quitarle el "(SIN REVISAR)" del título o decirlo en sesión).
3. En sesión: "procesa la bandeja" → `/prospecto` convierte cada ficha aprobada en perfil oficial, borra la ficha de la bandeja (el contenido ya vive en el perfil) y propone el material del nivel. Si se quiere, una Routine diaria puede revisar la bandeja y dejar los borradores listos.

## Privacidad

- La conversación completa NO se guarda en el repo: solo la ficha (extracto estructurado). El chat original queda en WhatsApp/n8n.
- El repo es privado; las fichas contienen datos personales — mismas reglas que `prospectos/` (no publicar, no copiar fuera).
- En n8n: no loggear el cuerpo de los chats; borrar ejecuciones antiguas.

## Economía de tokens (decisión de diseño, 17 Jul 2026)

Preocupación del usuario: no gastar tokens releyendo contexto en cada generación. Resolución — cada pieza donde rinde:

- **Extracción chat→ficha**: es el paso barato y automatizable — prompt fijo contra la API, sin ningún contexto del repo (centavos por prospecto). Por eso vive en n8n.
- **Generación de material**: aquí NO se ahorra. Se evaluó generar los PDF sin IA (mail-merge de la plantilla en n8n, costo cero) y se descartó: se pierde el criterio de revelación por nivel, el copy personalizado a la situación del prospecto y la presentación honesta de proyecciones — exactamente lo que cierra ventas. Decisión explícita del usuario: calidad para el cliente primero, el costo en tokens no importa.
- **La palanca de ahorro real sin perder calidad**: procesar en lote. Una sola sesión procesa TODA la bandeja pendiente (el contexto se lee una vez y se amortiza entre prospectos). Con volumen: una Routine programada (diaria o semanal según flujo) que procese la bandeja y deje los borradores listos para revisión.
- Los skills ya limitan la relectura: cada uno indica exactamente qué archivos leer; ninguna sesión necesita "releer todo".

## Pendientes para implementar v1

- [ ] Decidir la entrada: (a) correo dedicado — recomendada para empezar — o (b) WhatsApp Cloud API.
- [ ] Credenciales en n8n: Anthropic API key + GitHub token con acceso de escritura SOLO a este repo.
- [ ] Crear el flujo con el prompt de arriba y probar con 2–3 chats reales.
- [ ] (Opcional) MCP Server Trigger en n8n + conector personalizado en claude.ai para disparar flujos desde Claude.
