local concat = table.concat

local _M = {}

local main = [[
* { margin: 0; padding: 0; }

body {
  background-color: hsl(0, 0%, 10%);
  color: white;
  font-family: -apple-system, sans-serif;
}

.disabled { color: hsl(0, 0%, 50%); }

body { font-size: 0.83em; }

body {
  margin: 2em;
  column-gap: 2em;
}

@media only screen and (min-width: 600px) {
  body { column-count: 2; }
}

@media only screen and (min-width: 900px) {
  body { column-count: 3; }
}

@media only screen and (min-width: 1200px) {
  body { column-count: 4; }
}

.block {
  page-break-inside: avoid;
  padding-bottom: 2em;
}

h1 { font-size: 1.2em; }
th { font-size: 0.5em; }

h1 {
  font-style: normal;
  font-weight: normal;
  text-align: center;
}

.block:first-of-type h1 { font-weight: bold; }

th {
  font-style: normal;
  font-weight: normal;
  text-align: center;
}

table {
  border-collapse: collapse;
  margin: 1em auto 0 auto;
}

td { padding-bottom: 0.25em; }
th {
  padding-top: 0.25em;
  padding-bottom: 0.5em;
}

.mods, .key { width: -webkit-max-content; }

.mods, .key { font-weight: bold; }
.mods { text-align: right; }
.title { padding-left: 1em; }
]]

_M.config = {
    [0] = main,
}

local style

function _M.init(config)
    style = concat(config, '', 0)
end

function _M.css()
    return style
end

return _M
