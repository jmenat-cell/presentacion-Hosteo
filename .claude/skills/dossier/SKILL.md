---
name: dossier
description: Genera el dossier de cierre Nivel 3 de Hosteo (PDF A4 multipágina) para un prospecto decidido - servicio completo, procesos operativos, proyección, contrato modelo y checklist de entrega de la unidad. Usar cuando el usuario quiera cerrar, mande "el paquete final", el contrato o el material de firma.
---

# Generar el dossier de cierre (Nivel 3)

Argumento: nombre o slug del prospecto. Lee primero `CLAUDE.md`. Este es el material de máxima revelación: existe para darle al propietario decidido la seguridad final de que entregar su unidad a Hosteo es un proceso serio y sin sorpresas.

## Pasos

1. **Prospecto**: perfil obligatorio (sin excepción: un dossier siempre es para alguien concreto). Si el nivel autorizado del perfil es menor que 3, **detente y confirma con el usuario** que este prospecto amerita nivel 3; si confirma, actualiza el perfil.
2. **Verifica los insumos N3** antes de empezar:
   - `contenido/servicio.md` — sección "CONFIDENCIAL (N3)" completa (procesos, onboarding, checklist de entrega, primeros 30 días).
   - `contenido/legal/contrato-modelo.md` — **requisito**: si no existe, avisa al usuario; solo con su aprobación explícita genera el dossier sin sección de contrato.
   - `contenido/numeros.md` — datos para la proyección de su unidad.
   - Lo que esté `[POR COMPLETAR]` y sea necesario: lístalo y pídelo. Nada inventado.
3. **Estructura** sobre `plantillas/documento.html` (una `<section class="pagina">` por página), guardado en `prospectos/<slug>/entregables/AAAA-MM-DD-dossier-n3.html`:
   1. Carátula: preparado para ⟦nombre⟧ y su unidad, fecha, "Confidencial".
   2. La propuesta en una página (resumen ejecutivo: qué hará Hosteo, comisión, proyección en rango).
   3. El servicio completo y cómo operamos (detalle N2 + procesos N3 de `servicio.md`).
   4. Tu proyección (método de `numeros.md`: rango, supuestos visibles).
   5. El contrato: términos clave en lenguaje simple (plazo, comisión, responsabilidades, salida) + referencia al contrato modelo anexo.
   6. Entrega de tu unidad: checklist concreto y qué pasa en los primeros 30 días.
   7. Cierre: pasos para firmar, contacto.
4. **Tono**: incluso en el material más denso, la voz de `marca/sistema-diseno.md`: claro, cercano, sin letra chica tramposa. Los términos legales explicados en simple, sin reemplazar al contrato real.
5. **Renderiza, verifica, registra y entrega**: `scripts/html2pdf.sh` → leer el PDF completo (páginas legibles, sin desbordes, sin `⟦corchetes⟧`) → registrar en perfil (entregables + historial, estado → "negociación" o el que corresponda) → SendUserFile con resumen: qué contiene y qué falta para la firma.

## Regla especial

El dossier concentra la información confidencial de Hosteo. Antes de entregarlo, recuérdale al usuario en una línea que este PDF es solo para prospectos a punto de firmar — si se filtra, es el manual de operación completo.
