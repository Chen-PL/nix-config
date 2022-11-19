let
  setFont = font: builtins.map (className: { class = className; "font.face" = font; });
in
 setFont "Fira Code" [
    "sidebar_label"
    "sidebar_heading"
    "tab_label"
    "label_control"
    "quick_panel_label"
    "quick_panel_path_label"
  ]
