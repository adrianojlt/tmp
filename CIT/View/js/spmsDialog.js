

;(function($) { // wrap it in a closure ...

    (function() { /*console.log('constructor');*/ })();

    var init = function() {

        $body = $(document.body);
        $window = $(window);

        var base =  '<div class="dialog-overlay"></div>' +
                    '<div id="spmsDialog" class="dialog-fixed-container">' +
                        '<div class="dialog-header">' +
                            '<span></span>' +
                            '<img src="../imagens_cit_v3/x.png" />' +
                        '</div>' + 
                        '<div class="dialog-content">' +
                            '<div class="dialog-message" style="font-weight: bold;"> </div>' +
                        '</div>' +
                        '<div class="dialog-footer"> </div>' +
                    '</div>';

        $.spmsDialog.dialog = $(base).appendTo($body); 

        $.spmsDialog.dialog.on('keydown', function() {console.log('keydown');});

        $.spmsDialog.dialog.find('.dialog-header img').on('click', function() {
            $.spmsDialog.close();
        });

        return $.spmsDialog.dialog;
    };

    var keyDownEventHandler = function() {

        console.log('keyDownEventHandler');
        
        var key = (window.event) ? event.keyCode : e.keyCode;

        //escape key closes
        if(key === 27) {
            console.log('event');
            //fadeClicked();    
        }
    };

    var sampleFunction = function() {
        console.log('sample function here ...');
    };

    var addCloseButton = function(label) {
        var footer = $.spmsDialog.dialog.find('.dialog-footer');
        var buttons = '<input class="spms-button right cancel" type="button" style="*height: 30px; width: 100px; margin: 0px;" value="' + label + '">';
        $(buttons).appendTo($(footer));
        $.spmsDialog.dialog.find('.dialog-footer .cancel').on('click', function(event) {
            event.preventDefault();
            $.spmsDialog.close();
        });
    };

    var addOkButton = function(label, arg) {
        var footer = $.spmsDialog.dialog.find('.dialog-footer');
        var buttons = '<input class="spms-button right ok" type="button" style="*height: 30px; width: 100px; margin: 0px;" value="' + label + '">';
        $(buttons).appendTo($(footer));
        $.spmsDialog.dialog.find('.dialog-footer .ok').on('click', function(event) {
            event.preventDefault();
            $.spmsDialog.close();
            arg.callback(arg.message);
        });
    };

    var methods = {

        confirm: function(arg) {

            addCloseButton('CANCELAR');
            addOkButton('OK', arg);

            $.spmsDialog.dialog.find('.dialog-header span').text(arg.title);

            $.spmsDialog.dialog.find('.dialog-content').prepend('<img src="../imagens_cit_v3/question.png" />');

            $.spmsDialog.dialog.find('.dialog-message').text(arg.message);
        },

        error: function(arg) {

            addCloseButton('FECHAR');

            $.spmsDialog.dialog.find('.dialog-header span').text(arg.title);

            $.spmsDialog.dialog.find('.dialog-content').prepend('<img src="../imagens_cit_v3/delete.png" />');

            $.spmsDialog.dialog.find('.dialog-message').text(arg.message);
        },

        warning: function(arg) {

            addCloseButton('OK');

            $.spmsDialog.dialog.find('.dialog-header span').text(arg.title);

            $.spmsDialog.dialog.find('.dialog-content').prepend('<img src="../imagens_cit_v3/warning03.png" />');

            $.spmsDialog.dialog.find('.dialog-message').text(arg.message);
        },

        tmp: function(arg) {
            //console.log(arg);
        }
    };

    $.spmsDialog = function( method ) {

        // ... a dialog already in use ... 
        if ( $.spmsDialog.dialog ) return;

        if ( methods[method] ) {
            init();
            return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ));
        } else if ( typeof method === 'object' || ! method ) {
            init();
            return methods.tmp.apply( this, arguments );
        } else {
            $.error( 'Method ' +  method + ' does not exist on jQuery.spmsDialog' );
        }
    };

    $.spmsDialog.close = function() {
        if ( $.spmsDialog.dialog ) {
            $.spmsDialog.dialog.fadeOut('fast', function() {
                if ( $.spmsDialog.dialog ) $.spmsDialog.dialog.remove();
                $.spmsDialog.dialog = null;
            });
        }
    }

    /**
    * Enable using $('.selector').spmsDialog({});
    * This will grab the html within the prompt as the prompt message
    */
    $.fn.spmsDialog = function(options) {
        $.spmsDialog($(this).clone().html(),options);
    }

})(jQuery);

