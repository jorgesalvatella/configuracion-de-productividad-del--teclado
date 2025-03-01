# Configuración PRO de Productividad para Ubuntu Wayland

## ¿Qué es esto?

Este es un **script automatizado** que convierte tu Ubuntu (con GNOME y Wayland) en una estación de trabajo optimizada para productividad. Lo que hace es:

✅ Instalar herramientas clave.  
✅ Configurar atajos de teclado útiles.  
✅ Poner una fuente elegante (Avant Garde) en todo el sistema.  
✅ Aplicar tema oscuro.  
✅ Mostrar información útil cada vez que abres la terminal.  
✅ Colocar un fondo de pantalla.  

---

## Instalación (súper fácil)

Solo ejecuta este comando:

```bash
bash <(curl -s https://raw.githubusercontent.com/jorgesalvatella/configuracion-de-productividad-del--teclado/main/setup_teclado_pro_wayland_estetico.sh)
```


¿Qué herramientas instala y para qué sirven?
Herramienta	¿Para qué sirve?
wofi	Es un lanzador de aplicaciones rápido, se abre con Super + Espacio.
starship	Es un prompt bonito y útil para la terminal, muestra info clave en la línea de comandos.
neofetch	Muestra un resumen elegante de tu sistema cada vez que abres la terminal.
gnome-tweaks	Te permite ajustar cosas de GNOME fácilmente.
gnome-shell-extensions	Añade funciones extra al escritorio GNOME.

Atajos que se configuran
Atajo	Acción
Super + Espacio	Abre el lanzador de aplicaciones (wofi).
Super + ←	Mueve la ventana actual a la izquierda.
Super + →	Mueve la ventana actual a la derecha.
Super + ↑	Maximiza la ventana actual.
Super + ↓	Restaura la ventana al tamaño anterior.
Fuente y apariencia
✅ Fuente: ITC Avant Garde Gothic Std tamaño 12 (elegante, moderna y legible).
✅ Tema: Yaru oscuro (visual moderno y profesional).
✅ Fondo de pantalla: uno predefinido que puedes cambiar después.

¿Qué pasa cuando reinicias la terminal?
Cada vez que abres la terminal, verás algo como esto:

kotlin
Copiar
Editar
Usuario@Máquina ~/carpeta-actual
➜ 
Y antes de la primera línea, neofetch mostrará un resumen con:

Sistema operativo
Versión de kernel
Tiempo encendido
Resolución de pantalla
Procesador, memoria, etc.
¿Puedo personalizar después?
¡Claro! Puedes:

Cambiar la fuente (con gnome-tweaks).
Poner tu propio fondo de pantalla.
Ajustar o añadir más atajos.
Editar el script para agregar tus propias herramientas.
¿Qué requisitos tiene?
✅ Ubuntu 22.04 o superior
✅ Usar GNOME (con Wayland)
✅ Conexión a internet (para descargar lo necesario)

¿Y si quiero quitarlo después?
Todo lo que hace el script es configuración, no instala cosas raras. Puedes deshacerlo fácilmente con gnome-tweaks o simplemente restaurando la configuración de GNOME.

Conclusión
Este setup es para gente que quiere:

💻 Un entorno limpio, moderno y productivo.
⚡ Atajos que te ahorran tiempo.
✍️ Una terminal bonita y útil.
👀 Una apariencia cuidada desde el primer día.

Licencia
MIT - Úsalo, modifícalo, compártelo.

yaml
Copiar
Editar
