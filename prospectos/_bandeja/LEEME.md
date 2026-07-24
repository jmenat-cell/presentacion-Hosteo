# prospectos/_bandeja/

Fichas comerciales generadas por la automatización n8n (chat de WhatsApp → ficha), pendientes de revisión de Javier.

- Formato de archivo: `AAAA-MM-DD-<slug>.md`, título `# Ficha — <Nombre> (SIN REVISAR)`.
- **Nada se genera desde una ficha sin revisar.** Javier la aprueba (editándola, quitando el "(SIN REVISAR)" del título, o diciéndolo en sesión).
- Procesamiento: en una sesión de Claude Code, decir "procesa la bandeja" — el skill `/prospecto` convierte las fichas aprobadas en perfiles oficiales y elimina el archivo de la bandeja (el contenido ya vive en el perfil).
- Privacidad: contienen datos personales; mismas reglas que `prospectos/` (repo privado, no publicar).
