{ CompositeDisposable } = require 'atom'

module.exports = WaveIt =
    subscriptions: null

    activate: (state) ->

        # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
        @subscriptions = new CompositeDisposable

        # Register command that toggles this view
        @subscriptions.add atom.commands.add 'atom-workspace', 'wave-it:toggle': => @toggle()

    deactivate: ->
        @subscriptions.dispose()

    toggle: ->
        if editor = atom.workspace.getActiveTextEditor()

            sText = editor.getSelectedText()

            fWave = ( word ) ->
                word = word.toLowerCase()
                word = word.split ''
                for letter, i in word by 2
                    word[ i ] = word[ i ].toUpperCase()
                iToken = 1
                word = word.join ''

            fInvert = ( word  ) ->
                word = word.split ''
                for letter, i in word
                    if letter == letter.toUpperCase()
                        word[ i ] = word[ i ].toLowerCase()
                    if letter == letter.toLowerCase()
                        word[ i ] = word[ i ].toUpperCase()
                iToken = 2
                word = word.join ''

            if /([A-ZÀÁÂÃÄÅÇÑÈÉÊËÌÍÎÏÒÓÔÕÖØÙÚÛÜÝ][a-zàáâãäåçèéêëìíîïðòóôõöøñùúûüýÿ])+[A-ZÀÁÂÃÄÅÇÑÈÉÊËÌÍÎÏÒÓÔÕÖØÙÚÛÜÝ]?/.test sText
                editor.insertText( fInvert( sText ), { "select" : true } )
            else
                editor.insertText( fWave( sText ), { "select" : true } )
