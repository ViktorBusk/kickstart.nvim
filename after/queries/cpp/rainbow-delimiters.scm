; extends
(preproc_defined
  "(" @delimiter
  ")" @delimiter) @container
(preproc_function_def
  parameters: (preproc_params
    "(" @delimiter
    ")" @delimiter)) @container
(abstract_parenthesized_declarator
  "(" @delimiter
  ")" @delimiter) @container
(abstract_function_declarator
  parameters: (parameter_list
    "(" @delimiter
    ")" @delimiter)) @container
