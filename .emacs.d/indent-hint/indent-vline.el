(defun indent-vline ()
  (interactive)
  (funcall
   (lambda (x z)
     (font-lock-add-keywords
      nil `((,x
             (0 (if (save-excursion
                      (skip-chars-backward " ")
                      (bolp))
                    (let* ((p2 (point)) (p1 (1- p2)))
                      (if (overlays-at p1)
                          nil ;; (move-overlay (car (overlays-at p1)) p1 p2)
                        (overlay-put
                         (make-overlay p1 p2) 'face ',z))
                      nil)))))))
   "   \\( \\)"  '(:background "gray30")))
(length (overlay-lists))
(overlay-end (car o))
(overlay-put (make-overlay 1128 1132) 'face '(:background "gray30"))
(move-overlay (car (overlays-at 1128)) 1128 1240)

(defun indent-vline ()
  (interactive)
  (funcall
   (lambda (x y z)
     (font-lock-add-keywords
      nil `((,x
             (0 (if (save-excursion
                      (skip-chars-backward " ")
                      (bolp))
                    (progn
                      (compose-region (match-beginning 1) (match-end 1)
                                      ,(decode-char 'ucs y)
                                      'decompose-region)
                      ',z)))))))
   "   \\( \\)" #X007C '((t (:foreground "gray30")))))

(setq dot-vline-xpm
      (funcall
       (lambda (width height color)
         (let* ((w width)
                (h height)
                (s1 (concat "\"" (make-string w (string-to-char " ")) "\""))
                (s2 (concat "\"" (make-string (1- w) (string-to-char " ")) ".\""))
                (sa (concat s1 ",\n" s2 ",\n")))
           (eval `(concat "/* XPM */
static char * dot_vline_xpm[] = {
\"" (number-to-string w) " " (number-to-string h) " 2 1\",
\"  c None\",
\". c " color "\",\n"
,@(mapcar (lambda(x) sa)
          (make-list (1- (/ h 2)) 0))
s1 ",\n" s2 "};"
))))
       9 22 "#4D4D4D"))

(defun draw-indent-vline ()
  (interactive)
  (save-excursion
    (beginning-of-line)
    (let* ((i (current-indentation))
           (l (save-excursion
                (count-lines (point)
                             (forward-list)))))
      (while (> l 0)
        (let* ((p1 (progn (move-to-column i)(point)))
               (p2 (1+ p1)))
          (if (eq (get-byte p1) 32)
              (set-text-properties
               p1 p2
               `(display (image
                          :type xpm
                          :data ,dot-vline-xpm
                          :pointer text
                          :ascent center
                          :mask (heuristic t))
                         rear-nonsticky (display)
                         fontified t)))
          nil)
        (forward-line)
        (setq l (1- l))))))

(defun indent-vline-x ()
  (interactive)
  (funcall
   (lambda (x)
     (font-lock-add-keywords
      nil `((,x
             (0 (if (save-excursion
                      (skip-chars-backward " ")
                      (bolp))
                    (let* ((p2 (point))
                           (p1 (1- p2)))
                      (if (get-text-property p1 'display)
                          nil ;; (remove-text-properties p1 p2 '(display))
                        (set-text-properties
                         p1 p2
                         `(display (image
                                    :type xpm
                                    :data ,dot-vline-xpm
                                    :pointer text
                                    :ascent center
                                    :mask (heuristic t))
                                   rear-nonsticky (display)
                                   fontified t))
                        nil))))))))
   "   \\( \\)")
  (defadvice delete-char (after indent-vline activate compile)
    (save-excursion
      (let* ((p (point))
             (q (skip-chars-forward " "))
             (x (progn (skip-chars-backward " ")(bolp))))
        (if x
            (remove-text-properties p (+ p q) '(display)))))))

(make-local-variable 'indent-column-list)
(defvar indent-column-list '(0))
(defun indent-vline-s ()
  (interactive)
  (funcall
   (lambda (x)
     (font-lock-add-keywords
      nil `((,x
             (0 (if (> (current-indentation) 0)
                    (let* ((p1 (point))
                           (p2 (1+ p1))
                           (i (current-indentation))
                           (c (current-column)))
                      (while (> (car indent-column-list) i)
                        (setq indent-column-list (cdr indent-column-list)))
                      (add-to-list 'indent-column-list i)
                      (if (and (eq (get-byte p1) 32)
                               (memq c indent-column-list))
                          (set-text-properties
                           p1 p2
                           `(display (image
                                      :type xpm
                                      :data ,dot-vline-xpm
                                      :pointer text
                                      :ascent center
                                      :mask (heuristic t))
                                     rear-nonsticky (display)
                                     fontified t))
                        nil))))))))
   " ")

  (defadvice delete-char (after indent-vline activate compile)
    (save-excursion
      (let* ((p (point))
             (q (skip-chars-forward " "))
             (x (progn (skip-chars-backward " ")(bolp))))
        (if x
            (remove-text-properties p (+ p q) '(display)))))))

(defun indent-vline-lisp ()
  (interactive)
  (funcall
   (lambda (x)
     (font-lock-add-keywords
      nil `((,x
             (0 (draw-indent-vline))))))
   ;; "\\( \\)")
   "^[ \t]*[(,`]")
  (defadvice delete-char (after indent-vline activate compile)
    (save-excursion
      (let* ((p (point))
             (q (skip-chars-forward " "))
             (x (progn (skip-chars-backward " ")(bolp))))
        (if x
            (remove-text-properties p (+ p q) '(display)))))))


