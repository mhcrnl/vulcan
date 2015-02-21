#!/usr/bin/sh

NAME=journal

valac -o $NAME -X -lm \
--pkg gtk+-3.0 \
--pkg gtksourceview-3.0 \
--pkg pango \
--pkg vte-2.90 \
-X -fsanitize=address \
src/main.vala \
src/window.vala \
src/headerbar.vala \
src/consts.vala \
src/sourcestack.vala \
src/tabbox.vala \
src/dynamiclist.vala \
src/sidebar.vala \
src/filebar.vala \
src/settingsbar.vala \
src/terminal.vala \
src/sidebarlist.vala \
src/config.vala \