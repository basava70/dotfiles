;; extends
;; Match special comments like //[TODO] or // [FIXME]
((comment) @comment.tagged
  (#lua-match? @comment.tagged "^// ?%[[^%]]+%]"))

;; Match all other // comments, but exclude tagged ones
((comment) @comment.twoline
  (#lua-match? @comment.twoline "^//")
  (#not-lua-match? @comment.twoline "^// ?%[[^%]]+%]"))

