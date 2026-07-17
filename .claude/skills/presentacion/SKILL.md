---
name: presentacion
description: Genera la presentación comercial de Hosteo (deck PDF 16:9) para un prospecto, en su nivel de revelación (1 teaser, 2 propuesta, 3 cierre). Usar cuando el usuario pida una presentación, deck, PPT o "material para enviarle" a un propietario o prospecto.
---

# Generar la presentación para un prospecto

Argumentos: nombre o slug del prospecto y, opcionalmente, un nivel explícito (1, 2 o 3). Lee primero `CLAUDE.md` (tabla de revelación y regla de "nada inventado").

## Pasos

1. **Prospecto**: ubica `prospectos/<slug>/perfil.md`. Si no existe, ofrece registrarlo primero con el flujo de `/prospecto` (lo correcto casi siempre) o, si el usuario prefiere algo genérico sin personalizar, confírmalo explícitamente antes de seguir.
2. **Nivel**: usa el nivel pedido en el argumento; si no hay, el del perfil; si tampoco, pregunta. **Si el nivel pedido supera el autorizado en el perfil, detente y pide confirmación al usuario** (regla dura). Si la confirma, actualiza el nivel en el perfil.
3. **Insumos**: lee `contenido/empresa.md`, `contenido/servicio.md`, `contenido/numeros.md`, `marca/sistema-diseno.md` y el perfil. Antes de escribir nada, verifica que los datos que ese nivel necesita NO estén `[POR COMPLETAR]`:
   - N1: propuesta de valor, resumen del servicio, prueba social, contacto.
   - N2: además comisión %, condiciones y la proyección de SU unidad — la tarifa por noche estimada la da el usuario (la valoriza por dirección, características y fotos; ver `contenido/numeros.md`). Si no la tienes, pídesela antes de generar.
   - Si falta algo esencial, lista lo que falta y pídeselo al usuario. No inventes ni un número.
4. **Genera el HTML**: copia `plantillas/presentacion.html` a `prospectos/<slug>/entregables/AAAA-MM-DD-presentacion-n<N>.html` y edítalo:
   - Elimina por completo las `<section class="slide">` con `data-nivel` mayor que el nivel del material.
   - Reemplaza todos los `⟦corchetes⟧` con datos reales del perfil y de `contenido/`; personaliza portada y CTA con el nombre del prospecto y su unidad. No debe quedar ningún `⟦` en el archivo final.
   - Redacta el copy con la voz de `marca/sistema-diseno.md`: tuteo cercano, frases cortas, beneficio antes que característica, español de Perú. Sin signos de exclamación ni emojis; cifras `S/ 4,280`; serif nunca en bold.
   - En N2, arma la proyección siguiendo el método de `contenido/numeros.md` (rango + supuestos al pie).
5. **Renderiza y verifica**: `scripts/html2pdf.sh <ruta>.html <ruta>.pdf`. Lee el PDF generado (Read renderiza PDFs) y revisa: sin `⟦corchetes⟧`, sin texto cortado ni slides desbordadas, sin contenido de nivel superior filtrado.
6. **Registra**: agrega la fila en "Entregables enviados" del perfil (fecha, tipo, nivel, archivo) y una línea al historial. Actualiza el estado si corresponde (ej. → "propuesta enviada").
7. **Entrega**: envía el PDF al usuario (SendUserFile) con un resumen de 2–3 líneas: qué contiene, qué NO revela (para que sepa qué puede decir si le preguntan), y el siguiente paso comercial sugerido.

## Reglas

- La tabla de revelación de `CLAUDE.md` manda: en N1 jamás comisión, proyecciones ni procesos; el detalle operativo solo en N3.
- Cifras, testimonios y afirmaciones verificables salen solo de `contenido/`.
- El `.html` fuente queda junto al `.pdf` para poder iterar sin regenerar desde cero.
