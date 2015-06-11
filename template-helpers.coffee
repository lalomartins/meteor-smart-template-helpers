getParamNames = (fn) ->
    source = fn.toString()
    source.match(/\(.*?\)/)[0].replace(/[()]/gi,'').replace(/\s/gi,'').split(',')

TemplateHelpers =
    h: {}

    add: (name, fn) ->
        if typeof name is 'object'
            many = name
            for name, fn of many
                TemplateHelpers.add name, fn
        else
            TemplateHelpers.h[name] = fn
            paramNames = getParamNames fn
            if paramNames.length > 0
                Template.registerHelper name, ->
                    if arguments.length is 0
                        fn.call @, @
                    else if arguments.length is 1 and arguments[0] instanceof Spacebars.kw
                        hash = arguments[0].hash
                        args = (hash[param] for param in paramNames)
                        fn.apply @, args
                    else
                        fn.apply @, arguments
            else
                Template.registerHelper name, fn

TemplateHelpers.timeDisplayDep = new Tracker.Dependency
TemplateHelpers.timeDisplayDep._interval = Meteor.setInterval ->
    TemplateHelpers.timeDisplayDep.changed()
, 60000

TemplateHelpers.add
    makeRows: (list, columns = 3) ->
        # XXX actually implement this
        # (need a test dataset wide enough)
        if list instanceof Meteor.Collection.Cursor
            nRows = Math.ceil list.count() / columns
            for i in [0..nRows]
                cur = Object.create Meteor.Collection.Cursor.prototype
                _.extend cur, list
                cur.limit = columns
                cur.skip = i * columns
                index: i, total: nRows, columns: cur
        else
            nRows = Math.ceil list.count() / columns
            for i in [0..nRows]
                start = i * columns
                end = start + columns
                index: i, total: nRows, columns: list.slice(start, end)

    debug: ->
        debugger


if (moment = Package['momentjs:moment']?.moment)?
    TemplateHelpers.add
        displayDateFull: (date) ->
            moment(date).format TemplateHelpers.h.displayDateFull._format

        displayDateShort: (date) ->
            TemplateHelpers.timeDisplayDep.depend()
            moment(date).fromNow()

    TemplateHelpers.h.displayDateFull._format = 'dddd, YYYY-MM-DD h:mma Z'
