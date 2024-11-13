conky.config = {
use_xft = true,
font = 'DejaVu Sans Mono:size=12',
own_window = true,
own_window_class = 'Conky',
own_window_type = 'normal',
own_window_transparent = false,
own_window_argb_visual = true,
own_window_argb_value = 150,
own_window_hints = 'sticky,undecorated,below,skip_taskbar',
update_interval = 60.0,
alignment = 'bottom_right',
gap_x = 10,
gap_y = 10,
};

conky.text = [[
Date: ${time %A, %d %B %Y}
Machine: ${nodename}
Utilisateur: ${exec whoami}

IP ethernet : ${addr enp1s0}
IP wifi : ${addr wlp2s0}
]];
