differences
===========

the differences between oh-my-zsh and my fork.
    .zsh/
      `- zshrc
      `- README.markdown
      `- plugins/
            `- auto-fu/
            `- apt/
            `- color_cmd/
            `- ls_colors/
            `- github/
            `- zsh-syntax-highlighting
            `- zsh-syntax-highlighting-filetypes
      `- lib/
            `- aliases.zsh
            `- functions.zsh
      `- themes/
            `- stardiviner.zsh-theme

install
=======
.zsh/
    `- custom/ls--/
        =>  sudo cpan Term::ExtendedColor
            git clone git://github.com/trapd00r/ls--.git
            cd ls--
            perl Makefile.PL
            make && su -c 'make install'
            cp ls++.conf $HOME/.ls++.conf
