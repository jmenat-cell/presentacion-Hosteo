---
name: carta
description: Genera una carta o one-pager A4 en PDF, personalizado para un prospecto de Hosteo (propietario de departamento), en su nivel de revelación. Usar cuando el usuario pida una carta, propuesta breve, one-pager o "algo corto para enviar por WhatsApp o correo".
---

# Generar una carta / one-pager para un prospecto

Argumentos: nombre o slug del prospecto y, opcionalmente, el motivo ("post reunión", "seguimiento", "primera respuesta a su consulta"). Lee primero `CLAUDE.md`.

La carta es el formato ligero: **una sola página A4**, pensada para el cuerpo de un correo o un PDF por WhatsApp. Para material extenso usa `/presentacion` o `/dossier`.

## Pasos

1. **Prospecto y nivel**: igual que en `/presentacion` (perfil obligatorio salvo confirmación explícita; nivel del perfil; detenerse si se pide un nivel mayor al autorizado).
2. **Motivo**: la carta responde a un momento concreto de la relación. Si el argumento no lo dice, dedúcelo del historial del perfil o pregunta. El motivo define el ángulo:
   - Primera respuesta a "mándame información" → N1: despertar interés + invitar a conversar, sin regalar detalle.
   - Post reunión → N2: resumen de lo conversado + propuesta concreta de SU unidad.
   - Empujón de cierre → N3: condiciones acordadas + pasos para firmar y entregar la unidad.
3. **Insumos**: perfil, `contenido/` y `marca/sistema-diseno.md`. Si un dato esencial está `[POR COMPLETAR]`, pídelo antes de escribir. Revisa `contenido/objeciones.md`: si el prospecto planteó una objeción (según historial), la carta debe responderla con su ángulo.
4. **Genera**: copia `plantillas/documento.html` a `prospectos/<slug>/entregables/AAAA-MM-DD-carta-n<N>.html` y redacta: saludo personal, apertura que referencia el contacto previo, mensaje central en el destacado, 3 beneficios máximo, cierre con UN llamado a la acción fácil. Máximo ~300 palabras; una carta que no se lee no vende. Voz de marca: sin signos de exclamación ni emojis. Sin `⟦corchetes⟧` remanentes. Debe caber en una página (verifícalo en el PDF).
5. **Renderiza, verifica, registra y entrega**: igual que `/presentacion` (html2pdf.sh → leer el PDF → fila en entregables + historial → SendUserFile con resumen). Ofrece además la versión texto plano de la carta por si el usuario prefiere pegarla directo en el correo o WhatsApp.
