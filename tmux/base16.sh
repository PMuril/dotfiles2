# Base16 Styling Guidelines:

base00=default   # - Default
base01='#151515' # - Lighter Background (Used for status bars)
base02='#202020' # - Selection Background
base03='#909090' # - Comments, Invisibles, Line Highlighting
base04='#505050' # - Dark Foreground (Used for status bars)
base05='#D0D0D0' # - Default Foreground, Caret, Delimiters, Operators
base06='#E0E0E0' # - Light Foreground (Not often used)
base07='#F5F5F5' # - Light Background (Not often used)
base08='#AC4142' # - Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
base09='#D28445' # - Integers, Boolean, Constants, XML Attributes, Markup Link Url
base0A='#F4BF75' # - Classes, Markup Bold, Search Text Background
base0B='#90A959' # - Strings, Inherited Class, Markup Code, Diff Inserted
base0C='#75B5AA' # - Support, Regular Expressions, Escape Characters, Markup Quotes
base0D='#6A9FB5' # - Functions, Methods, Attribute IDs, Headings
base0E='#AA759F' # - Keywords, Storage, Selector, Markup Italic, Diff Changed
base0F='#8F5536' # - Deprecated, Opening/Closing Embedded Language Tags, e.g. <? php ?>

set -g status-left-length 32
set -g status-right-length 150
set -g status-interval 5

# default statusbar colors
set-option -g status-style fg=$base02,bg=$base00,default

set-window-option -g window-status-style fg=$base03,bg=$base00
set-window-option -g window-status-format " #I #W"

# active window title colors
set-window-option -g window-status-current-style fg=$base0C,bg=$base00
set-window-option -g window-status-current-format " #I #[bold]#W"

# Pane colors
set-window-option -g window-style bg=black 
set-window-option -g window-active-style bg=terminal

# pane borders
set-window-option -g pane-active-border-style 'bg=colour236,fg=colour51'
set-window-option -g pane-border-style 'bg=colour235,fg=colour238'

tm_session_name="#[default,bg=$base00,fg=$base0E] #S "
set -g status-left "$tm_session_name"
