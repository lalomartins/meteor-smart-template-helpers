# Smart Template Helpers

A system of template helpers that:

- Can be accessed from JS code (e.g. to get an user's display name)
- Converts Sparebars.kw into named positional arguments

To add a helper, use `TemplateHelpers.add(name, function)`.

To use it from JS, `TemplateHelpers.h.myHelper(...)`

Includes:

- debug: drop to the debugger, if one is open.

- makeRows(list, columns): given an array or cursor, return an array of objects
  `{index: i, total: t, columns: c}`, where index is zero-based, total is the
  number of objects returned, and c is the same type as the `list` argument
  (array or cursor), but of length no greater than `columns`.

And if you have momentjs installed (from moment:moment):

- displayDateFull: format according to `TemplateHelpers.h.displayDateFull._format`,
  which defaults to `'dddd, YYYY-MM-DD h:mma Z'`.

- displayDateShort: use moment's relative format (`m.fromNow()`), but with a
  reactive dependency that updates it every minute.

There's also an utility propetry, `TemplateHelpers.timeDisplayDep`, which is
used by displayDateShort to update every minute, but available even if momentjs
isn't present; you may use that for your own purposes.
