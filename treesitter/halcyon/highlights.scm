(string) @string
(string (escape_sequence) @constant.character.escape)

(character) @string
(character (escape_sequence) @constant.character.escape)

(identifier) @local.reference

(escape_sequence) @constant.character.escape

(number) @constant.numeric

(path
  module_name: (identifier) @namespace
)

(boolean) @constant.builtin

(line_comment) @comment
(block_comment) @comment

[
  "*"
  "*."
  "/"
  "/."
  "%"
  "+"
  "+."
  "-"
  "-."
  "xor"
  "or"
  "and"
  "|>"
  "=="
  "!="
  "<="
  "<"
  ">"
  ">="
  ";"
  ">>"
  "<<"
  "->"
] @operator

[
  ":"
  "::"
  ","
  ";"
] @punctuation.delimeter

[
  "{"
  "}"
  "("
  ")"
] @punctuation.bracket

[
  "if"
  "then"
  "else"
  "with"
  "match"
] @keyword.control

[
  "module"
  "end"
  "fn"
  "let"
  "type"
  "in"
  "import"
  "do"
  "of"
  "=>"
] @keyword

(operator_function op: _ @function)

(function_application
  function: (path field: (identifier) @function)
)

(function_application
  function: (identifier) @function
)

(binary_value_op (_) "|>" (identifier) @function)
(binary_value_op (_) "|>" (path field: (identifier) @function))

(binary_value_op (identifier) @function ">>" (_))
(binary_value_op (_) @function ">>" (identifier) @function)
(binary_value_op (_) ">>" (path field: (identifier) @function))
(binary_value_op (path field: (identifier) @function) ">>" (_))

(binary_value_op (identifier) @function "<<" (_))
(binary_value_op (_) @function "<<" (identifier) @function)
(binary_value_op (_) "<<" (path field: (identifier) @function))
(binary_value_op (path field: (identifier) @function) "<<" (_))

(function_definition
  parameter: (identifier)
) @local.scope

(function_definition
  parameter: (identifier) @variable.parameter
)

;; Types
(sum_type
  constructor: (identifier) @constructor
)

(type_unit (unit "(" @type ")" @type))

(type_path
  (identifier) @type
)
(type_path
  (path field: (_) @type)
)

(type_function parameter: (identifier) @type)

(type_construct argument: (identifier) @type)
(type_construct argument: (path field: (identifier)) @type)

;; Patterns
(pattern_constructor constructor: (identifier) @constructor)
(pattern_constructor constructor: (path field: (identifier) @constructor))
(pattern (identifier) @constructor (#match? @constructor "^[A-Z]"))
