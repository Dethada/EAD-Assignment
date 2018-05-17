var form = document.getElementById("statusform");
var url = new URL(window.location.href);

function appendInput(parent, name, value) {
    var input = document.createElement("input");
    input.type = "hidden";
    input.name = name;
    input.value = value;
    parent.appendChild(input);
}

document.getElementById("nowshowingbutton").addEventListener("click", function () {
    // form.appendChild(document.createTextNode("Member " + (i+1)));
    // Create an <input> element, set its type and name attributes
    var genre = url.searchParams.get("genre");
    if (genre !== null) {
        appendInput(form, "genre", genre);
    }
    appendInput(form, "status", "Now showing");
    form.submit();

});

document.getElementById("comingsoonbutton").addEventListener("click", function () {
    var genre = url.searchParams.get("genre");
    if (genre !== null) {
        appendInput(form, "genre", genre);
    }
    appendInput(form, "status", "Coming soon");
    form.submit();

});

