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

## El contrato protege, el material vende

Doctrina del usuario para todo material comercial: los términos que el propietario necesita para decidir se dicen claros y en positivo — retribución **15% del neto recibido, IGV incluido**, liquidación mensual dentro de 5 días hábiles, plazo de 1 año con salida con aviso de 30 días, limpieza pagada por el huésped, canales Airbnb/Booking/Vrbo/directas (fuente: `contenido/legal/contrato-modelo.md`). La letra chica defensiva (indemnidades, penalidades, límites de responsabilidad) vive en el contrato: no se exagera en presentaciones ni cartas, y se explica en simple solo cuando el prospecto pregunta o en el dossier N3.

## Estructura

```
contenido/       Fuente única de verdad sobre Hosteo: empresa, servicio (por nivel), números,
                 objeciones, copy-web.md (copy público aprobado de hosteo.pe), legal/
marca/           Sistema de diseño (colores, tipografía, voz) y activos (logo, fuentes, fotos)
plantillas/      Plantillas HTML: presentacion.html (deck 16:9) y documento.html (A4)
prospectos/      Un directorio por prospecto: perfil.md + entregables/ generados (versionados a propósito)
                 prospectos/_bandeja/ (si existe): fichas comerciales de la automatización, pendientes de revisión
scripts/         html2pdf.sh — renderiza HTML a PDF con Chromium headless
automatizacion/  Diseño del pipeline WhatsApp → ficha comercial → propuesta (v0 manual y v1 n8n)
.claude/skills/  Flujos de trabajo (ver abajo)
```

Regla de coherencia con la web: hosteo.pe define el estándar de lo público. Ningún material N1 revela más que la web — en particular, la web NO publica el % de comisión ("se define en la valorización gratuita"), así que el 15% aparece solo desde N2.

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

**Ubicación de render**: las plantillas cargan fuentes y logos con rutas relativas (`../../../marca/...`) calibradas para `prospectos/<slug>/entregables/`. Genera y renderiza los HTML siempre desde ahí (las vistas previas viven en `prospectos/_ejemplo/entregables/`); un HTML renderizado desde otra profundidad pierde las fuentes de marca.

## Marca y redacción (marca real desde Jul 2026)

La identidad completa está en `marca/sistema-diseno.md` (resumen operativo) y `marca/colors_and_type.css` (tokens de referencia). Lo innegociable al escribir cualquier material:

- **Sin emojis. Sin signos de exclamación. Nunca.** Calma sobre ingenio; la marca es editorial y premium, no una startup ruidosa.
- Tuteo peruano cálido y competente; "nosotros", nunca "el equipo". Frases cortas, declarativas, con números concretos en vez de adjetivos.
- Sentence case en títulos; MAYÚSCULAS solo en eyebrows. Serif (Cormorant) para titulares y cifras destacadas, **nunca en bold**; Inter para todo lo demás.
- Formatos: `S/ 4,280` (espacio tras S/; `US$` secundario) · `92%` sin decimales · fechas `15 Abr 2026`.
- Español de Perú: "alquiler" (no arriendo ni renta), "departamento", distritos. Cero siglas de STR sin explicar (di "tarifa promedio por noche", no "ADR").
- Tagline oficial: "Hosteo tu propiedad. Tú solo cobras."
- Adaptación comercial permitida: jerarquía persuasiva y cifras clave grandes (serif + bronce), manteniendo los innegociables.
- Archivos y directorios en kebab-case y en español.

## Privacidad

`prospectos/` contiene datos personales de clientes potenciales. Este repositorio es privado: no publiques su contenido (Artifacts, gists, servicios externos) ni copies datos de prospectos fuera del repo. Los contratos firmados reales tampoco se suben: al repo solo entran resúmenes anonimizados (como `contenido/legal/contrato-modelo.md`, sin DNI, dirección ni correo del propietario).

## Notas del entorno

- La web `hosteo.pe` NO es accesible desde este entorno remoto (la política de red del proxy la bloquea, igual que la mayoría de sitios). Para contenido de la web, pídelo al usuario. Google Fonts (`fonts.googleapis.com`/`gstatic`) sí está permitido.
- Las fuentes de marca ya están vendorizadas en `marca/activos/fuentes/`; los PDF renderizan sin red.

## Estado actual / pendientes del usuario

- [ ] **Tarifa promedio por noche por distrito/tipología** (exportable de Hostaway) — lo único que falta para proyecciones N2 completas. Ya se tiene: 85% ocupación, 4.9 en Airbnb, caso real S/ 5,300 (Jun 2026, 2 hab Miraflores).
- [ ] `contenido/empresa.md`: año de inicio, cargo público de Francesca y quién firma las cartas, testimonios autorizados.
- [ ] Confirmar estatus Superhost y el periodo del 85% de ocupación; confirmar que S/ 5,300 es pago neto al propietario.
- [ ] Detalle operativo N3 para el dossier: onboarding interno paso a paso, checklist de entrega, primeros 30 días (la versión pública de 3 pasos ya está en `contenido/copy-web.md`).
- [ ] Fotos de más unidades en `marca/activos/` (la web usa prop-miraflores.jpg, prop-san-isidro.jpg, prop-barranco.jpg, etc. — solo se entregó foto-hero.jpg) y, si existe, logo en SVG o en paleta cálida.
- [ ] Automatización WhatsApp→ficha v1: decisiones pendientes en `automatizacion/whatsapp-a-ficha.md`.

Cuando el usuario entregue algo de esto: intégralo en `contenido/` o `marca/`, borra el marcador correspondiente y actualiza esta lista.
