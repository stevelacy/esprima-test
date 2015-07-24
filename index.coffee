es = require 'esprima'

parsed =
  ast: es.parse code
  functions: {}
  variables: {}
  calls: {}


parsed.ast.body.forEach (v, k) ->

  if v.type is 'VariableDeclaration'
    return unless v.declarations[0]?.id?.name?
    parsed.variables[v.declarations[0].id.name] = v

  if v.type is 'FunctionDeclaration'
    return unless v.id?.name?
    parsed.functions[v.id.name] = v

  if v.type is 'ExpressionStatement'
    return unless v.expression?.callee?.name?
    parsed.calls[v.expression.callee.name] = v.expression

console.log JSON.stringify parsed.ast, 0, 2
