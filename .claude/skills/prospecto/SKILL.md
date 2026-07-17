---
name: prospecto
description: Registra o actualiza un prospecto (propietario interesado en entregar su departamento a Hosteo) en prospectos/<slug>/perfil.md y recomienda su nivel de revelación. Usar cuando el usuario mencione un nuevo interesado, propietario, lead o prospecto, o quiera actualizar el estado de uno existente.
---

# Registrar o actualizar un prospecto

El argumento es el nombre del prospecto (y opcionalmente datos sueltos: distrito, tipología, origen). Lee primero las reglas de `CLAUDE.md` (revelación progresiva).

## Pasos

1. **Busca si ya existe**: revisa `prospectos/` por slug o nombre parecido. Si existe, este flujo es una actualización: aplica los datos nuevos al `perfil.md`, agrega una línea al historial con la fecha de hoy y termina informando el estado y nivel actual.
2. **Si es nuevo**, crea `prospectos/<slug>/perfil.md` copiando la estructura exacta de `prospectos/_ejemplo/perfil.md`. El slug es kebab-case: `nombre-apellido` (o `nombre-distrito` si no hay apellido).
3. **Completa con lo que sepas** de la conversación y pregunta al usuario solo lo que falte y sea útil ahora (no interrogues; 3–5 datos):
   - Contacto (WhatsApp/correo) y **origen** (referido, web, Instagram, vecino de edificio administrado…)
   - Su unidad: edificio/dirección, distrito, tipología, m², ¿amoblado?
   - Contexto: ¿qué pidió exactamente? ¿ya conversaron? ¿qué tan en serio lo percibe el usuario?
4. **Recomienda el nivel de revelación** y regístralo en el perfil:
   - **Nivel 1** si es primer contacto, pidió "información" genérica, o hay señales de pesca (mucho interés en el "cómo" operativo, poca disposición a reunirse, es del rubro).
   - **Nivel 2** si ya hubo conversación real sobre SU unidad y muestra intención (pregunta por números, condiciones, plazos).
   - **Nivel 3** si ya decidió o está a un empujón de decidir (negocia condiciones, pregunta cómo empezar, pidió el contrato).
   Explica brevemente al usuario por qué recomiendas ese nivel; él tiene la última palabra.
5. **Cierra** proponiendo el siguiente paso natural: generar el material del nivel (`/presentacion`, `/carta` o `/dossier`).

## Modo conversación de WhatsApp

Si el usuario pega o sube una conversación de WhatsApp con el prospecto (texto o export .txt), antes de crear el perfil produce la **ficha comercial** y muéstrasela para validar:

1. Extrae SOLO lo que la conversación evidencia (nada inferido como si fuera dato): nombre y contacto; unidad (edificio, distrito, tipología, m², amoblado); origen del contacto; qué pidió exactamente y con qué urgencia; objeciones o dudas que planteó (mapear contra `contenido/objeciones.md`); señales de pesca (interés en el "cómo" operativo, evasivas a reunirse, es del rubro) vs. interés real (pregunta números, condiciones, plazos, disponibilidad); nivel recomendado con justificación de una línea; siguiente paso comercial sugerido.
2. Presenta la ficha en un bloque claro. El usuario corrige o aprueba.
3. Con la aprobación: crea/actualiza el perfil (pasos de arriba), registra en el historial "ficha generada desde conversación de WhatsApp del ⟦fecha⟧" y sugiere el material del nivel.
4. Privacidad: no copies la conversación completa al repo — al perfil van los datos de la ficha y un resumen de 2–3 líneas. El formato de ficha está en `automatizacion/whatsapp-a-ficha.md`.

## Reglas

- El nivel registrado en el perfil es el tope para todo material posterior (regla dura de `CLAUDE.md`).
- Nunca borres historial ni entregables registrados; el perfil es el registro de la relación.
- Datos personales de prospectos no salen del repositorio.
