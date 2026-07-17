# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

El resto del archivo está en español: todo el contenido del repositorio, su usuario y sus destinatarios trabajan en español (Perú).

## Qué es este repositorio

Hosteo es una empresa peruana que administra departamentos en alquiler de corta estadía (STR, tipo Airbnb) por cuenta de sus propietarios, cobrando una comisión porcentual de los ingresos. Este repositorio produce el material comercial de Hosteo — presentaciones, cartas, dossiers en PDF — dirigido a propietarios de departamentos que evalúan entregar su unidad en administración.

No es una aplicación: no hay build, tests ni dependencias. El "producto" son documentos HTML→PDF generados con los skills de `.claude/skills/`.

## Regla de oro: revelación progresiva

El problema comercial que resuelve este repo: muchos propietarios que piden información solo están "pescando" (para hacerlo por su cuenta o comparar), pero los verdaderos interesados necesitan un empujón extra para decidirse. Por eso todo material se genera en uno de tres niveles y nunca revela más de lo que su nivel permite:

- **Nivel 1 — Teaser**: primer contacto y curiosos. Vende el beneficio y la confianza usando solo información de carácter público. Objetivo: conseguir la reunión.
- **Nivel 2 — Propuesta**: interesados calificados (ya hubo conversación o reunión). Incluye comisión, servicio detallado y proyección personalizada de su unidad. Objetivo: la decisión.
- **Nivel 3 — Cierre**: decididos que necesitan el empujón final. Agrega procesos operativos, contrato modelo y checklist de entrega. Objetivo: la firma y la entrega de la unidad.

| Contenido | N1 Teaser | N2 Propuesta | N3 Cierre |
|---|---|---|---|
| Propuesta de valor, beneficios, prueba social pública | ✅ | ✅ | ✅ |
| Lista de servicios incluidos | Resumen | ✅ Detallada | ✅ Detallada |
| % de comisión y condiciones comerciales | ❌ | ✅ | ✅ |
| Proyección de ingresos personalizada de su unidad | ❌ | ✅ | ✅ |
| Testimonios con nombre y edificio | ❌ | ✅ | ✅ |
| Procesos operativos (pricing, limpieza, huéspedes, mantenimiento) | ❌ | Resumen | ✅ Detallados |
| Contrato modelo y términos legales | ❌ | ❌ | ✅ |
| Checklist de entrega de la unidad y onboarding | ❌ | ❌ | ✅ |

Reglas duras:

1. Nunca generes material de un nivel superior al autorizado en el `perfil.md` del prospecto sin confirmación explícita del usuario.
2. Lo marcado `CONFIDENCIAL (N3)` en `contenido/` jamás aparece en materiales N1/N2. El detalle operativo es el "manual" que un pescador de información querría llevarse gratis.
3. Todo entregable queda guardado y registrado en el perfil del prospecto: trazabilidad de qué sabe cada quién.

## Regla de contenido: nada inventado

Material comercial con datos falsos destruye la venta y la reputación de Hosteo:

- Cifras, métricas, testimonios, nombres de clientes y afirmaciones verificables salen **exclusivamente** de `contenido/`.
- Si el dato necesario está `[POR COMPLETAR]`, pídeselo al usuario o deja el marcador visible en el borrador — nunca lo rellenes con algo plausible.
- El copy de venta (títulos, transiciones, llamados a la acción) sí puedes redactarlo y mejorarlo libremente; los hechos no.

## Estructura

```
contenido/       Fuente única de verdad sobre Hosteo: empresa, servicio (por nivel), números, objeciones, legal/
marca/           Sistema de diseño (colores, tipografía, voz) y activos (logo, fotos)
plantillas/      Plantillas HTML: presentacion.html (deck 16:9) y documento.html (A4)
prospectos/      Un directorio por prospecto: perfil.md + entregables/ generados (versionados a propósito)
scripts/         html2pdf.sh — renderiza HTML a PDF con Chromium headless
.claude/skills/  Flujos de trabajo (ver abajo)
```

## Flujo de trabajo y skills

Ciclo comercial: registrar prospecto → calificar nivel → generar material → registrar entrega → subir de nivel → cerrar.

- `/prospecto <nombre>` — registra o actualiza un prospecto en `prospectos/<slug>/perfil.md` y recomienda su nivel.
- `/presentacion <prospecto> [nivel]` — genera la presentación (deck PDF) del nivel que corresponda.
- `/carta <prospecto>` — carta / one-pager A4 personalizado.
- `/dossier <prospecto>` — paquete de cierre Nivel 3 completo.

Convenciones de los entregables:

- Ruta: `prospectos/<slug>/entregables/AAAA-MM-DD-<tipo>-n<nivel>.pdf`, con su `.html` fuente al lado.
- Tras generar: registra el entregable en la tabla del `perfil.md`, actualiza el historial y muestra el PDF al usuario.
- Los entregables se versionan en git a propósito: son el registro de qué se le entregó a quién y cuándo.

## Generar PDFs

```bash
scripts/html2pdf.sh entrada.html salida.pdf
```

Usa Chromium headless (en este entorno remoto: `/opt/pw-browsers/chromium`; respeta la variable `CHROMIUM_BIN`). Las plantillas controlan el tamaño de página con `@page` (deck: 1280×720 px; documento: A4). No hay dependencias de npm. Verifica el PDF generado leyéndolo (la herramienta Read renderiza PDFs) antes de darlo por bueno.

## Convenciones de redacción

- Español de Perú: "alquiler" (no arriendo ni renta), "departamento", distritos (Miraflores, Barranco, San Isidro…). Moneda: soles `S/`; USD solo si `contenido/` lo indica para ese dato.
- Tono: cercano y profesional — tuteo ("tú"), cálido, directo, sin jerga corporativa vacía. Frases cortas. Beneficio antes que característica.
- El destinatario es un propietario, no un técnico: cero siglas de STR sin explicar (di "tarifa promedio por noche", no "ADR", o explícalo la primera vez).
- Archivos y directorios en kebab-case y en español.

## Privacidad

`prospectos/` contiene datos personales de clientes potenciales. Este repositorio es privado: no publiques su contenido (Artifacts, gists, servicios externos) ni copies datos de prospectos fuera del repo.

## Estado actual / pendientes del usuario

- [ ] `contenido/`: completar todos los `[POR COMPLETAR]` (% de comisión, métricas reales, testimonios, datos de la empresa).
- [ ] `marca/sistema-diseno.md`: reemplazar la paleta placeholder por la marca real de Hosteo (logo, colores, tipografías, fotos en `marca/activos/`).
- [ ] `contenido/legal/contrato-modelo.md`: agregar el contrato real (requisito de `/dossier`).

Cuando el usuario entregue su web, contrato o sistema de diseño: intégralos en estos archivos, actualiza las plantillas y elimina de esta sección lo que ya no falte.
