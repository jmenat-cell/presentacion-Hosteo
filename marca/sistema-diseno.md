# Sistema de diseño de Hosteo

**Estado: PLACEHOLDER.** Esta paleta y tipografía son provisionales, elegidas para que las plantillas se vean profesionales desde el día uno. Cuando el usuario entregue la marca real (web, logo, manual de marca), reemplazar aquí los valores y actualizar el bloque `:root` de las plantillas en `plantillas/` para que coincidan.

## Colores

| Token | Valor | Uso |
|---|---|---|
| `--color-primario` | `#14343B` | Fondos de portada, títulos, footer (petróleo oscuro) |
| `--color-acento` | `#E29E4B` | Acentos, cifras destacadas, llamados a la acción (ámbar cálido) |
| `--color-fondo` | `#FAF7F2` | Fondo de páginas claras (arena) |
| `--color-texto` | `#1D2A2E` | Texto principal sobre fondo claro |
| `--color-texto-suave` | `#5A6B70` | Texto secundario, pies, letra chica |
| `--color-blanco` | `#FFFFFF` | Texto sobre fondo primario |

Regla: fondos oscuros solo con `--color-primario`; el acento nunca como fondo de bloques grandes de texto.

## Tipografía

- **Familia**: stack de sistema — `-apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif`. [POR COMPLETAR: tipografía real de marca; si es de Google Fonts, descargar el .woff2 a `marca/activos/` e incrustarla, los PDF se generan sin red]
- **Escala en el deck**: título portada ~64px, título de slide ~40px, cuerpo 20–24px, letra chica 13px.
- **Escala en documentos A4**: título 24pt, cuerpo 11pt, letra chica 8pt.

## Logo y activos

- `marca/activos/` — colocar aquí: logo (SVG o PNG fondo transparente), variante clara para fondos oscuros, fotos reales de unidades administradas (las fotos reales venden más que cualquier stock).
- Mientras no haya logo, las plantillas usan el wordmark tipográfico "hosteo" en `--color-blanco`/`--color-primario`.
- En los HTML finales, incrustar imágenes como data URI o ruta relativa local (el render de PDF no descarga recursos externos).

## Voz de la marca

- Tuteo cercano y profesional. Cálido, directo, sin jerga corporativa.
- Beneficio antes que característica: "recibes tu liquidación cada mes" antes que "software de gestión".
- Frases cortas. Números presentados con honestidad (rangos y supuestos, no promesas).
- En español de Perú: alquiler, departamento, distritos.
