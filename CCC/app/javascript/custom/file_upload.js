// Prevent uploading of big images.
document.addEventListener("turbo:load", function() {
    document.addEventListener("change", function(event) {
        let file_upload = document.querySelector('#post_file');
        const size_in_megabytes = file_upload.files[0].size/1024/1024;
        if (size_in_megabytes > 300) {
            alert("Il valore massimo è di 300MB. Per favore carica un file di dimensioni inferiori");
            file_upload.value = "";
        }
    });
});