if (expand("%") != "") && !&diff && (v:progname !~ "vimdiff")
    normal \ec
endif
