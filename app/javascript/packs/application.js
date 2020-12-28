import './jquery.tagcloud'

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")

document.addEventListener("turbolinks:load", function () {
    $(function () {
        $('#ask-button').click(function () {
            $('#ask-form').slideToggle(300);
            return false;
        });
    });

    // Облако тэгов
    $('#tags a').tagcloud({
        size: { start: 12, end: 30, unit: 'pt' },
        color: { start: '#aaa', end: '#37474F' }
    });
});
