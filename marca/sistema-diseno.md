# Sistema de diseño de Hosteo (marca real)

Fuente: el Hosteo Design System entregado por el usuario (16 Jul 2026). La referencia técnica completa de tokens está en `marca/colors_and_type.css` (copiada verbatim del sistema). Este archivo es el resumen operativo para generar material comercial.

**Posicionamiento**: Hosteo es una marca premium de administración de alquiler de corta estadía en Lima — hospitalidad + estrategia de ingresos + operación impecable + tecnología invisible. Dirigida a propietarios de departamentos de valor que buscan un socio profesional y confiable, no una "startup". El look es **editorial, arquitectónico y calmado** (revista de interiores boutique, no dashboard SaaS).

## Colores (usar estos tokens, nunca hex sueltos)

| Token | Valor | Uso |
|---|---|---|
| `--bone` | `#F6F2EC` | Fondo de página/slide claro |
| `--paper` | `#FBF8F3` | Tarjetas, texto sobre oscuro |
| `--linen` | `#EFE8DC` | Bandas/bloques sutiles |
| `--sand` | `#E4DACB` | Chips, superficies elevadas |
| `--taupe` | `#8A8170` | Texto secundario, eyebrows |
| `--clay` | `#6B6355` | Texto de cuerpo |
| `--charcoal` | `#3A342B` | Titulares, texto principal |
| `--espresso` | `#221E18` | Superficies oscuras (portadas) — nunca negro puro |
| `--bronze` | `#8A6A3B` | Único acento: cifras clave, énfasis, CTA |
| hairlines | `rgba(58,52,43,.08 / .14)` | Toda separación; sin bordes gruesos |

Prohibido: gradientes, azul-morado SaaS, neón, neumorfismo. El navy `#0E2B6C` y teal `#3CA99A` son **solo del logo actual** (no usarlos en superficies).

## Tipografía (local, en `marca/activos/fuentes/` — los PDF renderizan sin red)

- **Display serif**: Cormorant Garamond (`CormorantGaramond-{400,500,600}.woff2`) para titulares y cifras destacadas. Pesos 400–600, **nunca bold**, tracking levemente negativo.
- **Sans**: Inter variable (`Inter-VariableFont_opsz_wght.ttf`, la fuente de marca del cliente) para cuerpo, etiquetas, tablas. Pesos 400/500/600; 700 solo énfasis puntual.
- **Eyebrow** (dispositivo firma de la marca): 11–14px, MAYÚSCULAS, tracking `0.18em`, color taupe (bronce en oscuro).
- Cuerpo con line-height 1.55–1.7, bloques de texto ≤ 62ch. Radios pequeños (4–10px).

## Voz (aplicar en TODO el copy)

- **Tuteo peruano cálido y competente**. "Nosotros" (nunca "el equipo"). Calma sobre ingenio.
- **Sin emojis. Sin signos de exclamación. Nunca.**
- Frases cortas, declarativas, con sustantivos y números concretos: "Tarifa promedio: S/ 412 por noche" le gana a "ingresos increíbles". (La cifra del ejemplo es ilustrativa del estilo, no un dato real.)
- Sentence case en títulos y botones. MAYÚSCULAS solo en eyebrows. La tecnología es invisible: se habla de resultados (ocupación, ingreso, tranquilidad), no de software.
- Formatos: moneda `S/ 4,280` (con espacio; `US$` secundario) · porcentajes `92%` sin decimales · fechas `15 Abr 2026`.
- Tagline oficial: **"Hosteo tu propiedad. Tú solo cobras."**
- Flechas tipográficas `→` permitidas al final de links/CTA; iconos solo Lucide (trazo 1.5px) y nunca decorativos.

## Logos (`marca/activos/`)

- `logo-horizontal.png` — lockup horizontal navy+teal, fondo transparente. Para cabeceras sobre fondos claros.
- `logo-mark-charcoal.png` — la casita-flecha en charcoal, transparente. Dispositivo de marca sobre claros.
- Sobre espresso (portadas): usar wordmark tipográfico "Hosteo" en paper (el logo navy no contrasta). Pendiente del usuario: logo en paleta cálida o SVG original.

## Adaptación comercial (autorizada por el usuario)

Estos materiales venden; el sistema se respeta pero con jerarquía persuasiva:

- Las cifras que cierran (ingreso neto, 15%, ocupación) pueden ir grandes, en serif y bronce.
- La letra chica se mantiene mínima y honesta (los términos duros viven en el contrato, ver CLAUDE.md).
- Lo NO negociable ni en versión comercial: emojis, signos de exclamación, gradientes, serif en bold, promesas infladas.
