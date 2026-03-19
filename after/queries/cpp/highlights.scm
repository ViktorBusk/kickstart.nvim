; extends
(pure_virtual_clause) @number
(reference_declarator "&" @keyword)
(pointer_declarator "*" @keyword)
(using_declaration "using" @keyword.import)
(alias_declaration "using" @keyword.import)
(function_declarator
  declarator: (operator_name "operator" @keyword.import (#set! priority 300)))
((identifier) @type.builtin
  (#any-of? @type.builtin
    "void" "bool" "int" "float" "double" "char")
  (#set! priority 200))
"default" @keyword.conditional (#set! priority 300)
