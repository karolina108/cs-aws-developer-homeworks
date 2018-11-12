$(document).ready((function () {

    var list = $("<ul></ul>");

        $.getJSON("../data/cold-starts-articles.json", function(data) {

            $.each(data, function () {
                var link = $("<a></a>").prop("href", this.link).text(this.title);
                $("<li></li>").append(link).appendTo(list);
            })
        });

    list.appendTo($("body"))
    })
);
