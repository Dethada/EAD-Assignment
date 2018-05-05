<html>
<head>
    <title>File Uploading Form</title>
</head>

<body>
<h3>File Upload:</h3>
Select a file to upload: <br />
<form method="post" enctype="multipart/form-data" id="fileUploadForm">
    <input type="file" name="file"  multiple="true"/><br/><br/>
    <input type="submit" value="Upload File" id="btnSubmit"/>
</form>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script>
    var path;
    $(document).ready(function () {

        $("#btnSubmit").click(function (event) {

            //stop submit the form, we will post it manually.
            event.preventDefault();

            // Get form
            var form = $('#fileUploadForm')[0];

            // Create an FormData object
            var data = new FormData(form);

            // disabled the submit button
            $("#btnSubmit").prop("disabled", true);

            $.ajax({
                type: "POST",
                enctype: 'multipart/form-data',
                url: "http://127.0.0.1:9000/upload",
                headers: {"token":"jwqIVxAJxBbe8iobMiyY4B1snIW7CSm9FNyfpjTrzdo389sQjvv9cF7x3AGDfDlj"},
                data: data,
                processData: false,
                contentType: false,
                cache: false,
                timeout: 600000,
                success: function (data) {

                    $("#result").text(data);
                    var x = JSON.parse(data).files.file.path.split('/');
                    path = x[x.length-1];
                    $.ajax({
                        type: 'POST',
                        // make sure you respect the same origin policy with this url:
                        // http://en.wikipedia.org/wiki/Same_origin_policy
                        url: 'http://127.0.0.1:8080/backend/UpdateMovieImagePath',
                        data: {
                            'id':'jsp here',
                            'path': path
                        },
                        success: function(msg){
                            alert(msg);
                        }
                    });
                    $("#btnSubmit").prop("disabled", false);

                },
                error: function (e) {
                    $("#result").text(e.responseText);
                    console.log("ERROR : ", e);
                    $("#btnSubmit").prop("disabled", false);
                }
            });
        });
    });

</script>
</html>