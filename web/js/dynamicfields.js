$(document).ready(function(){
    var next = parseInt(document.getElementById("next").value);
    $(".add-more").click(function(e){
        e.preventDefault();
        var addto = "#field" + next;
        var addRemove = "#field" + (next);
        next = next + 1;
        var newIn = '<input class="form-control" placeholder="Genre" id="field' + next + '" name="genre' + next + '" type="text">';
        var newInput = $(newIn);
        var removeBtn = '<button id="remove' + (next - 1) + '" class="btn btn-danger remove-me" >-</button>';
        var removeButton = $(removeBtn);
        $(addto).after(newInput);
        $(addRemove).after(removeButton);
        $("#field" + next).attr('data-source',$(addto).attr('data-source'));
        $("#count").val(next);

        $('.remove-me').click(function(e){
            e.preventDefault();
            var fieldNum = this.id.charAt(this.id.length-1);
            var fieldID = "#field" + fieldNum;
            $(this).remove();
            $(fieldID).remove();
        });
    });
    var next2 = parseInt(document.getElementById("next2").value);
    $(".add-more2").click(function(e){
        e.preventDefault();
        var add2to = "#fieldz" + next2;
        var add2Remove = "#fieldz" + (next2);
        next2 = next2 + 1;
        var newIn = '<input class="form-control" placeholder="Actor" id="fieldz' + next2 + '" name="actor' + next2 + '" type="text">';
        var newInput = $(newIn);
        var removeBtn = '<button id="remove' + (next2 - 1) + '" class="btn btn-danger remove-me2" >-</button>';
        var removeButton = $(removeBtn);
        $(add2to).after(newInput);
        $(add2Remove).after(removeButton);
        $("#fieldz" + next2).attr('data-source',$(add2to).attr('data-source'));

        $('.remove-me2').click(function(e){
            e.preventDefault();
            var fieldNum = this.id.charAt(this.id.length-1);
            var fieldID = "#fieldz" + fieldNum;
            $(this).remove();
            $(fieldID).remove();
        });
    });
});